for ind = 1:81
    if length(num2str(ind)) == 1
        index = ['0' num2str(ind)];
    else
        index = num2str(ind);
    end
    fileid = ['h5/2016-08-2016-09-02_wt_dfoc1t' index '_Simple Segmentation.h5'];
    mask = readIlastikFile(fileid, 1);
    imwrite(mask, ['rawilastik/mask' index '.tif'],'tif');
    mask = imfill(mask,'holes');
    thresh = 200;
    mask = bwareaopen(mask, thresh);
    mask = bwmorph(mask, 'majority', Inf);
    %imshow(mask)

    mask = simpleWS(mask);
    mask = bwareaopen(mask, thresh);
    %imshow(mask)
    mask = imclearborder(mask);
    %imshow(mask)
    imwrite(mask, ['postprocess/mask' index '.tif'],'tif');
end