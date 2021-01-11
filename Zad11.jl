module Zad11
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad11_func.jl")
end

Zad11.start!(r)