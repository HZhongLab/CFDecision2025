%Assemble data matrix
clear
load('EDF2def.mat')
mnames = fieldnames(opto_all);
FA = NaN(length(mnames),3);
FA2 = NaN(length(mnames),3);

for m =  1:8
    snames = fieldnames(opto_all.(mnames{m}));
    for s = 1 %cue (stim)
        FA(m,1)=opto_all.(mnames{m}).(snames{s}).perf.FA*100;
        FA(m,3)=opto_all.(mnames{m}).(snames{s}).perf.FA_S*100;
    end
end

for m =  6:8
    snames = fieldnames(opto_all.(mnames{m}));

    for s = 5 % cue (off window)
        FA2(m,1)=opto_all.(mnames{m}).(snames{s}).perf.FA*100;
        FA2(m,3)=opto_all.(mnames{m}).(snames{s}).perf.FA_S*100;
    end
end

Diff = [(FA2(:,3)-FA2(:,1)),(FA(:,3)-FA(:,1))];
Diff_mean = [mean(Diff(6:8,1)), NaN, mean(Diff(1:8,2))];
Diff_sem = [std(Diff(6:8,1))/sqrt(3), NaN, std(Diff(1:8,2))/sqrt(8)];

%plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,250,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
color = [0.5 0.5 0.5 ; 0.9 0.9 0];

errorbar(1:3,Diff_mean,Diff_sem,'k','LineWidth',2);hold on;
bar(1,Diff_mean(1),'EdgeColor','k' ,'FaceColor',color(1,:),'LineWidth',1.75);hold on;
bar(3,Diff_mean(3),'EdgeColor','k' ,'FaceColor',color(2,:),'LineWidth',1.75);hold on;
ylim([-10 40])
xlim([0 4])
ylabel('\Delta FA (%)')
set(gca, 'YTick', [0 20 40])
set(gca, 'XTick', [1 3])
set(gca, 'XTickLabel', {'Ctrl','Stim'})
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Staitiscs (2-sample t test)
[h1,p1] = ttest2(Diff(6:8,1),Diff(1:8,2));
disp('p(2 sample t-test) = ')
disp(p1)

