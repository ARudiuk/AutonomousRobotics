function [turn1,turn2] = inplace_turn(leftWheel,rightWheel,power,angle)
    if angle<0
        power = -power;
    end
    turn1 = NXTMotor();
    turn1.Port = leftWheel;
    turn1.Power = power;
    turn1.TachoLimit = angle*2;
    turn1.SmoothStart = true;
    turn1.SpeedRegulation = false;
    turn1.ActionAtTachoLimit = 'Brake'; %Holdbrake, brake, or coast
    turn2 = NXTMotor();
    turn2.Port = rightWheel;
    turn2.Power = -power;
    turn2.TachoLimit = angle*2;
    turn2.SmoothStart = true;
    turn2.SpeedRegulation = false;
    turn2.ActionAtTachoLimit = 'Brake'; %Holdbrake, brake, or coast
    turn1.SendToNXT();
    turn2.SendToNXT();
end