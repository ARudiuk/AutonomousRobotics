%We assume wheels are turning the same
function [] = straight(wheels, power, phi)
    wheels.ResetPosition();
    wheels.Power = power;
    wheels.SendToNXT();
    temp = 0;
    while(temp<phi)
        temp = wheels.ReadFromNXT().Position;
    end
    wheels.Stop('brake');
end