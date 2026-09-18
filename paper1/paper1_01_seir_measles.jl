using StockFlow

using LabelledArrays
using OrdinaryDiffEq
using Plots

println("SEIR - Measles")

include("ViewUtils.jl")

# Functions of dynamical variables
f_birth(u,uN,p,t)=p.μ*uN.N(u,t)
f_incid(u,uN,p,t)= p.β*u.S*u.I/uN.N(u,t)
f_inf(u,uN,p,t)=u.E/p.tlatent
f_rec(u,uN,p,t)=u.I/p.trecovery
f_deathS(u,uN,p,t)=u.S*p.δ
f_deathE(u,uN,p,t)=u.E*p.δ
f_deathI(u,uN,p,t)=u.I*p.δ
f_deathR(u,uN,p,t)=u.R*p.δ

seir=StockAndFlow(
    (:S=>(:birth,(:incid,:deathS),(:v_incid,:v_deathS),:N),
        :E=>(:incid,(:inf,:deathE),(:v_inf,:v_deathE),:N),
        :I=>(:inf,(:rec,:deathI),(:v_incid, :v_rec,:v_deathI),:N),
        :R=>(:rec,:deathR,:v_deathR,:N)),
    (:birth=>:v_birth,:incid=>:v_incid,:inf=>:v_inf,:rec=>:v_rec,:deathS=>:v_deathS,:deathE=>:v_deathE,:deathI=>:v_deathI,:deathR=>:v_deathR),
    (:v_birth=>f_birth,:v_incid=>f_incid,:v_inf=>f_inf,:v_rec=>f_rec,:v_deathS=>f_deathS,:v_deathE=>f_deathE,:v_deathI=>f_deathI,:v_deathR=>f_deathR),
    (:N=>(:v_birth,:v_incid))
);

# Key.
# :S=>(:birth, (:incid,:deathS), (:v_incid,:v_deathS), :N)
# inflows to S are (:birth)
# outflows from S are (:incid,:deathS)
# vars that depend on S are (:v_incid,:v_deathS)
# sum vars that S contributes to are (:N)
#
# :birth=>:v_birth
# flow rate of birth is controlled by var v_birth
#
# :N=>(:v_birth,:v_incid)
# sum var N is used by :v_birth and :v_incid

# StockAndFlow Tuple Syntax Key:
#
# 1. Stock Declaration: :Stock => (InFlows, OutFlows, DependentVars, SumVars)
#    :S => (:birth, (:incid, :deathS), (:v_incid, :v_deathS), :N)
#    - Inflows into S:              :birth
#    - Outflows from S:             :incid, :deathS
#    - Auxiliary vars using S:      :v_incid, :v_deathS
#    - Sum vars S contributes to:   :N
#
# 2. Flow Rate Mapping: :Flow => :AuxiliaryVar
#    :birth => :v_birth             (Flow rate of :birth is defined by :v_birth)
#
# 3. Sum Variable Usage: :SumVar => (:AuxiliaryVars...)
#    :N => (:v_birth, :v_incid)     (Sum total :N is used to compute :v_birth and :v_incid)

ViewUtils.display_graph(Graph(seir))

# Parameter values
p_measles = LVector(
    β=49.598, μ=0.03/12, δ=0.03/12, tlatent=8.0/30, trecovery=5.0/30
)

# Initial values for stocks
u0_measles = LVector(
    S=90000.0-930.0, E=0.0, I=930.0, R=773545.0
);

prob_measles = ODEProblem(vectorfield(seir),u0_measles,(0.0,120.0),p_measles);
sol_measles = solve(prob_measles,Tsit5(),abstol=1e-8);

ViewUtils.display_plot(plot(sol_measles))
