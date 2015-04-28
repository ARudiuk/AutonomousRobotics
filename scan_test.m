NXT_init();
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

r = 2.8;
l = 5.5;
map = [50,-80,0,0,3.14];
goal = [0 0];
forward_threshold = 40;
goal_threshold = 50;
status = 0;
orientation_resolution = 30;    %Degrees within which the robot can allign itself with the wall
bump = 0;

[heading_to_goal,distance_to_goal] = cart2pol((goal(1) - map(end,1)),(goal(2) - map(end,2)));

%status = 0 --> The robot is far from its goal
%status = 1 --> The robot is close to its goal and is trying to allign
%itself with the walls
%status = 2 --> The robot's subtask is complete

forward_scan = ultrasonic_forward_measurement();

%Advance and check for obstacles
while status == 0
    while forward_scan < forward_threshold
        move(mAB,30);
        forward_scan = ultrasonic_forward_measurement;
        map = move_map_update(map,mAB);
    end
    
    goal_flag = [map(:,3) - goal(1), map(:,4) - goal(2)];
    [~,n] = size(goal_flag);
    for goal_counter = 1:size(n)
        if abs(goal_flag(goal_counter,1)<goal_threshold) && abs(goal_flag(goal_counter,2)<goal_threshold)
            status = 1;
        else
            status = 0;
        end
    end
    
    if status == 0
        for j = 1:360/orientation_resolution
            turn(mB,mA,turn_power,-reading_resolution*pi/180,l,r);
            map = turn_map_update(map,mA,mB,r,l);
            pause(0.2);
            distance(j) = ultrasonic_forward_measurement();
        end
        
        possible_directions = distance
        
        for j = 1:360/orientation_resolution
            heading_difference(j) = heading_to_goal - j*orientation_resolution
        end
        goal_heading = min(abs(heading_difference))
        %select route which has a heading most similar to the goal heading
    end
end

while status == 1
    .
    .
    .
    .
    .
end

if status == 2
    if bump === 0
        
    for j = 1:360/orientation_resolution
        turn(mB,mA,turn_power,-reading_resolution*pi/180,l,r);
        map = turn_map_update(map,mA,mB,r,l);
        pause(0.2);
        distance(j+1) = ultrasonic_forward_measurement();
    end
    
    [~,dir] = min(distance);
    turn(mB,mA,turn_power,((map(end,5)-dir)*pi/180),l,r);
    map = turn_map_update(map,mA,mB,r,l);
    
    while 
    %bump into a wall
    %if after a certain time the bump is unsuccessful, restart the
    %scan/bump
    %retreat and do another 360 degree scan 
    %figure out the heading from which side (left or right) has a wall by
    %it.
    %Allign heading with -pi/2 and end subtask
end