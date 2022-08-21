clc
clear all
close all 
%% Applying Cross-validation, Normalization, Feature Selection, Training and Testing
Current_dir = pwd 
List_Current_dir = split(Current_dir,'\')
Data_Link = '' ;
for i=1:length(List_Current_dir)-1
    Data_Link = append(Data_Link, List_Current_dir{i,1},'\');
end
load(fullfile(Data_Link,'Feature_Extracted.mat'))
Number_of_Samples = size(Data_Feature_Extracted,1);
Num_Folds = 10; 
Whole_Acc = []; 
Whole_SE = []; 
Whole_SP = []; 
Whole_F1 = []; 
Whole_FDR = []; 
for l=1:1
    indices = crossvalind('Kfold',Number_of_Samples,Num_Folds);
    for k=1:Num_Folds
        %% Dividing data to the training and testing set 
        testindex = (indices == k);
        trainindex = ~testindex;
        Train_Data = Data_Feature_Extracted(trainindex,:);
        Train_Label = Labels(trainindex,:);
        Test_Data = Data_Feature_Extracted(testindex,:);
        Test_Label = Labels(testindex,:);
        %% Feature Selection
        [Tuning_Accuracy,Selected_Features] = SBFS_Based_Accuracy_SVM(Train_Data,Train_Label,10);
%         [Selected_Features,~] = SequentialFS(Train_Data,Train_Label,10,'backward');
    %   [~,Selected_Features] = SFFS_Based_AUC_SVM(Train_Data,Train_Label,5);
    %   [Selected_Features,history] = SequentialFS(Train_Data,Train_Label,10,'forward');
        Train_Data(:,Selected_Features) = [];
        %% Normalization
        [Train_Data_Norm,Mean_Train_Data,Std_Train_Data] = zscore(Train_Data);
    %     Mean_Train_Data = mean(Train_Data(:));
    %     Std_Train_Data = std(Train_Data(:));
    %     Train_Data_Norm = (Train_Data-Mean_Train_Data)/Std_Train_Data;
        %% Training the classifier
        Model = fitcsvm(Train_Data_Norm,Train_Label,'KernelFunction','rbf',...
            'OptimizeHyperparameters','auto','HyperparameterOptimizationOptions',...
        struct('ShowPlots',false,'UseParallel',true));
        %% Testing the classifier
        Test_Data(:,Selected_Features) = [];
        Test_Data_Norm = (Test_Data-Mean_Train_Data)./Std_Train_Data;
        [SE(k,1),SP(k,1),...
            F1(k,1),FDR(k,1),Acc(k,1)] = Evaluation_Classifier(Test_Data_Norm,Test_Label,Model);
    end
    l
    Whole_Acc = cat(1,Whole_Acc,Acc); 
    Whole_SE = cat(1,Whole_SE,SE);
    Whole_SP = cat(1,Whole_SP,SP);
    Whole_F1 = cat(1,Whole_F1,F1);
    Whole_FDR = cat(1,Whole_FDR,FDR);
end
save('Results.mat','Whole_Acc','Whole_SE','Whole_SP',...
    'Whole_F1','Whole_FDR')
Mean_Accuracy = mean(Whole_Acc);
Std_Accuracy = std(Whole_Acc);
Mean_Sensitivity = mean(Whole_SE);
Std_Sensitivity = std(Whole_SE);
Mean_Specificity = mean(Whole_SP);
Std_Specificity = std(Whole_SP);
Mean_F1_Score = mean(Whole_F1);
Std_F1_Score = std(Whole_F1);
Mean_FDR = mean(Whole_FDR);
Std_FDR = std(Whole_FDR);
