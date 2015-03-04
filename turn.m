%We assume wheels are turning the same
function [] = turn(lwheel, rwheel, power, phi)
    power
    lwheel.ResetPosition();
    lwheel.Power = power;
    rwheel.Power = -1*power;
    lwheel.SendToNXT();
    rwheel.SendToNXT();
    temp = 0;
    last_error = 0;
    tic;
    total_error = 0;
    last_time = toc;
    while(temp<phi)
        temp = lwheel.ReadFromNXT().Position;
        error = (phi-temp);
        total_error = total_error + error;
        temp_time = toc;
        power = error + (error-last_error)/(temp_time-last_time) + total_error;
        if power>100
            power = 100
        end
        last_time = temp_time;
        last_error = error;
    end
    lwheel.Stop('brake');
    rwheel.Stop('brake');
end