%load data
clear
load('Fig3hi.mat')

%Select example FOV
FOV = 2;

%Calculate cross correlation
correlation_matrix1 = correlation_matrix_nocue{FOV, 1}  ;
correlation_matrix2 = correlation_matrix_tone{FOV, 1}  ;

correlation_matrix1(correlation_matrix1==1)=NaN;
correlation_matrix2(correlation_matrix2==1)=NaN;

% Plot correlation matrix1
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[300,200,300,275];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

numColors = 1000;
cmap = slanCM(58,numColors);
colormap(cmap);
imagesc(correlation_matrix1);
colorbar;
clim([0 0.3])

% Plot correlation matrix2
scr=get(0,'ScreenSize');
W=scr(3); H=scr(4);
position=[600,200,300,275];
default_font('Arial',16);
Fig = figure('Position',position,...
    'PaperUnits','points','PaperPosition',position,'color','w');

numColors = 1000;
cmap = slanCM(58,numColors);
colormap(cmap);
imagesc(correlation_matrix2);
colorbar;
clim([0 0.3])