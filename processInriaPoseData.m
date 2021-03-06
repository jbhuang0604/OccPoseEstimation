% processInriaPoseData

datasetPath = 'dataset/';
datasetName = 'INRIAPose/';
seqDir = dir([datasetPath,datasetName,'Silhouettes/']);

XTrainRaw = [];
XTestRaw = [];
indSample = 1;
% Train
for indSeq = 1: 8
    imgDir = dir([datasetPath,datasetName,'Silhouettes/', '0',num2str(indSeq),'/*.png']);
    numImg = length(imgDir);
    for indImg = 1:numImg
        img = imread([datasetPath,datasetName,'Silhouettes/', '0',num2str(indSeq),'/',imgDir(indImg).name]);
        img = im2bw(img);
        img = img(:,32:95);

        XTrainRaw{indSample} = img;
        fprintf(1,'Train sample: %d\n', indSample);

        indSample = indSample + 1;
%         fprintf(1,'Train sample: %d\n', indSample);
    end
end
indSample = 1;

% Test
indSeq = 9;
imgDir = dir([datasetPath,datasetName,'Silhouettes/', '0',num2str(indSeq),'/*.png']);
numImg = length(imgDir);
for indImg = 1:numImg
    img = imread([datasetPath,datasetName,'Silhouettes/', '0',num2str(indSeq),'/',imgDir(indImg).name]);
    img = im2bw(img);
    img = img(:,32:95);
    XTestRaw{indSample} = img;

    fprintf(1,'Test sample: %d\n', indSample);
    indSample = indSample + 1;
end

% Load Y
load([datasetPath, datasetName, 'XYdata.mat']);
X1Raw = XTrainRaw;
X2Raw = XTestRaw;

save([datasetPath,datasetName, 'XYdataRaw.mat'], 'X1Raw', 'X2Raw', 'Y1','Y2');
