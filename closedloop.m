%This function peforms an inplace turn that stops when the found_test
%passes.
function [position_x, position_y] = closedloop(lWheel,rWheel,power,theta,position_x, position_y, goal_x, goal_y)
    lwheel.ResetPosition();
    rwheel.ResetPosition();
    data1 = lwheel.ReadFromNXT();
    data2 = rwheel.ReadFromNXT();
    tic;
    history = [data1.Position, data2.Position, toc];
    error = inf;
    dx = goal_x - position_x;
    dy = goal_y - position_y;  
    %rho is the distance from current point to goal
    rho = sqrt((dx)^2+(dy)^2);
    %alpha is the angle difference from the robots current heading to the 
    %goal heading in radians
    alpha = -theta+atan2(dy,dx);
    while(error~=0)
        %phi is how much the wheels need to be turned
        %for now we assume the turn at the same rate
        Phi_angle = alpha*l/r;
        Phi_angle = Phi_angle*180/pi; %convert to degrees
        Phi_distance = rho/r;
        %Change direction of rotation depending on provided angle
        if alpha<0
            power = -power;
        end
        turn1.SendToNXT();
        turn2.SendToNXT();    
        while(theta<)        
        end
        %Stop the motor in case we found the line. Otherwise we would still be
        %turning.   
    end
end