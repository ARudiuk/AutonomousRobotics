%We assume wheels are turning the same
function [] = turn(lwheel, rwheel, power, angle, l, r)
    lwheel.Power = power;
    rwheel.Power = -1*power;
        
    Phi_angle = abs(angle)*l/r;
    lwheel.TachoLimit = ceil(Phi_angle*180/pi);
    rwheel.TachoLimit = ceil(Phi_angle*180/pi);
    
    lwheel.SendToNXT();
    rwheel.SendToNXT();
end