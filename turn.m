%We assume wheels are turning the same
function [] = turn(lwheel, rwheel, power, angle, l, r)
    dir = sign(angle);
    lwheel.Power = dir*power;
    rwheel.Power = -1*dir*power;
        
    Phi_angle = abs(angle)*l/r;
    lwheel.TachoLimit = ceil(Phi_angle*180/pi);
    rwheel.TachoLimit = ceil(Phi_angle*180/pi);
    
    lwheel.SendToNXT();
    rwheel.SendToNXT();
    lwheel.WaitFor();
    rwheel.WaitFor();
end