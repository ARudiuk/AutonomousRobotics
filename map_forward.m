function [result,pos_History,dis_History] = map_forward(mAB)
    mAB.ResetPosition()
    move(mAB,30);
    pos_History = [];
    dis_History = [];
    while(bump_measurement()==0)
        dis = ultrasonic_measurement();
        pos = mAB.ReadFromNXT().Position;
        dis_History = [dis_History dis];
        pos_History = [pos_History pos];
        pause(0.4)
    end
    mAB.Stop('brake');
    result = 1;
end