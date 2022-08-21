function [HFD_All_Ch] = HDF(EEG_Signal,Kmax)
%{
This code is used to compute the Higuchi Fractal Dimension (HDF) of a signal.
Kmax: maximum number of sub-series composed from the original. 
%}
% EEG_Signal = EEG_Data.data;

for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
    HFD_All_Ch(:,i) = Higuchi_FD(Each_Channel, Kmax);
end
 

end