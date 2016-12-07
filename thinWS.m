function mask = thinWS(mask, sensitivity)
stats = regionprops(mask, 'MinorAxisLength', 'PixelIdxList');
widths = [stats.MinorAxisLength];
meanval = mean(widths);
absdev = abs(widths - meanval);
mad = median(absdev);
thresh = sensitivity * mad;
outliersIdx = abs(absdev) > thresh;
[rw, ~] = size(stats);
inds =1:rw;
outliers = inds(outliersIdx);
if ~isempty(outliers)
    orig = mask;
    for i=1:rw
        if (i~=outliers)
           mask(stats(i).PixelIdxList)=0;
        end
    end
    anti = orig - mask;
    mask = dynamicWS(mask,4);
    mask = anti + mask;
end