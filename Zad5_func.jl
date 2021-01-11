function start!(r::Robot)
    robot_path = RobotPath{Robot}(r)
    while !isborder(robot_path,Sud) || !isborder(robot_path,West)
        movements!(robot_path,Sud)
        movements!(robot_path,West)
    end
    ygol!(r,Nord)
    ygol!(r,Ost)
    ygol!(r,Sud)
    ygol!(r,West)
    movements_to_back!(robot_path)
end
function movements!(r,side)
    while isborder(r,side)==false
        move!(r,side)
    end
end
function ygol!(r::Robot,side::HorizonSide)
    moves!(r,side)
    putmarker!(r)
end
function moves!(r::Robot, side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps
        move!(r,side)
    end
end