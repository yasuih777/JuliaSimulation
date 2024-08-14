Base.@kwdef struct Parameters
    seed_number::Union{Int, Nothing} = nothing

    generation_iter::Int = 50
    cost_limit::Int = 50
    parent_size::Int = 100
    children_size::Int = 10
    item_size::Int = 20
    mutation_prob::Float16 = 0.25

    knapsack::Dict{String, NTuple{20, Int}} = Dict(
        "cost" => (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20),
        "value" => (2, 3, 5, 5, 6, 9, 10, 12, 15, 15, 16, 16, 17, 19, 20, 22, 24, 28, 29, 32),
    )
end