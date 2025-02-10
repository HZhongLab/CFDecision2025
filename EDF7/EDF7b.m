%% Classify what type of information an ROI encode

%load data
clear
load('EDF7bcd.mat')
cell_profile = [];
data = FZ_tt_all_full;

for c = 1:size(data,1)
    if FA_rate_cell(c)>0.1

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

%% calculate number of cells in each category
cell_profile2(any(isnan(cell_profile2), 2), :) = [];

profile_count(1,1) = length(find(all(cell_profile2 == [1 0 0], 2)));
profile_count(2,1) = length(find(all(cell_profile2 == [1 0 1], 2)));%choice
profile_count(3,1) = length(find(all(cell_profile2 == [1 1 0], 2)));%cue
profile_count(4,1) = length(find(all(cell_profile2 == [1 1 1], 2)));
profile_count(5,1) = length(find(all(cell_profile2 == [0 0 0], 2)));
profile_count(6,1) = length(find(all(cell_profile2 == [0 0 1], 2)));
profile_count(7,1) = length(find(all(cell_profile2 == [0 1 0], 2)));
profile_count(8,1) = length(find(all(cell_profile2 == [0 1 1], 2)));

profile_count(:,2) = profile_count(:,1)*100/length(cell_profile2);

disp(profile_count(2,2));
disp(profile_count(3,2));
