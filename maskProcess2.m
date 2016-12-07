for ind = 1:60
    if length(num2str(ind)) == 1
        index = ['0' num2str(ind)];
    else
        index = num2str(ind);
    end
    fileid = ['h5/2016-08-2016-09-02_wt_dfoc1t' index '_Simple Segmentation.h5'];
    mask = readIlastikFile(fileid, 1);
    mask = imfill(mask,'holes');
    thresh = 200;
    mask = bwareaopen(mask, thresh);
    mask = bwmorph(mask, 'majority', Inf);
    mask = simpleWS(mask);

    sensitivity = 7;
    mask = thinWS(mask, sensitivity);
    mask = bwareaopen(mask, thresh);
    imshow(mask)
    imwrite(mask, ['postprocess2/mask' index '.tif'],'tif');
end