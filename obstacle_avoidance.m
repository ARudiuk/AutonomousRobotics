function [map,result] = obstacle_avoidance(mA,mB,mAB,map,goal)
%obstacle_avoidance assumes that the robot wishes to return to the origin
%and reorient itself without scanning any obstacles on the way.



go forward at 30 power
scan forward as you go
if you see something close, adjust your heading incrementally and check looking to the left
head in the direction that has a forward scan value lower than your threshold


end