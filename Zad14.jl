module Zad14
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad14_func.jl")
end

Zad14.start!(r)