function [X, y1, XTest, yTest] = loadPoseData(datasetPath, datasetName, featureType, occlusionLevel)
    if(featureType==0) % histogram of shape context
        load([datasetPath, datasetName, 'XYdata.mat']);
        X = X1';
        y1 = Y1';
        XTest = X2';
        yTest = Y2';
    elseif(featureType==1) % downsampled
        load([datasetPath, datasetName, 'XYdataRaw.mat']);
        y1 = Y1';
        yTest = Y2';
        
        ds_scale = 0.125;
        numFeatDim = ds_scale^2*128*64;
        % Train samples
        numTrainSample = length(X1Raw);
        numTestSample = length(X2Raw);
        
        X1 = zeros(numFeatDim, numTrainSample);
        % Train samle
        for i = 1: numTrainSample 
            img = X1Raw{i};
            imgD = imresize(img, ds_scale);
            X1(:,i) = imgD(:);
        end
        % Test sample
        if(occlusionLevel>0)
            X2 = getTestSampleOcc(X2Raw, ds_scale, occlusionLevel, numFeatDim);
        else
            for i = 1: numTestSample
                img = X2Raw{i};
                imgD = imresize(img, ds_scale);
                X2(:,i) = imgD(:);
            end
        end        
        X = X1';
        XTest = X2';
    elseif(featureType==2) % PCA
        
    elseif(featureType==3)
        
    end
end