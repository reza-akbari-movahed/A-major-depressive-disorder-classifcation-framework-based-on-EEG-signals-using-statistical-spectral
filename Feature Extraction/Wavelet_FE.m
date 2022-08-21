function [Coeff,C_Mat] = Wavelet_FE(EEG_Data,N,wname,L1,L2)
% N is the level of wavelet decomposition 
% wname is the name of wavelet of window 
% L1 and L2 are the indicators for approximation and detail coefficients extraction
EEG_Signal = EEG_Data;
Lin = linspace(1,N,N);
for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
    [C,L] = wavedec(Each_Channel,N,wname);
    approx = appcoef(C,L,wname);
    approx = {approx};
    for j=1:N
        CD{j} = detcoef(C,L,j);
    end
    Coeff{i,1} = cat(2,approx,CD);
end
C = Coeff{1,1};
C_Mat = cell2mat(C(1:2));
for i=2:size(Coeff,1)
    C = Coeff{i,1};
    C_Mat = cat(2,C_Mat,cell2mat(C(L1:L2)));
end    
   

end