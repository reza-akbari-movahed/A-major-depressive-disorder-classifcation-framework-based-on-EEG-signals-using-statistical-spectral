function [Tuning_Accuracy,Features] = SBFS_Based_Accuracy_SVM(Train_Data,Train_Label,Num_Folds);
%%%%
Accuracy_all_Feature = Training_SVM_Accuracy(Train_Data,Train_Label,Num_Folds);
% Idx = 1 ;
parfor Idx=1:size(Train_Data,2)
% while Idx<=size(Train_Data,2)
    Train_Data_Copy = Train_Data; 
    Train_Data_Copy(:,Idx) = [];
    Accuracy_Each_Feature(Idx,1) = Training_SVM_Accuracy(Train_Data_Copy,Train_Label,Num_Folds);
%     Idx = Idx + 1 ; 
%     Model = fitcsvm(Train_Data_Each_Feature,Train_Label,'Standardize',true,'KernelFunction','rbf');
%     CompactSVMModel = compact(Model);
%     CompactSVMModel = fitPosterior(CompactSVMModel,Train_Data_Each_Feature,Train_Label);
%     [label,PostProbs] = predict(CompactSVMModel,Test_Data(:,j));
%     [~,~,~,AUC] = perfcurve(Test_Label,PostProbs(:,2),1);
%     Model = fitcdiscr(Train_Data_Each_Feature,Train_Label, 'DiscrimType','quadratic');
%     [Predict,score] = predict(Model,Data(:,j));
%     AUC_Array(j,1) = AUC;
end
All_accuries = [Accuracy_all_Feature;Accuracy_Each_Feature];
Max_Accuracy = max(All_accuries(:));
Tuning_Accuracy = Max_Accuracy;
Features = find(All_accuries==Max_Accuracy) ; 
Features = Features - 1 ; 
if Features==0
    disp('All Features are selected')
    Features = 1:size(Train_Data,2);
else
    Features = Features';
    New_Train_Data = Train_Data;
%     New_Train_Data(:,Features) = [];
    clear Accuracy_Each_Feature
    Alarm = 1 ;
    Idx = 1 ;
    while (Alarm==1)
        parfor i=1:size(New_Train_Data,2)
            if ~(ismember(i,Features))
                New_Features = cat(2,i,Features);
                New_New_Train_Data = New_Train_Data ;
                New_New_Train_Data(:,New_Features) = []; 
                Accuracy_Each_Feature(i,1) = Training_SVM_Accuracy(New_New_Train_Data,Train_Label,Num_Folds)
            end
        end
        Max_Accuracy = max(Accuracy_Each_Feature(:));
        Selected_Feature = find(Accuracy_Each_Feature==Max_Accuracy) ; 
        Selected_Feature = Selected_Feature' ; 
        if Max_Accuracy < Tuning_Accuracy(Idx)
            Alarm = 0 ;
        else
            Features = cat(2,Features,Selected_Feature);
        end
        Tuning_Accuracy(Idx+1) = Max_Accuracy ;
        clear Accuracy_Each_Feature
        Idx = Idx + 1 ; 
    end
% save('Features.mat','Features')
end