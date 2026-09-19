function Channels = processChannels(Channels)

disp(' ');
disp('====================================');
disp('PROCESSING ALL CHANNELS');
disp('====================================');

for i = 1:length(Channels)

    fprintf('\nProcessing Channel %d\n', i);

    switch Channels(i).SignalType

        case 'BPSK'
            SignalData = generateBPSK();

        case 'QPSK'
            SignalData = generateQPSK();

        case 'AM'
            SignalData = generateAM();

        case 'FM'
            SignalData = generateFM();

        case '16QAM'
            SignalData = generate16QAM();

        case 'OFDM'
            SignalData = generateOFDM();

        case 'Bluetooth'
            SignalData = generateBluetooth();

        case 'LTE'
            SignalData = generateLTE();

        case '5G'
            SignalData = generate5G();

        case 'Noise'

            SignalData = createSignalData();

            SignalData.signal = randn(1,1000);

        case 'Empty'

            SignalData = createSignalData();

            SignalData.signal = zeros(1,1000);

        otherwise

            warning('Unknown Signal Type');
            continue;

    end

    % Save signal information

    Channels(i).SignalData = SignalData;

    if isfield(SignalData,'energy')
        Channels(i).Energy = SignalData.energy;
    end

    if isfield(SignalData,'averagePower')
        Channels(i).AveragePower = SignalData.averagePower;
    end

    if isfield(SignalData,'peakPower')
        Channels(i).PeakPower = SignalData.peakPower;
    end

    if isfield(SignalData,'peakToPeak')
        Channels(i).PeakToPeak = SignalData.peakToPeak;
    end

    if isfield(SignalData,'peakFrequency')
        Channels(i).PeakFrequency = SignalData.peakFrequency;
    end

    if isfield(SignalData,'bandwidth')
        Channels(i).Bandwidth = SignalData.bandwidth;
    end

    if isfield(SignalData,'noiseFloor')
        Channels(i).NoiseFloor = SignalData.noiseFloor;
    end

    if isfield(SignalData,'SNR')
        Channels(i).SNR = SignalData.SNR;
    end

    fprintf('Completed Channel %d\n', i);

end

disp(' ');
disp('All Channels Processed Successfully');

end