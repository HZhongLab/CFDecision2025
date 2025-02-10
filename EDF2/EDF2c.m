%Assemble data matrix
clear
load('EDF2abc.mat')
mnames = fieldnames(opto_all);
lick1 = [];
lick1s = [];
lick2 = [];
lick2s = [];

for m =  1:length(mnames)
    snames = fieldnames(opto_all.(mnames{m}));
    lick1(m,:) =mean(opto_all.(mnames{m}).(snames{3}).lick.Go1_lick_rate); 
    lick1s(m,:) =mean(opto_all.(mnames{m}).(snames{3}).lick.Go1s_lick_rate);
    lick2(m,:) =mean(opto_all.(mnames{m}).(snames{3}).lick.NG1_lick_rate);
    lick2s(m,:) =mean(opto_all.(mnames{m}).(snames{3}).lick.NG1s_lick_rate); 
end


%Create empty figure and plot data
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,275,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;0.4 0.4 1 ;1 0.7529 0;0.9 0.9 0];

mean_data1 = mean(lick1,1);
sem_data1 = std(lick1,1)/sqrt(size(lick1,1));

mean_data2 = mean(lick1s,1);
sem_data2 = std(lick1s,1)/sqrt(size(lick1s,1));

mean_data3 = mean(lick2,1);
sem_data3 = std(lick2,1)/sqrt(size(lick2,1));

mean_data4 = mean(lick2s,1);
sem_data4 = std(lick2s,1)/sqrt(size(lick2s,1)); 

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));
yrange3=horzcat(mean_data3+sem_data3,fliplr(mean_data3-sem_data3));
yrange4=horzcat(mean_data4+sem_data4,fliplr(mean_data4-sem_data4));

plot(time_range(1:end),mean_data1,'-','color',color2(1,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data2,'--','color',color2(2,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data3,'-','color',color2(3,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data4,'--','color',color2(4,:),'LineWidth',3);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange3,color2(3,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange4,color2(4,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);


xlim([0 1.5])
ylim([0 10])

ylabel('Lick rate (Hz)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 5 10])
set(gca, 'XTick', [ -0.5 0 0.5 1.0 1.5])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
