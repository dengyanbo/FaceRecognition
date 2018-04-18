allcoor = allsamples * base;
sizealltests = size(alltests);
samplesize = size(allsamples);
Rank = 1;

% GE=[];
% IM=[];

for j =1:sizealltests(1)
    display(j/sizealltests(1));
    b = alltests(j,:);
    b = double(b);
    
    tcoor= b * base;
    mdist=zeros(1,samplesize(1));
    for k=1:samplesize(1)
        mdist(k)=norm(tcoor-allcoor(k,:));
    end;
    [dist,index2]=sort(mdist);
    class = index2(Rank);
    for k = 300:300:samplesize(1)
        curID = mapt(char(j));
        ID = map(char(k));
        if(strcmp(curID, ID))
            GE = [GE dist(k)];
        else 
            IM = [IM dist(k)];
        end
    end
%     curID = mapt(char(j));
%     ID = map(char(class));
%     if strcmp(curID, ID)
%         GE = [GE class];
%     end;
    
end
save('GE_IM.mat','GE','IM');

figure,
hG = histogram(GE,'Normalization','probability','faceColor','b','edgecolor','b','BinWidth',300);
hold on
hI = histogram(IM,'Normalization','probability','faceColor','r','edgecolor','r','BinWidth',300);
xlabel('Manhattan Distance');
ylabel('Probability');
title('Manhattan Distance Distribution');
legend('Genuine Distribution', 'Imposter Distribution', 'location', 'Northeast');
hold off

