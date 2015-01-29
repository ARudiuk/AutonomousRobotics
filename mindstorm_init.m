%Clear past connections and open new default connection to NXT
function [] = mindstorm_init()
    COM_CloseNXT('all')
    close all
    %clear all
    h = COM_OpenNXT();
    COM_SetDefaultNXT(h);
end