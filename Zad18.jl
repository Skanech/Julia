module Zad18
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad18_func.jl")
end

Zad18.start!(r)