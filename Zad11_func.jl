DEVIATION_NORD=0
DEVIATION_WEST=0
DEVIATION_SUD=0
DEVIATION_OST=0
function start!(r::Robot)
    robot_path = RobotPath{Robot}(r)
    while !isborder(robot_path,Sud) || !isborder(robot_path,West)
        movements!(robot_path,Sud)
        movements!(robot_path,West)
    end
    moves!(r,Nord,DEVIATION_SUD)
    moves!(r,Ost,DEVIATION_WEST)
    moves!(r,Sud,DEVIATION_NORD)
    moves!(r,West,DEVIATION_OST)
    movements_to_back!(robot_path)
end
function movements!(r,side)
    global DEVIATION_NORD, DEVIATION_WEST, DEVIATION_SUD, DEVIATION_OST
    while isborder(r,side)==false
        move!(r,side)
        if side==Sud
            DEVIATION_SUD +=1
        elseif side==West
            DEVIATION_WEST +=1
        end
    end
    DEVIATION_NORD = 10-DEVIATION_SUD
    DEVIATION_OST = 11-DEVIATION_WEST
end
function moves!(r::Robot,side::HorizonSide,DEVIATION_SIDE::Int)
    for _ in 1:DEVIATION_SIDE
        move!(r,side)
    end
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
    end
end