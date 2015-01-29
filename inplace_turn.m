function [] = inplace_turn(leftWheel,rightWheel,power,angle,found_test)
    if angle<0
        power = -power;
    end
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
    while(found_test()==false && turn1.WaitFor(0.1))        
    end
    turn1.Stop('brake');
    turn2.Stop('brake');  
end