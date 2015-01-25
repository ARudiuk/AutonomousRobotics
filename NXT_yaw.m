%This function calculates the yaw of the robot as it has been moving
function [angle] = NXT_yaw(mA,mB)
rightwheeldist = mA.ReadFromNXT();
leftwheeldist = mB.ReadFromNXT();

rad = (rightwheeldist.Position - leftwheeldist.Position)/2;
rad = rad*56*3.14/360;
rad = rad/57;

angle = rad*180/3.14;
end



