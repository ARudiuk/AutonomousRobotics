%Perform an arc search ahead of the robot
function [found] = three_arc_search(distance_limit, angle_limit, angle_step_size, bothWheels, light_threshold,power)
%Set up movement methods
    move_forward = straight_move(bothWheels,50,distance_limit);
    move_backward = move_forward;
    move_backward.Power = -move_backward.Power;
    [turn1,turn2] = inplace_turn(bothWheels(1),bothWheels(2),power,45);
    [turn3,turn4] = inplace_turn(bothWheels(1),bothWheels(2),power,-45);
    turn1.ResetPosition();
    turn2.ResetPosition();
    %turn one way first
    turn1.SendToNXT();
    turn2.SendToNXT();
    turn1.WaitFor();
    turn2.WaitFor();
    %move forward
    move_forward.SendToNXT();
    move_forward.WaitFor();
    %peform an arc search
    found = arc_search(angle_limit, angle_step_size, bothWheels, light_threshold,power);
    %if we found it stop the searching
    if found == true
        return
    end
    %repeat previous steps after moving backwards
    move_backward.SendToNXT();
    move_backward.WaitFor();
    turn3.SendToNXT();
    turn4.SendToNXT();
    turn3.WaitFor();
    turn4.WaitFor();
    move_forward.SendToNXT();
    move_forward.WaitFor();
    found = arc_search(angle_limit, angle_step_size, bothWheels, light_threshold,power);
    if found == true
        return
    end
    move_backward.SendToNXT();
    move_backward.WaitFor();
    turn3.SendToNXT();
    turn4.SendToNXT();
    turn3.WaitFor();
    turn4.WaitFor();
    move_forward.SendToNXT();
    move_forward.WaitFor();
    found = arc_search(angle_limit, angle_step_size, bothWheels, light_threshold,power);
    if found == true
        return
    end
    move_backward.SendToNXT();
    move_backward.WaitFor();
    turn1.SendToNXT();
    turn2.SendToNXT();
    turn1.WaitFor();
    turn2.WaitFor();
end