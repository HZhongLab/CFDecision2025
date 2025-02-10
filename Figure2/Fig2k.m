% load data
clear
load("Fig2jk.mat")

task = 2;
PC1a = [];
PC1b = [];
PC1c = [];
PC2a = [];
PC2b = [];
PC2c = [];
PC3a = [];
PC3b = [];
PC3c = [];

Data1 = FZ_tt_all{1,task}.';
Data2 = FZ_tt_all{3,task}.';
Data3 = FZ_tt_all{4,task}.';

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


%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400*task,200,300,260];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0.7529 0;1 0 1]; % trial outcome

plot3(new_score1(1:end,1), new_score1(1:end,2), new_score1(1:end,3),'-','LineWidth',3,'Color',color2(1,:)); hold on
plot3(new_score2(1:end,1), new_score2(1:end,2), new_score2(1:end,3),'-','LineWidth',3,'Color',color2(3,:)); hold on
plot3(new_score3(1:end,1), new_score3(1:end,2), new_score3(1:end,3),'-','LineWidth',3,'Color',color2(4,:)); hold on


color3 = [0 0 0; 0.4 0.4 0.4 ;0.8 0.8 0.8 ];

%Cue onset
scatter3(new_score1(8,1), new_score1(8,2), new_score1(8,3),'LineWidth',2.5,'MarkerEdgeColor','k'); hold on
scatter3(new_score2(8,1), new_score2(8,2), new_score2(8,3),'LineWidth',2.5,'MarkerEdgeColor','k'); hold on
scatter3(new_score3(8,1), new_score3(8,2), new_score3(8,3),'LineWidth',2.5,'MarkerEdgeColor','k'); hold on

scatter3(new_score1(16,1), new_score1(16,2), new_score1(16,3),'LineWidth',2.5,'MarkerEdgeColor',color3(2,:)); hold on
scatter3(new_score2(16,1), new_score2(16,2), new_score2(16,3),'LineWidth',2.5,'MarkerEdgeColor',color3(2,:)); hold on
scatter3(new_score3(16,1), new_score3(16,2), new_score3(16,3),'LineWidth',2.5,'MarkerEdgeColor',color3(2,:)); hold on

scatter3(new_score1(24,1), new_score1(24,2), new_score1(24,3),'LineWidth',2.5,'MarkerEdgeColor',color3(3,:)); hold on
scatter3(new_score2(24,1), new_score2(24,2), new_score2(24,3),'LineWidth',2.5,'MarkerEdgeColor',color3(3,:)); hold on
scatter3(new_score3(24,1), new_score3(24,2), new_score3(24,3),'LineWidth',2.5,'MarkerEdgeColor',color3(3,:)); hold on

view(230,18); % rotate the plot by changing the viewing angle
xlim([-14 24])
ylim([-14 10])
zlim([-10 7])

set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
xlabel('PC1')
ylabel('PC2')
zlabel('PC3')
box off
grid on
fname = 'PCA_discrim';
print(gcf,'-vector','-dsvg',[fname,'.svg']) % svg


