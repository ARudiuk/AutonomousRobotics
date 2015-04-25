%This function assumes we are far enough from the wall that we can turn in
%place safely
function [result] = corner_turn(mAB,mA,mB,l,r)
    %Move away from wall in front
    move(mAB,-30,50);
    mAB.WaitFor();
    turn(mA,mB,30,pi/2,l,r)
    mA.WaitFor();
    result = 1;
end