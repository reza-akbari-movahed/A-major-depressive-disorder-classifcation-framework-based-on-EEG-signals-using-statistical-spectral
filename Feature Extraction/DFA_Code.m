function [All_F,F_Per_Ch] = DFA_Code(EEG_Signal,pts)
% This code calculates the fluctuations corresponding to the windows specified in entries in pts.
% EEG_Signal = EEG_Data.data;
for i=1:size(EEG_Signal,1)
    Each_Channel = EEG_Signal(i,:);
    [~,F] = DFA_fun(Each_Channel,pts);
    F = F' ;
    F_Per_Ch(i,:) = F ; 

end
All_F = F_Per_Ch(:);
end

