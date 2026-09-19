function SignalData = occupancyDecision(SignalData)

disp(' ');
disp('------ OCCUPANCY DECISION ------');

if SignalData.signalDetected

    SignalData.isOccupied = true;
    SignalData.channelStatus = "Occupied";

else

    SignalData.isOccupied = false;
    SignalData.channelStatus = "Free";

end

disp(['Occupied : ' num2str(SignalData.isOccupied)]);
disp(['Channel Status : ' char(SignalData.channelStatus)]);

end