function [] = mindstorm_exit()
    COM_CloseNXT(COM_GetDefaultNXT()); 
end

