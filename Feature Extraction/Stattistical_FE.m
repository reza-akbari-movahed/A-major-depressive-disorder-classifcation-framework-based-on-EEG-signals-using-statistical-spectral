function [Features] = Stattistical_FE(EEG_Signal)
% EEG_Signal = EEG_Data.data;
EEG_Signal = EEG_Signal';
Mean_Per_Ch = mean(EEG_Signal);
Var_Per_Ch = var(EEG_Signal);
Ske_Per_Ch = skewness(EEG_Signal);
Kur_Per_C = kurtosis(EEG_Signal);
Min_Per_Ch = min(EEG_Signal);
Max_Per_Ch = max(EEG_Signal);
for i=1:size(EEG_Signal,2)
    Each_Channel = EEG_Signal(:,i);
    [Mob_Per_Ch(:,i),Com_Per_Ch(:,i)] = HjorthParameters(Each_Channel);
end
% [mobility,complexity] = HjorthParameters(xV)
Features = [Mean_Per_Ch,Var_Per_Ch,Ske_Per_Ch,Kur_Per_C,...
    Min_Per_Ch,Max_Per_Ch,Mob_Per_Ch,Com_Per_Ch];
end

