%Load data
load('Fig4a.mat')
mean_data1 = nanmean(Rev_learn1,1);
mean_data2 = nanmean(100-Rev_learn2,1);

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];
temp = [-2 -1, 1:10 ];

for m = 1:4
    plot(temp,Rev_learn1(m,1:12),'color',color2(2,:),'LineWidth',1);hold on
    plot(temp,100-Rev_learn2(m,1:12),'color',color2(1,:),'LineWidth',1);hold on
end

plot(temp,mean_data1(1:12),'color',color2(2,:),'LineWidth',3);hold on
plot(temp,mean_data2(1:12),'color',color2(1,:),'LineWidth',3);hold on

xlim([-2.5 10.5])
ylim([0 100])
ylabel('Lick response (%)')
xlabel('Training session')
set(gca, 'YTick', [ 0 50 100]) % 10 ticks
set(gca, 'XTick', [ -2 -1 1 5 9]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off