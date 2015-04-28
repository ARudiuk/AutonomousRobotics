clc;

NXT_init();

mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

map = [0 0 50 50 0];

sweepnum = 1;

threshold = 40;

l = 5.5;
r = 2.6;

current_location = [map(end,1), map(end,2)];
current_heading = map(end,5);

num_of_sweeps = 5;

top_of_map = max(map(:,4));

goal_x = 0;
goal_y = sweepnum*top_of_map/(num_of_sweeps + 1);

goal = [goal_x,goal_y];
goal_minus_current = goal - current_location;

[travel_heading,travel_dist] = cart2pol(goal_minus_current(1),goal_minus_current(2));

heading_change = travel_heading - current_heading;
 
while heading_change > 2*pi
     heading_change = heading_change - 2*pi;
 end
 
while heading_change < -2*pi
    heading_change = heading_change + 2*pi;
end

turn(mB,mA,turn_power,heading_change,l,r);
map = turn_map_update(map,mA,mB,r,l);

move(mAB,30,r,travel_dist);
map = move_map_update(map,mAB,r);

turn(mB,mA,turn_power,pi/2,l,r);
map = turn_map_update(map,mA,mB,r,l);

forward_scan = ultrasonic_forward_measurement();
while forward_scan < threshold
    move(mAB,30,r,abs(map(end,1)) - max(map(:,1)));
    map = move_map_update(map,mA,mB,r);
    forward_scan = ultrasonic_forward_measurement();
end

cartesian_forward_scan = [map(end,1)+forward_scan*cos(map(end,5)),map(end,2)+forward_scan*sin(map(end,5))];

id_status = obstacle_identification(map,cartesian_forward_scan,id_tolerance);

if id_status == 1
    map = obstacle_avoidance(mA,mB,mAB,map);
elseif id_status == 0 
    forward_scan = ultrasonic_forward_measurement;
    [map,~] = map_obstacle(mA,mB,mAB,map,distance_range);
    [map,~] = obstacle_avoidance(mA,mB,mAB,map);
end