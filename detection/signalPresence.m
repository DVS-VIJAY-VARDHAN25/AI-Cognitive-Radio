function SignalData = signalPresence(SignalData)

disp(' ');
disp('------ SIGNAL PRESENCE ------');

if SignalData.signalDetected

    SignalData.signalPresence = "Present";

else

    SignalData.signalPresence = "Absent";

end

disp(['Signal Presence : ' char(SignalData.signalPresence)]);

end