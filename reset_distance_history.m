function dist_hist = reset_distance_history()
    dist_hist = [];
    dist_hist(1) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(2) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(3) = ultrasonic_measurement();
    pause(0.5);
    dist_hist(4) = ultrasonic_measurement();
end