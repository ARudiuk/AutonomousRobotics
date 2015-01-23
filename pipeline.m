%Initialize connection to NXT
mindstorm_init()
%Set up motor constants
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
%Set up sensor Constants
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
lost_threshold = 360;%values less than this mean we are off the pipe completely
off_threshold = 430;%values less than this but greater than lost mean we are going off the pipe
%Search for Pipeline

%Track Pipeline
move_forward = straight_move(bothWheels,50,25);
KEEP_GOING_BUD = true;
while(KEEP_GOING_BUD)
    light = GetLight(SENSOR_3)
    if(light<lost_threshold) 
end
%Close sensor
CloseSensor(SENSOR_3);
%Close connection to NXT
mindstorm_exit()
