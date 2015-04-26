%This function assumes we are far enough from the wall that we can turn in
%place safely
function [result, map] = corner_turn(map,mAB,mA,mB,l,r)
    %Move away from wall in front
<<<<<<< HEAD
    move(mAB,-30,180);
    mAB.WaitFor();
=======
    move(mAB,-30,r,30);
    map = move_map_update(map,mAB,r);
>>>>>>> origin/master
    turn(mA,mB,30,pi/2,l,r)
    map = turn_map_update(map,mA,mB,r,l);
    mA.WaitFor();
    result = 1;
end