clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear all;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.

dirbtine = imread('/teksturos/dirbtine.png');
sky = imread('teksturos/clear_sky.png');
grass = imread('teksturos/grass.jpg');
figure;imshow(dirbtine);
figure;imshow(sky);
figure;imshow(grass);

stats_dirbtine = struct2array(graycoprops(rgb2gray(dirbtine)));
stats_sky = struct2array(graycoprops(rgb2gray(sky)));
stats_grass = struct2array(graycoprops(rgb2gray(grass)));

% Contrast is the difference in luminance or colour that makes an object 
%(or its representation in an image or display) distinguishable. 
%In visual perception of the real world, contrast is determined by the difference 
%in the color and brightness of the object and other objects within the same field of view. 
fprintf('kontrastas dirbtines: %3.2f \n', stats_dirbtine(1));
fprintf('kontrastas sky: %3.2f \n', stats_sky(1));
fprintf('kontrastas grass: %3.2f \n', stats_grass(1));

entropy_dirbtine = custom_entropy(dirbtine);
stats_sky = custom_entropy(sky);
stats_grass = custom_entropy(grass);

fprintf('entropija dirbtines: %3.2f %3.2f %3.2f \n', entropy_dirbtine(1), entropy_dirbtine(2), entropy_dirbtine(3));
fprintf('entropija sky: %3.2f %3.2f %3.2f \n', stats_sky(1), stats_sky(2), stats_sky(3));
fprintf('entropija grass: %3.2f %3.2f %3.2f \n', stats_grass(1), stats_grass(2), stats_grass(3));
