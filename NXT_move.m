%This function is used to command the NXT robot to move a commanded distance with a commanded power
function NXT_move(distance,power)
mAB = NXTMotor('AB', 'Power', power ,'SpeedRegulation', false);
mAB.TachoLimit = round(distance*360/56);
mAB.SendToNXT();
mAB.WaitFor();
mAB.Stop('off');