clear;

NXT_init;
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

map = [0 0 0 0 0];

distance_range = [10,30];
avg_range = (distance_range(1)+distance_range(2))/2;
threshold = distance_range(2);

%status 0 = nothing found within threshold
%status 1 = object sucessfully mapped
%status 2 = in progress
status = 2;
cone_angle = 90;        %The width of the scan angle for identifying the closest heading
reading_resolution = 10; %The extent that the robot will turn per scan
turn_power = 30;        %The motor power for the cone sweeps
l = 5.5;
r = 2.8;
tolerance = 20;         %The distance from the end of the obstacle which means its done
orbit_time = 30;        %Length of time after which the robot is assumed to not be within tolerance of it's starting position
tic;
too_far = tic;
end_flag = 0;           %Do not terminate the loop yet

turn(mB,mA,turn_power,cone_angle*pi/360,l,r);
map = turn_map_update(map,mA,mB,r,l);
distance(1) = ultrasonic_forward_measurement()
for j = 1:cone_angle/reading_resolution
    turn(mB,mA,turn_power,-reading_resolution*pi/180,l,r);
    map = turn_map_update(map,mA,mB,r,l);
    pause(0.2);
    distance(j+1) = ultrasonic_forward_measurement()
end


if min(distance) > threshold
    status = 0;
    end_flag = 1;
else
    [~,dir] = min(distance);
    turn(mB,mA,turn_power,((cone_angle/2-dir)*pi/180-pi/2),l,r);
    map = turn_map_update(map,mA,mB,r,l);
end

if end_flag == 0;
    orbit_end = [map(end,1),map(end,2)];
    bump = bump_measurement;
    orbit_status = 1;
end
    
while end_flag == 0
    if bump == 0
        move(mAB,30);
        %status
        %if we are alligned and moving forward
        if orbit_status == 1
            %update measured distance history
            side_distance = ultrasonic_measurement();
            map = move_map_update(map,mAB,r,side_distance);
            
            %check if appropriate distance
            if (side_distance<distance_range(1) || side_distance>distance_range(2))
                orbit_status = 3;
            end
        end
            
            %if we are trying to move away a certain distance
        if orbit_status == 3
            if side_distance <= distance_range(1)
                mAB.Stop('brake');
                turn(mA,mB,30,pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l);
                rotations = abs(avg_range-side_distance);
                move(mAB,30,r,rotations);
                map = move_map_update(map,mAB,r);
                turn(mA,mB,30,-pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l);
            elseif toc(too_far) > 4
                mAB.Stop('brake');
                move(mAB,30,r,12);
                map = move_map_update(map,mAB,r);
                turn(mA,mB,30,-pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l);
                move(mAB,30,r,avg_range+10);
                map = move_map_update(map,mAB,r);
                too_far = tic;
            end
            orbit_status = 1;
        end
    else
        %map the obstacle
        map(end+1,3) = map(end,1) + 11*cos(map(end,5));
        map(end+1,4) = map(end,2) + 11*cos(map(end,5));
        
        %Move away from obstacle in front
        move(mAB,-30,r,10);
        map = move_map_update(map,mAB,r);
        turn(mA,mB,30,pi/2,l,r)
        map = turn_map_update(map,mA,mB,r,l);
    end
    bump = bump_measurement;
    
    %If the robot is close to it's starting position
    if abs(orbit_end(1) - map(end,1)) < tolerance && abs(orbit_end(2) - map(end,2)) < tolerance
        if toc > orbit_time
            end_flag = 1;
        end
    end
    status = 1;
end
