@inline function log_like(theta::Array{Float64}, data::Array{Float64, 2})::Float64
    m, b = theta
    x = data[:,1]
    y = data[:,2]
    sigma = data[:,3]

    model_y = m .* x .+ b

    return -sum((model_y .- y).^2 ./ sigma.^2)
end

@inline function log_prior(theta::Array{Float64})::Float64
    m, b = theta

    if 0.0 < m < 10.0 && 0.0 < b < 10.0
        return 0.0
    end

    return -Inf64
end

@inline function proposal_function(param::Array{Float64}, eps::Float64)::Array{Float64}
    return eps .* randn(2) .+ param
end

@inline function log_prob(theta::Array{Float64}, data::Array{Float64, 2})::Float64
    return log_prior(theta) + log_like(theta, data)
end
