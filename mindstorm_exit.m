%Close connection to NXT using default handle
function [] = mindstorm_exit()
    COM_CloseNXT(COM_GetDefaultNXT()); 
end

