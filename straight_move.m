%Wheels are 56mm
%between wheels is 11.5cm
%This function makes the motor turn both wheels together to move forward or
%backward
function [move] = straight_move(bothWheels,power,distance, found_test)
%Set up various parameters of the motor
    move = NXTMotor();
    move.Port = bothWheels;
    move.Power = power;
    temp = distance*360/(pi*56);
    move.TachoLimit = round(temp);
    move.SmoothStart = true;
    move.SpeedRegulation = false;
    move.ActionAtTachoLimit = 'HoldBrake'; %Holdbrake, brake, or coast
    %if using holdbrake a stop must be used to stop engine    
    if distance == 0 %If going forever. This happens when on the line.       
        move.SendToNXT();
        %Since turning moves us backwards a bit, make sure to move forward
        %a bit before checking for pipeline again
        pause(0.4);
        %Keep going until we loose the line.
        while(found_test()==true)                
        end
    else
        move.SendToNXT();
        %Keep going until the motor stops or we find the line
        while(found_test()==false && move.WaitFor(0.1))                
        end
    end    
    %make sure the motor is stopped at the end
    move.Stop('brake');
end