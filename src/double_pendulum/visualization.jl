using Plots

function create_pendulum_gif(points::PendulumPoints, params::DoublePendulumParameters)
    times = points.time
    pendulum_1 = points.pendulum_1_point
    pendulum_2 = points.pendulum_2_point

    len = (params.pendulum_length[1] + params.pendulum_length[2]) * 1.1

    locus_x::Vector{Float64} = []
    locus_y::Vector{Float64} = []
    all_locus_x::Vector{Float64} = []
    all_locus_y::Vector{Float64} = []
    all_locus_t::Vector{Float64} = []

    anim = @animate for idx in 1:length(times)
        push!(locus_x, pendulum_2[idx][1])
        push!(locus_y, pendulum_2[idx][2])
        push!(all_locus_x, pendulum_2[idx][1])
        push!(all_locus_y, pendulum_2[idx][2])
        push!(all_locus_t, times[idx])

        if length(locus_x) > params.locus_max / params.t_delta
           popfirst!(locus_x) 
           popfirst!(locus_y) 
        end

        dinamics = plot(
            [0, pendulum_1[idx][1], pendulum_2[idx][1]],
            [0, pendulum_1[idx][2], pendulum_2[idx][2]],
            title = "Pendulum dinamics",
            lw = 3,
            lc = "black",
            markershape = :circle,
            ms = 5,
            mc = "black",
        )
        if length(locus_x) >= 2
            plot!(
                dinamics,
                locus_x,
                locus_y,
                lw = 5,
                c = :Greys_9,
                legend = false,
            )
        end

        locus = plot(
            title = "Pendulum locus",
            all_locus_x,
            all_locus_y,
            linez=all_locus_t,
            lw = 5,
            c = :jet,
            la = 0.5,
            legend = false,
        )

        plot(
            dinamics,
            locus,
            layout = (1, 2),
            plot_title = "time: $(times[idx])",
            legend = false,
            xaxis = false,
            yaxis = false,
            aspect_ratio = :equal,
            size = (1000, 500),
        )
        xlims!(-len, len)
        ylims!(-len, len)
    end

    mkpath("output/double_pendulum")
    gif(anim, "output/double_pendulum/simulation.gif", fps = Int.(1 / params.t_delta))
end