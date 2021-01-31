function start!(r::Robot)
    x=Ost
    y=Nord
    way = ygol1_and_return(r)
    while isborder(r,x)==false
        putmarkers_by_the_way(r,y)
        if !isborder(r,x)
            move!(r,x)
        end
        side_vert=inverse(y)
    end
    putmarkers_by_the_way(r,y)
    ygol1(r)
    move_by_the_way(r,way)
end

function putmarkers_by_the_way(r::Robot,side::HorizonSide)
    putmarker!(r)
    while move_if_true(r,side) == true
        putmarker!(r)
    end
    while move_if_true(r,inverse(side))
        putmarker!(r)
    end
end

function move_by_the_way(r,way::Array)
    n=length(way)
    while n>0
        move!(r,way[n])
        n=n-1
    end
end

function ygol1(r::Robot)
    while isborder(r,West)==false || isborder(r,Sud)==false
        if isborder(r,West)==false
            move!(r,West)
        end
        if isborder(r,Sud)==false
            move!(r,Sud)
        end
    end
end

function ygol1_and_return(r::Robot) ::Array
    way=[]
    while isborder(r,Sud)==false || isborder(r,West)==false
        if isborder(r,Sud)==false
            move!(r,Sud)
            push!(way,Nord)
        end
        if isborder(r,West)==false
            move!(r,West)
            push!(way,Ost)
        end
    end
    return way
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

start!(r)