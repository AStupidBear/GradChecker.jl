module GradChecker

export ngradient, gradcheck

using LinearAlgebra

function ngradient(f, x, is = 1:length(x); δ = 1e-2)
    Δ = zero(x)
    for i in is
        tmp = x[i]
        x[i] = tmp - δ / 2
        y1 = f(x)
        x[i] = tmp + δ / 2
        y2 = f(x)
        x[i] = tmp
        Δ[i] = (y2 - y1) / δ
    end
    return Δ
end

function gradcheck(f, θ, is = 1:length(θ))
    g = f'(θ)[is]
    g′ = ngradient(f, θ, is)[is]
    err = norm(g .- g′) / norm(g)
    return g, g′, err
end

end