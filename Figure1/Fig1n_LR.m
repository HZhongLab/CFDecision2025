%load data
clear 
load("Fig1mn_LR.mat")
FR = 15.625;
tone_label = {'8 kHz';'14 kHz'};
data_all1 = [];
data_all2 = [];

task = 2; 

% Normalize data to baseline

%Early lick onset or Low lick rate
for c = 1:length(FZ_tt_all{1,task})
    baseline1 = mean(FZ_tt_all{1,task}(c,9:16));
    data1 = FZ_tt_all{1,task}(c,:)-baseline1;
    data_all1(c,:) = data1;
end

%Late lick onset or High lick rate
for c = 1:length(FZ_tt_all{2,task})
    baseline2 = mean(FZ_tt_all{2,task}(c,9:16));
    data2 = FZ_tt_all{2,task}(c,:)-baseline2;
    data_all2(c,:) = data2;
end

%Create empty figure and plot data
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,600,275,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.4353 0.3059 0.2157 ;0.3010 0.7450 0.9330]; %for lick rate

time_range = -1.024:1/FR:4.992;

mean_data1 = mean(data_all1,1);
sem_data1 = std(data_all1,1)/sqrt(size(data_all1,1));

mean_data2 = mean(data_all2,1);
sem_data2 = std(data_all2,1)/sqrt(size(data_all2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
yline(0,'--','LineWidth',1.0);

xlim([-0.5 1.5])
ylim([-0.2 0.8])

ylabel('\Delta F (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.4 0.8]) 
set(gca, 'XTick', [ -0.5 0 0.5 1.0 1.5]) 
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% Inset -> mean data of high and low lick rate

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,600,225,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'Units','inches','PaperUnits','inches','color','w');

color2 = [0.4353 0.3059 0.2157 ;0.3010 0.7450 0.9330]; %for lick rate

task = 2;
data1 = LR_all{1,task};
data2 = LR_all{2,task};

%Calculate mean + sem
mean_dp(:,1) = mean(data1);
sem_dp(:,1) = std(data1)/sqrt(length(data1));

mean_dp(:,2) = mean(data2);
sem_dp(:,2) = std(data2)/sqrt(length(data2));


errorbar(1:2,mean_dp,sem_dp,'.k','LineWidth',2);hold on;

for g = 1:2
    bar(g,mean_dp(:,g),'BarWidth',0.6,'FaceColor',color2(g,:),'EdgeColor','none');hold on;
end

ylim([0 8])
xlim([0.5 2.5])

ylabel('Lick rate (Hz)');
set(gca, 'YTick', [0 8]) % 10 ticks
set(gca, 'XTick', [ 1 2 ]) % 10 ticks
set(gca, 'XTickLabel', {'low','high'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics
[h1,p1] = ttest2(data1,data2) ;
disp('2 samples t-test: p=');
disp(p1);
