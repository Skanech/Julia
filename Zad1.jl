function start!(r::Robot) # главная функция, благодаря которой стартует робот и выполняются все подфункции
    for side in (Nord,West,Sud,Ost) # перебираются все возможные направления
        putmarkers!(r,side) # вызывает функцию
        move_by_markers(r,inverse(side)) # двигается по маркерам в обратном выбранному направлению после проставления маркеров дойдя до стенки
    end
    putmarker!(r) # ставится маркер на исходном месте
end
function putmarkers!(r::Robot,side::HorizonSide) # ставит маркеры на выбранном направлении до стенки
    while isborder(r,side)==false # двигается в выбранном направлении, пока не дойдет до стенки
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