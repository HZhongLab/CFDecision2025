%load data
clear
load('Fig3m.mat');

%Calculate distance
distance_all1 = [];
distance_all2 = [];

for f = 1:31
    row_a = FOV_all(f,2) + 1;
    row_z = FOV_all(f+1,2);
    group_FOV = group(row_a:row_z,:);
    ROI_fit_C_FOV= ROI_fit_C_all(row_a:row_z,:);
    mean_slope= mean(ROI_slope_all(row_a:row_z,:));
    corner1 = 0;
    corner2 = -512*mean_slope;
    corner3 = 512;
    corner4 = 512-512*mean_slope;

    ROI_fit_C_FOV1 = ROI_fit_C_FOV(group_FOV==1);
    ROI_fit_C_FOV2 = ROI_fit_C_FOV(group_FOV==2);

    for c = 1:length(ROI_fit_C_FOV1)
        distance_diff1 = abs(ROI_fit_C_FOV1(c,:)-ROI_fit_C_FOV1);
        distance1 = distance_diff1/sqrt(mean_slope^2+1);
        distance1 = distance1(distance1>0);
        if isempty(distance1) == 1

            corner_diff1 = abs(ROI_fit_C_FOV1(c,:)-corner1);
            corner_diff2 = abs(ROI_fit_C_FOV1(c,:)-corner2);
            corner_diff3 = abs(ROI_fit_C_FOV1(c,:)-corner3);
            corner_diff4 = abs(ROI_fit_C_FOV1(c,:)-corner4);

            distance1 = max([corner_diff1,corner_diff2,corner_diff3,corner_diff4]);
            min_dist1 = distance1/sqrt(mean_slope^2+1);
        else
            min_dist1 = min(distance1);
        end

        distance_diff2 = abs(ROI_fit_C_FOV1(c,:)-ROI_fit_C_FOV2);
        distance2 = distance_diff2/sqrt(mean_slope^2+1);
        distance2 = distance2(distance2>0);
        min_dist2 = min(distance2);

        distance_all1 = [distance_all1;[min_dist1,min_dist2]];
    end

    for c = 1:length(ROI_fit_C_FOV2)
        distance_diff1 = abs(ROI_fit_C_FOV2(c,:)-ROI_fit_C_FOV1);
        distance1 = distance_diff1/sqrt(mean_slope^2+1);
        distance1 = distance1(distance1>0);
        min_dist1 = min(distance1);


        distance_diff2 = abs(ROI_fit_C_FOV2(c,:)-ROI_fit_C_FOV2);
        distance2 = distance_diff2/sqrt(mean_slope^2+1);
        distance2 = distance2(distance2>0);
        if isempty(distance2) == 1

            corner_diff1 = abs(ROI_fit_C_FOV2(c,:)-corner1);
            corner_diff2 = abs(ROI_fit_C_FOV2(c,:)-corner2);
            corner_diff3 = abs(ROI_fit_C_FOV2(c,:)-corner3);
            corner_diff4 = abs(ROI_fit_C_FOV2(c,:)-corner4);

            distance2 = max([corner_diff1,corner_diff2,corner_diff3,corner_diff4]);
            min_dist2 = distance2/sqrt(mean_slope^2+1);
        else
            min_dist2 = min(distance2);
        end

        distance_all2 = [distance_all2;[min_dist1,min_dist2]];
    end
end

distance_data = [distance_all1;distance_all2(:, [2, 1])];

%Calculate mean + sem
mean_data = mean(distance_data);
sem_data = std(distance_data)/sqrt(length(distance_data));

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,175,250];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot data
hold on

plot(1:2, distance_data,'-','Color',[0.8 0.8 0.8], 'LineWidth', 1.5, 'MarkerSize', 15);hold on
errorbar(1:2, mean_data, sem_data, 'o-','Color','k',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none');hold on

alpha(0.2)
xlim([0.5, 2+0.5])
ylim([0 500])
xticks(1:2)
yticks([0,250,500])
xticklabels({'same', 'diff.'})
ylabel('Nearest neighbor (pixels)')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%Staitiscs (2-sample t test)
[h1,p1] = ttest(distance_data(:,1),distance_data(:,2));
