COM_CloseNXT('all')
h = COM_OpenNXT();
COM_SetDefaultNXT(h);
OpenUltrasonic(SENSOR_4);
OpenSwitch(SENSOR_3);
OpenSwitch(SENSOR_1);
OpenUltrasonic(SENSOR_2);
