clear
load('EDF8f.mat')
mean_data = [];
sem_data = [];

data1 = -d_score_gain/50;

%Calculate mean + sem
mean_data1 = mean(data1);
sem_data1 = std(data1)/sqrt(length(data1));

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
errorbar(-0.375:0.25:0.875, mean_data1, sem_data1, 'o-','Color','b',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on

yline(0,'--','LineWidth',2)
xline(0,'--','LineWidth',2)
alpha(0.2)
ylim([-0.12 0.06])
yticks([-0.10 -0.05 0 0.05])
xticks(-0.5:0.5:1)
ylabel('Gain in decoding score')
xlabel('Time frome cue onset (s)')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

