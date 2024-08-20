include("parameters.jl")
include("differential_equation.jl")
include("visualization.jl")

function double_pendulum_process()
    params::DoublePendulumParameters = DoublePendulumParameters()
    len = params.pendulum_length
    weight = params.pendulum_weight
    gravity = params.gravity

    theta, omega = runge_kutta(
        motion_equation,
        params.theta_init,
        params.omega_init,
        params
    )

    points = solution(params)

    create_pendulum_gif(points, params)
end