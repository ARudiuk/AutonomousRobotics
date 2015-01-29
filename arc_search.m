%This function performs an arc search around the robots current location
%It stops when the sensor is above the pipeline
function [] = arc_search(angle_limit, bothWheels, power,found_test)
%Search in one direction first 90 degrees
    inplace_turn(bothWheels(1),bothWheels(2),power,angle_limit,found_test);    
    if found_test() == false %if not found rotate the other way 180 degrees
        inplace_turn(bothWheels(1),bothWheels(2),power,-angle_limit*2,found_test);
        if found_test() == false %if we failed to find it return to origin
            %by rotating 90 degrees the other way
            inplace_turn(bothWheels(1),bothWheels(2),power,angle_limit,found_test);
        end
    end     
end