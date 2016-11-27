% http://stackoverflow.com/a/27739166/1883645
% returns entropy for each seperate color channel
% https://en.wikipedia.org/wiki/Entropy_%28information_theory%29#Definition

%Entropy is a statistical measure of randomness that 
%can be used to characterize the texture of the input image. 
function [ E ] = custom_entropy( I )

E = zeros(1,size(I,3));
    for idx = 1 : size(I,3)
        %// Calculate PDF
        chan = I(:,:,idx);
        h = imhist(chan);
        h = h / numel(chan);

        %// Find any entries in the PDF that are 0 to 1 so log calculation works
        h(h == 0) = 1;

        %// Calculate entropy
        E(idx) = -sum(h.*log2(h));
    end
end

