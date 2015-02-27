%This code runs the second problem of assignment 2, implementing an
%open-loop controller

%Initialize the brick, returns motor objects
[mA, mB, mAB, mC] = NXT_init;

%Initializing some robot parameters
l = 0.055;          %One half of the wheel spacing (m)
r = 0.028;          %Wheel radius (m)
FudgeFactor = 1;    %Turning fudge factor

%Inclusion of a FudgeFactor to compensate for robot imperfections
%FudgeFactor = 1 means no FF is needed.

%Assign a matrix of target locations <x,y> in meters
Target = [0.5,0;0.5,0;0.5,0;0.5,0];    %0.5X0.5 m square
%Target = [0.433,0.25; 0.433,0.25; 0.433,0.25; 0.433,0.25; 0.433,0.25; 0.433,0.25];

for i=1:4
    OL_Target2(Target(i,:), l, r, mA, mB, mAB, FudgeFactor);
end

COM_CloseNXT(COM_GetDefaultNXT());