%Load data
clear
load('EDF1c.mat')

%d prime plot (gen + dis)
for m = 1:6
    for t = 1:5
        data1 = Gen_learn1(m,t);
        data2 = Gen_learn2(m,t);
        if data1 >99
            data1 = 99;
        elseif data1 <1
            data1 = 1;
        end

        if data2 >99
            data2 = 99;
        elseif data2 <1
            data2 = 1;
        end

        dprime_gen(m,t) = norminv(data1/100)-norminv(data2/100);
    end
end

for m = 1:6
    for t = 1:7
        data1 = Dis_learn1(m,t);
        data2 = Dis_learn2(m,t);
        if data1 >99
            data1 = 99;
        elseif data1 <1
            data1 = 1;
        end

        if data2 >99
            data2 = 99;
        elseif data2 <1
            data2 = 1;
        end

        dprime_dis(m,t) = norminv(data1/100)-norminv(data2/100);
    end
end

% plot
mean_data1 = [];
mean_data2 = [];
sem_data1 = [];
sem_data2 = [];

%   Plot
%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,250,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

%color1 = [0.8 0.8 1  ; 1 0.9 0.7];
color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

mean_data1 = nanmean(dprime_gen,1);
mean_data2 = nanmean(dprime_dis,1);

for m = 1:6
    plot(1:5,dprime_gen(m,:),'k-','LineWidth',1);hold on
    plot(1:7,dprime_dis(m,:),'r-','LineWidth',1);hold on
end

% errorbar(mean_data1,sem_data1,'k-','LineWidth',3,'CapSize',0); hold on
% errorbar(mean_data2,sem_data2,'r-','LineWidth',3,'CapSize',0); hold on
plot(1:5,mean_data1,'k-','LineWidth',3);hold on
plot(1:7,mean_data2,'r-','LineWidth',3);hold on

xlim([0.5 7.5])
ylim([-0.2 4])
ylabel('Discrimination index (d'')')
xlabel('Training session')
%set(gca, 'YTick', [ 0 2 4]) % 10 ticks
set(gca, 'XTick', [ 1 3 5 7 ]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
%legend('General.','Discrim.','box','off')
%title(tone_label{t_type})
box off

 




