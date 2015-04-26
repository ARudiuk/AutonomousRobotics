function [map] = turn_map_update(map,mA,mB,r,l)
    wheel_turn = mA.ReadFromNXT().Position;
    mA.ResetPosition();
    mB.ResetPosition();
    alpha = (wheel_turn*r*pi)/(l*180)
    new_heading = map(end,5)+alpha
    while new_heading>2*pi
        new_heading = new_heading-2*pi;
    end
    while new_heading<-2*pi
        new_heading = new_heading+2*pi;
    end
    map = [map;map(end,1) map(end,2) map(end,3) map(end,4) new_heading];
    draw(map)
end