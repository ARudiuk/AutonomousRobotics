%This function is used to command the NXT robot to turn while moving
%forward
function NXT_movespin(power,deltapower,mA,mB)
mA.Power = power + deltapower;
mB.Power = power - deltapower;
mA.SendToNXT();
mB.SendToNXT();