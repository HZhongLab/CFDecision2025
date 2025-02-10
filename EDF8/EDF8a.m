%Load data
load('EDF8a.mat')

%Calculate d prime
     for m = 1:4
         for t = 1:14
             data1 = Rev_learn1(m,t);
             data2 = 100-Rev_learn2(m,t);
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

             dprime_rev(m,t) = -1*(norminv(data1/100)-norminv(data2/100));
         end
     end

mean_data1 = nanmean(dprime_rev,1);

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];
temp = [-2 -1, 1:10 ];

for m = 1:4
    plot(temp,dprime_rev(m,1:12),'color',[0.5 0.5 0.5],'LineWidth',1);hold on
end

plot(temp,mean_data1(1:12),'color',[0 0 0],'LineWidth',3);hold on
yline(0,'--')
xlim([-2.5 10.5])
ylim([-4 4])
ylabel('Discrim. Index (d'')')
xlabel('Training session')
set(gca, 'YTick', [ -4 0 4]) % 10 ticks
set(gca, 'XTick', [ -2 -1 1 5 9]) % 10 ticks
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off