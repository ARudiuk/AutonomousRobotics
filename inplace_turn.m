%This function peforms an inplace turn that stops when the found_test
%passes.
function [] = inplace_turn(leftWheel,rightWheel,power,angle,found_test)
%Change direction of rotation depending on provided angle
    if angle<0
        power = -power;
    end
    %Set up parameters of the motor
    turn1 = NXTMotor();
    turn1.Port = leftWheel;
    turn1.Power = power;
    turn1.TachoLimit = abs(angle)*2;
    turn1.SmoothStart = true;
    turn1.SpeedRegulation = false;
    turn1.ActionAtTachoLimit = 'Holdbrake'; %Holdbrake, brake, or coast
    turn2 = NXTMotor();
    turn2.Port = rightWheel;
    turn2.Power = -power;
    turn2.TachoLimit = abs(angle)*2;
    turn2.SmoothStart = true;
    turn2.SpeedRegulation = false;
    turn2.ActionAtTachoLimit = 'Holdbrake'; %Holdbrake, brake, or coast
    turn1.ResetPosition();
    turn2.ResetPosition();
    turn1.SendToNXT();
    turn2.SendToNXT();
    %Keep turning until the motor is ready to take commands again or the
    %line is found. The WaitFor function will return true for a given time
    %parameter if the motor is busy by the end of the time period. By using
    %a small time period we quickly check the state of the motor this way.
    while(found_test()==false && turn1.WaitFor(0.1))        
    end
    %Stop the motor in case we found the line. Otherwise we would still be
    %turning. 
    turn1.Stop('brake');
    turn2.Stop('brake');  
end