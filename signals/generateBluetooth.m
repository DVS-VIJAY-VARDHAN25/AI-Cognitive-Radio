function SignalData = generateBluetooth()
% Always locate the project root
thisFile = mfilename('fullpath');
signalsFolder = fileparts(thisFile);
projectRoot = fileparts(signalsFolder);

addpath(genpath(projectRoot));

disp("Current folder:");
disp(pwd)

disp("projectConfig exists?");
disp(exist('projectConfig','file'))
%==========================================
% Load Project Configuration
%==========================================

config = projectConfig();

%==========================================
% Create Empty Signal Structure
%==========================================

SignalData = createSignalData();

%==========================================
% Generate Random Binary Data
%==========================================

numberOfBits = 100;

bits = randi([0 1],1,numberOfBits);

disp('Generated Bluetooth Bits');
disp(bits);

SignalData.bits = bits;

%==========================================
% Time Vector
%==========================================

t = 0:1/config.Fs:config.signalDuration-1/config.Fs;

SignalData.time = t;
SignalData.Fs = config.Fs;

%==========================================
% Bluetooth Parameters
%==========================================

Fc = config.BluetoothCarrier;

freqDeviation = 2000;

samplesPerBit = floor(length(t)/numberOfBits);

bluetoothSignal = [];

%==========================================
% Generate GFSK Signal
%==========================================

for k = 1:numberOfBits

    if bits(k)==1
        freq = Fc + freqDeviation;
    else
        freq = Fc - freqDeviation;
    end

    ts = t((k-1)*samplesPerBit+1:k*samplesPerBit);

    bitSignal = cos(2*pi*freq*ts);

    bluetoothSignal = [bluetoothSignal bitSignal];

end

%==========================================
% Store Signal
%==========================================

SignalData.signal = bluetoothSignal;

SignalData.signalName = 'Bluetooth';

SignalData.modulation = 'Gaussian Frequency Shift Keying (GFSK)';

SignalData.centerFrequency = Fc;
%==========================================
% Plot Bluetooth Signal
%==========================================

if config.trainingMode == 0

    figure;

    plot(t(1:length(bluetoothSignal)), ...
         bluetoothSignal,'LineWidth',1.2);

    grid on;

    title('Generated Bluetooth Signal');

    xlabel('Time (s)');
    ylabel('Amplitude');

end

disp('Length of Bluetooth Signal:');
disp(length(bluetoothSignal));

%==========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('Bluetooth Signal Generated Successfully');