%% Compare gen vs discrim for each tone

%Load data
clear
load("Fig1jkl.mat")
FR = 15.625;
tone_label = {'8 kHz';'14 kHz'};
data_all1 = [];
data_all2 = [];

%   Plot
for t_type = 1:2

    %Create empty figure
    scr=get(0,'ScreenSize');
    W=scr(3); H=scr(4);
    position=[300*t_type,200,275,225];
    default_font('Arial',16);
    Fig = figure('Position',position,...
        'PaperUnits','points','PaperPosition',position,'color','w');
    color1 = [0 0 0  ; 0 0 0];
    color2 = [0.5 0 1 ;1 0.7529 0];

    time_range = -1.024:1/FR:4.992;

    for c = 1:length(FZ_tt_all{t_type,1})
        baseline1 = mean(FZ_tt_all{t_type,1}(c,9:16));
        data1 = FZ_tt_all{t_type,1}(c,:)-baseline1;
        data_all1(c,:) = data1;
    end

    for c = 1:length(FZ_tt_all{t_type,2})
        baseline2 = mean(FZ_tt_all{t_type,2}(c,9:16));
        data2 = FZ_tt_all{t_type,2}(c,:)-baseline2;
        data_all2(c,:) = data2;
    end

    mean_data1 = mean(data_all1,1);
    sem_data1 = std(data_all1,1)/sqrt(size(data_all1,1));
    mean_data2 = mean(data_all2,1);
    sem_data2 = std(data_all2,1)/sqrt(size(data_all2,1));

    xrange=horzcat(time_range(1:end),fliplr(time_range(1:end)));
    yrange1=horzcat(mean_data1+sem_data1,fliplr(mean_data1-sem_data1));
    yrange2=horzcat(mean_data2+sem_data2,fliplr(mean_data2-sem_data2));

    plot(time_range(1:end),mean_data1,'color',color1(t_type,:),'LineWidth',2.1);hold on
    plot(time_range(1:end),mean_data2,'color',color2(t_type,:),'LineWidth',2.1);hold on
    fill(xrange,yrange1,color1(t_type,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
    fill(xrange,yrange2,color2(t_type,:),'FaceAlpha',0.3,'EdgeColor','none');hold on
    yline(0,'--','LineWidth',1.0);
    xline(0,'--','LineWidth',1.0);
    xlim([-0.5 1.5])
    ylim([-0.2 0.8])
    ylabel('Z-score')
    xlabel('Time (s)')
    set(gca, 'YTick', [ 0 0.4 0.8]) % 10 ticks
    set(gca, 'XTick', [ -0.5 0 0.5 1.0 1.5]) % 10 ticks
    set(gca,'linewidth',2)
    set(gca, 'TickDir', 'out')
    legend('General.','Discrim.','box','off')
    box off
end
