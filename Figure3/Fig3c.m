%load data
clear
load('Fig3abc.mat');
d_score_all1 = d_score_all{1, 1}/0.5-1;
d_score_all2 = d_score_all{1, 2}/0.5-1;

%Generalization
data1a = FZ_tt_all{1,1};
data1b = FZ_tt_all{2,1};

for c = 1:length(data1a)
    diff_all1(c,1) = mean(data1a(c,25:32))-mean(data1b(c,25:32));
end

%Discrimination
data2a = FZ_tt_all{1,2};
data2b = FZ_tt_all{2,2};

for c = 1:length(data2a)
    diff_all2(c,1) = mean(data2a(c,25:32))-mean(data2b(c,25:32));
end

%Find threshold (2sd from mean in generalization)
mean_base = mean(diff_all1);
sd_base = std(diff_all1);
threshold1 = mean_base-2*sd_base;
threshold2 =  mean_base+2*sd_base;

%Categorize cells based on threshold (discrimination)
High_2SD = find(diff_all2>threshold2);
Low_2SD = find(diff_all2<threshold1);
Outside_2SD = find(diff_all2<threshold1 | diff_all2>threshold2);
Within_2SD = find(diff_all2<threshold2 & diff_all2>threshold1);

%Calculate mean dscore for each group
dscore_within = d_score_all2(Within_2SD);
dscore_outside = d_score_all2(Outside_2SD);

mean_dscore = [mean(dscore_within),mean(dscore_outside)];
sem_dscore1 = std(dscore_within)/sqrt(length(dscore_within));
sem_dscore2 = std(dscore_outside)/sqrt(length(dscore_outside));
sem_dscore = [sem_dscore1,sem_dscore2];

% Plot the results
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,225,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'Units','inches','PaperUnits','inches','color','w');

color = [0.3 0.3 0.3 ;0 1 0 ];

errorbar(1:2,mean_dscore,sem_dscore,'.k','LineWidth',2);hold on;

for g = 1:2
    bar(g,mean_dscore(:,g),'BarWidth',0.6,'FaceColor',color(g,:),'EdgeColor','none');
    hold on;
end

ylim([0 0.3 ])
xlim([0.5 2.5])

ylabel('Decoding score ');
set(gca, 'XTick', [ 1 2 ]) % 10 ticks
set(gca, 'XTickLabel', {'In','Out'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics
[h,p] = ttest2(dscore_within,dscore_outside);
disp(p)