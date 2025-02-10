%% Classify what type of information an ROI encode

%load data
clear
load('EDF7bcd.mat')
load('EDF7bcd_1.mat')
load('EDF7bcd_2.mat')
cell_profile = [];
FZ_tt_all_full = [FZ_tt_all_FULL1;FZ_tt_all_FULL2];
data = FZ_tt_all_full;

for c = 1:size(data,1)
    if FA_rate_cell(c)>0.1 %remove cells with too little FA trials

        Hit = data{c, 1};
        CR = data{c, 3};
        FA = data{c, 4};

        Hit_norm = Hit(:,17:32)-mean(Hit(:,9:16),2);
        CR_norm = CR(:,17:32)-mean(CR(:,9:16),2);
        FA_norm = FA(:,17:32)-mean(FA(:,9:16),2);

        for t = 1:16 % 0-1 s from cue onset
            [~,p1] = ttest2(Hit_norm(:,t), CR_norm(:,t));
            [~,p2] = ttest2(Hit_norm(:,t), FA_norm(:,t));
            [~,p3] = ttest2(CR_norm(:,t), FA_norm(:,t));
            p1_all(t) = p1;
            p2_all(t) = p2;
            p3_all(t) = p3;
        end

        p1_consecutive = any(conv(p1_all<0.05, [1 1], 'valid') == 2);
        p2_consecutive = any(conv(p2_all<0.05, [1 1], 'valid') == 2);
        p3_consecutive = any(conv(p3_all<0.05, [1 1], 'valid') == 2);

        cell_profile = [cell_profile; [p1_consecutive,p2_consecutive,p3_consecutive]];

    else
        cell_profile = [cell_profile; NaN(1,3)];
    end
end

cell_profile2 = cell_profile(Outside_2SD,:);

%% Randomly separate data into half 

F1a = [];
F1b = [];
F3a = [];
F3b = [];
F4a = [];
F4b = [];

rng(9);%set random seed

for c =1:1056
    m1 = size(FZ_tt_all_full{c, 1},1);
    m3 = size(FZ_tt_all_full{c, 3},1);
    m4 = size(FZ_tt_all_full{c, 4},1);

    indices1 = randperm(m1);
    indices3 = randperm(m3);
    indices4 = randperm(m4);

    mid1 = floor(m1/2);
    mid3 = floor(m3/2);
    mid4 = floor(m4/2);

    F1a = [F1a; mean(FZ_tt_all_full{c, 1}(indices1(1:mid1),:) ,1 )];
    F1b = [F1b; mean(FZ_tt_all_full{c, 1}(indices1(mid1+1:end),:) ,1 )];
    F3a = [F3a; mean(FZ_tt_all_full{c, 3}(indices3(1:mid3),:) ,1 )];
    F3b = [F3b; mean(FZ_tt_all_full{c, 3}(indices3(mid3+1:end),:) ,1 )];

    if m4>1
        F4a = [F4a; mean(FZ_tt_all_full{c, 4}(indices4(1:mid4),:) ,1 )];
        F4b = [F4b; mean(FZ_tt_all_full{c, 4}(indices4(mid4:end),:) ,1 )];
    else
        F4a = [F4a; mean(FZ_tt_all_full{c, 4},1 )];
        F4b = [F4b; mean(FZ_tt_all_full{c, 4},1 )];
    end
end

F1a = F1a(Outside_2SD,:);
F1b = F1b(Outside_2SD,:);
F3a = F3a(Outside_2SD,:);
F3b = F3b(Outside_2SD,:);
F4a = F4a(Outside_2SD,:);
F4b = F4b(Outside_2SD,:);

%% Classify Hit or CR prefer for choice ROIs

F_mod1 = FZ_tt_all{1, 2}(Outside_2SD,:);
F_mod3 = FZ_tt_all{3, 2}(Outside_2SD,:);
F_mod4 = FZ_tt_all{4, 2}(Outside_2SD,:);

encode = find(all(cell_profile2 == [1 0 1], 2)); %choice-encoding

Data1 = mean(F_mod1(encode,25:32),2)-mean(F_mod1(encode,9:16),2);
Data2 = mean(F_mod3(encode,25:32),2)- mean(F_mod3(encode,9:16),2);

idx = (Data1-Data2)>0;
encode1 = encode(idx==1); %Hit prefer
encode2 = encode(idx==0); %CR prefer

%% plot for Hit prefer (set A)

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,500,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

%Plot
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

group = encode1;

data1 = F1a(group,:)-mean(F1a(group,9:16),2);
data2 = F3a(group,:)-mean(F3a(group,9:16),2);
data3 = F4a(group,:)-mean(F4a(group,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));

mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

mean_data3 = mean(data3,1);
sem_data3 = std(data3,1)/sqrt(size(data3,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));
yrange3=horzcat(mean_data3+sem_data3,fliplr(mean_data3-sem_data3));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data3,'color',color2(3,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange3,color2(3,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
xlim([-0.5 1])
ylim([-0.7 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4]) % 10 ticks
set(gca, 'XTick', [-0.5 0 0.5 1.0]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% plot for Hit prefer (set B)

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,500,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

%Plot
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

group = encode1;

data1 = F1b(group,:)-mean(F1b(group,9:16),2);
data2 = F3b(group,:)-mean(F3b(group,9:16),2);
data3 = F4b(group,:)-mean(F4b(group,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));

mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

mean_data3 = mean(data3,1);
sem_data3 = std(data3,1)/sqrt(size(data3,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));
yrange3=horzcat(mean_data3+sem_data3,fliplr(mean_data3-sem_data3));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data3,'color',color2(3,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange3,color2(3,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
xlim([-0.5 1])
ylim([-0.7 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4]) % 10 ticks
set(gca, 'XTick', [-0.5 0 0.5 1.0]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% plot for CR prefer (set A)

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

%Plot
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

group = encode2;

data1 = F1a(group,:)-mean(F1a(group,9:16),2);
data2 = F3a(group,:)-mean(F3a(group,9:16),2);
data3 = F4a(group,:)-mean(F4a(group,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));

mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

mean_data3 = mean(data3,1);
sem_data3 = std(data3,1)/sqrt(size(data3,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));
yrange3=horzcat(mean_data3+sem_data3,fliplr(mean_data3-sem_data3));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data3,'color',color2(3,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange3,color2(3,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
xlim([-0.5 1])
ylim([-0.7 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4]) % 10 ticks
set(gca, 'XTick', [-0.5 0 0.5 1.0]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% plot for CR prefer (set B)

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

%Plot
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

group = encode2;

data1 = F1b(group,:)-mean(F1b(group,9:16),2);
data2 = F3b(group,:)-mean(F3b(group,9:16),2);
data3 = F4b(group,:)-mean(F4b(group,9:16),2);

mean_data1 = mean(data1,1);
sem_data1 = std(data1,1)/sqrt(size(data1,1));

mean_data2 = mean(data2,1);
sem_data2 = std(data2,1)/sqrt(size(data2,1));

mean_data3 = mean(data3,1);
sem_data3 = std(data3,1)/sqrt(size(data3,1));

xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));
yrange3=horzcat(mean_data3+sem_data3,fliplr(mean_data3-sem_data3));

plot(time_range(1:end),mean_data1,'color',color2(1,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data2,'color',color2(2,:),'LineWidth',2.1);hold on
plot(time_range(1:end),mean_data3,'color',color2(3,:),'LineWidth',2.1);hold on

fill(xrange,yrange1,color2(1,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange2,color2(2,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
fill(xrange,yrange3,color2(3,:),'FaceAlpha',0.3,'EdgeColor','none');hold on

xline(0,'--','LineWidth',1.0);
xlim([-0.5 1])
ylim([-0.7 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4]) % 10 ticks
set(gca, 'XTick', [-0.5 0 0.5 1.0]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off