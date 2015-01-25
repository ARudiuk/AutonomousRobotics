%Spins the ultrasonic sensor on top of the robot
function NXT_headspin(angle)
power = 20;
angle = round(angle);

%Detecting if the ultrasonic sensor needs to turn the other way
if angle < 0;
    power = - power;
    angle = abs(angle);
end

if angle > 360
    angle = angle - 360;
end

mC = NXTMotor('C', 'Power', power ,'SpeedRegulation', false);
mC.TachoLimit = angle;
mC.SendToNXT
end