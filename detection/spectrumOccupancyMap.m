function SignalData = spectrumOccupancyMap(SignalData, ax)

disp(' ');
disp('------ 5-CHANNEL SPECTRUM OCCUPANCY ------');

% ==========================================
% GET CHANNEL DATA
% ==========================================

channelOccupied = SignalData.channelOccupied;
channelEnergy = SignalData.channelEnergy;
numChannels = SignalData.numChannels;

% ==========================================
% DISPLAY CHANNEL STATUS
% ==========================================

for k = 1:numChannels

    if channelOccupied(k)

        disp(['Channel ' num2str(k) ' : OCCUPIED']);

    else

        disp(['Channel ' num2str(k) ' : FREE']);

    end

end

disp(['Recommended Channel : ' ...
    char(SignalData.recommendedChannel)]);

% ==========================================
% CHECK AXES
% ==========================================

if nargin < 2 || isempty(ax)

    figure;
    ax = gca;

end

% ==========================================
% CLEAR AXES
% ==========================================

cla(ax);

% ==========================================
% OCCUPANCY DATA
% ==========================================

occupancy = double(channelOccupied);

% ==========================================
% CREATE BAR GRAPH
% ==========================================

b = bar(ax,1:numChannels,occupancy);

b.FaceColor = 'flat';

% ==========================================
% COLOR BARS
% ==========================================

for k = 1:numChannels

    if channelOccupied(k)

        % Occupied
        b.CData(k,:) = [0.85 0.20 0.20];

    else

        % Free
        b.CData(k,:) = [0.20 0.70 0.30];

    end

end

% ==========================================
% GRAPH SETTINGS
% ==========================================

ylim(ax,[0 1.25]);

xlim(ax,[0.5 5.5]);

xticks(ax,1:5);

xticklabels(ax,{
    'Channel 1'
    'Channel 2'
    'Channel 3'
    'Channel 4'
    'Channel 5'
    });

yticks(ax,[0 1]);

yticklabels(ax,{
    'FREE'
    'OCCUPIED'
    });

xlabel(ax,'Channel');

ylabel(ax,'Occupancy');

title(ax,'5-Channel Spectrum Occupancy');

grid(ax,'on');

% ==========================================
% DISPLAY OCCUPIED / FREE
% ==========================================

for k = 1:numChannels

    if channelOccupied(k)

        text(ax,k,1.05,'OCCUPIED',...
            'HorizontalAlignment','center',...
            'FontWeight','bold');

    else

        text(ax,k,0.05,'FREE',...
            'HorizontalAlignment','center',...
            'FontWeight','bold');

    end

end

% ==========================================
% DISPLAY CHANNEL ENERGY
% ==========================================

maxEnergy = max(channelEnergy);

for k = 1:numChannels

    if maxEnergy > 0

        energyText = sprintf('%.3g',channelEnergy(k));

        text(ax,k,1.15,energyText,...
            'HorizontalAlignment','center',...
            'FontWeight','bold');

    end

end

% ==========================================
% RECOMMENDED CHANNEL
% ==========================================

subtitle(ax,...
    ['Recommended : ' ...
    char(SignalData.recommendedChannel)]);

end