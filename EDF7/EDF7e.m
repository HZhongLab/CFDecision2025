%load data
clear
load('EDF7e.mat')
dist = [];
correlation = [];

%select example FOV
FOV = 21; 

for c = FOV_all(FOV,2)+1:FOV_all(FOV+1,2)
dist = [dist;distance_all{c, 1}] ;
correlation = [correlation;correlation_all{c, 1} ];
end

% Scatter plot for all ROI pairs
scr=get(0,'ScreenSize');
    W=scr(3); H=scr(4);
    position=[300,200,260,225];
    default_font('Arial',16);
    Fig = figure('Position',position,...
        'PaperUnits','points','PaperPosition',position,'color','w');

scatter(dist,correlation,'o','MarkerEdgeColor',[0.5 0.5 0.5]); hold on

% Extract coefficients and plot linear fit
p = polyfit(dist, correlation, 1);
a = p(1); % Slope
b = p(2); % Intercept
plot(dist, a*dist + b,'-','LineWidth',2,'Color',[0 0 0]); % Plot linear fit

xlabel('Mediolateral distance ')
ylim([-0.05,0.7])
ylabel('Correlation coefficient')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%statistics
[rho,pval] = corr(dist,correlation);
disp(rho)


