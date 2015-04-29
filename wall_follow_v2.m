%go straight
%map continuously
%if you notice that your past few readings are getting smaller or larger
%make a small adjustment in heading to reallign yourself
%continue until your bump sensor is triggered

<<<<<<< HEAD
function [bump,map] = wall_follow(map, mA, mB, mAB,r,l,distance_range,i)
    bump = 0;    
    dist_hist = reset_distance_history();
    AdjPwr = 50;
    tic;

=======
function [bump,map] = wall_follow(map, mA, mB, mAB,r,l,distance_range,wall_angle)
    power = 40;
    bump = 0;    
    dist_hist = reset_distance_history();
>>>>>>> origin/master
    mA.ResetPosition();
    mB.ResetPosition();
    mAB.ResetPosition();
    %1 - alligned and the correct distance
    %2 - not alligned
    %3 - alligned, but not the correct distance
    status = 1;
    move(mAB,power);
    last_drift_value = 0.25*(sum(dist_hist))-(sum(distance_range)/2);
    drift_over_time = 0;
    while bump == 0
        %status
        %if we are alligned and moving forward
        if status == 1
            %update measured distance history
            dist_hist = update_distance_history(dist_hist);
            avg_distance = 0.25*(sum(dist_hist));
            drift = avg_distance-(sum(distance_range)/2)
            if drift ~= last_drift_value
                drift_over_time = drift_over_time+(drift-last_drift_value)
                last_drift_value = drift
            end
            map = move_map_update(map,mAB,r,avg_distance);
            %check if alligned
            if abs(drift_over_time)>5
                status = 2;
            %check if appropriate distance
            elseif (avg_distance<=distance_range(1) || avg_distance>=distance_range(2))
                status = 3;
                mAB.Stop('brake');
<<<<<<< HEAD
            end
       
        %if we are trying to allign
        elseif status == 2
            if toc >= 1 && i > pastnum
                drift = sqrt((map(i-pastnum,1)-map(i-pastnum,3))^2+(map(i-pastnum,2)-map(i-pastnum,4))^2)-sqrt((map(i,1)-map(i,3))^2+(map(i,2)-map(i,4))^2);
                mA.ResetPosition();
                mB.ResetPosition();   
                if drift > Threshhold                
                    mA.TachoLimit = TurnTachLimit;
                    mB.TachoLimit = TurnTachLimit;
                    mA.Power = AdjPwr;
                    mB.Power = -AdjPwr;
                    mA.SendToNXT();
                    mB.SendToNXT();
                    mA.WaitFor(0.5);
                    mB.WaitFor(0.5);
                    mA.Stop('brake');
                    mB.Stop('brake');
                end

                if drift < -Threshhold                
                    mA.TachoLimit = TurnTachLimit;
                    mB.TachoLimit = TurnTachLimit;
                    mA.Power = -AdjPwr;
                    mB.Power = AdjPwr;
                    mA.SendToNXT();
                    mB.SendToNXT();
                    mA.WaitFor(0.5);
                    mB.WaitFor(0.5);
                    mA.Stop('brake');
                    mB.Stop('brake');
                end
            tic;
            end
        pause(0.2)
      
=======
            end             
        %if we are trying to allign
        elseif status == 2
            if avg_distance<(sum(distance_range)/2)
                mAB.Stop('brake');
                turn(mA,mB,power,pi/10,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
            elseif avg_distance>(sum(distance_range)/2)
                mAB.Stop('brake');
                turn(mA,mB,power,-pi/10,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
            end
            dist_hist = reset_distance_history();
            drift_over_time = 0
            last_drift_value = 0.25*(sum(dist_hist))-(sum(distance_range)/2)
            status = 1;
            move(mAB,power);
>>>>>>> origin/master
        %if we are trying to move away a certain distance
        elseif status == 3
            [avg_distance, distance_range(1), distance_range(2), avg_distance<distance_range(1), avg_distance>distance_range(2)]
            avg_range = (distance_range(1)+distance_range(2))/2;
            if avg_distance <= distance_range(1)
                turn(mA,mB,power,pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
                rotations = abs(avg_range-dist_hist(1));
                move(mAB,power,r,rotations);
                map = move_map_update(map,mAB,r);
                turn(mA,mB,power,-pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
            else
                turn(mA,mB,power,-pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
                rotations = abs(avg_range-dist_hist(1));
                move(mAB,power,r,rotations);
                map = move_map_update(map,mAB,r);
                turn(mA,mB,power,pi/2,l,r);
                map = turn_map_update(map,mA,mB,r,l,wall_angle);
            end
            dist_hist = reset_distance_history();
            drift_over_time = 0;
            last_drift_value = 0.25*(sum(dist_hist))-(sum(distance_range)/2);
            status = 1;
            move(mAB,power);
        end
       
        bump = bump_measurement(); 

    end

    mA.Stop('brake');
    mB.Stop('brake');
    mAB.Stop('brake');
end

function dist_hist = update_distance_history(dist_hist)
    dist_hist(4) = dist_hist(3);
    dist_hist(3) = dist_hist(2);
    dist_hist(2) = dist_hist(1);
    dist_hist(1) = ultrasonic_measurement();
end

function dist_hist = reset_distance_history()
    dist_hist = [];
    dist_hist(1) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(2) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(3) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(4) = ultrasonic_measurement();
end
