NXT_init();
mA = NXTMotor('A', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mB = NXTMotor('B', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);
mAB = NXTMotor('AB', 'SpeedRegulation', false,'ActionAtTachoLimit','Holdbrake', 'SmoothStart', true,'TachoLimit',0);

r = 2.8;
l = 5.5;
map = [50,-80,0,0,3.14];
forward_threshold = 40;

forward_scan = ultrasonic_forward_measurement();

while forward_scan < forward_threshold
    move(mAB,30,r)
    forward_scan = ultrasonic_forward_measurement;
end