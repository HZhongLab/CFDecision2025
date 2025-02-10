%% Heatmap for sorting by activity at 0-1 s
clear
load('Fig1jkl.mat');

task = 2;
for c = 1:length(FZ_tt_all{1,task })
    baseline1 = 0;
    %baseline1 = mean(FZ_tt_all{1,task }(c,9:16));
    data1b = (FZ_tt_all{1,task }(c,:)-baseline1);
    data_all1b(c,:) = data1b;
end

for c = 1:length(FZ_tt_all{2,task })
    baseline2 = 0;
    %baseline2 = mean(FZ_tt_all{2,task }(c,9:16));
    data2b = (FZ_tt_all{2,task }(c,:)-baseline2);
    data_all2b(c,:) = data2b;
end

Data1 = data_all1b;
Data2 = data_all2b;
[~,idx]= sort(mean(Data1(:,17:24),2),1,'descend');

% plot1 (8 kHz)
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[1000,500,210,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
colormap(hot);

imagesc(Data1(idx,:));
xlim([9 40])
xline(17,'w--','LineWidth',2.5);
cb = colorbar;
caxis([-0.2 1.8]) ;
ylabel('Cell')
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

% plot2 (14 kHz)
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[1250,500,210,300];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');
colormap(hot);

imagesc(Data2(idx,:));
xlim([9 40])
xline(17,'w--','LineWidth',2.5);
cb = colorbar;
caxis([-0.2 1.8]);
ylabel('Cell')
set(gca,'linewidth',2.0)
set(gca,'TickLength',[0.015, 0.015])
set(gca, 'TickDir', 'out')
cb.TickDirection='out';
cb.LineWidth = 2.0;
box off

%% Quantify number of positive response ROI
diff1 = mean(Data1(:,17:24),2)-mean(Data1(:,9:16),2);
diff2 = mean(Data2(:,17:24),2)-mean(Data2(:,9:16),2);

positive_rows = (diff1 > 0) & (diff2 > 0);
num_positive_rows = sum(positive_rows);
