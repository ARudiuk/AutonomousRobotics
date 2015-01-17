h = COM_OpenNXT();
COM_SetDefaultNXT(h);
NXT_PlayTone(440,100);
mAB = NXTMotor('AB', 'Power', 50,'SpeedRegulation', false);
mAB.TachoLimit = 360;
mAB.SendToNXT();
mAB.WaitFor();
mR = mAB;
mR.Power = -mAB.Power;
mR.SendToNXT();
mR.WaitFor();
%pause(4);   % wait exactly 3 seconds
mAB.Stop('off');
