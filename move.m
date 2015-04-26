%We assume wheels are turning the same
function [] = move(wheels, power, r, distance)
    wheels.ResetPosition();
    wheels.Power = power;
    tacholimit = 0;
    if nargin > 2
        tacholimit = ceil((distance*180)/(pi*r));
    end
    wheels.TachoLimit = tacholimit;
    wheels.SendToNXT();
    if tacholimit ~= 0
        wheels.WaitFor();
        wheels.Stop('brake');
    end
end