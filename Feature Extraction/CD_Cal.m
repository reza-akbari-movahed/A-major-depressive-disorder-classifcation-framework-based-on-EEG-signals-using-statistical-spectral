function [corDim,lyapExp] = CD_Cal(EEG_Signal,fs)
% This code calculates the correlation dimension and Lyapunov exponent of the signal
% EEG_Signal = EEG_Data.data;
for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
     corDim(:,i) = correlationDimension(Each_Channel);
    lyapExp(:,i) = lyapunovExponent(Each_Channel,fs);
end 
end