%load data
clear
load('EDF3.mat');
mean_data = [];
sem_data = [];

% plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[750,800,300,225];
default_font('Arial',14);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

for tone_type = 1:2
   
    data1 = FZ_tt_all{tone_type,1};
    data2 = FZ_tt_all{tone_type,2};

    mean_data1= mean(data1(:,17:24),2);
    mean_data2= mean(data2(:,17:24),2);


    color1 = [0.8 0.8 1  ; 1 0.9 0.7];
    color2 = [0.5 0 1 ;1 0.7529 0];

    h1= cdfplot(mean_data1 );hold on
    h1.Color = color1(tone_type,:);
    h1.LineWidth = 2;
    h1.LineStyle = '--';

    h2 = cdfplot(mean_data2 );hold on
    h2.Color = color2(tone_type,:);
    h2.LineWidth = 2;
    h2.LineStyle = '-';

    xlim([-1 1.5])
    ylim([0 1])
    set(gca, 'XTick', [-1 0 1 ]) % 10 ticks
    set(gca, 'YTick', [0 0.5 1 ]) % 10 ticks
    ylabel('Cumulative fraction of ROIs')
    xlabel('Mean Ca activity (z-score)')
    set(gca,'linewidth',2)
    set(gca, 'TickDir', 'out')
    grid off
    box off
    title('Cue (0-0.5s)')
    %legend("Generalization","Discrimination","Location","best",'Box','off')

    % statistics (two-sample Kolmogorov-Smirnov test)
    [h,p] = kstest2(mean_data1,mean_data2);
    disp(p)
end
