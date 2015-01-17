h = COM_OpenNXT();
COM_SetDefaultNXT(h);
OpenLight(SENSOR_3, 'ACTIVE'); % have to specify mode, ACTIVE or INACTIVE
light = GetLight(SENSOR_3)
pause(4);
CloseSensor(SENSOR_3);
voltage = NXT_GetBatteryLevel()
COM_CloseNXT(COM_GetDefaultNXT()); 