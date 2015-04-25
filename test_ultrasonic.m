NXT_init();
while(true)
    ultrasonic_measurement();
    pause(0.2);
end
NXT_close();