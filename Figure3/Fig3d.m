%load data 
clear
load("Fig3de.mat");

%Assemble data
cspk_all_high = cspk_tt_all(High_2SD,:);
cspk_all_low = cspk_tt_all(Low_2SD,:);

data1a = cspk_all_high{116, 1};
data2a = cspk_all_high{116, 2};
data_a = [data1a ;NaN(1,95);data2a] ;

data1b = cspk_all_low{64, 1};
data2b = cspk_all_low{64, 2};
data_b = [data1b ;NaN(1,95);data2b] ;

%% plot for High 2SD
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[225,500,160,250]; %for manusciprt 
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

colormap(viridis);
imagesc(data_a);

xlim([9 32])
xline(17,'w--','LineWidth',2.5);
yline(size(data1a,1)+1,'w-','LineWidth',4);
yline(size(data1a,1)+1+size(data2a,1)+1,'w-','LineWidth',4);
set(gca, 'XTick', [])
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

%% plot for Low 2SD
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400,500,160,250]; %for manusciprt 
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

colormap(viridis);
imagesc(data_b);

xlim([9 32])
xline(17,'w--','LineWidth',2.5);
yline(size(data1b,1)+1,'w-','LineWidth',4);
yline(size(data1b,1)+1+size(data2b,1)+1,'w-','LineWidth',4);
set(gca, 'XTick', [])
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off
