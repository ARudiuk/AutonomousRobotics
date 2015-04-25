%We assume wheels are turning the same
function [] = move(wheels, power, tacholimit)
    wheels.ResetPosition();
    wheels.Power = power;
    if nargin < 3
        tacholimit = 0;
    end
    wheels.TachoLimit = tacholimit;    
    wheels.SendToNXT();
end