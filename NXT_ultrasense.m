function [distance] = NXT_ultrasense()
OpenUltrasonic(SENSOR_4);
distance = GetUltrasonic(SENSOR_4);