function [] = reset_turn(turn1,turn2,power)    
    data1 = turn1.ReadFromNXT();
    data2 = turn2.ReadFromNXT(); 
    pos = abs(data1.Position);
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