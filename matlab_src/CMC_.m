allcoor = allsamples * base;
sizealltests = size(alltests);
samplesize = size(allsamples);
Rank = 1;
TPR = [];
% TPR = zeros(1,50);
for R = 1:500:sizealltests(1)
    TP = 0;
    for j =1:sizealltests(1)
        display(j/sizealltests(1));
        b = alltests(j,:);
        b = double(b);
        tcoor= b * base;
        mdist = zeros(1,samplesize(1));
        for k=1:samplesize(1)
            mdist(k)=norm(tcoor-allcoor(k,:));
        end;
        [dist,index2]=sort(mdist);
        
        for Rank = 1:R
            class = index2(Rank);
            curID = mapt(char(j));
            ID = map(char(class));
            if strcmp(curID, ID)
                TP=TP+1;
                break;
            end;
        end
    end
    TPR = [TPR TP/sizealltests(1)];
end

figure(2)
% TPR = [0 TPR 1];
x = 1:500:sizealltests(1);
x = [0 x];
TPR = [0 TPR];
plot(x,TPR);
xlim([-100 4000]);
ylim([-0.1 1.1]);
title('CMC curve');
xlabel('Rank Counted as Recognition');
ylabel('Recognition Rate');