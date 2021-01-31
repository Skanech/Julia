function start!(r::Robot)
    num=0
    way = ygol1_and_return(r)

    putmarker!(r)
    while !isborder(r,Ost)
        move!(r,Ost)
        putmarker!(r)
    end
    length_field=move_and_return(r,West)

    while !isborder(r,Nord) && length_field > 0
        need_markers = length_field
        move!(r,Nord)
        while need_markers > 0
            putmarker!(r)
            need_markers -= go_over_obstacles_and_return(r,Ost)
        end
        back_over_obstacles(r,West)
        length_field-=1
    end

    ygol1(r)
    move_by_the_way(r,way)
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

function move_and_return(r::Robot,side::HorizonSide) :: Int
    n=0
    while isborder(r,side)==false
        move!(r,side)
        n=n+1
    end 
    return n
end

function move_by_the_way(r,way::Array)
    n=length(way)
    while n>0
        move!(r,way[n])
        n=n-1
    end
end

function go_over_obstacles_and_return(r::Robot, side::HorizonSide) ::Int
    num_steps=0
    while isborder(r,side) && !isborder(r,previous_side(side))
        move!(r,previous_side(side))
        num_steps+=1
    end
    steps_taken =0
    if !isborder(r,side)
        move!(r,side)
        steps_taken +=1
    end
    if num_steps != 0
        while isborder(r, inverse(previous_side(side)))
            move!(r,side)
            steps_taken +=1
        end
        for _ in 1:num_steps
            move!(r, inverse(previous_side(side)))
        end
    end
    return steps_taken 
end

function back_over_obstacles(r::Robot, side::HorizonSide)
    steps_taken = 1
    while steps_taken !=0
        steps_taken = go_over_obstacles_and_return(r,side)
    end
end

function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end

function next_side(side::HorizonSide)
    HorizonSide(mod(Int(side)-1,4))
end

function previous_side(side::HorizonSide)
    HorizonSide(mod(Int(side)+1,4))
end

start!(r)