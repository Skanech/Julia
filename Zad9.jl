function start!(r)
    max_num_steps=1
    side=Nord
    while ismarker(r)==false
        for _ in 1:2
            find_marker!(r,side,max_num_steps)
            side=next_side(side)
        end
        max_num_steps+=1
    end
end
function find_marker!(r,side,max_num_steps)
    for _ in 1:max_num_steps
        if ismarker(r)
            return nothing
        end
        move!(r,side)
    end
end
function next_side(side::HorizonSide)
    HorizonSide(mod(Int(side)+1,4))
end

start!(r)