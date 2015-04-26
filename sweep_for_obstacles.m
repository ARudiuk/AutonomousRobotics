% go along wall to the scan start
% if bump occurs, turn 90 and cross the map using the front scan to avoid any obstacles and align heading to parallel with line
% advance and scan in front of yourself
% if you detect something that is within a threshhold, treat as an obstacle
%     call obstacle avoidance
% if nothing is found, then advance until the location is close to a wall according to the map
%     

function [result,map,sweepnum] = sweep_for_obstacles(mA,mB,mAB,map)

current_location = [map(end,1), map(end,2)];
current_heading = map(end,5);

num_of_sweeps = 5;

top_of_map = max(map(:,4));

goal_x = 0;
goal_y = sweepnum*top_of_map/(num_of_sweeps + 1);

goal = [goal_x,goal_y];

[travel_heading,travel_dist] = cart2pol(goal - current_location);

heading_change = travel_heading - current_heading;
 
while heading_change > 2*pi
     heading_change = heading_change - 2*pi;
 end
 
while heading_change < -2*pi
    heading_change = heading_change + 2*pi;
end

turn
turn_map_update 



end