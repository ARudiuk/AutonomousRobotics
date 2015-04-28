%This function assumes we are far enough from the wall that we can turn in
%place safely
function [result, map] = corner_turn(map,mAB,mA,mB,l,r,new_wall_angle)
    %Move away from wall in front
<<<<<<< HEAD
    move(mAB,-30,r,30);
=======
    move(mAB,-30,r,15);
>>>>>>> origin/master
    map = move_map_update(map,mAB,r);
    turn(mA,mB,30,pi/2,l,r)
    map = turn_map_update(map,mA,mB,r,l,new_wall_angle);
    result = 1;
end