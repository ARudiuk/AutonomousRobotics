%We assume wheels are turning the same
function [] = turn(rwheel, lwheel, power, angle, l, r)
    dir = sign(angle);
    lwheel.Power = -1*dir*power;
    rwheel.Power = dir*power;
        
    Phi_angle = abs(angle)*l/r;
    lwheel.TachoLimit = ceil(Phi_angle*180/pi);
    rwheel.TachoLimit = ceil(Phi_angle*180/pi);
    
    lwheel.SendToNXT();
    rwheel.SendToNXT();    
    lwheel.WaitFor(1);
    rwheel.WaitFor(1);
    while abs(lwheel.ReadFromNXT().Power)>10
        lwheel.WaitFor(1);
        rwheel.WaitFor(1);
    end
    lwheel.Stop('brake');
    rwheel.Stop('brake');
end