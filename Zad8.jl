function start!(r)
    side=Ost
    while isborder(r,Nord)==true
        putmarker!(r)
        move_by_markers!(r,side)
        side=inverse(side)
    end
end
function move_by_markers!(r,side)
    while ismarker(r)==true
        move!(r,side)
    end
end
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end

start!(r)