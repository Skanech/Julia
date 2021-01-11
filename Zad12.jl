module Zad12
    using HorizonSideRobots
    include("robot_types.jl")
    include("horizonside.jl")
    include("horizonside_robot.jl")

    include("Zad12_func.jl")
    export start!
    COORDINATE_X=0
    COORDINATE_Y=0
    SIZE = 0
end

Zad12.start!(r,4)