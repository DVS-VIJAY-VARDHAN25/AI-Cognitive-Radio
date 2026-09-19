function SignalData = channelRecommendation(SignalData)

disp(' ');
disp('------ CHANNEL RECOMMENDATION ------');

% ==========================================
% CHANNEL CONFIGURATION
% ==========================================

numChannels = 5;

% Get sampling frequency
if isfield(SignalData,'Fs') && ~isempty(SignalData.Fs)

    Fs = SignalData.Fs;

else

    Fs = 1/(SignalData.time(2)-SignalData.time(1));

end

% ==========================================
% GET SIGNAL
% ==========================================

x = SignalData.signal;

% ==========================================
% FFT
% ==========================================

N = length(x);

Y = fft(x);

P2 = abs(Y/N);

P1 = P2(1:floor(N/2)+1);

if length(P1) > 2

    P1(2:end-1) = 2*P1(2:end-1);

end

f = Fs*(0:floor(N/2))/N;

% ==========================================
% CHANNEL BANDWIDTH
% ==========================================

channelBandwidth = Fs/(2*numChannels);

% ==========================================
% CALCULATE ENERGY FOR EACH CHANNEL
% ==========================================

channelEnergy = zeros(1,numChannels);

for k = 1:numChannels

    fLow = (k-1)*channelBandwidth;

    fHigh = k*channelBandwidth;

    idx = f >= fLow & f < fHigh;

    if any(idx)

        channelEnergy(k) = sum(P1(idx).^2);

    else

        channelEnergy(k) = 0;

    end

end

% ==========================================
% DETERMINE OCCUPANCY THRESHOLD
% ==========================================

occupancyThreshold = mean(channelEnergy);

% ==========================================
% OCCUPANCY DECISION
% ==========================================

channelOccupied = channelEnergy > occupancyThreshold;

% ==========================================
% STORE RESULTS
% ==========================================

SignalData.channelEnergy = channelEnergy;

SignalData.channelOccupied = channelOccupied;

SignalData.numChannels = numChannels;

SignalData.channelBandwidth = channelBandwidth;

% ==========================================
% DISPLAY CHANNEL STATUS
% ==========================================

disp(' ');

disp('Channel Occupancy:');

for k = 1:numChannels

    if channelOccupied(k)

        disp(['Channel ' num2str(k) ' : OCCUPIED']);

    else

        disp(['Channel ' num2str(k) ' : FREE']);

    end

end

% ==========================================
% FIND FREE CHANNELS
% ==========================================

freeChannels = find(~channelOccupied);

% ==========================================
% RECOMMEND BEST CHANNEL
% ==========================================

if isempty(freeChannels)

    SignalData.recommendedChannel = "No Free Channel";

    disp('Recommended Channel : No Free Channel');

else

    % Select free channel with lowest energy

    [~,index] = min(channelEnergy(freeChannels));

    bestChannel = freeChannels(index);

    SignalData.recommendedChannel = ...
        "Channel " + string(bestChannel);

    disp(['Recommended Channel : Channel ' ...
        num2str(bestChannel)]);

end

end