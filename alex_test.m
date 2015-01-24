mindstorm_init()
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];
OpenLight(SENSOR_3, 'ACTIVE');
forward = straight_move(bothWheels, 50,25);
forward.SendToNXT();
forward.WaitFor();
%[turn_around1,turn_around2] = inplace_turn(leftWheel,rightWheel,50,360);
%turn_around1.WaitFor();
%turn_around2.WaitFor();
%forward.SendToNXT();
%forward.WaitFor();
%pause(1);
arc_search(0, 90, 10, bothWheels, 500,50)

CloseSensor(SENSOR_3);
mindstorm_exit()
