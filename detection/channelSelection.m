function SignalData = channelSelection(SignalData)

disp(' ');
disp('------ CHANNEL SELECTION ------');

% Example simulated channel occupancy
channelOccupied = SignalData.channelOccupied;

% Find available channels
availableChannels = find(~channelOccupied);

if isempty(availableChannels)

    SignalData.recommendedChannel = "No Channel Available";

    disp('No available channel found.');

else

    % Select the first available channel
    selectedChannel = availableChannels(1);

    SignalData.recommendedChannel = ...
        "Channel " + string(selectedChannel);

    disp(['Recommended Channel : ' ...
        char(SignalData.recommendedChannel)]);

end

SignalData.availableChannels = availableChannels;

end