module Zad6
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad6_func.jl")
end

Zad6.start!(r)