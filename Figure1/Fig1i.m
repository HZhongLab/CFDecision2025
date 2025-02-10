%% Example Ca2+ activity traces (M5-FOV6)

% Load data
load('Fig1hi.mat');
F = F(iscell(:,1)==1,:);
stat = stat(:,iscell(:,1)==1);

% Compute the spatial position for each ROI
spatial_positions = zeros(1, length(stat));
for i = 1:length(stat)
    x_avg = mean(stat{1, i}.xpix);
    y_avg = mean(stat{1, i}.ypix);
    
    spatial_positions(i) = y_avg * 4 - x_avg; % scale y by 4 and subtract x
end

% Get the indices that would sort the ROIs by their spatial positions
[~, sorted_indices] = sort(spatial_positions);

% Sort the 'F' matrix using these indices
F = F(sorted_indices, :);
stat = stat(:, sorted_indices);

%clean up the 'F' matrix 
for c = 1:size(F,1)
    if sum(F(c,:))==0
        F(c,:) = NaN(1,8000);
        stat(c)=[];
    end
end
F(any(isnan(F), 2), :) = [];

% Convert raw fluorescence to normalized signals
for c = 1:size(F,1)
Fsd(c,:)=zscore(F(c,:));
end

% Plot 
Cue_plot =  [7244;7331;7431;7519]-7201; 
high_d = [15;12;4;26;19];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

for c= 1:5
    plot(Fsd(high_d(c),7200:7559)+12*c,'k','LineWidth', 1 ); hold on
end

xline(Cue_plot(1),'--','Color',color2(1,:)); hold on
xline(Cue_plot(2),'--','Color',color2(2,:)); hold on
xline(Cue_plot(3),'--','Color',color2(1,:)); hold on
xline(Cue_plot(4),'--','Color',color2(2,:)); hold on
set(gca,'color','w')
set(gca,'YTickLabel',[]);
set(gca,'XTickLabel',[]);
set(gca,'visible','off')
box off

%add scalebar
scalebar;