function [scan,bump] = move_update_scan(mAB,motor_power,tolerance,map)
distance = 10*tolerance;
bump = 0;
%consider disabling the side scanner if weird results start happening
move(mAB,motor_power);
while distance > tolerance
    [map] = move_update;    %update map from forward motion
    distance = ultrasonic_forward_measurement;

    %check the bump sensor
    bump = bump_measurement();
    if bump == 1;
       distance = 11; %The distance that the bump sensor end is in front of the wheel base
    end
end
scan(1) = map(end,1) + distance*cos(map(end,5));
scan(2) = map(end,2) + distance*sin(map(end,5));
mAB.Stop('brake');