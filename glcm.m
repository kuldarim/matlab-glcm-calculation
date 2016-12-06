clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear all;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.

dirbtine = imread('/teksturos/dirbtine.png');
sky = imread('teksturos/clear_sky.png');
grass = imread('teksturos/grass.jpg');
% figure;imshow(dirbtine);
% figure;imshow(sky);
% figure;imshow(grass);

% offsets explained https://se.mathworks.com/help/images/specify-offset-used-in-glcm-calculation.html
% possible offset [0 1; -1 1; -1 0; -1 -1]
OFFSET = [0 1; 0 2; 0 3; 0 4;...
           -1 1; -2 2; -3 3; -4 4;...
           -1 0; -2 0; -3 0; -4 0;...
           -1 -1; -2 -2; -3 -3; -4 -4];
GLCM_dirbtine = graycomatrix(rgb2gray(dirbtine),'Offset', OFFSET);
GLCM_sky = graycomatrix(rgb2gray(sky),'Offset', OFFSET);
GCLM_grass = graycomatrix(rgb2gray(grass),'Offset', OFFSET);

stats_dirbtine = struct2array(graycoprops(GLCM_dirbtine));
stats_sky = struct2array(graycoprops(GLCM_sky));
stats_grass = struct2array(graycoprops(GCLM_grass));

% Contrast is the difference in luminance or colour that makes an object 
%(or its representation in an image or display) distinguishable. 
%In visual perception of the real world, contrast is determined by the difference 
%in the color and brightness of the object and other objects within the same field of view. 
fprintf('kontrastas dirbtines: %3.2f \n', stats_dirbtine(1));
fprintf('kontrastas sky: %3.2f \n', stats_sky(1));
fprintf('kontrastas grass: %3.2f \n', stats_grass(1));

entropy_dirbtine = custom_entropy(GLCM_dirbtine);
entropy_sky = custom_entropy(GLCM_sky);
entropy_grass = custom_entropy(GCLM_grass);

fprintf('entropija dirbtines: %3.2f \n', entropy_dirbtine);
fprintf('entropija sky: %3.2f \n', entropy_sky);
fprintf('entropija grass: %3.2f \n', entropy_grass);
