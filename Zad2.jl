function start!(r::Robot)
    num_vert = moves!(r,Sud)
    num_hor = moves!(r,West) # передвигают робота в начальное положение, запоминая кол-во сделанных шагов
    for side in (Nord,Ost,Sud,West) # расставляет маркеры по часовой стрелки вдоль стенки
        putmarkers!(r, side)
    end
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor) # перемещают робота на исходное положение
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
function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end

start!(r)