%Initialize connection to NXT
mindstorm_init()
%Set up motor constants
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
distance_step_size = 25;
%Set up sensor Constants
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
lost_threshold = 500;%values less than this mean we are off the pipe completely
off_threshold = 430;%values less than this but greater than lost mean we are going off the pipe
%Search for Pipeline

%Track Pipeline
move_forward = straight_move(bothWheels,50,distance_step_size);
KEEP_GOING_BUD = true;
while(KEEP_GOING_BUD == true)
    found = false;
    light = GetLight(SENSOR_3)
    if(light>lost_threshold) 
        found = arc_search(30,10,bothWheels,lost_threshold,50);
        if( found == false)
            while(found == false)
                found = three_arc_search(distance_step_size,30,10,bothWheels,lost_threshold,50);
                if found == false
                    move_forward.SendToNXT();
                    move_forward.WaitFor();
                end
            end
        end
    else
        move_forward.SendToNXT();
        move_forward.WaitFor();
    end
end
%Close sensor
CloseSensor(SENSOR_3);
%Stop motor
move_forward.Stop();
%Close connection to NXT
mindstorm_exit()
