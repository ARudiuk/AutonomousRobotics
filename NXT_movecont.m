%This function is used to command the NXT robot to move forward
%continuously
function [mA,mB] = NXT_movecont(power)
mA = NXTMotor('A', 'Power', power ,'SpeedRegulation', false);
mA.TachoLimit = 0;
mB = NXTMotor('B', 'Power', power ,'SpeedRegulation', false);
mB.TachoLimit = 0;
mA.SendToNXT();
mB.SendToNXT();
end