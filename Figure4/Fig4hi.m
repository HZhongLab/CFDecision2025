%load data
clear
load('Fig4hi.mat')
[~,idx]= sort(diff_all2,1,'ascend');

% Apply moving average
windowSize = 20; % Set the window size for averaging
diff2_smoothed = movmean(diff_all2(idx), windowSize);
diff3_smoothed = movmean(diff_all3(idx), windowSize);
diff1_smoothed = movmean(diff_all1(idx), windowSize);
x = 1:247;

% Plot the original and smoothed data
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,235,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

plot(x, diff2_smoothed, 'r', x, diff3_smoothed,'b',x, diff1_smoothed, 'k', 'LineWidth', 3);
yline(0,'--', 'LineWidth', 1.5);
xlim([0.5 247.5])
ylim([-1 1])
ylabel('\Delta Z (8 vs 14 kHz)')
xlabel('Matched ROI')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% Fig4i (correlation - scatter plot)

scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,265,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

scatter(diff_all2, diff_all3,'k'); hold on
lsline;
ylabel('\Delta Z (Reversal)')
xlabel('\Delta Z (Discrimination)')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
ylim([-1.15 1])

%Statistics
[rho,pval] = corr(diff_all2, diff_all3);
