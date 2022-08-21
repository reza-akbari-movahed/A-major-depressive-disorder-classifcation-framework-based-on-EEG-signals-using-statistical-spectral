function [C0_Features,approxEnt,complexity,Entropy] = C0_Features(EEG_Signal)
% This code extractes these features:
% the C0 features per channels,approximate entropy
% Kolmogorov entropy and shannon entropy
% EEG_Signal = EEG_Data.data;
for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
    C0_Features(:,i) = C0_Cal(Each_Channel);
    approxEnt(:,i) = approximateEntropy(Each_Channel);
    complexity(:,i) = Kolmogorov(Each_Channel);
    Entropy(:,i) = Shannon_Entropy(Each_Channel);
end
end

