%% Rolling Ball Analysis

if ~exist('BG','var')
    BG = median(V,4); % generate background image
end
[x1size x2size csize tsize] = size(V);

VD = zeros(size(V),'uint8'); %preallocate Video with differences
for i = 1:tsize
    VD(:,:,:,i) = V(:,:,:,i) - BG; %find diff between BG and Image
    imshow(VD(:,:,:,i),[])
end

imaqmontage(VD);