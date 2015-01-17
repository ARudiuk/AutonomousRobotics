turningPower = 40;
turningDist = 360;
leftWheel   = MOTOR_B;
rightWheel  = MOTOR_A;
% for turning the bot, we have two objects each:
mTurnLeft1 = NXTMotor(leftWheel, 'Power', -turningPower, 'TachoLimit', turningDist);
mTurnLeft1.SpeedRegulation = false; % don't need this for turning
% for the 2nd part of turning, use first part's settings and modify:
mTurnLeft2 = mTurnLeft1;                 % copy object
mTurnLeft2.Port     = rightWheel;        % but use other wheel
mTurnLeft2.Power    = -mTurnLeft1.Power; % swap power again

% the right-turn objects are the same, but mirrored:
mTurnRight1 = mTurnLeft1;               % first copy...
mTurnRight2 = mTurnLeft2;
mTurnRight1.Power = -mTurnRight1.Power; % now mirror powers
mTurnRight2.Power = -mTurnRight2.Power;
% Instead of mirroring the powers, we could've also changed
% the ports (swapped left and right wheels).

% make a left-turn
mTurnLeft1.SendToNXT();
mTurnLeft2.SendToNXT();
mTurnLeft2.WaitFor();

% wait here a moment
pause(1);

% turn back to the origin
mTurnRight1.SendToNXT();
mTurnRight2.SendToNXT();
mTurnRight2.WaitFor();

COM_CloseNXT(COM_GetDefaultNXT()); 
