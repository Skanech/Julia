function start!(r)
    num_vert = moves!(r,Sud)
    num_hor = moves!(r,West)

    if mod(num_vert+num_hor,2)==0
        space_dot!(r,Ost)
        move!(r,Nord)
        space_dot!(r,West)
        move!(r,Nord)
        space_dot!(r,Ost)
        move!(r,Nord)
        space_dot!(r,West)
        move!(r,Nord)
        space_dot!(r,Ost)
        move!(r,Nord)
        space_dot!(r,West)
        move!(r,Nord)
        space_dot!(r,Ost)
        move!(r,Nord)
        space_dot!(r,West)
        move!(r,Nord)
        space_dot!(r,Ost)
        move!(r,Nord)
        space_dot!(r,West)
        move!(r,Nord)
        space_dot!(r,Ost)
    else
        dot_space!(r,Ost)
        move!(r,Nord)
        dot_space!(r,West)
        move!(r,Nord)
        dot_space!(r,Ost)
        move!(r,Nord)
        dot_space!(r,West)
        move!(r,Nord)
        dot_space!(r,Ost)
        move!(r,Nord)
        dot_space!(r,West)
        move!(r,Nord)
        dot_space!(r,Ost)
        move!(r,Nord)
        dot_space!(r,West)
        move!(r,Nord)
        dot_space!(r,Ost)
        move!(r,Nord)
        dot_space!(r,West)
        move!(r,Nord)
        dot_space!(r,Ost)
    end
    ygol!(r)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
end
function dot_space!(r,side)
    move!(r,side)
    n=0
    while n!=5
        putmarker!(r)
        move!(r,side)
        move!(r,side)
        putmarker!(r)
        n+=1
    end
end
function space_dot!(r,side)
    n=0
    while n!=5
        putmarker!(r)
        move!(r,side)
        move!(r,side)
        putmarker!(r)
        n+=1
    end
    move!(r,side)
end
function moves!(r::Robot, side::HorizonSide)
    num_steps=0 # создает переменную и возвращает ей прежнее значение
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1 # переменная равна прошлому значению плюс один
    end
    return num_steps # возвращает переменную
end
function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for _ in 1:num_steps # символ "_" заменяет не используемую переменную
        move!(r,side)
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

start!(r)