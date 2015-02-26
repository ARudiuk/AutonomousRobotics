%Commands the robot to advance in a straight line at a given speed to
%determine how to control with dead reckoning

[mA, mB, mAB, mC] = NXT_init;

MotorPower = 50;    %The motor power which will be used for our test

mAB.Power = MotorPower;
mAB.SendToNXT();

%The code should terminate eventually. At this point the robot should have reached its target already

pause(40);
mAB.Stop(1);                            %The motors are commanded to stop
COM_CloseNXT(COM_GetDefaultNXT());      %Terminating the session
