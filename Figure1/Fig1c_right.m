%% Learning curve plot (Discrimination)
clear
load("Fig1c.mat");

% Create empty variable
mean_data1 = [];
mean_data2 = [];
sem_data1 = [];
sem_data2 = [];

%   Plot
%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,200,250,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

mean_data1 = nanmean(Dis_learn1,1);
mean_data2 = nanmean(Dis_learn2,1);

for m = 1:6
    plot(1:7,Dis_learn1(m,:),'color',color2(1,:),'LineWidth',1);hold on
    plot(1:7,Dis_learn2(m,:),'color',color2(2,:),'LineWidth',1);hold on
end

plot(1:7,mean_data1,'color',color2(1,:),'LineWidth',3);hold on
plot(1:7,mean_data2,'color',color2(2,:),'LineWidth',3);hold on

xlim([0.5 7.5])
ylim([0 100])
ylabel('Lick response (%)')
xlabel('Training session')
set(gca, 'YTick', [ 0 50 100]) % 10 ticks
set(gca, 'XTick', [ 1 3 5 7 ]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
