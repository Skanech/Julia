SUM_TEMP=0
NUM_MARK=0
function start!(r)
    num_vert = moves!(r,Sud)
    num_hor = moves!(r,West)
    check!(r,Nord)
    ygol!(r)
    moves!(r, Nord, num_vert)
    moves!(r, Ost, num_hor)
    return SUM_TEMP/NUM_MARK
end
function check!(r,side)
    global SUM_TEMP, NUM_MARK
    while isborder(r,Ost)==false
        while isborder(r,side)==false
            if ismarker(r)==true
                SUM_TEMP += temperature(r)
                NUM_MARK += 1
            end
            move!(r,side)
        end
        move!(r,Ost)
        while isborder(r,inverse(side))==false
            if ismarker(r)==true
                SUM_TEMP += temperature(r)
                NUM_MARK += 1
            end
            move!(r,inverse(side))
        end
        if isborder(r,Ost)==false
            move!(r,Ost)
        end
    end
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
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end

start!(r)