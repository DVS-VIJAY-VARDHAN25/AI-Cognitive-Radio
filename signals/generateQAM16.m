function SignalData = generateQAM16()
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
% Load Configuration
%==========================================

config = projectConfig();

SignalData = createSignalData();

%==========================================
% Generate Random Data
%==========================================

numberOfSymbols = 100;

I = randi([-3 3],1,numberOfSymbols);
Q = randi([-3 3],1,numberOfSymbols);

% Force valid 16-QAM levels
levels = [-3 -1 1 3];

for k=1:numberOfSymbols
    [~,idx] = min(abs(levels-I(k)));
    I(k)=levels(idx);

    [~,idx] = min(abs(levels-Q(k)));
    Q(k)=levels(idx);
end

SignalData.I = I;
SignalData.Q = Q;

%==========================================
% Time Vector
%==========================================

t = 0:1/config.Fs:config.signalDuration-1/config.Fs;

SignalData.time = t;
SignalData.Fs = config.Fs;

samplesPerSymbol = floor(length(t)/numberOfSymbols);

qam16Signal = [];

%==========================================
% Generate Signal
%==========================================

for k = 1:numberOfSymbols

    ts = t((k-1)*samplesPerSymbol+1:k*samplesPerSymbol);

    Iwave = I(k)*cos(2*pi*config.QAMCarrier*ts);

    Qwave = Q(k)*sin(2*pi*config.QAMCarrier*ts);

    qam16Signal = [qam16Signal Iwave-Qwave];

end

SignalData.signal = qam16Signal;

SignalData.signalName = 'QAM16';

SignalData.modulation = 'QAM16';

SignalData.centerFrequency = config.QAMCarrier;
%==========================================
% Plot QAM16 Signal
%==========================================

if config.trainingMode == 0

    figure;

    plot(t(1:length(qam16Signal)), qam16Signal,'LineWidth',1.2);

    grid on;

    title('Generated QAM16 Signal');

    xlabel('Time (s)');
    ylabel('Amplitude');

    %==========================================
    % QAM16 Constellation
    %==========================================

    figure;

    scatter(I,Q,'filled');

    grid on;

    axis equal;

    title('QAM16 Constellation');

    xlabel('In-Phase');
    ylabel('Quadrature');

end

disp('Length of QAM16 Signal:');
disp(length(qam16Signal));

%==========================================
% Process Complete Signal
%==========================================

disp(' ');
disp('Processing Signal...');

SignalData = processSignal(SignalData);

disp('Processing Completed Successfully');

disp('QAM16 Signal Generated Successfully');