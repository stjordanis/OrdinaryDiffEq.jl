using OrdinaryDiffEq, StaticArrays, Test

# More ODE event tests, cf. #201, #199, #198, #197
function test_callback_inplace(alg; kwargs...)
    f = (du, u, p, t) -> @. du = u
    cb = ContinuousCallback((u,t,int) -> u[1] - exp(1), terminate!)
    prob = ODEProblem(f, [5.0], (2.0, 0.0), callback=cb)
    sol = solve(prob, alg; kwargs...)
    sol.u[end][1] ≈ exp(1)
end

function test_callback_outofplace(alg; kwargs...)
    f = (u, p, t) -> copy(u)
    cb = ContinuousCallback((u,t,int) -> u[1] - exp(1), terminate!)
    prob = ODEProblem(f, [5.0], (2.0, 0.0), callback=cb)
    sol = solve(prob, alg; kwargs...)
    sol.u[end][1] ≈ exp(1)
end

function test_callback_scalar(alg; kwargs...)
    f = (u, p, t) -> u
    cb = ContinuousCallback((u,t,int) -> u - exp(1), terminate!)
    prob = ODEProblem(f, 5.0, (2.0, 0.0), callback=cb)
    sol = solve(prob, alg; kwargs...)
    sol.u[end] ≈ exp(1)
end

function test_callback_svector(alg; kwargs...)
    f = (u, p, t) -> u
    cb = ContinuousCallback((u,t,int) -> u[1] - exp(1), terminate!)
    prob = ODEProblem(f, SVector(5.0), (2.0, 0.0), callback=cb)
    sol = solve(prob, alg; kwargs...)
    sol.u[end][1] ≈ exp(1)
end

function test_callback_mvector(alg; kwargs...)
    f = (u, p, t) -> copy(u)
    cb = ContinuousCallback((u,t,int) -> u[1] - exp(1), terminate!)
    prob = ODEProblem(f, MVector(5.0), (2.0, 0.0), callback=cb)
    sol = solve(prob, alg; kwargs...)
    sol.u[end][1] ≈ exp(1)
end

println("inplace")
@test test_callback_inplace(BS3())
@test test_callback_inplace(BS5())
@test test_callback_inplace(SSPRK432())
@test test_callback_inplace(SSPRK932())
@test test_callback_inplace(OwrenZen3())
@test test_callback_inplace(OwrenZen4())
@test test_callback_inplace(OwrenZen5())
@test test_callback_inplace(DP5())
@test test_callback_inplace(DP8())
@test test_callback_inplace(Feagin10())
@test test_callback_inplace(Feagin12())
@test test_callback_inplace(Feagin14())
@test test_callback_inplace(TanYam7())
@test test_callback_inplace(Tsit5())
@test test_callback_inplace(TsitPap8())
@test test_callback_inplace(Vern6())
@test test_callback_inplace(Vern7())
@test test_callback_inplace(Vern8())
@test test_callback_inplace(Vern9())
@test test_callback_inplace(Rosenbrock23())
@test test_callback_inplace(Rosenbrock32())
@test test_callback_inplace(AB3(); dt=0.1)
@test test_callback_inplace(ABM32(); dt=0.1)
@test test_callback_inplace(AB4(); dt=0.1)
@test test_callback_inplace(ABM43(); dt=0.1)
@test test_callback_inplace(AB5(); dt=0.1)
@test test_callback_inplace(ABM54(); dt=0.1)
@test test_callback_inplace(VCAB3())
@test test_callback_inplace(VCAB4())
@test test_callback_inplace(VCAB5())
@test test_callback_inplace(VCABM3())
@test test_callback_inplace(VCABM4())
@test test_callback_inplace(VCABM5())

println("outofplace")
@test test_callback_outofplace(BS3())
@test test_callback_outofplace(BS5())
@test test_callback_outofplace(SSPRK432())
@test test_callback_outofplace(SSPRK932())
@test test_callback_outofplace(OwrenZen3())
@test test_callback_outofplace(OwrenZen4())
@test test_callback_outofplace(OwrenZen5())
@test test_callback_outofplace(DP5())
@test test_callback_outofplace(DP8())
@test test_callback_outofplace(Feagin10())
@test test_callback_outofplace(Feagin12())
@test test_callback_outofplace(Feagin14())
@test test_callback_outofplace(TanYam7())
@test test_callback_outofplace(Tsit5())
@test test_callback_outofplace(TsitPap8())
@test test_callback_outofplace(Vern6())
@test test_callback_outofplace(Vern7())
@test test_callback_outofplace(Vern8())
@test test_callback_outofplace(Vern9())
@test test_callback_outofplace(Rosenbrock23())
@test test_callback_outofplace(Rosenbrock32())
@test test_callback_outofplace(AB3(); dt=0.1)
@test test_callback_outofplace(ABM32(); dt=0.1)
@test test_callback_outofplace(AB4(); dt=0.1)
@test test_callback_outofplace(ABM43(); dt=0.1)
@test test_callback_outofplace(AB5(); dt=0.1)
@test test_callback_outofplace(ABM54(); dt=0.1)
@test test_callback_outofplace(VCAB3())
@test test_callback_outofplace(VCAB4())
@test test_callback_outofplace(VCAB5())
@test test_callback_outofplace(VCABM3())
@test test_callback_outofplace(VCABM4())
@test test_callback_outofplace(VCABM5())

println("scalar")
@test test_callback_scalar(BS3())
@test test_callback_scalar(BS5())
@test test_callback_scalar(SSPRK432())
@test test_callback_scalar(SSPRK932())
@test test_callback_scalar(OwrenZen3())
@test test_callback_scalar(OwrenZen4())
@test test_callback_scalar(OwrenZen5())
@test test_callback_scalar(DP5())
@test test_callback_scalar(DP8())
@test test_callback_scalar(Feagin10())
@test test_callback_scalar(Feagin12())
@test test_callback_scalar(Feagin14())
@test test_callback_scalar(TanYam7())
@test test_callback_scalar(Tsit5())
@test test_callback_scalar(TsitPap8())
@test test_callback_scalar(Vern6())
@test test_callback_scalar(Vern7())
@test test_callback_scalar(Vern8())
@test test_callback_scalar(Vern9())
@test test_callback_scalar(Rosenbrock23())
@test test_callback_scalar(Rosenbrock32())
@test test_callback_scalar(AB3(); dt=0.1)
@test test_callback_scalar(ABM32(); dt=0.1)
@test test_callback_scalar(AB4(); dt=0.1)
@test test_callback_scalar(ABM43(); dt=0.1)
@test test_callback_scalar(AB5(); dt=0.1)
@test test_callback_scalar(ABM54(); dt=0.1)
@test test_callback_scalar(VCAB3())
@test test_callback_scalar(VCAB4())
@test test_callback_scalar(VCAB5())
@test test_callback_scalar(VCABM3())
@test test_callback_scalar(VCABM4())
@test test_callback_scalar(VCABM5())

println("svector")
@test test_callback_svector(BS3())
@test test_callback_svector(BS5())
@test test_callback_svector(SSPRK432())
@test test_callback_svector(SSPRK932())
@test test_callback_svector(OwrenZen3())
@test test_callback_svector(OwrenZen4())
@test test_callback_svector(OwrenZen5())
@test test_callback_svector(DP5())
@test test_callback_svector(DP8())
@test test_callback_svector(Feagin10())
@test test_callback_svector(Feagin12())
@test test_callback_svector(Feagin14())
@test test_callback_svector(TanYam7())
@test test_callback_svector(Tsit5())
@test test_callback_svector(TsitPap8())
@test test_callback_svector(Vern6())
@test test_callback_svector(Vern7())
@test test_callback_svector(Vern8())
@test test_callback_svector(Vern9())
@test test_callback_svector(Rosenbrock23())
@test test_callback_svector(Rosenbrock32())
@test test_callback_svector(AB3(); dt=0.1)
@test test_callback_svector(ABM32(); dt=0.1)
@test test_callback_svector(AB4(); dt=0.1)
@test test_callback_svector(ABM43(); dt=0.1)
@test test_callback_svector(AB5(); dt=0.1)
@test test_callback_svector(ABM54(); dt=0.1)
@test test_callback_svector(VCAB3())
@test test_callback_svector(VCAB4())
@test test_callback_svector(VCAB5())
@test test_callback_svector(VCABM3())
@test test_callback_svector(VCABM4())
@test test_callback_svector(VCABM5())

print("mvector")
@test test_callback_mvector(BS3())
@test test_callback_mvector(BS5())
print(".")
@test test_callback_mvector(SSPRK432())
@test test_callback_mvector(SSPRK932())
print(".")
@test test_callback_mvector(OwrenZen3())
@test test_callback_mvector(OwrenZen4())
print(".")
@test test_callback_mvector(OwrenZen5())
@test test_callback_mvector(DP5())
print(".")
@test test_callback_mvector(DP8())
@test test_callback_mvector(Feagin10())
print(".")
@test test_callback_mvector(Feagin12())
@test test_callback_mvector(Feagin14())
print(".")
@test test_callback_mvector(TanYam7())
@test test_callback_mvector(Tsit5())
print(".")
@test test_callback_mvector(TsitPap8())
@test test_callback_mvector(Vern6())
print(".")
@test test_callback_mvector(Vern7())
@test test_callback_mvector(Vern8())
print(".")
@test test_callback_mvector(Vern9())
@test test_callback_mvector(Rosenbrock23())
print(".")
@test test_callback_mvector(Rosenbrock32())
@test test_callback_mvector(AB3(); dt=0.1)
print(".")
@test test_callback_mvector(ABM32(); dt=0.1)
@test test_callback_mvector(AB4(); dt=0.1)
print(".")
@test test_callback_mvector(ABM43(); dt=0.1)
@test test_callback_mvector(AB5(); dt=0.1)
print(".")
@test test_callback_mvector(ABM54(); dt=0.1)
@test test_callback_mvector(VCAB3())
print(".")
@test test_callback_mvector(VCAB4())
@test test_callback_mvector(VCAB5())
print(".")
@test test_callback_mvector(VCABM3())
@test test_callback_mvector(VCABM4())
print(".")
@test test_callback_mvector(VCABM5())
println(".")
