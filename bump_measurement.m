function bump = bump_measurement()
    bump = GetSwitch(SENSOR_3);
    if bump<1
        bump = GetSwitch(SENSOR_1);
    end
end