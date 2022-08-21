function [Signal_Segments] = Slicing_Function(EEG_Data,Slicing_Time)
% The Slicing Time input should be per minute;
Sample_Rate = EEG_Data.srate;
EEG_Signal = EEG_Data.data;
Slicing_Time = Slicing_Time * 60 ; % Slicing Time per second
Slicing_Sample = Slicing_Time * Sample_Rate;
Rr = 1; 
Ll = Slicing_Sample;
Ind = 1 ;
Idx = 1;
while Ll <= size(EEG_Signal,2)
    Signal_Segments{Idx} = EEG_Signal(:,Rr:Ll);
    Rr = Rr +Slicing_Sample ; 
    Ll = Ll + Slicing_Sample;
    Idx = Idx + 1 ;
end
% while Ind <=2
%     Signal_Segments{Idx} = EEG_Signal(:,Rr:Ll);
%     Rr = Rr +Slicing_Sample ; 
%     Ll = Ll + Slicing_Sample;
%     Idx = Idx + 1 ;
%     if Ll >= size(EEG_Signal,2)
%         Ll = size(EEG_Signal,2);
%         Ind = Ind + 1 ;
%     end
% end
end

