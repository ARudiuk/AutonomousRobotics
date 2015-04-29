NXT_init();
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

r = 2.8;
l = 5.5;

map = [0 0 0 0 pi/2];

move(mAB,30,r,80);
map = move_map_update(map,mAB,r);
turn(mA,mB,turn_power,pi/2,l,r);
map = turn_map_update(map,mA,mB,r,l);
move(mAB,30,r,50);
map = move_map_update(map,mAB,r);

goal = [0 0];
forward_threshold = 25;
goal_threshold = 35;
status = 0;
orientation_resolution = 30;    %Degrees within which the robot can allign itself with the wall
bump = 0;
turn_power = 30;

[heading_to_goal,distance_to_goal] = cart2pol((goal(1) - map(end,1)),(goal(2) - map(end,2)));

%status = 0 --> The robot is far from its goal
%status = 1 --> The robot is close to its goal and is trying to allign
%itself with the walls
%status = 2 --> The robot's subtask is complete

turn(mA,mB,turn_power,heading_to_goal-map(end,5),l,r);
map = turn_map_update(map,mA,mB,r,l);

%Advance and check for obstacles
while status == 0
    forward_scan = ultrasonic_forward_measurement();
    while forward_scan > forward_threshold
        move(mAB,30);
        forward_scan = ultrasonic_forward_measurement();
        map = move_map_update(map,mAB,r);
    end
    pause(0.1);
    goal_flag = [map(end,1) - goal(1), map(end,2) - goal(2)];
    if abs(goal_flag(1))<goal_threshold && abs(goal_flag(2))<goal_threshold
        status = 1
    else
        status = 0;
    end
    
    if status == 0
        [heading_to_goal,distance_to_goal] = cart2pol((goal(1) - map(end,1)),(goal(2) - map(end,2)));
        for j = 1:360/orientation_resolution
            turn(mA,mB,turn_power,-orientation_resolution*pi/180,l,r);
            map = turn_map_update(map,mA,mB,r,l);
            pause(0.1);
            distance(j) = ultrasonic_forward_measurement();
            if distance(j) > forward_threshold
                possible_directions(j) = heading_to_goal - map(end,5);
                while possible_directions(j) > pi
                    possible_directions(j) = possible_directions(j) - 2*pi;
                end
                while possible_directions(j) < -pi
                    possible_directions(j) = possible_directions(j) + 2*pi;
                end
            else
                possible_directions(j) = inf;
            end
        end
        possible_directions
        %select route which has a heading most similar to the goal heading
        [goal_heading,min_index] = min(abs(possible_directions));
        sgn = sign(possible_directions(min_index));
        goal_heading = sgn*goal_heading;
        turn(mA,mB,turn_power,goal_heading,l,r);
        map = turn_map_update(map,mA,mB,r,l);
    end
end

while status == 1
    while bump == 0
        for j = 1:360/orientation_resolution
            turn(mA,mB,turn_power,-orientation_resolution*pi/180,l,r);
            map = turn_map_update(map,mA,mB,r,l);
            pause(0.1);
            distance(j) = ultrasonic_forward_measurement();
        end
        
        [~,dir] = min(distance);
        dir = dir*orientation_resolution*pi/180;
        
        while dir > pi
            dir =  - 2*pi;
        end
        while dir < -pi
                dir = dir + 2*pi;
        end
        wall_heading = dir - map(end,5);
        turn(mA,mB,turn_power,wall_heading,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        move(mAB,30,r,15);
        map = move_map_update(map,mAB,r,NaN);
        bump = bump_measurement();
    end
    move(mAB,-30,r,10);
    map = move_map_update(map,mAB,r,NaN);
    right_side_scan = ultrasonic_measurement();
    if right_side_scan < goal_threshold
        turn(mA,mB,turn_power,-pi/2,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        move(mAB,30,r,goal_threshold);
        move(mAB,-30,r,10);
        map = move_map_update(map,mAB,r,NaN);
        turn(mA,mB,turn_power,-pi,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        status = 2;
    
    else
        turn(mA,mB,turn_power,pi/2,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        move(mAB,30,r,goal_threshold);
        move(mAB,-30,r,10);
        map = move_map_update(map,mAB,r,NaN);
        turn(mA,mB,turn_power,pi,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        status = 2;
    end
end
if status == 2
    map(end+1,1) = 0;
    map(end+1,2) = 0;
    map(end+1,5) = pi/2;
end

NXT_close;