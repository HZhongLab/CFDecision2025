%load data
clear
load('EDF4.mat')

% Assemble data
Coordinates = location; % Replace with your actual 31x2 matrix
for L = 1:31
    distance(L,1) = sqrt(Coordinates(L,1)^2 + Coordinates(L,2)^2);
end

dscore_FOV = dscore_FOV*2-1;

%Plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

scatter(distance , dscore_FOV(:,1),100,'k','filled'); hold on
scatter(distance , dscore_FOV(:,2),100,'r','filled'); hold on
alpha(0.8)

yline(0,'--')
ylabel('Decoding score')
xlabel('Relative distance (µm)');
ylim([-0.4 1])
set(gca, 'YTick', [0 0.5 1])% 10 ticks
set(gca, 'XTick', [0 1000 2000])% 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

