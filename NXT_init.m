function [mA, mB, mAB, mC] = NXT_init
h = COM_OpenNXT();
COM_SetDefaultNXT(h);
OpenUltrasonic(SENSOR_4);
mA = NXTMotor('A', 'SpeedRegulation', false, 'SmoothStart', true);
mB = NXTMotor('B', 'SpeedRegulation', false, 'SmoothStart', true);
mAB = NXTMotor('AB', 'SpeedRegulation', false, 'SmoothStart', true);
mC = NXTMotor('C', 'SpeedRegulation', false, 'SmoothStart', true);
NXT_PlayTone(440,100);