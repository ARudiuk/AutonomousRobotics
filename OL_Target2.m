%This code is a function which accepts a 2D target as a vector of two
%elements, <x,y> in the NXT robot's flatland reference frame and commands
%the robot to drive to that location. Following this, a variable is
%returned which signifies that the robot has reached its desired location.

function Goal = OL_Target2(Target, l, r, mA, mB, mAB, FudgeFactor)

%Transposing the target
Target = Target';

%The robot is assumed to not be at its desired location
Goal = 0;

%Determine a speed at which to run the motors
MotorPower = 50;        %The motor power with which the robot will advance
RobotSpeed = 0.18;      %The assumed speed of the robot in m/s for the "MotorPower" value
TurnPower = 50;         %The motor power with which the robot will turn
RobotTurnSpeed = 0.18;  %The motor speed of the robot in m/s for the "TurnPower" value

Rho = sqrt(Target(1)^2 + Target(2)^2);
Alpha = atan2(Target(2),Target(1)) - pi/2;

Sgn = sign(Alpha);

if abs(Alpha) > pi
    Alpha = 2*pi - abs(Alpha);
    Alpha = -Sgn*Alpha;
end

%Drive alpha to zero first

%Associating similar signed drive direction of the Right wheel with CCW (+) Alpha
%direction, and opposite signed drive direction of the Left wheel with CCW
%(+) Alpha direction
mA.Power = Sgn*TurnPower;
mB.Power = -Sgn*TurnPower;

%Inclusion of a FudgeFactor to compensate for robot imperfections
RunTimeT = l*Alpha/RobotTurnSpeed;

mA.SendToNXT();
mB.SendToNXT();

pause(RunTimeT*FudgeFactor); %Wait while the robot turns toward the goal

mA.Stop(1);
mB.Stop(1);

RunTimeF = Rho/RobotSpeed;

%Tell the robot  to move forward at "MotorPower"
mAB.Power = MotorPower;
mAB.SendToNXT();

pause(RunTimeF); %Wait while the robot moves towards the goal

mAB.Stop(1);

Goal = 1;       %Goal is reached
end
