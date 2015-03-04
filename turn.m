%We assume wheels are turning the same
function [] = turn(lwheel, rwheel, power, phi)
    power
    %set variables for PID
    max_power = 100;
    min_power = 30;
    proportional_gain = 0.5;
    differential_gain = 0;
    integral_gain = 0;
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
        error = (phi-temp)
        total_error = total_error + error;
        temp_time = toc;
        new_power = proportional_gain*error + differential_gain*(error-last_error)/(temp_time-last_time) + integral_gain*total_error
        new_power = round(new_power);
        if new_power>max_power
            new_power = max_power;
        end
        if new_power<min_power
            new_power = min_power;
        end
        new_power
        last_time = temp_time;
        last_error = error;
        lwheel.Power = sign(power)*new_power;
        rwheel.Power = sign(power)*-1*new_power;
        lwheel.SendToNXT();
        rwheel.SendToNXT();
    end
    lwheel.Stop('brake');
    rwheel.Stop('brake');
end