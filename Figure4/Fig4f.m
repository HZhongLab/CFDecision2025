%% Heatmap for sorting by activity at 0-1 s
% clear
load('Fig4f.mat');

Data1 = FZ_tt_all{1, 1}-FZ_tt_all{2, 1};
Data2 = FZ_tt_all{1, 2}-FZ_tt_all{2, 2};
Data3 = FZ_tt_all{1, 3}-FZ_tt_all{2, 3};

[~,idx]= sort(mean(Data2(:,17:32),2),1,'descend');

% plot1 (gen)
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,500,210,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
numColors = 1000;
cmap = slanCM(103,numColors); % Choose colormap
colormap(cmap);

imagesc(Data1(idx,:));
xlim([9 32])
xline(17,'w--','LineWidth',2.5);
cb = colorbar;
clim([-2 2]) ;
ylabel('Cell')
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

% plot2 (dis)
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[550,500,210,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
numColors = 1000;
cmap = slanCM(103,numColors); % Choose colormap
colormap(cmap);

imagesc(Data2(idx,:));
xlim([9 32])
xline(17,'w--','LineWidth',2.5);
cb = colorbar;
clim([-2 2]) ;
ylabel('Cell')
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

% plot3 (rev)
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[800,500,210,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
numColors = 1000;
cmap = slanCM(103,numColors); % Choose colormap
colormap(cmap);

imagesc(Data3(idx,:));
xlim([9 32])
xline(17,'w--','LineWidth',2.5);
cb = colorbar;
clim([-2 2]) ;
ylabel('Cell')
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off