function wifiData = scanWiFi()
% FORCE FRESH WI-FI SCAN
% ==========================================

system('netsh wlan scan');

pause(2);
% ==========================================
% SCAN NEARBY WI-FI NETWORKS
% ==========================================

[status, cmdout] = system( ...
    'netsh wlan show networks mode=bssid');

if status ~= 0
    error('Wi-Fi scan failed.');
end

% ==========================================
% SPLIT OUTPUT INTO LINES
% ==========================================

lines = splitlines(string(cmdout));

% ==========================================
% INITIALIZE
% ==========================================

wifiData = struct( ...
    'SSID', {}, ...
    'BSSID', {}, ...
    'Signal', {}, ...
    'RadioType', {}, ...
    'Band', {}, ...
    'Channel', {}, ...
    'ChannelUtilization', {});

currentSSID = "";
currentBSSID = "";

% ==========================================
% PARSE EACH LINE
% ==========================================

for i = 1:length(lines)

    line = strtrim(lines(i));

    % --------------------------------------
    % SSID
    % --------------------------------------

    token = regexp(line, ...
        '^SSID\s+\d+\s*:\s*(.*)$', ...
        'tokens', 'once');

    if ~isempty(token)

        currentSSID = string(strtrim(token{1}));

        continue;

    end

    % --------------------------------------
    % BSSID
    % --------------------------------------

    token = regexp(line, ...
        '^BSSID\s+\d+\s*:\s*(.*)$', ...
        'tokens', 'once');

    if ~isempty(token)

        currentBSSID = string(strtrim(token{1}));

        % Create new entry
        n = length(wifiData) + 1;

        wifiData(n).SSID = currentSSID;
        wifiData(n).BSSID = currentBSSID;
        wifiData(n).Signal = NaN;
        wifiData(n).RadioType = "";
        wifiData(n).Band = "";
        wifiData(n).Channel = NaN;
        wifiData(n).ChannelUtilization = NaN;

        continue;

    end

    % --------------------------------------
    % SIGNAL
    % --------------------------------------

    token = regexp(line, ...
        '^Signal\s*:\s*(\d+)%$', ...
        'tokens', 'once');

    if ~isempty(token) && ~isempty(wifiData)

        wifiData(end).Signal = ...
            str2double(token{1});

        continue;

    end

    % --------------------------------------
    % RADIO TYPE
    % --------------------------------------

    token = regexp(line, ...
        '^Radio type\s*:\s*(.*)$', ...
        'tokens', 'once');

    if ~isempty(token) && ~isempty(wifiData)

        wifiData(end).RadioType = ...
            string(strtrim(token{1}));

        continue;

    end

    % --------------------------------------
    % BAND
    % --------------------------------------

    token = regexp(line, ...
        '^Band\s*:\s*(.*)$', ...
        'tokens', 'once');

    if ~isempty(token) && ~isempty(wifiData)

        wifiData(end).Band = ...
            string(strtrim(token{1}));

        continue;

    end

    % --------------------------------------
    % CHANNEL
    % --------------------------------------

    token = regexp(line, ...
        '^Channel\s*:\s*(\d+)$', ...
        'tokens', 'once');

    if ~isempty(token) && ~isempty(wifiData)

        wifiData(end).Channel = ...
            str2double(token{1});

        continue;

    end

    % --------------------------------------
    % CHANNEL UTILIZATION
    % --------------------------------------

    token = regexp(line, ...
        '^Channel Utilization\s*:\s*(\d+)', ...
        'tokens', 'once');

    if ~isempty(token) && ~isempty(wifiData)

        wifiData(end).ChannelUtilization = ...
            str2double(token{1});

        continue;

    end

end

end