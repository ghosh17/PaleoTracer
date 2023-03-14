function [MAP, MAP_PPM, MAP_PPM_MIN, MAP_PPM_MAX, MAT_Sal, MAT_PPM, MAT_PPM_MIN, MAT_PPM_MAX, MAT_PWI, age_XRF, age_PPM] = func_plot_XRF(siteId)

    XRF_temp = strcat(siteId,'_XRF.xlsx');
    [~, ~, XRF_all] = xlsread(XRF_temp);
    
    [~, ~, Age_XRF_temp] = xlsread(XRF_temp,'B:B');
    age_XRF = str2double(string(Age_XRF_temp));
    
    [~, ~, MAP_temp] = xlsread(XRF_temp,'W:W');
    MAP = str2double(string(MAP_temp));
    
    [~, ~, MAT_PWI_temp] = xlsread(XRF_temp,'Y:Y');
    MAT_PWI = str2double(string(MAT_PWI_temp));
    
    [~, ~, MAT_Sal_temp] = xlsread(XRF_temp,'Z:Z');
    MAT_Sal = str2double(string(MAT_Sal_temp));
    
    %%%%%%%%%%%%%%%
    %PPM Model
    
    PPM_temp = strcat(siteId,'_Geochem.xlsx');
    [~, ~, XRF_all] = xlsread(PPM_temp);

     [~, ~, Age_PPM_temp] = xlsread(PPM_temp,'B:B');
    age_PPM = str2double(string(Age_PPM_temp));


    %PPM MAP and uncertainty
    [~, ~, MAP_PPM_temp] = xlsread(PPM_temp,'D:D');
    MAP_PPM = str2double(string(MAP_PPM_temp));

    [~, ~, MAP_PPM_MIN_temp] = xlsread(PPM_temp,'I:I');
    MAP_PPM_MIN = str2double(string(MAP_PPM_MIN_temp));

    [~, ~, MAP_PPM_MAX_temp] = xlsread(PPM_temp,'J:J');
    MAP_PPM_MAX = str2double(string(MAP_PPM_MAX_temp));


    %PPM MAT and uncertainty
    [~, ~, MAT_PPM_temp] = xlsread(PPM_temp,'G:G');
    MAT_PPM = str2double(string(MAT_PPM_temp));

    [~, ~, MAT_PPM_MIN_temp] = xlsread(PPM_temp,'K:K');
    MAT_PPM_MIN = str2double(string(MAT_PPM_MIN_temp));

    [~, ~, MAT_PPM_MAX_temp] = xlsread(PPM_temp,'L:L');
    MAT_PPM_MAX = str2double(string(MAT_PPM_MAX_temp));

    
    %{
    grid on;
    
  
    % Plot MAP
    figure('Name', 'Mean Average Precipitation');
    MAP_plot = scatter(MAP, age_XRF, 'r');
    ylabel('Time (Ma)');
    xlabel('Mean Average Precipitation (mm)');
    %ylim([0.2*min(Fire_input),2*max(Fire_input)]);
   
    set(gca, 'YDir','reverse');
    
    xlim([min(MAP)-0.2*min(MAP) max(MAP)+0.2*max(MAP)]);
    ylim([3 19]);
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'MAP_temporal';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    % Plot MAT_PWI
    figure('Name', 'Mean Average Temperature PWI Index');
    MAT_PWI_plot = scatter(MAT_PWI, age_XRF, 'r');
    ylabel('Time (Ma)');
    xlabel('Mean Average Temperature (°C)');
    %ylim([0.2*min(Fire_input),2*max(Fire_input)]);
   
    set(gca, 'YDir','reverse');
    
    xlim([min(MAT_PWI)-0.1*min(MAT_PWI) max(MAT_PWI)+0.1*max(MAT_PWI)]);
    ylim([3 19]);
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'MAP_PWI_temporal';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    % Plot MAT_Sal
    figure('Name', 'Mean Average Temperature Salinization index');
    MAT_Sal_plot = scatter(MAT_Sal, age_XRF, 'r');
    ylabel('Time (Ma)');
    xlabel('Mean Average Temperature (°C)');
    %ylim([0.2*min(Fire_input),2*max(Fire_input)]);
   
    set(gca, 'YDir','reverse');
    
    xlim([min(MAT_Sal)-0.1*min(MAT_Sal) max(MAT_Sal)+0.1*max(MAT_Sal)]);
    ylim([3 19]);
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'MAP_Sal_temporal';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    %}
    
    
end