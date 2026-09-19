function Channels = scanSpectrum(Channels)

disp(' ');
disp('====================================');
disp('SCANNING ALL CHANNELS');
disp('====================================');

for i = 1:length(Channels)

    disp(' ');
    disp(['Scanning Channel ' num2str(i)]);

    disp(['Signal : ' Channels(i).SignalType]);

end

disp(' ');
disp('Spectrum Scan Completed');

end