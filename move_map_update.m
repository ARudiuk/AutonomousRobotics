%update map based on the assumption we are moving forward
%can optionally pass in an ultrasonic reading if one was already taken 
function [map] = move_map_update(map,mAB,r,reading)
    if nargin<4
        reading = ultrasonic_measurement();
        if reading > 100
            reading = NaN;
        end
    end
    wheel_turn = mAB.ReadFromNXT().Position;
    mAB.ResetPosition();
    rho = (wheel_turn*r*pi)/(180);
    [x,y] = pol2cart(map(end,5),rho);
    map = [map;map(end,1)+x map(end,2)+y map(end,1)+x+reading*cos(map(end,5)-pi/2) map(end,2)+y+reading*sin(map(end,5)-pi/2) map(end,5)];
    if (toc-tic)>1
        draw(map);
        tic;
    end
end