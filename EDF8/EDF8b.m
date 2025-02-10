%Assemble data matrix
clear
load('EDF8b.mat')
dp_FOV1 = behavior_FOV_all{1, 2}(:,3);  
dp_FOV2 = behavior_FOV_all{1, 3}(:,3)*-1;  

dp_mean1 = mean(dp_FOV1);
dp_mean2 = mean(dp_FOV2);

dp_sem1 = std(dp_FOV1)/sqrt(length(dp_FOV1));
dp_sem2 = std(dp_FOV2)/sqrt(length(dp_FOV2));

dp_mean = [dp_mean1,dp_mean2];
dp_sem = [dp_sem1,dp_sem2];

%plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,200,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
color = [0.5 0.5 0.5 ; 0.9 0.9 0];

errorbar(1:2,dp_mean,dp_sem,'k.','LineWidth',2);hold on;
bar(1,dp_mean(1),'EdgeColor','k' ,'FaceColor',[1 0 0],'EdgeColor','none');hold on;
bar(2,dp_mean(2),'EdgeColor','k' ,'FaceColor',[ 0 0 1],'EdgeColor','none');hold on;
ylim([-4 4])
xlim([0.3 2.7])
ylabel('Discrim. index (d'')')
set(gca, 'YTick', [-4 0 4])
set(gca, 'XTick', [1 2])
set(gca, 'XTickLabel', {'Dis.','Rev.'})
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

% %Staitiscs (2-sample t test)
[h1,p1] = ttest2(dp_FOV1,dp_FOV2);
disp('p(2 sample t-test) = ')
disp(p1)

