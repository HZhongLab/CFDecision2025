%Load data
clear
load('EDF1ab.mat')
task = 2;
lick1 = lick_trace_all{1,task};
lick2 = lick_trace_all{2,task};

%Create empty figure and plot data
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,275,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

if task == 3
    color2 = [1 0.7529 0; 0.5 0 1 ;];
else
    color2 = [0.5 0 1 ;1 0.7529 0];
end

mean_data1 = mean(lick1,1);
sem_data1 = std(lick1,1)/sqrt(size(lick1,1));

mean_data2 = mean(lick2,1);
sem_data2 = std(lick2,1)/sqrt(size(lick2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'-','color',color2(1,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data2,'-','color',color2(2,:),'LineWidth',3);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.2,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.2,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);

xlim([0 1.5])
ylim([0 10])

ylabel('Lick rate (Hz)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 5 10]) 
set(gca, 'XTick', [ 0 0.5 1.0 1.5]) 
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
