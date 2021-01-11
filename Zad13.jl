function start!(r::Robot)
    for side in (Nord,West,Sud,Ost)
        putmarkers!(r,side)
        move_by_markers(r,inverse(side))
    end
    putmarker!(r)
end
function putmarkers!(r::Robot,side::HorizonSide)
    while isborder(r,side)==false && isborder(r,HorizonSide(mod(Int(side)+1,4)))==false
        move!(r,side)
        move!(r,HorizonSide(mod(Int(side)+1,4)))
        putmarker!(r)
    end
end
function move_by_markers(r::Robot,side::HorizonSide)
    while ismarker(r)==true
        move!(r,side)
        move!(r,HorizonSide(mod(Int(side)+1,4)))
    end
end
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end

start!(r)