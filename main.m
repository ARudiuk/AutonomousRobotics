%This is the main body of the NXT controller
%Initialize a connection to the NXT
NXT_init();
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

%l is the distance between the wheels halved
l = 5.5;
%r is the radius of the wheels
r = 2.8;
%Initializing a map counter
i = 1;

position = [0,0];
map = [];
goal = [];

%1-Leave Starting Area
meta_goal_completed = 0;
while(meta_goal_completed == 0)
    temp = find_wall(mAB,30);
    if temp == 1
        meta_goal_completed = 1;
    end
end

%2-Map Walls
meta_goal_completed = 0;
while(meta_goal_completed == 0)
    for i = 1:4
        [temp1,map,map2,i] = wall_follow(position,mA,mB,mAB,20,r,l,i);
        position = map(end,1:2);
        if temp1 == 1
            temp2 = corner_turn(mAB,mA,mB,l,r);
            if temp2 == 1
                meta_goal_completed = 1;
            end
        end
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