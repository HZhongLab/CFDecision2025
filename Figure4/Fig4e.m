%load data
clear
load('Fig4e.mat')

dscore_FOV1 = dscore_FOV(:,1)*2-1;
dscore_FOV2 = (1-dscore_FOV(:,3))*2-1;

% calculate mean difference in CF response
for f = 1:19
    %Generalization
    data1a = FZ_tt_all{1,1}(f,:);
    data1b = FZ_tt_all{2,1}(f,:);
    diff_all(f,1) = abs(mean(data1a(25:32))-mean(data1b(25:32)));

    %Reversal
    data2a = FZ_tt_all{1,3}(f,:);
    data2b = FZ_tt_all{2,3}(f,:);
    diff_all(f,2) = abs(mean(data2a(25:32))-mean(data2b(25:32)));
end

%plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,300,293];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');


scatter(diff_all(:,1),dscore_FOV1,60,'k',"LineWidth",1.5); hold on
scatter(diff_all(:,2),dscore_FOV2,60,'b',"LineWidth",1.5); hold on

scatter(mean(diff_all(:,1)),mean(dscore_FOV1),150,'k','filled',"LineWidth",2); hold on
scatter(mean(diff_all(:,2)),mean(dscore_FOV2),150,'b','filled',"LineWidth",2); hold on

%plot errorbar
x_pos = [mean(diff_all(:,1)),mean(diff_all(:,2))];
y_pos = [mean(dscore_FOV1),mean(dscore_FOV2)];
x_error = std(diff_all)/sqrt(size(diff_all,1));
y_error = [std(dscore_FOV1)/sqrt(size(diff_all,1)),std(dscore_FOV2)/sqrt(size(diff_all,1))];
errorbar(x_pos,y_pos,y_error,y_error,x_error,x_error,'k','CapSize',0)
yline(0,'--')
ylabel('Decoding score')
xlabel('|\Delta Z (8 vs 14 kHz)|')
ylim([-0.9 0.3])
yticks([-0.8 -0.4 0])
xticks([0 0.3 0.6])
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%statistics
[R2,p2] = corrcoef([diff_all(:,1);diff_all(:,2)],[dscore_FOV1;dscore_FOV2]);
%[R3,p3] = corrcoef([diff_all(:,1);diff_all(:,2)],[data1(:,7);data2(:,7)]);

