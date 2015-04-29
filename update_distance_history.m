function dist_hist = update_distance_history(dist_hist)
    dist_hist(4) = dist_hist(3);
    dist_hist(3) = dist_hist(2);
    dist_hist(2) = dist_hist(1);
    dist_hist(1) = ultrasonic_measurement();
end