function [SL_Features,indeices] = SL_Cal(EEG_Signal,lag,m,w1,w2,pref)
% This code extractes the synchronization likelihood features
% EEG_Signal = EEG_Data.data;
EEG_Signal = EEG_Signal';
Matrix_Results = H_sl(EEG_Signal,lag,m,w1,w2,pref);

Index = 2:1:size(EEG_Signal,2);
Idx = 1;
for i=1:size(EEG_Signal,2)
    for j=1:size(Index,2)
        SL_Features(:,Idx) = Matrix_Results(i,Index(j));
        indeices(Idx,:) = [i,Index(j)];
        Idx = Idx + 1;
    end
    Index = (2+i):1:size(EEG_Signal,2);
end


end

