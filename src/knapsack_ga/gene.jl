mutable struct Gene
    keep_idx::Int

    parents::Array{Int, 2}
    childerens::Array{Int, 2}
    scores::Array{Int, 1}
end

function build_param(params::Parameters)
    return Gene(
        params.parent_size - params.children_size,
        Int.(Random.bitrand((params.parent_size, params.item_size))),
        zeros(Int, params.children_size, params.item_size),
        zeros(Int, params.parent_size),
    )
end

function evaluation!(params::Parameters, gene::Gene)
    costs::Matrix{Int} = sum(gene.parents' .* params.knapsack["cost"], dims=1)
    values::Matrix{Int} = sum(gene.parents' .* params.knapsack["value"], dims=1)

    gene.scores = [
        if costs[idx] <= params.cost_limit values[idx]
        else params.cost_limit - costs[idx]
        end
        for idx in 1:params.parent_size
    ]

    best_gene_id::Int = argmax(gene.scores)
    return best_gene_id, costs[best_gene_id], values[best_gene_id]
end

function tournament_selection!(params::Parameters, gene::Gene)
    block::Int = div(params.parent_size, params.children_size)
    for idx in 1:block
        idx_max::Int = argmax(gene.scores[(idx - 1) * block + 1: idx * block])
        gene.childerens[idx, :] = gene.parents[(idx - 1) * block + idx_max, :]
    end
end

function uniform_crossbreeding!(params::Parameters, gene::Gene)
    gene_code::Int = -1
    parent_idx::Matrix{Int} = sample(1:params.children_size, (gene.keep_idx, 2))

    for p_idx in 1:gene.keep_idx
        for i_idx in 1:params.item_size
            if rand() <= 0.5
                gene_code = gene.childerens[parent_idx[p_idx, 1], i_idx]
            else
                gene_code = gene.childerens[parent_idx[p_idx, 2], i_idx]
            end
            gene.parents[p_idx, i_idx] = gene_code
        end
    end
end

function mutation!(params::Parameters, gene::Gene)
    for p_idx in 1:gene.keep_idx
        for i_idx in 1:params.item_size
            if rand() <= params.mutation_prob
                gene.parents[p_idx, i_idx] = div(gene.parents[p_idx, i_idx] + 1, 2)
            end
        end
    end
end

function insert_children!(params::Parameters, gene::Gene)
    gene.parents[gene.keep_idx + 1:params.parent_size, :] = gene.childerens
    gene.parents = gene.parents[shuffle(1:end), :]
end