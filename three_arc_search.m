function [found] = three_arc_search(distance_limit, angle_limit, bothWheels, power,found_test)
    %turn one way first    
    inplace_turn(bothWheels(1),bothWheels(2),power,60,found_test);
    %move forward
    straight_move(bothWheels,50,distance_limit,found_test);
    arc_search(angle_limit, bothWheels, power,found_test);
    if found_test() == true
        return
    end    
    straight_move(bothWheels,-40,distance_limit,found_test);
    inplace_turn(bothWheels(1),bothWheels(2),power,-45,found_test);    
    straight_move(bothWheels,50,distance_limit,found_test);
    arc_search(angle_limit, bothWheels, power,found_test);
    if found_test() == true
        return
    end
    straight_move(bothWheels,-40,distance_limit,found_test);    
    inplace_turn(bothWheels(1),bothWheels(2),power,-45,found_test); 
    straight_move(bothWheels,50,distance_limit,found_test);
    arc_search(angle_limit, bothWheels, power,found_test);
    if found_test() == true
        return
    end
    straight_move(bothWheels,-40,distance_limit,found_test);
    inplace_turn(bothWheels(1),bothWheels(2),power,45,found_test);
end