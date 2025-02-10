%load data
clear
load('EDF6de.mat')

for task = 2
    PC1a = [];
    PC1b = [];
    PC2a = [];
    PC2b = [];
    PC3a = [];
    PC3b = [];
    data_all1 = [];
    data_all3 = [];
    data_all4 = [];

    Data1 = FZ_tt_main{1,task}.';
    Data2 = FZ_tt_main{3,task}.';
    Data98 = FZ_tt_all{1,task}.';
    Data99 = FZ_tt_all{2,task}.';

    Data1 = Data1(9:32,:);
    Data2 = Data2(9:32,:);
    Data98 = Data98(9:32,:);
    Data99 = Data99(9:32,:);

    Data4 = [Data1;Data2];

    [coeff1,score1,latent1,tsquared1,explained1,mu1] = pca(Data4);

    for c = 1:size(Data1,2)
        PC1a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,1);
        PC2a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,2);
        PC3a(:,c) = (Data98(:,c)-mu1(c))* coeff1(c,3);

        PC1b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,1);
        PC2b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,2);
        PC3b(:,c) = (Data99(:,c)-mu1(c))* coeff1(c,3);

    end
    new_score1 = [sum(PC1a,2),sum(PC2a,2),sum(PC3a,2)];
    new_score2 = [sum(PC1b,2),sum(PC2b,2),sum(PC3b,2)];

    Estimate_diff1 = new_score1-new_score2;
    Estimate_diff1 = Estimate_diff1 - mean(Estimate_diff1(1:8,:));

end

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400*task,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot the distance as a function of time
time = -0.512:0.064:0.96;
plot(time, Estimate_diff1(:,1),'-','color',[0 0.408 0.22],'LineWidth',2.5); hold on
plot(time, Estimate_diff1(:,2),'-','color',[0.224 0.71 0.29],'LineWidth',2.5); hold on
plot(time, Estimate_diff1(:,3),'-','color',[0.553 0.776 0.247],'LineWidth',2.5); hold on
xlim([-0.5 1])
ylim([-11 10])
yticks([-10 0 10])
xlabel('Time from cue onset (s)');
ylabel('\Delta CF inputs (a.u.)');
xline(0,'--','LineWidth',1.0);
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
