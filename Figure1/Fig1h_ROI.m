%Load ROI data (M5-FOV6)
clear
load('Fig1hi.mat');
stat = stat(:,iscell(:,1)==1);
spatial_positions = zeros(1, length(stat));
for i = 1:length(stat)
    x_avg = mean(stat{1, i}.xpix);
    y_avg = mean(stat{1, i}.ypix);
    spatial_positions(i) = y_avg * 4 - x_avg; % scale y by 4 and subtract x
end

[~, sorted_indices] = sort(spatial_positions);
stat = stat(:, sorted_indices);

% Define the colormap
rng(27); %set random seed
numColors = 1000;
cmap = slanCM(162,numColors); % Choose 'jet' or another colormap

% Create empty figure
scr = get(0, 'ScreenSize');
W = scr(3); H = scr(4);
position = [400, 500, W, H/3];
Fig = figure('Position', position, ...
    'PaperUnits', 'points', 'PaperPosition', position, 'color', 'w');

% Create black background
I = zeros(512);

% Resize and normalize the grayscale image
I = imresize(I, [size(I, 1), size(I, 2)]);
I_double = double(I) / max(I(:));
I_rgb = repmat(I_double, [1, 1, 3]);

% Set scale factor
scale_factor = 4;

% Loop over ROIs
for i = 1:length(stat)
    % Get pixel coordinates of the ROI
    x = stat{1, i}.xpix;
    y = stat{1, i}.ypix * scale_factor; % Scale y coordinates

    % Ensure coordinates are within bounds
    x = max(min(x, size(I, 2)), 1);
    y = max(min(y, size(I, 1)), 1);
    color = cmap(randi([1, numColors]), :); % Get the color from the colormap

    % Create a list of coordinates to fill in the gaps
    for j =  1:length(x)
        y_fill = y(j):min(y(j) + scale_factor - 1, size(I, 1));
        x_fill = repmat(x(j), 1, length(y_fill));

        % Draw the ROI with random color
        for k = 1:length(y_fill)
            I_rgb(y_fill(k), x_fill(k), :) = color; % Color this pixel
        end
    end
end

% Display the image
imshow(I_rgb);hold on
