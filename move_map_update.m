%update map based on the assumption we are moving forward
%can optionally pass in an ultrasonic reading if one was already taken 
function [map,map2] = move_map_update(map,map2,mAB,r,reading,reading2)
    tic();
    if nargin<6
        reading = ultrasonic_measurement();
        reading2 = ultrasonic_forward_measurement();
        if reading2 > 125
            reading = NaN;
        end
    end
    wheel_turn = mAB.ReadFromNXT().Position;
    mAB.ResetPosition();
    rho = (wheel_turn*r*pi)/(180);
    [x,y] = pol2cart(map(end,5),rho);
    map = [map;map(end,1)+x map(end,2)+y map(end,1)+x+reading*cos(map(end,5)-pi/2) map(end,2)+y+reading*sin(map(end,5)-pi/2) map(end,5)];
    map2 = [map2;map(end,1)+x+reading2*cos(map(end,5)+pi/2) map(end,2)+y+reading2*sin(map(end,5)+pi/2)];
    if (toc())>3
        draw(map,map2);
        tic();
    end
end