%This function performs an arc search
function [found] = arc_search(angle_limit, angle_step_size, bothWheels, light_threshold,power)
    found = false;%search state
    [turn1,turn2] = inplace_turn(bothWheels(1),bothWheels(2),power,angle_step_size);
    [turn3,turn4] = inplace_turn(bothWheels(1),bothWheels(2),power,-angle_step_size);
    turn1.ResetPosition();
    turn2.ResetPosition();
    i = angle_step_size;
    while i<=angle_limit && found == false
        i = i + angle_step_size;
        turn1.SendToNXT();
        turn2.SendToNXT();
        turn1.WaitFor();
        turn2.WaitFor();
        light = GetLight(SENSOR_3);
        if light<light_threshold
            found = true;
        end
    end
    if found == false 
        reset_turn(turn1,turn2,power)
        i = -angle_step_size;
        while i>=-angle_limit && found == false
            i = i - angle_step_size;
            turn3.SendToNXT();
            turn4.SendToNXT();
            turn3.WaitFor();
            turn4.WaitFor();
            light = GetLight(SENSOR_3);
            if light<light_threshold
                found = true;
            end  
        end
    end
    
    if found == false
        reset_turn(turn3,turn4,-power);
    end    
end