%This is a continous algorithm that tracks a piece of black tape on the
%floor, simulating the tracking of an underwater pipeline.
%Initialize connection to NXT
mindstorm_init()
%Set up motor constants
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
%Set up movement constant
distance_step_size = 60;
%Set up sensor Constants
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
lost_threshold = 500;%values less than this mean we are off the pipe completely
%Pipeline detection functions
found_test = @() GetLight(SENSOR_3)<lost_threshold;
%Track Pipeline
KEEP_GOING_BUD = true;
found = false;
previous_found_state = false;
%Move straight until sensor picks up the tape
%This can be edited out if close enough to the simulated pipeline
straight_move(bothWheels,50,0, found_test);
%Pipeline tracking loop
%Basically an infinite loop
while(KEEP_GOING_BUD == true)
    %Set whether the pipe was found or not found in the last state
    previous_found_state = found;
    %Check if the robot currently sees the line
    found = found_test();
    if(found == false)%If the pipeline is not detected
        if(previous_found_state == true)%and we just saw the line
            arc_search(10,bothWheels,50,found_test);%do a small search
            if found_test() == false %if still not found
                arc_search(90,bothWheels,50,found_test);%do a wider search
            end
        else%If we were lost in the last state search ahead in an arc        
            three_arc_search(distance_step_size,30,bothWheels,50, found_test);
            if found_test() == false%Move forward if not found
                straight_move(bothWheels,80,distance_step_size,found_test);                      
            end
        end        
    else %If we are on the line move straight ahead until we lose the line
        straight_move(bothWheels,50,0,found_test);
    end    
end
%Close sensor
CloseSensor(SENSOR_3);
%Close connection to NXT
mindstorm_exit()
