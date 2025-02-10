%Load data
clear
load('EDF8e.mat')
mean_data = [];
sem_data = [];

%Calculate mean + sem
dscore_FOV1 = dscore_FOV(:,1)/0.5-1;
dscore_FOV2 = (1-dscore_FOV(:,2))/0.5-1;
dscore_FOV3 = (1-dscore_FOV(:,3))/0.5-1;
dscore_FOV = [dscore_FOV1, dscore_FOV2, dscore_FOV3];
mean_data = mean(dscore_FOV);
sem_data = std(dscore_FOV)/sqrt(length(dscore_FOV));

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,225,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot data
hold on
color = [0.5 0 1  ; 1 0.7529 0 ];

plot(1:3, dscore_FOV,'-','Color',[0.8 0.8 0.8], 'LineWidth', 1.5, 'MarkerSize', 15);hold on
errorbar(1:3, mean_data, sem_data, 'o-','Color','k',...
'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none');hold on

yline(0,'--');
alpha(0.2)
xlim([0.5, 3+0.5])
ylim([-0.8 0.8])
yticks([-0.6 0 0.6])
xticks(1:3)
xticklabels({'dis.', 'rev.','shuffled'})
ylabel('Decoding score')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%Staitiscs (2-sample t test)
[h1,p1] = ttest(dscore_FOV(:,1),dscore_FOV(:,2));
[h2,p2] = ttest(dscore_FOV(:,2),dscore_FOV(:,3));
disp(p1)
disp(p2)

