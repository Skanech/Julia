function start!(r::Robot) # главная функция, благодаря которой стартует робот и выполняются все подфункции
    num_vert = moves!(r,Sud)
    num_hor = moves!(r,West) # передвигают робота в начальное положение, запоминая кол-во сделанных шагов
    for x in (11,10,9,8,7,6,5,4,3,2,1)
        putmarkers!(r,Ost,x)
        move_by_markers(r,inverse(Ost))
        if isborder(r,Nord)==false
            move!(r,Nord)
        end
    end
    putmarker!(r) # ставит маркер в клетке, в которой находится
    putmarkers!(r,Sud) # ставит маркеры по пути к стенке на Юг
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
function putmarkers!(r::Robot,side::HorizonSide) # ставит маркеры на выбранном направлении до стенки
    while isborder(r,side)==false # двигается в выбранном направлении, пока не дойдет до стенки
        move!(r,side) # двигается по выбранной стороне
        putmarker!(r) # ставится маркер
    end
end
function putmarkers!(r::Robot,side::HorizonSide,num_steps::Int) # ставит маркеры на выбранном направлении до стенки
    for _ in 1:num_steps
        move!(r,side) # двигается по выбранной стороне
        putmarker!(r) # ставится маркер
    end
end
function move_by_markers(r::Robot,side::HorizonSide) # робот двигается по дороге из маркеров, пока не дойдет до клетки без маркера
    while ismarker(r)==true # пока есть маркер
        move!(r,side) # двигается по выбранной стороне
    end
end
function inverse(side::HorizonSide) # инверсия выбранной стороны
    HorizonSide(mod(Int(side)+2,4)) # рассчитывается противоположная сторона света
end

start!(r)