function [IA] = Interhemispheric_Asymmetric(EEG_Signal,Sampling_Rate)
% Defining four frequency bands of EEG signal 
Delta_frerange = [0.5,4];
Theta_frerange = [4,8];
Alpha_frerange = [8,13];
Beta_frerange = [13,30];
% Extracing data and sampling rate from EEG data 
% Sampling_Rate = EEG_Data.srate;
% EEG_Signal = EEG_Data.data;
EEG_Signal_tr = EEG_Signal';
% Extracting pair channels 
Pair_Channel_Indic = [1,10;...
    2,11;...
    6,15;...
    3,12;...
    4,13;...
    7,16;...
    8,17;...
    5,14];
% Fp1 = EEG_Signal_tr(:,1);
% Fp2 = EEG_Signal_tr(:,10);
% F3 = EEG_Signal_tr(:,2);
% F4 = EEG_Signal_tr(:,11);
% F7 = EEG_Signal_tr(:,6);
% F8 = EEG_Signal_tr(:,15);
% C3 = EEG_Signal_tr(:,3);
% C4 = EEG_Signal_tr(:,12);
% P3 = EEG_Signal_tr(:,4);
% P4 = EEG_Signal_tr(:,13);
% T3 = EEG_Signal_tr(:,7);
% T4 = EEG_Signal_tr(:,16);
% T5 = EEG_Signal_tr(:,8);
% T6 = EEG_Signal_tr(:,17);
% O1 = EEG_Signal_tr(:,5);
% O2 = EEG_Signal_tr(:,14);
IA = [];
for i=1:size(Pair_Channel_Indic,1)
    % Extracting left and right channels
    L_S = EEG_Signal_tr(:,Pair_Channel_Indic(i,1));
    R_S = EEG_Signal_tr(:,Pair_Channel_Indic(i,2));
    % Calculating the band powers of the left signal
    [pxx_L,f_L] = pwelch(L_S,[],[],[],Sampling_Rate);
    P_Alpha_L = bandpower(pxx_L,f_L,Alpha_frerange,'psd');
    P_Delta_L = bandpower(pxx_L,f_L,Delta_frerange,'psd');
    P_Theta_L = bandpower(pxx_L,f_L,Theta_frerange,'psd');
    P_Beta_L = bandpower(pxx_L,f_L,Beta_frerange,'psd');
    % Calculating the band powers of the right signal
    [pxx_R,f_R] = pwelch(R_S,[],[],[],Sampling_Rate);
    P_Alpha_R = bandpower(pxx_R,f_R,Alpha_frerange,'psd');
    P_Delta_R = bandpower(pxx_R,f_R,Delta_frerange,'psd');
    P_Theta_R = bandpower(pxx_R,f_R,Theta_frerange,'psd');
    P_Beta_R = bandpower(pxx_R,f_R,Beta_frerange,'psd');
    % Calculating the Interhemispheric asymmetry for each frequency band
    IA_Alpha = log(P_Alpha_R)-log(P_Alpha_L);
    IA_Delta = log(P_Delta_R)-log(P_Delta_L);
    IA_Theta = log(P_Theta_R)-log(P_Theta_L);
    IA_Beta = log(P_Beta_R)-log(P_Beta_L);
    IA = [IA,IA_Alpha,IA_Delta,IA_Theta,IA_Beta];
end
    




end

