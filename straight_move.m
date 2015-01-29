%Wheels are 56mm
%between wheels is 11.5cm
function [move] = straight_move(bothWheels,power,distance, found_test)
    move = NXTMotor();
    move.Port = bothWheels;
    move.Power = power;
    temp = distance*360/(pi*56);
    move.TachoLimit = round(temp);
    move.SmoothStart = true;
    move.SpeedRegulation = false;
    move.ActionAtTachoLimit = 'HoldBrake'; %Holdbrake, brake, or coast
    %if using holdbrake a stop must be used to stop engine    
    if distance == 0        
        move.SendToNXT();
        %Since turning moves us backwards a bit, make sure to move forward
        %a bit before checking for pipeline again
        pause(0.4);
        while(found_test()==false)                
        end
    else
        move.SendToNXT();
        while(found_test()==false && move.WaitFor(0.1))                
        end
    end    
    move.Stop('brake');
end