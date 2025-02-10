%load data
clear;
load('Fig4d.mat');

%Assemble data
tone_label = {'8 kHz';'14 kHz'};
mean_data = [];
sem_data = [];
max_all = [];

data1 = data1/0.5-1;
data2 = data2/0.5-1;
data3 = (data3/0.5-1)*-1;

%Calculate mean + sem
mean_data1 = mean(data1);
sem_data1 = std(data1)/sqrt(length(data1));

mean_data2 = mean(data2);
sem_data2 = std(data2)/sqrt(length(data2));

mean_data3 = mean(data3);
sem_data3 = std(data3)/sqrt(length(data3));


%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,250,235];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot data
hold on
color = [0.5 0 1  ; 1 0.7529 0 ];
errorbar(1:7, mean_data1, sem_data1, 'o-','Color','k',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on

errorbar(1:7, mean_data2, sem_data2, 'o-','Color','r',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on

errorbar(1:7, mean_data3, sem_data3, 'o-','Color','b',...
    'LineWidth', 2.5, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'none','CapSize',0);hold on

yline(0,'--','LineWidth',2)
alpha(0.2)
xlim([0.5, 7+0.5])
ylim([-0.4  0.4])
xticks(1:7)
yticks([ -0.4 0 0.4])
xticklabels({'single', '10%','25%','50%','75%','90%','all'})
ylabel('Decoding score')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off


