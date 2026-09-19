function SignalData = generateFM()

% Always locate the project root
thisFile = mfilename('fullpath');
signalsFolder = fileparts(thisFile);
projectRoot = fileparts(signalsFolder);

addpath(genpath(projectRoot));

disp("Current folder:");
disp(pwd)

disp("projectConfig exists?");
disp(exist('projectConfig','file'))

config = projectConfig();

SignalData = createSignalData();

t = 0:1/config.Fs:config.signalDuration-1/config.Fs;

SignalData.time=t;

SignalData.Fs=config.Fs;

message = cos(2*pi*500*t);

carrier = cos(2*pi*config.FMCarrier*t);

SignalData.carrier = carrier;

kf = 50;

fmSignal = cos(2*pi*config.FMCarrier*t + ...
    2*pi*kf*cumsum(message)/config.Fs);

SignalData.signal=fmSignal;

SignalData.message=message;

SignalData.signalName='FM';

SignalData.modulation='Frequency Modulation';

SignalData.centerFrequency=config.FMCarrier;
%==========================================
% Plot FM Signal
%==========================================

if config.trainingMode == 0

    figure;

    plot(t(1:length(fmSignal)), fmSignal,'LineWidth',1.2);

    grid on;

    title('Generated FM Signal');

    xlabel('Time (s)');
    ylabel('Amplitude');

end

disp('Length of FM Signal:');
disp(length(fmSignal));

%==========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('FM Signal Generated Successfully');