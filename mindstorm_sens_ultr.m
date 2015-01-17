h = COM_OpenNXT();
COM_SetDefaultNXT(h);
OpenUltrasonic(SENSOR_4);
distance = GetUltrasonic(SENSOR_4)
for i = 1:50
    distance = GetUltrasonic(SENSOR_4)
    NXT_PlayTone(distance*10,100);
    pause(0.2)
end
CloseSensor(SENSOR_4);
COM_CloseNXT(COM_GetDefaultNXT()); 