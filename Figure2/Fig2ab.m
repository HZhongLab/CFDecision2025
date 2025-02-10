%load data
clear
load('Fig2abc.mat')
P_label = {'tone identity';'lick'};

for p_type = 1:2

% plot results
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400*p_type,800,285,225];
default_font('Arial',14);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

h1= cdfplot(abs(coeff_all{p_type,1}));hold on
h1.Color = [0.2 0.2 0.2];
h1.LineWidth = 3;

h2 = cdfplot(abs(coeff_all{p_type,2}));hold on
h2.Color = [0.8 0 0];
h2.LineWidth = 3;

ylabel('Cumulative fraction of ROIs')
xlabel('GLM weight')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
grid off
box off
title(P_label{p_type})
legend("Generalization","Discrimination","Location","best",'Box','off')

% statistics (two-sample Kolmogorov-Smirnov test)
[h,p] = kstest2(abs(coeff_all{p_type, 1}),abs(coeff_all{p_type, 2}));
disp(p)
end
