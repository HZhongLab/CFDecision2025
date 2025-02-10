%load data
clear
load('Fig2i.mat')

dscore_FOV = dscore_FOV*2-1;

% calculate mean difference in CF response
for f = 1:31
    %Generalization
    data1a = FZ_tt_all{1,1}(f,:);
    data1b = FZ_tt_all{2,1}(f,:);
    diff_all(f,1) = abs(mean(data1a(25:32))-mean(data1b(25:32)));

    % %Discrimination
    data2a = FZ_tt_all{1,2}(f,:);
    data2b = FZ_tt_all{2,2}(f,:);
    diff_all(f,2) = abs(mean(data2a(25:32))-mean(data2b(25:32)));
end

%plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,300,293];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');


scatter(diff_all(:,1),dscore_FOV(:,1),60,'k',"LineWidth",1.5); hold on
scatter(diff_all(:,2),dscore_FOV(:,2),60,'r',"LineWidth",1.5); hold on

scatter(mean(diff_all(:,1)),mean(dscore_FOV(:,1)),150,'k','filled',"LineWidth",2); hold on
scatter(mean(diff_all(:,2)),mean(dscore_FOV(:,2)),150,'r','filled',"LineWidth",2); hold on

%plot errorbar
x_pos = [mean(diff_all(:,1)),mean(diff_all(:,2))];
y_pos = [mean(dscore_FOV(:,1)),mean(dscore_FOV(:,2))];
x_error = std(diff_all)/sqrt(size(diff_all,1));
y_error = [std(dscore_FOV(:,1))/sqrt(size(diff_all,1)),std(dscore_FOV(:,2))/sqrt(size(diff_all,1))];
errorbar(x_pos,y_pos,y_error,y_error,x_error,x_error,'k','CapSize',0)

yline(0,'--','LineWidth',1)
ylabel('Decoding score')
xlabel('|\Delta Z (8 vs 14 kHz)|')
ylim([-0.4 0.72])
yticks([-0.3 0 0.3 0.6])
xticks([0 0.3 0.6])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%statistics
[R2,p2] = corrcoef([diff_all(:,1);diff_all(:,2)],[dscore_FOV(:,1);dscore_FOV(:,2)]);

