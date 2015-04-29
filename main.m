%This is the main body of the NXT controller
%Initialize a connection to the NXT
NXT_init();
tic;
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

%l is the distance between the wheels halved
l = 5.5;
%r is the radius of the wheels
r = 2.8;

map = [0 0 0 0 pi/2];
map2 = [0 0];

%1-Leave Starting Area
meta_goal_completed = 0;
while(meta_goal_completed == 0)
    temp = find_wall(mAB,30);
    if temp == 1
        meta_goal_completed = 1;
    end
end
%still assume we are pointing in the same direction, and that we are now at
%0,0
%2-Map Walls
meta_goal_completed = 0;
i = 1;
while(meta_goal_completed == 0)    
    [wall_follow_success,map,map2] = wall_follow(map,map2,mA,mB,mAB,r,l,[15,30],i*pi/2);
    if wall_follow_success == 1
        [bump_true, map] = corner_turn(map,map2,mAB,mA,mB,l,r,(i+1)*pi/2);
        if map(end,2)<=-20
            meta_goal_completed = 1;
        end
        i = i+1;
    end
 end

% %3-Map Inner Area
% meta_goal_completed = 0;
% while(meta_goal_completed == 0)
%     
% end
% 
% %4-Return
% meta_goal_completed = 0;
% while(meta_goal_completed == 0)
%     
% end
% %5-Finished
%Close the connection to the NXT when done
NXT_close();