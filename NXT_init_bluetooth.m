COM_CloseNXT all
hNXT = COM_OpenNXT('bluetooth.ini');  % look for USB devices, THEN for Bluetooth
COM_SetDefaultNXT(hNXT);              % set global default handle

NXT_PlayTone(440, 500);

% clean up
COM_CloseNXT(hNXT);