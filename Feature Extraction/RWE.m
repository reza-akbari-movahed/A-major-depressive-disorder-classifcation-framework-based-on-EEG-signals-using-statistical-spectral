function [RWE_All_Ch_vec,...
    WE_All_Ch_vec,RWE_All_Ch,WE_All_Ch] = RWE(EEG_Signal,N,wname)
% This code calculates the relative wavelet energy(RWE) and wavelet entropy(WE)
% Relative Wavelet Energy calculation code
% N is the level of wavelet decomposition 
% wname is the name of wavelet of window 
% EEG_Signal = EEG_Data.data;
RWE_All_Ch = [];
WE_All_Ch = [];
for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
    [C,L] = wavedec(Each_Channel,N,wname);
    [Ea,Ed] = wenergy(C,L);
    Etotal = sum(Ed);
    RWE = Ed/Etotal; 
    WE = -(sum(RWE.*log(RWE)));
    WE_All_Ch = cat(1,WE_All_Ch,WE);
    RWE_All_Ch = cat(1,RWE_All_Ch,RWE);
end
RWE_All_Ch_vec = (RWE_All_Ch(:))';
WE_All_Ch_vec = (WE_All_Ch(:))';   

end