function [Senivity,Specifity,F1_Score,FDR,Accuracy] = Evaluation_Classifier(Test_Data,Test_Label,Model)
TP = 0 ; TN = 0 ; FP =0 ; FN=0;
for i=1:size(Test_Data,1)
    Classification_Result = predict(Model,Test_Data(i,:));
    Label = Test_Label(i,1); 
    if (Classification_Result==-1)&(Label==-1)
        TP = TP + 1 ;
    end
    if (Classification_Result==-1)&(Label==1)
        FP = FP + 1 ; 
    end
    if (Classification_Result==1)&(Label==-1)
        FN = FN + 1 ; 
    end
    if (Classification_Result==1)&(Label==1)
        TN = TN + 1 ;
    end
end
Accuracy = (TP+TN)/size(Test_Data,1) ;
Senivity = TP/(TP+FN) ; 
Specifity = TN/(TN+FP) ;    
FDR = FP/(TP+FP) ; 
F1_Score = (2*(TP))/((2*(TP))+FP+FN);
end