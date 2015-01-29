%This function search in an arc ahead of the robot
%It does it by going out three times at three different angles and
%performing an arc search at each point
function [] = three_arc_search(distance_limit, angle_limit, bothWheels, power,found_test)
    %turn one way first    
    inplace_turn(bothWheels(1),bothWheels(2),power,60,found_test);
    %move forward
    straight_move(bothWheels,50,distance_limit,found_test);
    %look around the point
    arc_search(angle_limit, bothWheels, power,found_test);
    %if we found it then stop
    if found_test() == true
        return
    end
    %move back
    straight_move(bothWheels,-40,distance_limit,found_test);
    %repeat previous steps several times
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
    %If we failed to find the line then return to origin
    straight_move(bothWheels,-40,distance_limit,found_test);
    inplace_turn(bothWheels(1),bothWheels(2),power,45,found_test);
end