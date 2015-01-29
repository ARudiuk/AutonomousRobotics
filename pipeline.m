%Initialize connection to NXT
mindstorm_init()
%Set up motor constants
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
distance_step_size = 30;
%Set up sensor Constants
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
lost_threshold = 500;%values less than this mean we are off the pipe completely
%Search for Pipeline
found_test = @() GetLight(SENSOR_3)<lost_threshold;
lost_test = @() GetLight(SENSOR_3)>=lost_threshold;
%Track Pipeline
KEEP_GOING_BUD = true;
found = false;
previous_found_state = false;
straight_move(bothWheels,50,0, found_test);
while(KEEP_GOING_BUD == true)
    previous_found_state = found;
    found = found_test();      
    if(found == false)
        if(previous_found_state == true)
            arc_search(10,bothWheels,50,found_test);
            if found_test() == false
                arc_search(90,bothWheels,50,found_test);
            end
        else            
            three_arc_search(distance_step_size,30,bothWheels,50, found_test);
            if found_test() == false
                straight_move(bothWheels,30,distance_step_size,found_test);                      
            end
        end        
    else
        straight_move(bothWheels,50,0,lost_test);
    end    
end
%Close sensor
CloseSensor(SENSOR_3);
%Stop motor
move_forward.Stop();
%Close connection to NXT
mindstorm_exit()
