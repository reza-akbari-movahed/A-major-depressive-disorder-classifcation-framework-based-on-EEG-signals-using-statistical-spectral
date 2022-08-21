% Feature Extraction Code
clc
clear all
close all
%% Loading dataset
load('G:\MATLAB_Codes\EEG Codes\Final_Set_to_MAT\EEG_Dataset_Mod_Channels.mat');
%% EEG Signal Slicing (EEG Signal Segmentation) (Data Augmentation)
Idx = 1; 
for i=1:length(EEG_Dataset)
    Signal_Segments = Slicing_Function(EEG_Dataset{i,1},1);
    for j=1:size(Signal_Segments,2)
        Each_Segment{Idx,1} = Signal_Segments{1,j};
        Labels(Idx,1) = EEG_Dataset{i,2};
        Idx = Idx + 1; 
    end
end
%% Feature Extraction 
Sampling_Rate = EEG_Dataset{1, 1}.srate ;
%
N = 3 ; 
wname = 'coif5';
%
lag = 10;   % lag
m = 10;   % embedding dimension
w1 = 100;  % window (Theiler correction for autocorrelation)
w2 = 410;  % window (used to sharpen the time resolution of synchronization measure)
pref = 0.01;
%
pts = 700;
%
Kmax = 30;
%
parfor i=1:length(Each_Segment)
   [ST(i,:)] = Stattistical_FE(Each_Segment{i,1});
   [P(i,:)] = Band_Power_Cal(Each_Segment{i,1},Sampling_Rate);
   [IA(i,:)] = Interhemispheric_Asymmetric(Each_Segment{i,1},Sampling_Rate);
   [RWE_F(i,:),WE_F(i,:),~,~] = RWE(Each_Segment{i,1},N,wname);
   [SL_F(i,:),In] = SL_Cal(Each_Segment{i,1},lag,m,w1,w2,pref);
   [DFA_F(i,:),~] = DFA_Code(Each_Segment{i,1},pts);
   [HFD_F(i,:)] = HDF(Each_Segment{i,1},Kmax);
   [corDim(i,:),lyapExp(i,:)] = CD_Cal(Each_Segment{i,1},Sampling_Rate);
   [C0_F(i,:),AE_F(i,:),Ko_F(i,:),Sh_F(i,:)] = C0_Features(Each_Segment{i,1});
end
Data_Feature_Extracted = cat(2,ST,P,IA,RWE_F,WE_F,SL_F,DFA_F,...
    HFD_F,corDim,lyapExp,C0_F,AE_F,Ko_F,Sh_F);
save('Feature_Extracted_one_m_Mod.mat','Data_Feature_Extracted','Labels');