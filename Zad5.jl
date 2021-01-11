module Zad5
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad5_func.jl")
end

Zad5.start!(r)