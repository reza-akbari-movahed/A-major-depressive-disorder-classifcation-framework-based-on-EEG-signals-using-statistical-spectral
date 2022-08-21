function [E] = Shannon_Entropy(EEG_Signal)
p = hist(EEG_Signal,5000);
p(p==0) = [];
p = p/numel(EEG_Signal);
E = -sum(p.*log2(p));
end

