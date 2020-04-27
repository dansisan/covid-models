Pkg.add("Plots");Pkg.add("PyPlot");Pkg.add("DifferentialEquations");

using Plots; using DifferentialEquations;

function sir!(du,u,p,t)
 S,I,R = u
 N = S+I+R
 β,ν,γ = p
 
 du[1] = -β*(I*S) / N
 du[2] = β*(I*S) / N - ν*I
 du[3] = ν*I
end

function simSir(β,ν,γ)
   p = [β;ν;γ]
   u0 = [100.0; 1.0; 0.0]
   tspan = (0.0,100.0)
   prob = ODEProblem(sir!,u0,tspan,p)
   sol = solve(prob)
   return sol
end

sol = simSir(.3,.05,0); 
plot(sol,linewidth=2,xaxis="t", label=["S" "I" "R"])
newCases = diff(map(x -> x[2] + x[3], sol(1:1:100).u))
sum(newCases[1:25])
plot(diff(map(x -> x[2] + x[3], sol(1:1:100).u)))
