function start!(r::Robot,n::Int)
    global SIZE
    SIZE = n
    side=Ost
    robot_path = RobotPath{Robot}(r)
    while !isborder(robot_path,Sud) || !isborder(robot_path,West)
        movements!(robot_path,Sud)
        movements!(robot_path,West)
    end
    just_do_it(r,side)
    while isborder(r,Nord)==false
        move_decart!(r,Nord)
        side = inverse(side)
        just_do_it(r,side)
    end
    ygol!(r)
    movements_to_back!(robot_path)
end
function just_do_it(r::Robot,side::HorizonSide)       
    chess!(r)
    while isborder(r,side)==false
        move_decart!(r,side)
        chess!(r)
    end
end
function chess!(r)
    if (mod(COORDINATE_X, 2*SIZE) in 0:SIZE-1) && (mod(COORDINATE_Y, 2*SIZE) in 0:SIZE-1) 
        putmarker!(r)
    end
end
function move_decart!(r,side)
    global COORDINATE_X, COORDINATE_Y
    if side==Nord
        COORDINATE_Y+=1
    elseif side==Sud
        COORDINATE_Y-=1
    elseif side==Ost
        COORDINATE_X+=1
    else
        COORDINATE_X-=1
    end
    move!(r,side)
end
function ygol!(r)
    while isborder(r,West)==false
        move!(r,West)
    end
    while isborder(r,Sud)==false
        move!(r,Sud)
    end
end
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end