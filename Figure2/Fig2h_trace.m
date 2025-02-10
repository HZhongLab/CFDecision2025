%load data 
clear
load('Fig2h.mat')
FR = 15.625;
data_all1 = [];
data_all2 = [];

%Generalization 
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[205,300,250,150];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color1 = [0.8 0.8 1  ; 1 0.9 0.7];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/FR:4.992;

data1 = FZ_tt_FOV_task1{28, 1}   ;
data2 = FZ_tt_FOV_task1{28, 2}   ;
data1 = data1 - mean(data1(:,9:16),2);
data2 = data2 - mean(data2(:,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));
mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',3);hold on
fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
ylim([-0.4 1.7])
xlim([-0.5 1.0])
ylabel('z-score')
xlabel('Time from cue onset (s)')
set(gca, 'XTick', [ -0.5 0 0.5 1.0 ]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%Discrimination
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[480,300,250,150];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color1 = [0.8 0.8 1  ; 1 0.9 0.7];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/FR:4.992;

data1 = FZ_tt_FOV_task2{28, 1}   ;
data2 = FZ_tt_FOV_task2{28, 2}   ;
data1 = data1 - mean(data1(:,9:16),2);
data2 = data2 - mean(data2(:,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));
mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',3);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',3);hold on
fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
ylim([-0.4 1.7])
xlim([-0.5 1.0])
ylabel('z-score')
xlabel('Time from cue onset (s)')
set(gca, 'XTick', [ -0.5 0 0.5 1.0 ]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off