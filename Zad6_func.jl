function start!(r::Robot)
    robot_path = RobotPath{Robot}(r)
    while !isborder(robot_path, Sud) || !isborder(robot_path, West)
        movements!(robot_path, Sud)
        movements!(robot_path, West)
    end
    search!(r,Nord)
    check!(r,Nord)
    movements_to_back!(robot_path)
end
function search!(r,side)
    n=0
    while !isborder(r,side)
        move!(r,side)
        n+=1
    end
    if n==10
        move!(r,Ost)
        search!(r,inverse(side))
    else
        move!(r,West)
    end
end
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end
function check!(r,Nord)
    move!(r,Nord)
    if isborder(r,Ost)==true
        move!(r,Sud)
        putmarker!(r)
        putmarkers!(r,Nord)
        putmarkers!(r,Ost)
        putmarkers!(r,Sud)
        putmarkers!(r,West)
        ygol!(r)
    else
        move!(r,Sud)
        putmarker!(r)
        putmarkers!(r,Ost)
        putmarkers!(r,Sud)
        putmarkers!(r,West)
        putmarkers!(r,Nord)
        ygol!(r)
    end
end
function putmarkers!(r::Robot,side::HorizonSide)
    move!(r,side)
    putmarker!(r)
    while isborder(r,HorizonSide(mod(Int(side)-1,4)))==true
        move!(r,side)
        putmarker!(r)
    end
end
function ygol!(r)
    while isborder(r,West)==false
        move!(r,West)
    end
    while isborder(r,Sud)==false
        move!(r,Sud)
    end
end