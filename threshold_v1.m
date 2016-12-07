clearvars

name = '2016-08-2016-09-02_wt_dfo'; % the file name for your run
D = dir('*.tif');
numimages = length(D); % final number of images
iint = 3; % time between images (min)
phase_sigma = 4; % number of stdev below for thresholding

frame = 1; %frame for background

phase = imread(strcat(name,'c1t01.tif'));

figure(1);
imshow(phase);
title('Define Background')
rect = getrect;
close

xmin = round(rect(1,1));
xmax = round(rect(1,1) + rect(1,3));
ymin = round(rect(1,2));
ymax = round(rect(1,2) + rect(1,4));

background = phase(ymin:ymax,xmin:xmax);
mean = mean2(background);
std = std2(background);

thresholdPHASE = mean-(phase_sigma*std);

phase = imread(strcat(name,'c1t',sprintf('%02d',frame),'.tif'));
mask = phase<thresholdPHASE;
mask16 = uint16(mask);
on = sum(sum(mask16));

mkdir('Masks');

for j = 1:numimages 
    
    num = sprintf('%02d',j);
    
    % make mask
    phase = imread(strcat(name,'c1t',num,'.tif'));
    mask = phase<thresholdPHASE;
    imwrite(mask,strcat('Masks/',name,'c1t',num,'.tif'));
    
    fprintf('Analysis Frame %d Completed\n',j)
end