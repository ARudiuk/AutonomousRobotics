mindstorm_init()
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A; 
bothWheels = [rightWheel,leftWheel];

forward = straight_move(bothWheels, 50,2);
forward.WaitFor();
[turn_around1,turn_around2] = inplace_turn(leftWheel,rightWheel,50,180);
turn_around1.WaitFor();
turn_around2.WaitFor();
forward.SendToNXT();
forward.WaitFor();
%pause(1);

mindstorm_exit()
