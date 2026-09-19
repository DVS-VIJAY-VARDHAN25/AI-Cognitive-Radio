function Channels = createChannels()

disp(' ');
disp('=======================================');
disp('CREATING VIRTUAL CHANNELS');
disp('=======================================');

NumberOfChannels = 8;

Channels = struct();

SignalList = { ...
    'BPSK',...
    'Noise',...
    'LTE',...
    'Empty',...
    'OFDM',...
    'FM',...
    'Bluetooth',...
    'QPSK'};

for i = 1:NumberOfChannels

    Channels(i).ChannelID = i;

    Channels(i).SignalType = SignalList{i};

    Channels(i).Occupied = false;

    Channels(i).Energy = [];

    Channels(i).AveragePower = [];

    Channels(i).PeakPower = [];

    Channels(i).PeakToPeak = [];

    Channels(i).PeakFrequency = [];

    Channels(i).Bandwidth = [];

    Channels(i).NoiseFloor = [];

    Channels(i).SNR = [];

    Channels(i).Status = "";

    disp(['Channel ' num2str(i) ' Created']);

end

disp(' ');
disp('All Channels Created Successfully');

end