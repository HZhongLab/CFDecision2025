%load data
clear
load('Fig2d.mat')

%Plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400,800,200,150];
default_font('Arial',14);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

Data1 = d_score_all{1,1}*100;
Data2 = d_score_all{1,2}*100;

histogram(Data2,'Normalization','probability','FaceColor','r','BinWidth',2,'EdgeColor','none');hold on
histogram(Data1,'Normalization','probability','FaceColor','k','BinWidth',2,'EdgeColor','none');hold on

alpha(0.6)
ylabel('Fraction of ROIs')
xlabel('Decoding score')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
grid off
box off
title('')

% statistics (two-sample Kolmogorov-Smirnov test)
[h,p] = kstest2(d_score_all{1,1} ,d_score_all{1,2} );
disp(p)

%saveas(Fig,'dscore_CF','svg')
