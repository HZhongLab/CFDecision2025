%load data
clear
load('Fig3abc.mat');
d_score_all1 = d_score_all{1, 1}/0.5-1;
d_score_all2 = d_score_all{1, 2}/0.5-1;

%Generalization
data1a = FZ_tt_all{1,1};
data1b = FZ_tt_all{2,1};

for c = 1:length(data1a)
    diff_all1(c,1) = mean(data1a(c,25:32))-mean(data1b(c,25:32));
end

%Discrimination
data2a = FZ_tt_all{1,2};
data2b = FZ_tt_all{2,2};

for c = 1:length(data2a)
    diff_all2(c,1) = mean(data2a(c,25:32))-mean(data2b(c,25:32));
end

%Find threshold (2sd from mean in generalization)
mean_base = mean(diff_all1);
sd_base = std(diff_all1);
threshold1 = mean_base-2*sd_base;
threshold2 =  mean_base+2*sd_base;

%Categorize cells based on threshold (discrimination)
High_2SD = find(diff_all2>threshold2);
Low_2SD = find(diff_all2<threshold1);
Outside_2SD = find(diff_all2<threshold1 | diff_all2>threshold2);
Within_2SD = find(diff_all2<threshold2 & diff_all2>threshold1);

% plot scatter
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,300,225];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

for c = 1:length(diff_all2) 
    if diff_all2(c) < threshold1
        scatter(diff_all2(c),d_score_all2(c),60,"LineWidth",1.0,'MarkerFaceColor','none','MarkerEdgeColor','g'); hold on
    elseif diff_all2(c) > threshold2

        scatter(diff_all2(c),d_score_all2(c),60,"LineWidth",1.0,'MarkerFaceColor','none','MarkerEdgeColor','g'); hold on
    else
        scatter(diff_all2(c),d_score_all2(c),60,"LineWidth",1.0,'MarkerFaceColor','none','MarkerEdgeColor',[0.3 0.3 0.3]); hold on
    end
end

xline (threshold1,'k--');
xline (threshold2,'k--');
ylabel('Decoding score')
xlabel('\DeltaZ (8 vs 14 kHz, trace period)')
xlim([-1.2 1.2]) %for FZ
yticks([-0.6 0 0.6])
xticks([-1 0 1])
ylim([-0.6 0.68]);
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
box off

%save figure
fname = 'DS_Ca_scatter2';
print(gcf,'-vector','-dsvg',[fname,'.svg']) % svg

%% Inset (pie chart)

%Create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[700,200,200,175];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

counts = [length(Outside_2SD)/length(d_score_all2) ,length(Within_2SD)/length(d_score_all2)];
explode = [0 0]; % only explode the '1' slice
pie(counts, explode); % use pie3 for 3D chart

% Define the colormap
colors = [0 1 0;   
          0.3 0.3 0.3]; 
colormap(colors);

% chi-square test (compare with gen)
n1 = 58; N1 = 1010;
n2 = 246; N2 = 1056;
x1 = [repmat('a',N1,1); repmat('b',N2,1)];
x2 = [repmat(1,n1,1); repmat(2,N1-n1,1); repmat(1,n2,1); repmat(2,N2-n2,1)];
[tbl,chi2stat,pval] = crosstab(x1,x2)
