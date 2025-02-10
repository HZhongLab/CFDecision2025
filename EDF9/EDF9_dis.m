% load data
clear
load("EDF9_heatmap.mat");
f = 2; %example FOV5
task =2; 
row_a = FOV_all(f, task) + 1;
row_z = FOV_all(f+1, task);
FZ_diff = diff_all2(row_a:row_z);
stat = stat2;

% Define the colormap
numColors = 1000;
cmap = slanCM(103,numColors); 

% Adjust activity levels from to [-1, 1]
minActivity = -1;
maxActivity = 1;
normalized_activity = (FZ_diff-minActivity) / (maxActivity - minActivity);

% Ensure the normalized activities are bounded between 0 and 1 (just in case of outliers)
normalized_activity = max(0, min(1, normalized_activity));

% Convert normalized activity levels to colormap indices
FZ_diff_idx = round(normalized_activity * (numColors - 1)) + 1;

% Create blank image
I = zeros(512);

% Resize and normalize the grayscale image
I = imresize(I, [size(I, 1), size(I, 2)]);
I_double = double(I) / max(I(:));
I_rgb = repmat(I_double, [1, 1, 3]);
I_rgb2 = repmat(I_double, [1, 1, 3]); % Prepare RGB version of I for coloring

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

    colorIdx = FZ_diff_idx(i); % Get the colormap index for this ROI's activity level
    color = cmap(colorIdx, :); % Get the color from the colormap

    % Create a list of coordinates to fill in the gaps
    for j = 1:length(x)
        y_fill = y(j):min(y(j) + scale_factor - 1, size(I, 1));
        x_fill = repmat(x(j), 1, length(y_fill));

        % Draw the ROI with its activity level color
        for k = 1:length(y_fill)
            I_rgb(y_fill(k), x_fill(k), :) = color; % Color this pixel
        end
    end
end

% Display the image
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[470,600,300,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

imshow(I_rgb);hold on
colormap(cmap);
cb = colorbar;
clim([minActivity maxActivity]);
ylabel(cb, '\Delta Z (8 vs 14 kHz)');
