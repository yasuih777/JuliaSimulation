using Random
using StatsBase

include("parameters.jl")
include("gene.jl")

function knapsack_ga_process()
    # initiation
    params::Parameters = Parameters()
    # MersenneTwister(params.seed_number)
    gene::Gene = build_param(params)
    best_gene_id::Int = -1

    for idx in 1:params.generation_iter
        # evalution
        best_gene_id, best_cost, best_value = evaluation!(params, gene)

        # selection
        tournament_selection!(params, gene)

        # crossbreeding
        uniform_crossbreeding!(params, gene)

        # mutation
        mutation!(params, gene)

        # insertion eugenic gene
        insert_children!(params, gene)

        println(
            "Generation $(idx): cost: $(best_cost) value: $(best_value)"
        )
    end
    println("Best gene: ", gene.parents[best_gene_id, :])
end