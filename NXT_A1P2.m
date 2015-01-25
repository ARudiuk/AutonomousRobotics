%This code runs the second problem of assignment 1, tracking a bumpy wall

%Desired distance from wall in cm
reference = 50;

%Acceptable error range for wall tracking
resolution = 5;

%Initialize the brick, returns motor objects
[mA, mB, mAB, mC] = NXT_init;

%Run wall tracking algorithm
while 1;
    
    for i=0:1;
    
        %Acquire the actual distance between the robot and the wall
        distance = GetUltrasonic(SENSOR_4);
    
        %Compute the difference between the desired and actual values
        error = distance - reference;
    
        %If the robot's too far, move closer
        if error > resolution
        
            %Turn
            mA.Power = 30;
            mA.TachoLimit = 185;
            mB.Power = - 30;
            mB.TachoLimit = 185;
            mA.SendToNXT();
            mB.SendToNXT();
            mA.WaitFor();
            mB.WaitFor();
                
            %Go straight
            mAB.Power = 30;
            mAB.TachoLimit = error*20;
            mAB.SendToNXT();
            mAB.WaitFor();
        
            %Turn again
            mA.Power = - 30;
            mA.TachoLimit = 185;
            mB.Power = 30;
            mB.TachoLimit = 185;
            mA.SendToNXT();
            mB.SendToNXT();
            mA.WaitFor();
            mB.WaitFor();
        
            %If the robot's too close, move farther away
        else if error < - resolution
            
                %Turn
                mA.Power = - 50;
                mA.TachoLimit = 185;
                mB.Power = 30;
                mB.TachoLimit = 185;
                mA.SendToNXT();
                mB.SendToNXT();
                mA.WaitFor();
                mB.WaitFor();
            
                %Go straight
                mAB.Power = 30;
                mAB.TachoLimit = abs(error*20);
                mAB.SendToNXT();
                mAB.WaitFor();
            
                %Turn again
                mA.Power = 30;
                mA.TachoLimit = 185;
                mB.Power = - 30;
                mB.TachoLimit = 185;
                mA.SendToNXT();
                mB.SendToNXT();
                mA.WaitFor();
                mB.WaitFor();
            end
        end
    
        %Advance a step along the wall
        mAB.Power = 40;
        mAB.TachoLimit = 180;
        mAB.SendToNXT();
        mAB.WaitFor();
    end
    
    %Now a head sweep is performed to re-allign the robot with the wall
    mC.Power = 30;
    mC.TachoLimit = 60;
    StartPos = mC.ReadFromNXT();
    mC.SendToNXT();
    mC.WaitFor();
    distance = 255;
    for j=1:12
        mC.Power = -30;
        mC.TachoLimit = 10;
        mC.SendToNXT();
        mC.WaitFor();
        distancenew = GetUltrasonic(SENSOR_4);
        if distancenew < distance
            distance = distancenew;
            EndPos = mC.ReadFromNXT;
        end
    end
    mC.Power = 30;
    mC.TachoLimit = 60;
    mC.SendToNXT();
    mC.WaitFor();
    turnamt = EndPos.Position - StartPos.Position;
    if turnamt < 0;
        mA.Power = - 30;
        mA.TachoLimit = round(abs(turnamt));
        mB.Power = 30;
        mB.TachoLimit = round(abs(turnamt));
        mA.SendToNXT();
        mB.SendToNXT();
        mA.WaitFor();
        mB.WaitFor();
    else mA.Power = 30;
        mA.TachoLimit = round(abs(turnamt));
        mB.Power = - 30;
        mB.TachoLimit = round(abs(turnamt));
        mA.SendToNXT();
        mB.SendToNXT();
        mA.WaitFor();
        mB.WaitFor();
    end
end

NXT_close;