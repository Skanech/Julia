DEVIATION_NORD=0
DEVIATION_SUD=0
DEVIATION_HOR=0
CAKE_IS_A_LIE=0
I_AM_YOUR_FATHER=0
function start!(r::Robot)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    putmarker!(r)
    robot_path = RobotPath{Robot}(r)
    while !isborder(robot_path,Sud) || !isborder(robot_path,West)
        movements!(robot_path,Sud)
        movements!(robot_path,West)
    end
    while isborder(r,Ost)==false
        putmarkers!(r,Nord)
        if CAKE_IS_A_LIE==0
            check_putmarker!(r,Nord)
        else
            CAKE_IS_A_LIE=0
        end
        while isborder(r,Nord)==false
            move!(r,Nord)
            check_wall_without_putmarker!(r,Nord)
        end
        move!(r,Ost)
        putmarkers!(r,Sud)
        if CAKE_IS_A_LIE==0
            check_putmarker!(r,Sud)
        else
            CAKE_IS_A_LIE=0
        end
        while isborder(r,Sud)==false
            move!(r,Sud)
        end
        if isborder(r,Ost)==false
            check_wall_without_putmarker!(r,Sud)
            move!(r,Ost)
        end
    end
    while isborder(r,West)==false
        move!(r,West)
    end
    movements_to_back!(robot_path)
end
function movements!(r,side)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    while isborder(r,side)==false
        move!(r,side)
        if side==Sud
            DEVIATION_SUD += 1
        end
    end
end
function putmarkers!(r,side)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    I_AM_YOUR_FATHER=0
    if side==Nord
        DEVIATION_NORD = 10-DEVIATION_SUD
        while DEVIATION_SUD!=0
            if isborder(r,side)==false
                move!(r,side)
                DEVIATION_SUD -= 1
            else
                check_wall!(r,side)
            end
        end
    else
        DEVIATION_SUD = 10-DEVIATION_NORD
        while DEVIATION_NORD!=0
            if isborder(r,side)==false
                move!(r,side)
                DEVIATION_NORD -= 1
            else
                check_wall!(r,side)
            end
        end
    end
end
function check_putmarker!(r,side)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    if side==Nord
        if ismarker(r)==false
            putmarker!(r)
            while isborder(r,side)==true && I_AM_YOUR_FATHER==0
                check_wall_without_putmarker!(r,side)
            end
        else
            putmarker_vert!(r,Nord)
        end
    else
        if ismarker(r)==false
            putmarker!(r)
            while isborder(r,side)==true && I_AM_YOUR_FATHER==0
                check_wall_without_putmarker!(r,side)
            end
        else
            putmarker_vert!(r,Sud)
        end
    end
end
function check_wall!(r,side)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    while isborder(r,side)==true && isborder(r,West)==false
        move!(r,West)
        DEVIATION_HOR += 1
    end
    if isborder(r,side)==false
        if side==Nord
            move!(r,side)
            DEVIATION_SUD -= 1
            while isborder(r,Ost)==true
                move!(r,side)
                DEVIATION_SUD -= 1
            end
            while DEVIATION_HOR!=0
                move!(r,Ost)
                DEVIATION_HOR -= 1
            end
            if DEVIATION_SUD<0
                DEVIATION_SUD=0
                CAKE_IS_A_LIE=1
            end
        else
            move!(r,side)
            DEVIATION_NORD -= 1
            while isborder(r,Ost)==true
                move!(r,side)
                DEVIATION_NORD -= 1
            end
            while DEVIATION_HOR!=0
                move!(r,Ost)
                DEVIATION_HOR -= 1
            end
            if DEVIATION_NORD<0
                DEVIATION_NORD=0
                CAKE_IS_A_LIE=1
            end
        end
    end
end
function check_wall_without_putmarker!(r,side)
    global DEVIATION_NORD, DEVIATION_SUD, DEVIATION_HOR, CAKE_IS_A_LIE, I_AM_YOUR_FATHER
    while isborder(r,side)==true && isborder(r,West)==false
        move!(r,West)
        DEVIATION_HOR += 1
    end
    if isborder(r,side)==true && isborder(r,West)==true
        I_AM_YOUR_FATHER=1
        while DEVIATION_HOR!=0
            move!(r,Ost)
            DEVIATION_HOR -= 1
        end
    else
        move!(r,side)
        while isborder(r,Ost)==true
            move!(r,side)
        end
        while DEVIATION_HOR!=0
            move!(r,Ost)
            DEVIATION_HOR -= 1
        end
    end
end
function putmarker_vert!(r,side)
    while isborder(r,inverse(side))==false
        move!(r,inverse(side))
        if isborder(r,inverse(side))==true
            check_wall_without_putmarker!(r,inverse(side))
            putmarker!(r)
        end
    end
    putmarker!(r)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
        if isborder(r,side)==true
            check_wall_without_putmarker!(r,side)
            putmarker!(r)
        end
    end
end
function inverse(side::HorizonSide)
    HorizonSide(mod(Int(side)+2,4))
end