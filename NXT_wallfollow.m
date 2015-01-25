%This function can be looped to ensure that the robot maintains a distance
%from a wall
function NXT_wallfollow(power,reference,Kp,mA,mB)
distance = GetUltrasonic(SENSOR_4);
error = reference - distance;
deltapower = round(Kp*error);
NXT_movespin(power,deltapower,mA,mB);
angle = NXT_yaw(mA,mB);
NXT_headspin(angle);
end