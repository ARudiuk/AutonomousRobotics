COM_CloseNXT all
h = COM_OpenNXT();
COM_SetDefaultNXT(h);
OpenUltrasonic(SENSOR_4);
OpenUltrasonic(SENSOR_2);
OpenSwitch(SENSOR_3);
