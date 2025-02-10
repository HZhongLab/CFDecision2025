%Load data
clear
load('Fig1d.mat')

%Assemble data
dprime_all1 = [behavior_FOV_all{1, 1}(:,3)];
dprime_all2 = [behavior_FOV_all{1, 2}(:,3)];

mean_dp = [mean(dprime_all1),mean(dprime_all2)];
sem_dp = [std(dprime_all1)/sqrt(length(dprime_all1)),std(dprime_all2)/sqrt(length(dprime_all2))];

% Plot the results
close all
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,225,300];
default_font('Arial',24);

Fig = figure('Position',position,...
    'Units','inches','PaperUnits','inches','color','w');

color = [0.9 0.9 0.9 ;0.1 0.1 0.1 ];

errorbar(1:2,mean_dp,sem_dp,'.k','LineWidth',2);hold on;

for g = 1:2
    bar(g,mean_dp(:,g),'BarWidth',0.6,'FaceColor',color(g,:),'EdgeColor','none');hold on;
end

ylim([0 4])
xlim([0.5 2.5])

ylabel('Discrimination index (d'')');
set(gca, 'XTick', [ 1 2 ]) % 10 ticks
set(gca, 'XTickLabel', {'Dis.','Rev.'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics (paired t-test)
[h1,p1] = ttest2(dprime_all1,dprime_all2) ;
disp('two sample t-test: p=');
disp(p1);
