%load data
clear
load('Fig3l.mat')
f = 4; %example FOV4
row_a = FOV_all(f, 2) + 1;
row_z = FOV_all(f+1, 2);
group_fov = group(row_a:row_z);

% Create blank image
I = zeros(512);

% Create separate binary images for each group
I_bin1 = zeros(size(I, 1), size(I, 2));
I_bin2 = zeros(size(I, 1), size(I, 2));
I_bin3 = zeros(size(I, 1), size(I, 2));

%Set scale factor
scale_factor = 4;

% Loop over ROIs
for i = 1:length(stat)
    % Get pixel coordinates of the ROI
    x = stat{1,i}.xpix;
    y = stat{1,i}.ypix*scale_factor; % Scale y coordinates

    % Check and adjust x and y if necessary
    x = max(min(x, size(I_bin1,2)), 1);
    y = max(min(y, size(I_bin1,1)), 1);

% Create a list of coordinates to fill in the gaps
    for j = 1:length(x)
        y_fill = y(j):min(y(j)+scale_factor-1, size(I_bin1,1));
        x_fill = repmat(x(j), 1, length(y_fill));

        % Draw the ROI on the image
        if group_fov(i)==1
            I_bin1(sub2ind(size(I_bin1), y_fill, x_fill)) = 1; % Draw on I_bin1
        elseif group_fov(i)==2
            I_bin2(sub2ind(size(I_bin2), y_fill, x_fill)) = 1; % Draw on I_bin2
        else
            I_bin3(sub2ind(size(I_bin3), y_fill, x_fill)) = 1; % Draw on I_bin3
        end
    end
end

% Resize and normalize the grayscale image
I = imresize(I, [size(I, 1), size(I, 2)]);

%Set color
color1 = [0 0.7 0.7]; % choice-encoding
color2 = [0.4 0.2 0]; % cue-encoding
color3 = [0.8 0.8 0.8]; % other type

% Create colored images by using the binary images as masks
I_rgb1 = reshape(color1, [1, 1, 3]);
I_rgb2 = reshape(color2, [1, 1, 3]);
I_rgb3 = reshape(color3, [1, 1, 3]);

% % Convert to double and normalize
I = double(I) / max(I(:));

% Combine the colored images
I_rgb = I_rgb1 .* I_bin1 + I_rgb2 .* I_bin2 + I_rgb3 .* I_bin3 ;

% Display the image
imshow(I_rgb);
