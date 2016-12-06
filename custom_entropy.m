% http://stackoverflow.com/a/22954154/1883645
% https://en.wikipedia.org/wiki/Entropy_%28information_theory%29#Definition

%Entropy is a statistical measure of randomness that 
%can be used to characterize the texture of the input image. 
function [ entropySum ] = custom_entropy( GLCM )

p = bsxfun(@rdivide,GLCM,sum(sum(GLCM,1),2)); % normalize each GLCM to probs

numGLCMs = size(p,3);
entropyVals = zeros(1,numGLCMs);
for ii=1:numGLCMs,
    pi = p(:,:,ii);
    entropyVals(ii) = -sum(pi(pi>0).*log(pi(pi>0)));
end

entropySum = sum(entropyVals);

