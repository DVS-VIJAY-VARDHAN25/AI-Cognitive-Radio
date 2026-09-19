function SignalData = decisionReport(SignalData)

disp(' ');
disp('===========================================');
disp('        AI COGNITIVE RADIO REPORT');
disp('===========================================');

disp(['Energy                : ' num2str(SignalData.energy)]);
disp(['Average Power         : ' num2str(SignalData.averagePower)]);
disp(['Peak Power            : ' num2str(SignalData.peakPower)]);
disp(['Peak-To-Peak          : ' num2str(SignalData.peakToPeak)]);
disp(['Peak Frequency        : ' num2str(SignalData.peakFrequency) ' Hz']);
disp(['Bandwidth             : ' num2str(SignalData.bandwidth) ' Hz']);
disp(['Noise Floor           : ' num2str(SignalData.noiseFloor)]);
disp(['SNR                   : ' num2str(SignalData.SNR) ' dB']);
disp(['Threshold             : ' num2str(SignalData.threshold)]);
disp(['Signal Presence       : ' char(SignalData.signalPresence)]);
disp(['Channel Status        : ' char(SignalData.channelStatus)]);
disp(['Recommended Channel   : ' char(SignalData.recommendedChannel)]);

disp('===========================================');

end