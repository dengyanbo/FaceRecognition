% %function FaceRecognition
clear  % calc xmean,sigma and its eigen decomposition
close all
allsamples=[];
imgDataPath = 'C:\Users\dengy\Desktop\face_data_new\';
imgDataDir  = dir(imgDataPath);
map = containers.Map;

display('Start...');
count = 1;
for i = 1:length(imgDataDir)
    per = i/length(imgDataDir);
    if per > 0.1*count
        display(count);
        count=count+1;
    end
    %     display(imgDataDir(i).name);
    %skip non-folders******************************************************
    if(isequal(imgDataDir(i).name,'.')||...
            isequal(imgDataDir(i).name,'..')||...
            ~imgDataDir(i).isdir)
        continue;
    end
    %end skip non-folders**************************************************
    trainDir = [imgDataPath imgDataDir(i).name '\Train_data\'];
    imgDir = dir([trainDir '*.nef']);
    for j =1:length(imgDir)
        name = [trainDir imgDir(j).name];
        a = rgb2gray(imread(name));
        a = transpose(a);
        b = a(:)';
        b = double(b);
        allsamples=[allsamples; b];
        map(char(count)) = imgDataDir(i).name;
    end
end
save('allsamples.mat', 'allsamples','map');
display('image reading done');

samplemean=mean(allsamples); 
figure,
imshow(mat2gray(reshape(samplemean,160,120)));
samplesize=size(allsamples);
for i=1:samplesize(1)
    xmean(i,:)=allsamples(i,:)-samplemean; 
end;
figure
imshow(mat2gray(reshape(xmean(1,:),160,120)));
sigma=xmean*xmean';   
[v,d]=eig(sigma);
d1=diag(d);
[d2,index]=sort(d1); 
cols=size(v,2);


for i=1:cols
    vsort(:,i) = v(:, index(cols-i+1) );
    dsort(i)   = d1( index(cols-i+1) );
end
display('compute eigenface done');
dsum = sum(dsort);
dsum_extract = 0;
p = 0;
while( dsum_extract/dsum < 0.9)
    p = p + 1;
    dsum_extract = sum(dsort(1:p));
end

i=1;
while (i<=p && dsort(i)>0)
    base(:,i) = dsort(i)^(-1/2) * xmean' * vsort(:,i);
    i = i + 1;
end
%
% for i=1:20
%   figure
% b=reshape(base(:,i)',160,120);%
% imshow(mat2gray(b));
% end
save('base.mat', 'base');
display('finish training');

mapt = containers.Map;
allcoor = allsamples * base; 
display('start testing');
testNumber = 0;
accu = 0;
alltests = [];
for i = 1:length(imgDataDir)
    %     display(imgDataDir(i).name);
    %skip non-folders******************************************************
    if(isequal(imgDataDir(i).name,'.')||...
            isequal(imgDataDir(i).name,'..')||...
            ~imgDataDir(i).isdir)
        continue;
    end
    %end skip non-folders**************************************************
    testDir = [imgDataPath imgDataDir(i).name '\Test_data\'];
    imgDir = dir([testDir '*.nef']);
    for j =1:length(imgDir)
        testNumber = testNumber + 1;
        name = [testDir imgDir(j).name];
        a = rgb2gray(imread(name));
        a = transpose(a);
        b = a(:)';
        b = double(b);
        alltests=[alltests; b];
        mapt(char(count)) = imgDataDir(i).name;
        
        tcoor= b * base;
        for k=1:samplesize(1)
            mdist(k)=norm(tcoor-allcoor(k,:));
        end; 
        [dist,index2]=sort(mdist);
        class = index2(1);

        temp = strsplit(imgDir(j).name,'d');
        curID = char(temp(1));
        ID = map(char(class));
        if strcmp(curID, ID)
            accu=accu+1;
        end;
    end
end

accuracy=accu/testNumber