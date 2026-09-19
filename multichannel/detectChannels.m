function Channels = detectChannels(Channels)

disp(' ');
disp('====================================');
disp('CHANNEL DETECTION');
disp('====================================');

Threshold = 500;

for i = 1:length(Channels)

    fprintf('\nChecking Channel %d\n', i);

    if Channels(i).Energy > Threshold

        Channels(i).Occupied = true;
        Channels(i).Status = "Occupied";

    else

        Channels(i).Occupied = false;
        Channels(i).Status = "Free";

    end

    fprintf('Energy : %.2f\n', Channels(i).Energy);
    fprintf('Status : %s\n', Channels(i).Status);

end

disp(' ');
disp('Detection Completed');

end