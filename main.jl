include("sampler.jl")
using Plots

function mock_data()
    n = 20
    x = rand(n) * 3.0
    noise = randn(n) .* 2.
    true_m, true_b = 7.6, 3.5

    y = true_m .* x .+ true_b .+ noise

    data = [x y noise]

    return data
end

function main()
    data = mock_data()
    n = 10000

    t0 = time()
    chain = sample([5.5, 3.0], data, n)
    t1 = time()

    println(t1 - t0)

    println("m ", sum(chain[:,1]) / n)
    println("b ", sum(chain[:,2]) / n)

    return data, chain
end

function plot_results(data, chain, nsamples=200)
    n = length(chain[:,1])
    p = scatter(data[:,1], data[:,2], label=nothing)
    
    for i in 1:nsamples
        sample = rand(1000:n)

        m ,b = chain[sample,1], chain[sample,2]

        plot!(data[:,1], data[:,1] * m .+ b, linecolor=:black, linealpha=0.1, label=nothing)
    end

    m, b = (sum(chain[:,1]) / n, sum(chain[:,2]) / n)
    plot!(data[:,1], data[:,1] * m .+ b, linewidth=0.5, linecolor=:red, label=nothing)

    return p
end

function plot_chain(chain, drop=0.1)
    drop_count = trunc(Int, length(chain[:,1]) * drop)
    return plot(chain[drop_count:end,1], label=nothing), plot(chain[drop_count:end,2], label=nothing)
end

function show_plots(data, chain)
    l = @layout [a ; b c]
    p1 = plot_results(data, chain)
    p2, p3 = plot_chain(chain)
    plot(p1, p2, p3, layout=l)
end

data, chain = main()
show_plots(data, chain)
