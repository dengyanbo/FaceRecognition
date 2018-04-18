% clear;
% clc;
% close all;

%*********************************ROC**************************************
G=hG.Values;
I=hI.Values;
FPR = [];%FP/(FP+TN);
TPR = [];%TP/(TP+FN);
TPIR = [];
for i=1:length(G)
    FP = sum(I(1:i));
    FN = sum(G(i:end));
    TP = sum(G(1:i));
    TN = sum(I(i:end));
    FPR = [FPR FP/(FP+TN)];
    TPR = [TPR TP/(TP+FN)];
%     TPIR = [TPIR TP/(TP+FN)];
end
figure(1)
plot(FPR,TPR);
title('ROC curve');
ylabel('Verification Rate');
xlabel('False Accept Rate');

%*********************************CMC**************************************
% score = [Gscore Iscore];
% score(isnan(score))=[];
% 
% sorted_score = sort(score);
% for i = 1:length(score)
%     
%     TPIR = [TPIR sum(Gscore<=sorted_score(i))/length(Gscore)];
% end 
% TPIR = [TPIR 1];    

% figure(2)
% plot(1:(length(sorted_score)+1),TPIR);
% title('CMC curve for LG2200 2010');
% xlabel('Rank Counted as Recognition');
% ylabel('Recognition Rate');