%Assemble data matrix
clear
load('Fig1f.mat')
mnames = fieldnames(opto_all);
dprime = NaN(length(mnames),8);

for m =  1:length(mnames)
    snames = fieldnames(opto_all.(mnames{m}));
    for s = 1:3
        dprime(m,3*s-2)=opto_all.(mnames{m}).(snames{s}).perf.dprime;
        dprime(m,3*s-1)=opto_all.(mnames{m}).(snames{s}).perf.dprime_S;
    end
end

mean = nanmean(dprime,1);
sem = nanstd(dprime)/sqrt(length(mnames));

%Plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,400,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

for m = 1:length(mnames)
    plot(dprime(m,:),'color',[0.7 0.7 0.7],'LineWidth',2.25); hold on
end

errorbar(1:8,mean,sem,'k.-','LineWidth',3,'CapSize',0,'MarkerSize',30,'MarkerFaceColor','k');hold on;

ylim([0 4])
xlim([0.5 8.5])

ylabel('d''')
xlabel('Light delivery')
set(gca, 'YTick', [0 2 4]) % 10 ticks
set(gca, 'XTick', [ 1 2 4 5 7 8]) % 10 ticks
set(gca, 'XTickLabel', {'-','+','-','+','-','+'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics (paired t-test)
[h1,p1] = ttest(dprime(:,1),dprime(:,2)) ;
[h2,p2] = ttest(dprime(:,4),dprime(:,5)) ;
[h3,p3] = ttest(dprime(:,7),dprime(:,8)) ;
disp(p1)
disp(p2)
disp(p3)
