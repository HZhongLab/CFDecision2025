
%load data
load('Fig2abc.mat')

%create empty figure
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,200,290];
default_font('Arial',16);

Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

% Assemble data
data = {};
data{1,1} = abs(coeff_all{1,1})-abs(coeff_all{2,1});
data{1,2} = abs(coeff_all{1,2})-abs(coeff_all{2,2});

% Calculate mean and SEM
mean_data = cellfun(@mean, data);
sem_data = cellfun(@(x) std(x)./sqrt(numel(x)), data);

% Set offset for data points
offset = 0.2;

% Plot data
hold on
yline(0,'--')

for i = 1:numel(data)
    x = i + offset * linspace(-1,1,numel(data{i}));
    plot(x, data{i}, 'ok', 'MarkerSize', 6, 'MarkerFaceColor', [0.8 0.8 0.8],'MarkerEdgeColor', 'none')
end

errorbar(1:numel(mean_data), mean_data, sem_data, '.k', 'LineWidth', 2.1, 'MarkerSize', 10, 'MarkerEdgeColor', 'none', 'MarkerFaceColor', 'k');
alpha(0.2)

xlim([0.5, 2+0.5])
xticks(1:numel(mean_data))
xticklabels({'General.', 'Discrim.'})
ylabel('\Delta GLM weight')
set(gca,'linewidth',2)
set(gca, 'TickDir', 'out')
%title('W_t_o_n_e - W_l_i_c_k')
box off

[h1,p1] = ttest2(data{1,1},data{1,2});
disp(mean_data);
disp(p1)
