%We assume wheels are turning the same
function [] = turn(lwheel, rwheel, power, phi)
    power
    lwheel.ResetPosition();
    lwheel.Power = power;
    rwheel.Power = -1*power;
    lwheel.SendToNXT();
    rwheel.SendToNXT();
    temp = 0;
    while(temp<phi)
        temp = lwheel.ReadFromNXT().Position;
    end
    lwheel.Stop('brake');
    rwheel.Stop('brake');
end