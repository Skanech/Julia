function start!(r::Robot)
    for side in (Nord, West, Sud, Ost)
        num_steps = putmarkers(r,side)
        go_over_obstacles(r,inverse(side), num_steps)
    end
    putmarker!(r)
end

function putmarkers(r::Robot,side::HorizonSide)
    num_steps=0 
    while move_if_true(r, side) == true
        putmarker!(r)
        num_steps += 1
    end 
    return num_steps
end

function go_over_obstacles(r::Robot, side::HorizonSide, num_steps::Int)
    for _ in 1:num_steps
        move_if_true(r,side)
    end
end

function move_if_true(r::Robot, direct_side::HorizonSide)::Bool
    orthogonal_side = next_side(direct_side)
    reverse_side = inverse(orthogonal_side)
    num_steps=0
    if isborder(r,direct_side)==false
        move!(r,direct_side)
        result=true
    else
        while isborder(r,direct_side) == true
            if isborder(r, orthogonal_side) == false
                move!(r, orthogonal_side)
                num_steps += 1
            else
                break
            end
        end
        if isborder(r,direct_side) == false
            move!(r,direct_side)
            while isborder(r,reverse_side) == true
                move!(r,direct_side)
            end
            result = true
        else
            result = false
        end
        while num_steps>0
            num_steps=num_steps-1
            move!(r,reverse_side)
        end
    end
    return result
end

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end

function next_side(side::HorizonSide)
    HorizonSide(mod(Int(side)-1,4))
end