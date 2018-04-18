imgDataPath = 'C:\Users\dengy\Desktop\face_data_new\';
imgDataDir  = dir(imgDataPath);
map = containers.Map;

count = 1;
for i = 1:length(imgDataDir)
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
        map(char(count)) = imgDataDir(i).name;
        count = count + 1;
    end
    
end