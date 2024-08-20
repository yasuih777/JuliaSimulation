Base.@kwdef struct DoublePendulumParameters
    pendulum_length::NTuple{2, Float16} = (1.0, 0.5)
    pendulum_weight::NTuple{2, Float16} = (0.5, 0.2)
    gravity::Float16 = 9.8

    theta_init::Vector{Float64} = [3 * π / 4, 3 * π / 4]
    omega_init::Vector{Float64} = [0.0, 0.0]

    t_max::Float16 = 60.0
    t_delta::Float16 = 0.05

    locus_max::Float16 = 2.0
end