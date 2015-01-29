%This is a discrete algorithm that tracks a piece of black tape on the
%floor, simulating the tracking of an underwater pipeline.
%Initialize connection to NXT
%More detialed commenting is in the continuous version code
mindstorm_init()
%Set up motor constants
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
distance_step_size = 25;
move_forward = straight_move(bothWheels,50,distance_step_size);
%Set up sensor Constants
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
lost_threshold = 500;%values less than this mean we are off the pipe completely
%Search for Pipeline
%Track Pipeline
KEEP_GOING_BUD = true;
found = false;
previous_found_state = false;
%Pipeline tracking loop
%Basically an infinite loop
while(KEEP_GOING_BUD == true)
    previous_found_state = found;
    found = false;
    %check if are currently on the pipeline
    light = GetLight(SENSOR_3)
    if light<lost_threshold
        found = true;
    end    
    %If we are not
    if(found == false)
        if(previous_found_state == true)%were in the previous state?            
            found = arc_search(10,10,bothWheels,lost_threshold,50);%small search
            if found == false
                found = arc_search(90,15,bothWheels,lost_threshold,50);%larger search
            end
        else            
            found = three_arc_search(distance_step_size,30,10,bothWheels,lost_threshold,50);%largest search
            if found == false%move forward if searches failed
                move_forward.SendToNXT();
                move_forward.WaitFor();                            
            end
        end        
    else%if on the line move forward a step
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
