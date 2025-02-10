%Assemble data matrix
clear
load('EDF10def.mat')
mnames = fieldnames(opto_all);
lick = NaN(8,5);
mean_lick = NaN(1,5);
sem_lick = NaN(1,5);

for m =  1:8
    snames = fieldnames(opto_all.(mnames{m}));
    s = 6;

    % Control lick
    C_delay=[opto_all.(mnames{m}).(snames{s}).lick.Go1s_delay_lick_rate; ...
        opto_all.(mnames{m}).(snames{s}).lick.NG1s_delay_lick_rate] ;

    C_resp= [opto_all.(mnames{m}).(snames{s}).lick.Go1s_resp_lick_rate; ...
        opto_all.(mnames{m}).(snames{s}).lick.NG1s_resp_lick_rate ];

    lick(m,3) = nanmean(C_resp);
end

mean_lick(:,3) = nanmean(lick(:,3),1);
sem_lick(:,3) = nanstd(lick(:,3),1)/sqrt(8);


for m =  1:8
    snames = fieldnames(opto_all.(mnames{m}));
    s = 1;

    % NG lick
    NG_delay=opto_all.(mnames{m}).(snames{s}).lick.NG1_delay_lick_rate ;
    NG_resp=opto_all.(mnames{m}).(snames{s}).lick.NG1_resp_lick_rate ;
    lick(m,1) = nanmean(NG_resp);

    % NGs lick
    NG1s_delay=opto_all.(mnames{m}).(snames{s}).lick.NG1s_delay_lick_rate ;
    NG1s_resp=opto_all.(mnames{m}).(snames{s}).lick.NG1s_resp_lick_rate ;
    lick(m,5) = nanmean(NG1s_resp);
end

mean_lick(:,1) = mean(lick(:,1),1);
sem_lick(:,1)  = std(lick(:,1),1)/sqrt(8);

mean_lick(:,5) = mean(lick(:,5),1);
sem_lick(:,5)  = std(lick(:,5),1)/sqrt(8);

%plot
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,250,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color = [1 0.7529 0; 0 0.66 1; 0.9 0.9 0];

errorbar(1:5,mean_lick,sem_lick,'-k','LineWidth',2);hold on;
bar(1,mean_lick(1),'EdgeColor','k' ,'FaceColor',color(1,:),'LineWidth',1.75);hold on;
bar(3,mean_lick(3),'EdgeColor','k' ,'FaceColor',color(2,:),'LineWidth',1.75);hold on;
bar(5,mean_lick(5),'EdgeColor','k' ,'FaceColor',color(3,:),'LineWidth',1.75);hold on;
ylim([0 2])
xlim([0 6])
ylabel('Lick rate (Hz)')
set(gca, 'YTick', [0 1 2]) % 10 ticks
set(gca, 'XTick', [ 1 3 5]) % 10 ticks
set(gca, 'XTickLabel', {'14kHz','LED','14kHz+LED'}) % 10 ticks
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off

%Staitiscs (2-sample t test)
[h1,p1] = ttest2(lick(:,1),lick(:,3));
[h2,p2] = ttest2(lick(:,3),lick(:,5));
[h3,p3] = ttest2(lick(:,1),lick(:,5));
