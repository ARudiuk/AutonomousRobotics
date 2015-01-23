function [move] = straight_move(bothWheels,power,distance)
    move = NXTMotor();
    move.Port = bothWheels;
    move.Power = power;
    move.TachoLimit = distance*360/56;
    move.SmoothStart = true;
    move.SpeedRegulation = false;
    move.ActionAtTachoLimit = 'Brake'; %Holdbrake, brake, or coast
    %if using holdbrake a stop must be used to stop engine
    move.SendToNXT();
end