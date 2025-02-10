%Assemble data matrix
clear
load('EDF10def.mat')
mnames = fieldnames(opto_all);
FA = NaN(length(mnames),8);

for m =  1:length(mnames)
    snames = fieldnames(opto_all.(mnames{m}));
    for s = 1:3
        FA(m,3*s-2)=opto_all.(mnames{m}).(snames{s}).perf.FA*100;
        FA(m,3*s-1)=opto_all.(mnames{m}).(snames{s}).perf.FA_S*100;
    end
end

mean = nanmean(FA,1);
sem = nanstd(FA)/sqrt(length(mnames));

% Plot opto stim for different period in trained mice
%
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,100,400,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

errorbar(1:8,mean,sem,'.-','Color',[1 0.7529 0],'LineWidth',3,'CapSize',0,'MarkerSize',30,'MarkerFaceColor',[0.5 0 1]);hold on;

ylim([0 100])
xlim([0.5 8.5])

ylabel('FA (%)')
xlabel('Light delivery')
set(gca, 'YTick', [0 50 100]) % 10 ticks
set(gca, 'XTick', [ 1 2 4 5 7 8]) % 10 ticks
set(gca, 'XTickLabel', {'-','+','-','+','-','+'}) % 10 ticks

set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Statistics (paired t-test)
[h1,p1] = ttest(FA(:,1),FA(:,2)) ;
[h2,p2] = ttest(FA(:,4),FA(:,5)) ;
[h3,p3] = ttest(FA(:,7),FA(:,8)) ;
