function [result] = find_wall(mAB,ultrasound_thres)
    move(mAB,30);
    while(ultrasonic_measurement()>ultrasound_thres)
        pause(0.4)
    end
    mAB.Stop('brake');
    result = 1;
end