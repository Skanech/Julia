module Zad15
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad15_func.jl")
end

Zad15.start!(r)