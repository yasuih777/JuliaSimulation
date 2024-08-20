module JuliaSimulation
include("./knapsack_ga/pipeline.jl")
include("./double_pendulum/pipeline.jl")

function knapsack_ga()
    knapsack_ga_process()
end
function double_pendulum()
    double_pendulum_process()
end
end