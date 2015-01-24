%Wheels are 56mm
%between wheels is 11.5cm
function [move] = straight_move(bothWheels,power,distance)
    move = NXTMotor();
    move.Port = bothWheels;
    move.Power = power;
    temp = distance*360/(pi*56);
    move.TachoLimit = round(temp);
    move.SmoothStart = true;
    move.SpeedRegulation = false;
    move.ActionAtTachoLimit = 'HoldBrake'; %Holdbrake, brake, or coast
    %if using holdbrake a stop must be used to stop engine
end