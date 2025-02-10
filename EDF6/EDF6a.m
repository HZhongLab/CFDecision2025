%% 3D Neural trajectory (-0.5-1.0 s) for lick control analysis
clear
load("EDF6abc.mat")
title_ID = {'Generalization','Discrimination','Reversal'};

task = 2;
PC1a = [];
PC1b = [];
PC2a = [];
PC2b = [];
PC3a = [];
PC3b = [];

for c = 1:length(FZ_tt_main{1,task})
    data1 = FZ_tt_main{1,task}(c,:);
    data_all1(c,:) = data1;
end

for c = 1:length(FZ_tt_main{3,task})
    data2 = FZ_tt_main{3,task}(c,:);
    data_all2(c,:) = data2;
end


for c = 1:length(FZ_tt_all{1,task})
    data98 = FZ_tt_all{1,task}(c,:);
    data_all98(c,:) = data98;
end

for c = 1:length(FZ_tt_all{2,task})
    data99 = FZ_tt_all{2,task}(c,:);
    data_all99(c,:) = data99;
end

Data1 = data_all1.';
Data2 = data_all2.';
Data98 = data_all98.';
Data99 = data_all99.';

Data1 = Data1(9:32,:);
Data2 = Data2(9:32,:);
Data98 = Data98(9:32,:);
Data99 = Data99(9:32,:);

Data4 = [Data1;Data2];

[coeff1,score1,latent1,tsquared1,explained1,mu1] = pca(Data4);

for c = 1:size(Data1,2)
    PC1a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,1);
    PC2a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,2);
    PC3a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,3);

    PC1b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,1);
    PC2b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,2);
    PC3b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,3);
end

new_score1 = [sum(PC1a,2),sum(PC2a,2),sum(PC3a,2)];
new_score2 = [sum(PC1b,2),sum(PC2b,2),sum(PC3b,2)];

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400*task,200,300,260];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.4353 0.3059 0.2157 ;0.3010 0.7450 0.9330]; %for lick rate
%color2 = [0.8500 0.3250 0.0980 ;0 0 1]; % for lick onset

plot3(new_score1(1:end,1), new_score1(1:end,2), new_score1(1:end,3),'-','LineWidth',3,'Color',color2(1,:)); hold on
plot3(new_score2(1:end,1), new_score2(1:end,2), new_score2(1:end,3),'-','LineWidth',3,'Color',color2(2,:)); hold on

color3 = [0 0 0; 0.4 0.4 0.4 ;0.8 0.8 0.8 ];

%Cue onset
scatter3(new_score1(8,1), new_score1(8,2), new_score1(8,3),'LineWidth',2.5,'MarkerEdgeColor','k'); hold on
scatter3(new_score2(8,1), new_score2(8,2), new_score2(8,3),'LineWidth',2.5,'MarkerEdgeColor','k'); hold on

scatter3(new_score1(16,1), new_score1(16,2), new_score1(16,3),'LineWidth',2.5,'MarkerEdgeColor',color3(2,:)); hold on
scatter3(new_score2(16,1), new_score2(16,2), new_score2(16,3),'LineWidth',2.5,'MarkerEdgeColor',color3(2,:)); hold on

scatter3(new_score1(24,1), new_score1(24,2), new_score1(24,3),'LineWidth',2.5,'MarkerEdgeColor',color3(3,:)); hold on
scatter3(new_score2(24,1), new_score2(24,2), new_score2(24,3),'LineWidth',2.5,'MarkerEdgeColor',color3(3,:)); hold on

view(230,18);   % rotate the plot by changing the viewing angle
xlim([-14 24])
ylim([-14 10])
zlim([-10 7])

set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
box off
grid on
fname = 'PCA_lick_rate';
print(gcf,'-vector','-dsvg',[fname,'.svg']) % svg

%%
%% Inset -> mean data of high and low lick rate

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,200,225,300];
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
set(gca, 'XTickLabel', {'Lo.','Hi.'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics
[h1,p1] = ttest2(data1,data2) ;
disp('2 samples t-test: p=');
disp(p1);
