function X2 = getTestSampleOcc(X2Raw, ds_scale, occlusionLevel, numFeatDim)

    numTestSample = length(X2Raw);
    X2 = zeros(numFeatDim, numTestSample);
    for i = 1: numTestSample
        img = X2Raw{i};
        % Add occlusion by generating random blocks
        [imgHeight, imgWidth] = size(img);
%         occBlockSize = imgWidth*occlusionLevel;
        blkSize = rand(1,2)*imgHeight*occlusionLevel;
        blkPos = rand(1,2).*[imgHeight, imgWidth];
        r1 = 1+round(blkPos(1)-0.5*blkSize(1));
        r2 = 1+round(blkPos(1)+0.5*blkSize(1));
        c1 = 1+round(blkPos(2)-0.5*blkSize(2));
        c2 = 1+round(blkPos(2)+0.5*blkSize(2));
        if(r1<1) r1 = 1; end
        if(r2>imgHeight) r2 = imgHeight; end
        if(c1<1) c1 = 1; end
        if(c2>imgWidth) c2 = imgWidth; end
        
        img(r1:r2,c1:c2) = 1;
%         figure(1), imshow(img);
        imgD = imresize(img, ds_scale);
        X2(:,i) = imgD(:);
    end

end