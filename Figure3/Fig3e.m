%Load data
clear
load('Fig3de.mat')

cdata1_all = [];
cdata2_all = [];

for c = 1:1056
    cdata1 = [];
    cdata2 = [];

    data1 = cspk_tt_all{c, 1} ;
    data2 = cspk_tt_all{c, 2} ;

    %calculate cumulative spike num for 0-1 s
    data1 = data1(:,17:32);
    data2 = data2(:,17:32);

    cdata1 = data1;
    cdata2 = data2;

    for i = 1:15
        cdata1(:,i+1) = cdata1(:,i+1)+cdata1(:,i);
        cdata2(:,i+1) = cdata2(:,i+1)+cdata2(:,i);
    end

    cdata1_all = [cdata1_all;mean(cdata1,1)];
    cdata2_all = [cdata2_all;mean(cdata2,1)];
end

%% Plot for High 2SD
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,500,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];
time_range = 0:1/15.625:0.96;

group = High_2SD;
data1 = cdata1_all(group,:);
data2 = cdata2_all(group,:);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));
mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
ylim([0 3])
xlim([0 1])
ylabel('Cumulative CF events')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 1 2 3])
set(gca, 'XTick', [-0.5 0 0.5 1.0])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% Plot for Low 2SD
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];
time_range = 0:1/15.625:0.96;

group = Low_2SD;
data1 = cdata1_all(group,:);
data2 = cdata2_all(group,:);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));
mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
ylim([0 3])
xlim([0 1])
ylabel('Cumulative CF events')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 1 2 3])
set(gca, 'XTick', [-0.5 0 0.5 1.0])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

