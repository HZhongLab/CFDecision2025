%% Classify what type of information an ROI encode

%load data
load('Fig3fg.mat')
load('Fig3fg_1.mat')
load('Fig3fg_2.mat')
cell_profile = [];
FZ_tt_all_full = [FZ_tt_all_FULL1;FZ_tt_all_FULL2];
data = FZ_tt_all_full;

for c = 1:size(data,1)
    if FA_rate_cell(c)>0.1 %remove cells with too little FA trials

        Hit = data{c, 1};
        CR = data{c, 3};
        FA = data{c, 4};

        Hit_norm = Hit(:,17:32)-mean(Hit(:,9:16),2);
        CR_norm = CR(:,17:32)-mean(CR(:,9:16),2);
        FA_norm = FA(:,17:32)-mean(FA(:,9:16),2);

        for t = 1:16 % 0-1 s from cue onset
            [~,p1] = ttest2(Hit_norm(:,t), CR_norm(:,t));
            [~,p2] = ttest2(Hit_norm(:,t), FA_norm(:,t));
            [~,p3] = ttest2(CR_norm(:,t), FA_norm(:,t));
            p1_all(t) = p1;
            p2_all(t) = p2;
            p3_all(t) = p3;
        end

        p1_consecutive = any(conv(p1_all<0.05, [1 1], 'valid') == 2);
        p2_consecutive = any(conv(p2_all<0.05, [1 1], 'valid') == 2);
        p3_consecutive = any(conv(p3_all<0.05, [1 1], 'valid') == 2);

        cell_profile = [cell_profile; [p1_consecutive,p2_consecutive,p3_consecutive]];

    else
        cell_profile = [cell_profile; NaN(1,3)];
    end
end

cell_profile2 = cell_profile(Outside_2SD,:);


%% Classify Hit vs CR or 8 kHz vs 14 kHz 

F_mod1 = FZ_tt_all{1, 2}(Outside_2SD,:);
F_mod3 = FZ_tt_all{3, 2}(Outside_2SD,:);
F_mod4 = FZ_tt_all{4, 2}(Outside_2SD,:);

%choice-encoding
encode = find(all(cell_profile2 == [1 0 1], 2)); 
Data1 = mean(F_mod1(encode,25:32),2)-mean(F_mod1(encode,9:16),2);
Data2 = mean(F_mod3(encode,25:32),2)- mean(F_mod3(encode,9:16),2);

idx = (Data1-Data2)>0;
encode1 = encode(idx==1); %Hit prefer
encode2 = encode(idx==0); %CR prefer

Hit_prefer = length(encode1)/(length(encode1)+length(encode2));
CR_prefer = length(encode2)/(length(encode1)+length(encode2));

%cue-encoding
encode = find(all(cell_profile2 == [1 1 0], 2)); 
Data1 = mean(F_mod1(encode,25:32),2)-mean(F_mod1(encode,9:16),2);
Data2 = mean(F_mod3(encode,25:32),2)- mean(F_mod3(encode,9:16),2);

idx = (Data1-Data2)>0;
encode1 = encode(idx==1); %8 kHz prefer
encode2 = encode(idx==0); %14 kHz prefer

Tone8_prefer = length(encode1)/(length(encode1)+length(encode2));
Tone14_prefer = length(encode2)/(length(encode1)+length(encode2));


%% calculate number of cells in each category
cell_profile2(any(isnan(cell_profile2), 2), :) = [];

profile_count(2,1) = length(find(all(cell_profile2 == [1 0 1], 2)));%choice
profile_count(3,1) = length(find(all(cell_profile2 == [1 1 0], 2)));%cue
profile_count(4,1) = length(find(all(cell_profile2 == [1 1 1], 2)));
profile_count(5,1) = length(find(all(cell_profile2 == [0 0 0], 2)));
profile_count(6,1) = length(find(all(cell_profile2 == [0 0 1], 2)));
profile_count(7,1) = length(find(all(cell_profile2 == [0 1 0], 2)));
profile_count(8,1) = length(find(all(cell_profile2 == [0 1 1], 2)));

profile_count(:,2) = profile_count(:,1)*100/length(cell_profile2);

fraction_choice = profile_count(2,2);
fraction_cue = profile_count(3,2);

Discrim_ROI = [fraction_choice*Hit_prefer,fraction_choice*CR_prefer;...
               fraction_cue*Tone8_prefer,fraction_cue*Tone14_prefer ];

%% Plot the results
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[500,500,175,300];
default_font('Arial',24);
Fig = figure('Position',position,...
    'Units','inches','PaperUnits','inches','color','w');

color2 = [0.5 0 1 ;1 0.7529 0; 1 0 1; 0.5 0 0.5];

ba = bar(1:2,Discrim_ROI,'stacked','BarWidth',0.6,'EdgeColor','none', 'FaceColor','flat');
ba(1).CData = [0.5 0 1];
ba(2).CData = [1 0.7529 0];

ylim([0 20 ])
xlim([0.5 2.5])

ylabel('Discriminative ROI (%) ');
set(gca, 'YTick', [0 10 20 ])
set(gca, 'XTick', [ 1 2 ])
set(gca, 'XTickLabel', {'choice','cue'})
set(gca,'linewidth',3)
set(gca, 'TickDir', 'out')
set(gca,'TickLength',[0.025, 0.025])
box off
