%go straight
%map continuously
%if you notice that your past few readings are getting smaller or larger
%make a small adjustment in heading to reallign yourself
%continue until your bump sensor is triggered

function [bump,map] = wall_follow(position, mA, mB, mAB, dis_from_wall,r,l)
    FwdPower = 30;
    bump = 0;
    location = position;
    heading = pi/2;

    distmin1 = dis_from_wall;
    distmin2 = dis_from_wall;
    distmin3 = dis_from_wall;

    i = 1;
    AdjPwr = 70;
    TurnTachLimit = 90;
    Threshhold = 5;
    pastnum = 10;

    mA.ResetPosition();
    mB.ResetPosition();

    while bump == 0

        distance = ultrasonic_measurement();    

        avg_distance = 0.25*(distmin3 + distmin2 + distmin1 + distance);

        mAB.Power = FwdPower;
        mAB.SendToNXT();

        %Update the location and heading of the robot
        RightDist = mA.ReadFromNXT().Position;
        LeftDist = mB.ReadFromNXT().Position;

        displacement = (RightDist + LeftDist)*r*pi/360;
        rotation = (RightDist - LeftDist)*r*pi/(l*360);
        heading = heading + rotation;

        [x,y] = pol2cart(heading,displacement);

        location(1) = location(1) + x;
        location(2) = location(2) + y;

        %The sensor avg_distance is mapped
        %The sensor is mounted on the right side of the robot

        sensor(1) = location(1) + avg_distance*cos(heading - pi/2);
        sensor(2) = location(2) + avg_distance*sin(heading - pi/2);

        map(i,:) = [location,sensor];
        
        bump = bump_measurement();

        mA.ResetPosition();
        mB.ResetPosition();    

        distmin3 = distmin2;
        distmin2 = distmin1;
        distmin1 = distance;    

        if toc >= 3 && i > pastnum
            drift = sqrt((map(i-pastnum,1)-map(i-pastnum,3))^2+(map(i-pastnum,2)-map(i-pastnum,4))^2)-sqrt((map(i,1)-map(i,3))^2+(map(i,2)-map(i,4))^2)
             mA.ResetPosition();
             mB.ResetPosition();   
            if drift > Threshhold
                mA.Power = AdjPwr;
                mB.Power = -AdjPwr;
                mA.TachoLimit = TurnTachLimit;
                mB.TachoLimit = TurnTachLimit;
                mA
                mB
                mA.SendToNXT();
                mB.SendToNXT();
                mA.ReadFromNXT()
                mB.ReadFromNXT()
                mA.WaitFor();
                mB.WaitFor();
                mA.TachoLimit = 0;
                mB.TachoLimit = 0;
            end

            if drift < -Threshhold
                mA.Power = -AdjPwr;
                mB.Power = AdjPwr;
                mA.TachoLimit = TurnTachLimit;
                mB.TachoLimit = TurnTachLimit;
                mA
                mB
                mA.SendToNXT();
                mB.SendToNXT();                
                mA.ReadFromNXT()
                mB.ReadFromNXT()
                mA.WaitFor();
                mB.WaitFor();
                mA.TachoLimit = 0;
                mB.TachoLimit = 0;
            end
            tic;
        end
        pause(0.2)
        i = i + 1;
    end

    mA.Stop('brake');
    mB.Stop('brake');
    mAB.Stop('brake');
end
