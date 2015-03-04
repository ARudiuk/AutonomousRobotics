%Planner
%This is the overall planner
%all units are SI. I.e distances are in meters, etc. 
%Establish connection to NXT
NXT_init();
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
%Set coordinate points the robot wants to reach
goals = generate_polygon(4,0.2);
position_x = goals(end,1);
position_y = goals(end,2);
%theta is the current angle in radians
theta = 0;
%l is the distance between the wheels halved
l = 0.055;
%r is the radiaus of the wheels
r = 0.028;
while(~isempty(goals))
    %pop out first element
    goal_x = goals(1,1);
    goal_y = goals(1,2);
    goals(1,:)=[];    
    dx = goal_x - position_x;
    dy = goal_y - position_y;
    rho = sqrt((dx)^2+(dy)^2);
    alpha = -theta+atan2(dy,dx);
    Sgn = sign(alpha);
    if abs(alpha) > pi
        alpha = 2*pi - abs(alpha);
        alpha = -Sgn*alpha;
    end
    %phi is how much the wheels need to be turned
    %for now we assume the turn at the same rate
    Phi_angle = abs(alpha)*l/r;
    Phi_angle = Phi_angle*180/pi; %convert to degrees
    power = 40;
    if alpha<0
        power = -power;
    end
    turn(mA,mB,power,Phi_angle);
    Phi_distance = rho/(2*pi*r);
    Phi_distance = Phi_distance*360;
    power = 40;
    straight(mAB,power,Phi_distance);
    position_x = goal_x;
    position_y = goal_y;
    theta = theta + alpha;
end
mA.Stop('brake');
mB.Stop('brake');
mAB.Stop('brake');
NXT_exit();
