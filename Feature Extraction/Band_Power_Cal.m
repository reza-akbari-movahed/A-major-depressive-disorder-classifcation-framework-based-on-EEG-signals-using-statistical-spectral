function [P] = Band_Power_Cal(EEG_Signal,Sampling_Rate)
% Defining four frequency bands of EEG signal 
Delta_frerange = [0.5,4];
Theta_frerange = [4,8];
Alpha_frerange = [8,13];
Beta_frerange = [13,30];
% Extracing data and sampling rate from EEG data 
% Sampling_Rate = EEG_Data.srate;
% EEG_Signal = EEG_Data.data;
EEG_Signal_tr = EEG_Signal';
% Calculating periodogram and band power of four frequency bands
[pxx,f] = pwelch(EEG_Signal_tr,[],[],[],Sampling_Rate);
P_Alpha = bandpower(pxx,f,Alpha_frerange,'psd');
P_Delta = bandpower(pxx,f,Delta_frerange,'psd');
P_Theta = bandpower(pxx,f,Theta_frerange,'psd');
P_Beta = bandpower(pxx,f,Beta_frerange,'psd');
P = [P_Alpha,P_Delta,P_Theta,P_Beta];




end

