%load data
clear
load('EDF5.mat')

neural_dist = [];
for task = 1:2
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


    if task ==1
        for i = 1:size(new_score1,1)
            new_score1(i,:) = new_score1(i,:)/norm(new_score1(i,:));
            new_score2(i,:) = new_score2(i,:)/norm(new_score2(i,:));

            neural_dist(i,1) = dot(new_score1(i,:),new_score2(i,:));
        end
    end

    if task ==2
        for i = 1:size(new_score1,1)
            new_score1(i,:) = new_score1(i,:)/norm(new_score1(i,:));
            new_score2(i,:) = new_score2(i,:)/norm(new_score2(i,:));
            new_score3(i,:) = new_score3(i,:)/norm(new_score3(i,:));

            neural_dist(i,2) = dot(new_score1(i,:),new_score2(i,:));
            neural_dist(i,3) = dot(new_score3(i,:),new_score2(i,:));
        end
    end
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
plot(time, neural_dist(:,1),'k-','LineWidth',3); hold on
plot(time, neural_dist(:,2),'-','color',[0.929 0.133 0.141],'LineWidth',3); hold on
plot(time, neural_dist(:,3),'-','color',[0.725 0.325 0.624],'LineWidth',3); hold on
yticks([-1 0 1])
xlim([-0.5 1])
ylim([-1 1])
xlabel('Time from cue onset (s)');
ylabel('Similarity');
xline(0,'--','LineWidth',1.0);
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off


