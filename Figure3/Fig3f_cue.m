%% Classify what type of information an ROI encode

%load data
clear
load('Fig3fg.mat')
load('Fig3fg_1.mat')
load('Fig3fg_2.mat')
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

%% Classify 8 kHz or 14 kHz prefer for cue-encoding ROIs

F_mod1 = FZ_tt_all{1, 2}(Outside_2SD,:);
F_mod3 = FZ_tt_all{3, 2}(Outside_2SD,:);
F_mod4 = FZ_tt_all{4, 2}(Outside_2SD,:);

encode = find(all(cell_profile2 == [1 1 0], 2)); %cue-encoding

Data1 = mean(F_mod1(encode,25:32),2)-mean(F_mod1(encode,9:16),2);
Data2 = mean(F_mod3(encode,25:32),2)- mean(F_mod3(encode,9:16),2);

idx = (Data1-Data2)>0;
encode1 = encode(idx==1); %8 kHz prefer
encode2 = encode(idx==0); %14 kHz prefer


%% plot for 8kHz-prefer cue ROIs
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,500,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

group = encode1;

%Plot
color1 = [0.8 0.8 1  ; 1 0.9 0.7];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

data1 = F_mod1(group,:)-mean(F_mod1(group,9:16),2) ;
data2 = F_mod3(group,:)-mean(F_mod3(group,9:16),2);
data3 = F_mod4(group,:)-mean(F_mod4(group,9:16),2);

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
ylim([-0.62 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4])
set(gca, 'XTick', [-0.5 0 0.5 1.0])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% plot for 14kHz-prefer cue ROIs
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

group = encode2;

%Plot
color1 = [0.8 0.8 1  ; 1 0.9 0.7];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

time_range = -1.024:1/15.625:4.992;

data1 = F_mod1(group,:)-mean(F_mod1(group,9:16),2) ;
data2 = F_mod3(group,:)-mean(F_mod3(group,9:16),2);
data3 = F_mod4(group,:)-mean(F_mod4(group,9:16),2);

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
ylim([-0.62 1.7])
ylabel('\DeltaF (z-score)')
xlabel('Time from cue onset (s)')
set(gca, 'YTick', [ 0 0.7 1.4])
set(gca, 'XTick', [-0.5 0 0.5 1.0])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off