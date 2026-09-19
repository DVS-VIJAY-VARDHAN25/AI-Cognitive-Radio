function bluetoothData = scanBluetooth()

% ==========================================
% BLE NEARBY DEVICE SCANNER
% ==========================================

% Scan for nearby BLE advertisements
b = blelist;

% Number of detected devices
N = height(b);

% Initialize output
bluetoothData = struct( ...
    'Name', {}, ...
    'Address', {}, ...
    'RSSI', {}, ...
    'Quality', {}, ...
    'Score', {});

% ==========================================
% PROCESS DEVICES
% ==========================================

for k = 1:N

    % --------------------------------------
    % Device name
    % --------------------------------------

    deviceName = string(b.Name(k));

    if strlength(strtrim(deviceName)) == 0
        deviceName = "Unknown BLE Device";
    end

    % --------------------------------------
    % Address
    % --------------------------------------

    deviceAddress = string(b.Address(k));

    % --------------------------------------
    % RSSI
    % --------------------------------------

    rssi = b.RSSI(k);

    % --------------------------------------
    % QUALITY
    % --------------------------------------

    if rssi >= -50

        quality = "Excellent";

    elseif rssi >= -60

        quality = "Good";

    elseif rssi >= -70

        quality = "Fair";

    elseif rssi >= -80

        quality = "Weak";

    else

        quality = "Poor";

    end

    % --------------------------------------
    % QUALITY SCORE
    % --------------------------------------

    % Convert RSSI approximately to 0-100
    score = 2*(rssi + 100);

    score = max(0,min(100,score));

    % --------------------------------------
    % STORE
    % --------------------------------------

    bluetoothData(k).Name = deviceName;
    bluetoothData(k).Address = deviceAddress;
    bluetoothData(k).RSSI = rssi;
    bluetoothData(k).Quality = quality;
    bluetoothData(k).Score = score;

end

end