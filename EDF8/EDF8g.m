% load data
clear
load("EDF8ghij.mat")
task = 3;
Data1 = FZ_tt_all{2,task}.';
Data1_shuffled =[];
Data2 = FZ_tt_all{4,task}.';
Data2_shuffled = [];

Data1 = Data1(9:32,:);
Data2 = Data2(9:32,:);
Data3 = [Data1;Data2];

[coeff1,score1,latent1,tsquared1,explained1,mu1] = pca(Data3);

% shuffle time bin for each cell
for c = 1:size(Data1,2)
    cell_data = [];
    cell_data2 = [];
    cell_data =  Data1(:,c);
    cell_data2 =  Data2(:,c);
    perm = randperm(length(cell_data));
    cell_data = cell_data(perm);
    cell_data2 = cell_data2(perm);
    Data1_shuffled(:,c)= cell_data;
    Data2_shuffled(:,c)= cell_data2;
end

Data3_shuffled = [Data1_shuffled;Data2_shuffled];

[coeff2,score2,latent2,tsquared2,explained2,~] = pca(Data3_shuffled);

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400*task,200,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Plot the explained variance for each principal component
color = [0 0 0;1 0 0;0 0 1];

for i = 1:10
    bar(i,explained1(i),'BarWidth',0.6,'FaceColor',color(task,:),'EdgeColor','none');hold on;
end

plot(1:length(explained2), explained2,'--', 'color',[0.5 0.5 0.5 0.5], 'LineWidth', 3,'MarkerEdgeColor',[0.75 0.75 0.75]);hold on

ylim([0 80])
xlim([0.5 10.5])
xlabel('Principal Component');
xticks([1:2:10]);
yticks([0 40 80])
ylabel('Explained Variance (%)');
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

disp(sum(explained1(1:3)))
disp(sum(explained2(1:3)))



