include("stats.jl")

function sample_step(theta::Array{Float64}, data::Array{Float64, 2}, p_old::Float64)::Tuple{Array{Float64}, Float64}
    new_theta = proposal_function(theta, 0.05)
    p_new = log_prob(new_theta, data)

    if p_new > p_old
        return (new_theta, p_new)
    end 

    accept = rand()
    prob = exp(p_new - p_old)

    if accept < prob
        return (new_theta, p_new)
    end

    return (theta, p_old)
end

function sample(theta_initial::Array{Float64}, data::Array{Float64, 2}, nsteps::Int64)::Array{Float64, 2}
    chain = zeros(nsteps, 2)

    theta = theta_initial
    prob = log_prob(theta, data)

    for i in 1:nsteps
        chain[i,:] = theta
        theta, prob = sample_step(theta, data, prob)
    end

    return chain
end
