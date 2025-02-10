%load data
clear
load('EDF5.mat')

task = 2;
PC1a = [];
PC1b = [];
PC2a = [];
PC2b = [];
PC3a = [];
PC3b = [];

if task == 1
    Data1 = FZ_tt_all{1,task}.';
    Data2 = FZ_tt_all{4,task}.';
    Data3 = FZ_tt_all{4,task}.';
elseif task == 2
    Data1 = FZ_tt_all{1,task}.';
    Data2 = FZ_tt_all{3,task}.';
    Data3 = FZ_tt_all{4,task}.';
elseif task == 3
    Data1 = FZ_tt_all{2,task}.'; % 8kHz - CR
    Data2 = FZ_tt_all{4,task}.'; % 14 kHz - Hit
    Data3 = FZ_tt_all{1,task}.'; % 8kHz - FA
end

Data1 = Data1(9:32,:);
Data2 = Data2(9:32,:);
Data3 = Data3(9:32,:);
Data4 = [Data1;Data2];

[coeff1,score1,latent1,tsquared1,explained1,mu1] = pca(Data4);

for c = 1:size(Data1,2)
    PC1a(:,c) = (Data1(:,c)-mu1(c))* coeff1(c,1);
    PC2a(:,c) = (Data1(:,c)-mu1(c))* coeff1(c,2);
    PC3a(:,c) = (Data1(:,c)-mu1(c))* coeff1(c,3);

    PC1b(:,c) = (Data2(:,c)-mu1(c))* coeff1(c,1);
    PC2b(:,c) = (Data2(:,c)-mu1(c))* coeff1(c,2);
    PC3b(:,c) = (Data2(:,c)-mu1(c))* coeff1(c,3);

    PC1c(:,c) = (Data3(:,c)-mu1(c))* coeff1(c,1);
    PC2c(:,c) = (Data3(:,c)-mu1(c))* coeff1(c,2);
    PC3c(:,c) = (Data3(:,c)-mu1(c))* coeff1(c,3);
end

new_score1 = [sum(PC1a,2),sum(PC2a,2),sum(PC3a,2)];
new_score2 = [sum(PC1b,2),sum(PC2b,2),sum(PC3b,2)];
new_score3 = [sum(PC1c,2),sum(PC2c,2),sum(PC3c,2)];

Estimate_diff1 = new_score1-new_score2;
Estimate_diff2 = new_score3-new_score2;

Estimate_diff1 = Estimate_diff1 - mean(Estimate_diff1(1:8,:));
Estimate_diff2 = Estimate_diff2 - mean(Estimate_diff2(1:8,:));


%% Hit vs CR
%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

time = -0.512:0.064:0.96;
plot(time, Estimate_diff1(:,1),'-','color',[0.929 0.11 0.141],'LineWidth',2.5); hold on
plot(time, Estimate_diff1(:,2),'-','color',[0.945 0.353 0.161],'LineWidth',2.5); hold on
plot(time, Estimate_diff1(:,3),'-','color',[0.984 0.69 0.251],'LineWidth',2.5); hold on
yline(0,'--')
xlim([-0.5 1])
ylim([-11 10])
yticks([-10 0 10])
xlabel('Time from cue onset (s)');
ylabel('\Delta CF inputs (a.u.)');
xline(0,'--','LineWidth',1.0);
% legend({'PC1','PC2','PC3'})
% legend box off
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%% FA vs CR

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[700,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

time = -0.512:0.064:0.96; 
plot(time, Estimate_diff2(:,1),'-','color',[0.925 0 0.549],'LineWidth',2.5); hold on
plot(time, Estimate_diff2(:,2),'-','color',[0.62 0.122 0.388],'LineWidth',2.5); hold on
plot(time, Estimate_diff2(:,3),'-','color',[0.4 0.176 0.569],'LineWidth',2.5); hold on
yline(0,'--')
xlim([-0.5 1])
ylim([-11 10])
yticks([-10 0 10])
xlabel('Time from cue onset (s)');
ylabel('\Delta CF inputs (a.u.)');
xline(0,'--','LineWidth',1.0);
% legend({'PC1','PC2','PC3'})
% legend box off
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off
