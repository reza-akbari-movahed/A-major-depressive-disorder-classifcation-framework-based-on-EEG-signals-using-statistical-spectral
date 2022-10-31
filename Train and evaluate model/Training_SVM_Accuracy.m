function [Accuracy_Each_Feature] = Training_SVM_Accuracy(Train_Data_Each_Feature,Train_Label,Num_Folds)
indices = crossvalind('Kfold',size(Train_Data_Each_Feature,1),Num_Folds);
for k=1:Num_Folds
    testindex = (indices == k);
    trainindex = ~testindex;
    Training_Data = Train_Data_Each_Feature(trainindex,:);
    Training_Label = Train_Label(trainindex,:);
    Testing_Data = Train_Data_Each_Feature(testindex,:);
    Testing_Label = Train_Label(testindex,:);
    
    Mean = mean(Training_Data(:));
    Std = std(Training_Data(:));
    Training_Data_Norm = (Training_Data-Mean)/Std ; 
    
    Mdl = fitcsvm(Training_Data_Norm,Training_Label);
    
    Testing_Data_Norm = (Testing_Data-Mean)/Std ;
    Te_Acuraccy(k,1) = sum(predict(Mdl,Testing_Data_Norm) == Testing_Label)/size(Testing_Label,1);
end
Accuracy_Each_Feature = mean(Te_Acuraccy(:));
end

