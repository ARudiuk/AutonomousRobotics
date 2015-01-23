%This function performs an arc search
%This consists of rotating a fixed 
function [found] = arc_search(distance_limit, angle_limit, angle_step_size, bothWheels, light_threshold,power)
    found = false;
    [turn1,turn2] = inplace_turn(bothWheels(1),bothWheels(2),power,angle_step_size);
    [turn3,turn4] = inplace_turn(bothWheels(1),bothWheels(2),power,-angle_step_size);
    turn1.ResetPosition();
    turn2.ResetPosition();
    i = 0;
    while i<=angle_limit && found == false
        i = i + angle_step_size;
        turn1.SendToNXT();
        turn2.SendToNXT();
        turn1.WaitFor();
        turn2.WaitFor();
        light = GetLight(SENSOR_3)
        if light<light_threshold
            found = true;
        end        
    end
    if found == false 
        reset_turn(turn1,turn2,power)
        i = 0;
        while i>=-angle_limit && found == false
            i = i - angle_step_size;
            turn3.SendToNXT();
            turn4.SendToNXT();
            turn3.WaitFor();
            turn4.WaitFor();
            light = GetLight(SENSOR_3)
            if light<light_threshold
                found = true;
            end        
        end
    end
    
    if found == false
        reset_turn(turn3,turn4,-power)
    end    
end

function [] = reset_turn(turn1,turn2,power)    
    data1 = turn1.ReadFromNXT();
    data2 = turn2.ReadFromNXT(); 
    pos = abs(data1.Position)
    power1 = power;
    power2 = -power;
    turn1.ResetPosition();
    turn2.ResetPosition();
    turn1.TachoLimit = pos;
    turn2.TachoLimit = pos;    
    turn1.Power = -power1;
    turn2.Power = -power2;
    turn1.SendToNXT();
    turn2.SendToNXT();
    turn1.WaitFor();
    turn2.WaitFor();
    turn1.ResetPosition();
    turn2.ResetPosition();
end