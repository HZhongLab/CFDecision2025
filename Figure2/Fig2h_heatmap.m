%load data 
clear
load("Fig2h.mat");

%Assemble data
data1a = FZ_tt_FOV_task1{28, 1}(1:30,:);
data2a = FZ_tt_FOV_task1{28, 2}(1:30,:);
data_a = [data1a ;NaN(1,95);data2a] ;

data1b = FZ_tt_FOV_task2{28, 1}(1:30,:);
data2b = FZ_tt_FOV_task2{28, 2}(1:30,:);
data_b = [data1b ;NaN(1,95);data2b] ;

%plot for generalization
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[225,500,250,250]; %for manusciprt 
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

colormap(viridis);
imagesc(data_a);

xlim([9 32])
xline(17,'w--','LineWidth',2.5);
yline(size(data1a,1)+1,'w-','LineWidth',4);
yline(size(data1a,1)+1+size(data2a,1)+1,'w-','LineWidth',4);
cb = colorbar;
clim([-0.25 1.25]) %for manusciprt
set(gca, 'XTick', [])
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

%plot for discrimination 
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,250,250]; %for manusciprt 
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

colormap(viridis);
imagesc(data_b);

xlim([9 32])
xline(17,'w--','LineWidth',2.5);
yline(size(data1b,1)+1,'w-','LineWidth',4);
yline(size(data1b,1)+1+size(data2b,1)+1,'w-','LineWidth',4);
cb = colorbar;
clim([-0.25 1.25]) %for manusciprt
set(gca, 'XTick', [])
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off
