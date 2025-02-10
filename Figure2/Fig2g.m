clear
load('Fig2g.mat')
mean_data = [];
sem_data = [];

data1 = [d_score_gain{1,1}]/50;
data2 = [d_score_gain{1,2}]/50;

%Calculate mean + sem
mean_data1 = mean(data1);
sem_data1 = std(data1)/sqrt(length(data1));

mean_data2 = mean(data2);
sem_data2 = std(data2)/sqrt(length(data2));

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,360,270];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot data
hold on
color = [0.5 0 1  ; 1 0.7529 0 ];
errorbar(-0.375:0.25:0.875, mean_data1, sem_data1, 'o-','Color','k',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on
errorbar(-0.375:0.25:0.875, mean_data2, sem_data2, 'o-','Color','r',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on

yline(0,'--','LineWidth',2)
xline(0,'--','LineWidth',2)
alpha(0.2)
ylim([-0.06 0.1])
yticks([-0.04 0 0.04 0.08])
xticks(-0.5:0.5:1)
ylabel('Gain in decoding score')
xlabel('Time frome cue onset (s)')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

