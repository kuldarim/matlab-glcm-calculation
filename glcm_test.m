% Finds objects (coins) in an image and tells which coins are "next" to
% each other.
clc;    % Clear the command window.
close all;  % Close all figures (except those of imtool.)
clear all;  % Erase all existing variables.
workspace;  % Make sure the workspace panel is showing.
fontSize = 18;

% Check that user has the Image Processing Toolbox installed.
hasIPT = license('test', 'image_toolbox');
if ~hasIPT
	% User does not have the toolbox installed.
	message = sprintf('Sorry, but you do not seem to have the Image Processing Toolbox.\nDo you want to try to continue anyway?');
	reply = questdlg(message, 'Toolbox missing', 'Yes', 'No', 'Yes');
	if strcmpi(reply, 'No')
		% User said No, so exit.
		return;
	end
end

% Read in a standard MATLAB gray scale demo image.
folder = fileparts(which('cameraman.tif')); % Determine where demo folder is (works with all versions).
button = menu('Use which demo image?', 'CameraMan', 'Moon', 'Eight', 'Coins', 'Pout');
if button == 1
	baseFileName = 'cameraman.tif';
elseif button == 2
	baseFileName = 'moon.tif';
elseif button == 3
	baseFileName = 'eight.tif';
elseif button == 4
	baseFileName = 'coins.png';
else
	baseFileName = 'pout.tif';
end

% Get the full filename, with path prepended.
fullFileName = fullfile(folder, baseFileName);
% Check if file exists.
if ~exist(fullFileName, 'file')
	% File doesn't exist -- didn't find it there.  Check the search path for it.
	fullFileNameOnSearchPath = baseFileName; % No path this time.
	if ~exist(fullFileNameOnSearchPath, 'file')
		% Still didn't find it.  Alert user.
		errorMessage = sprintf('Error: %s does not exist in the search path folders.', fullFileName);
		uiwait(warndlg(errorMessage));
		return;
	end
end
grayImage = imread(fullFileName);
% Get the dimensions of the image.  
% numberOfColorBands should be = 1.
[rows, columns, numberOfColorBands] = size(grayImage);
if numberOfColorBands > 1
	% It's not really gray scale like we expected - it's color.
	% Convert it to gray scale by taking only the green channel.
	grayImage = grayImage(:, :, 2); % Take green channel.
end
% Display the original gray scale image.
subplot(2, 2, 1);
imshow(grayImage, []);
axis on;
title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
colorbar

% Let's compute and display the histogram.
[pixelCount, grayLevels] = imhist(grayImage);
subplot(2, 2, 3); 
bar(grayLevels, pixelCount);
grid on;
title('Histogram of original image', 'FontSize', fontSize);
xlim([0 grayLevels(end)]); % Scale x axis manually.

% Ask user for a number of gray level ranges to use.
defaultValue = 256;
titleBar = 'Enter a value';
userPrompt = 'Enter the number of gray level ranges (2 to 256)';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
% Round to nearest integer in case they entered a floating point number.
integerValue = round(str2double(cell2mat(caUserInput)));
% Check for a valid integer.
if isnan(integerValue)
    % They didn't enter a number.  
    % They clicked Cancel, or entered a character, symbols, or something else not allowed.
    integerValue = defaultValue;
    message = sprintf('I said it had to be an integer.\nI will use %d and continue.', integerValue);
    uiwait(warndlg(message));
end
numGLRanges = integerValue; % Rename it for readability.

% Ask user for the distance to use.
defaultValue = 1;
titleBar = 'Enter a value';
userPrompt = 'Enter the distance away to look (typically 1)';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
if isempty(caUserInput),return,end; % Bail out if they clicked Cancel.
% Round to nearest integer in case they entered a floating point number.
D = round(str2double(cell2mat(caUserInput)));
% Check for a valid integer.
if isnan(D)
    % They didn't enter a number.  
    % They clicked Cancel, or entered a character, symbols, or something else not allowed.
    D = defaultValue;
    message = sprintf('I said it had to be an integer.\nI will use %d and continue.', D);
    uiwait(warndlg(message));
end

% Now get the GLCM with graycomatrix().
kernel = [0, D; -D, D; -D, 0; -D, -D];
glcm = graycomatrix(grayImage, 'NumLevels', numGLRanges,...
	'GrayLimits', [],'offset',kernel);
numberOfDirections = size(glcm, 3);
for k = 1 : numberOfDirections
    glcm(:,:,k) % Display in the command window.
end
% Combine all directions into one.
% Sum along the third dimension.
glcm = sum(glcm, 3);
% Display the 2D glcm as a matrix.
subplot(1, 2, 2);
rgbImage = ind2rgb(glcm, hot(numGLRanges));
imshow(rgbImage);
% imshow(glcm, []);
axis on;
title('Image of the GLCM', 'FontSize', fontSize);

