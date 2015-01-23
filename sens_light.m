mindstorm_init();
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
light = GetLight(SENSOR_3)
%light = GetLight(SENSOR_3) %normalized (default) light value (0..1023 / 10 Bit)
CloseSensor(SENSOR_3);
mindstorm_exit();