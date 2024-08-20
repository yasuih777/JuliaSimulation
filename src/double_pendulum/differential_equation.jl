struct PendulumPoints
    time::Vector{Float16}
    pendulum_1_point::Vector{Vector{Float64}}
    pendulum_2_point::Vector{Vector{Float64}}
end

function solution(params::DoublePendulumParameters)
    times = [params.t_delta:params.t_delta:params.t_max;]
    points = PendulumPoints([], [], [])

    theta = params.theta_init
    omega = params.omega_init
    pendulum_points = trans_point(theta, params)

    push!(points.time, 0.0)
    push!(points.pendulum_1_point, pendulum_points[1])
    push!(points.pendulum_2_point, pendulum_points[2])

    for now_t in times
        theta, omega = runge_kutta(motion_equation, theta, omega, params)
        pendulum_points = trans_point(theta, params)

        push!(points.time, now_t)
        push!(points.pendulum_1_point, pendulum_points[1])
        push!(points.pendulum_2_point, pendulum_points[2])
    end

    return points
end

function trans_point(theta::Vector{Float64}, params::DoublePendulumParameters)
    pendulum_1::Vector{Float64} = [0, 0]
    pendulum_2::Vector{Float64} = [0, 0]

    pendulum_1[1] = params.pendulum_length[1] * sin(theta[1])
    pendulum_1[2] = - params.pendulum_length[1] * cos(theta[1])
    pendulum_2[1] = pendulum_1[1] + params.pendulum_length[2] * sin(theta[2])
    pendulum_2[2] = pendulum_1[2] - params.pendulum_length[2] * cos(theta[2])

    return pendulum_1, pendulum_2
end

function runge_kutta(
    func,
    theta::Vector{Float64},
    omega::Vector{Float64},
    params::DoublePendulumParameters,
)
    k1_theta = omega * params.t_delta
    k1_omega = func(theta, omega, params) * params.t_delta

    k2_theta = (omega + k1_omega / 2) * params.t_delta
    k2_omega = func(theta + k1_theta / 2, omega + k1_omega / 2, params) * params.t_delta

    k3_theta = (omega + k2_omega / 2) * params.t_delta
    k3_omega = func(theta + k2_theta / 2, omega + k2_omega / 2, params) * params.t_delta

    k4_theta = (omega + k3_omega) * params.t_delta
    k4_omega = func(theta + k3_theta, omega + k3_omega / 2, params) * params.t_delta

    new_theta = theta + (k1_theta + 2 * k2_theta + 2 * k3_theta + k4_theta) / 6
    new_omega = omega + (k1_omega + 2 * k2_omega + 2 * k3_omega + k4_omega) / 6

    return new_theta, new_omega
end

function motion_equation(
    theta::Vector{Float64},
    omega::Vector{Float64},
    params::DoublePendulumParameters,
)
    len = params.pendulum_length
    weight = params.pendulum_weight
    gravity = params.gravity

    c_const = cos(theta[1] - theta[2])
    s_const = sin(theta[1] - theta[2])
    m_const = (weight[1] + weight[2]) / weight[2]

    values::Vector{Float64} = zeros(Float64, 2)
    values[1] = (
        gravity * (c_const * sin(theta[2]) - m_const * sin(theta[1]))
        - (len[1] * omega[1] ^ 2 * c_const + len[2] * omega[2] ^ 2) * s_const
    ) / (len[1] * (m_const - c_const ^ 2))
    values[2] = (
        gravity * m_const * (c_const * sin(theta[1]) - sin(theta[2]))
        + (m_const * len[1] * omega[1] ^ 2 + len[2] * omega[2] ^ 2 * c_const) * s_const
    ) / (len[2] * (m_const - c_const ^ 2))

    return values
end