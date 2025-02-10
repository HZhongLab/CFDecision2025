%Load data
clear
load('Fig3k.mat');

%Calculate distance
diff_ind = zeros(1056,1);
diff_ind(diff_all2>0)=1;
diff_ind(diff_all2<0)=2;
distance_all = [];

for f = 1:31
    row_a = FOV_all(f,2) + 1;
    row_z = FOV_all(f+1,2);
    Diff_FOV = diff_ind(row_a:row_z);
    ROI_fit_C_FOV= ROI_fit_C_all(row_a:row_z,:);
    mean_slope= mean(ROI_slope_all(row_a:row_z,:));

    for c = 1:length(ROI_fit_C_FOV)

        distance_diff = abs(ROI_fit_C_FOV(c,:)-ROI_fit_C_FOV);
        distance = distance_diff/sqrt(mean_slope^2+1);

        Diff_FOV_mod = Diff_FOV(distance>0);
        distance = distance(distance>0);
        min_dist1 = min(distance(Diff_FOV_mod==1));
        min_dist2 = min(distance(Diff_FOV_mod==2));
        if ~isempty(min_dist1) & ~isempty(min_dist2)
            distance_all = [distance_all;[min_dist1,min_dist2]];
        else
            distance_all = [distance_all;[NaN,NaN]];
        end
    end
end

distance_all1 = distance_all(diff_all2>0&group==1,:);
distance_all2 = distance_all(diff_all2<0&group==1,:);

distance_data = [distance_all1;distance_all2(:, [2, 1])];
distance_data(any(isnan(distance_data),2),:) = []; %Remove NaN

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
ylim([0 400])
xticks(1:2)
yticks([0,200,400])
xticklabels({'same', 'diff.'})
ylabel('Nearest neighbor (pixels)')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%Staitiscs (2-sample t test)
[h1,p1] = ttest(distance_data(:,1),distance_data(:,2));
