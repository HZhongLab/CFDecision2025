% Load data
clear
load('Fig1b_left.mat')

% plot 
default_font('Arial',16);
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[400,349,225,300];
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

ax1 = axes(Fig,'Position',[0.25 0.12 0.55 0.8]); 
Color = [0 1 0; 1 0 0];

session = SessionData.RawEvents.Trial;
Outcome = SessionData.Outcomes';

v = [0 0; 0.5 0; 0.5 80; 0 80];
f = [1 2 3 4];

for t = 1:70
    lick_time = [];
    if isfield(session{1, t}.Events,'BNC1High')
        lick_time = session{1, t}.Events.BNC1High - session{1, t}.States.cue(1);
        lick_time = lick_time(lick_time>0 & lick_time<4);
        if ~isempty(lick_time)
            ILI=(lick_time-circshift(lick_time,1));
            ILI(1)=[];
            lick_time = [lick_time(1) lick_time(ILI>0.05)];
        end
    end
    
    if ~isempty(lick_time)
        trial_temp = ones(1,length(lick_time));
        if Outcome(t) == 1 || Outcome(t) == 2
        plot(ax1,lick_time, trial_temp*t,'ko','MarkerFaceColor',[0.5 0 1],'MarkerSize',3 ...
            ,'MarkerEdgeColor','none'); hold(ax1, 'on')
        elseif Outcome(t) == 3 || Outcome(t) == 4
            plot(ax1,lick_time, trial_temp*t,'ko','MarkerFaceColor',[1 0.7529 0 ],'MarkerSize',3 ...
            ,'MarkerEdgeColor','none'); hold(ax1, 'on')
        end
    end
end

xlim(ax1,[0 1.5])
ylim(ax1,[0 70.5])
xlabel(ax1,'Time from cue onset (s)')
ylabel(ax1,'Trial')
set(ax1,'linewidth',2)
set(ax1, 'TickDir', 'out')
box (ax1,"off")