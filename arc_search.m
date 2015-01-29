%This function performs an arc search
function [] = arc_search(angle_limit, bothWheels, power,found_test)
    inplace_turn(bothWheels(1),bothWheels(2),power,angle_limit,found_test);    
    if found_test() == false
        inplace_turn(bothWheels(1),bothWheels(2),power,-angle_limit*2,found_test);
        if found_test() == false
            inplace_turn(bothWheels(1),bothWheels(2),power,angle_limit,found_test);
        end
    end     
end