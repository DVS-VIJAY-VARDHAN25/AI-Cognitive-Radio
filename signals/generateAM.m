function SignalData = generateAM()
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

carrier = cos(2*pi*config.AMCarrier*t);

modulationIndex = 0.8;

amSignal = (1+modulationIndex*message).*carrier;

SignalData.signal = amSignal;

SignalData.message = message;

SignalData.carrier = carrier;

SignalData.signalName='AM';

SignalData.modulation='Amplitude Modulation';

SignalData.centerFrequency=config.AMCarrier;

%==========================================
% Plot AM Signal
%==========================================

if config.trainingMode == 0

    figure;

    plot(t(1:length(amSignal)), amSignal,'LineWidth',1.2);

    grid on;

    title('Generated AM Signal');

    xlabel('Time (s)');
    ylabel('Amplitude');

end

disp('Length of AM Signal:');
disp(length(amSignal));

%==========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('AM Signal Generated Successfully');