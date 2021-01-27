function [] = func_consolidated_temporal_plot(SideId, IsotopicValue, ConiferInput, FireInput, MAP, MAT_Sal, MAT_PWI, ACL, VPD, t, age_XRF, numsamples)

    

    figure('Name', 'Consolidated Temporal Figure');
    
    grid on;
    t_min = min(t);
    t_max = max(t);
    y_max_1 = t_max - 0.05*(t_min-t_max);
    y_min_1 = t_min + 0.05*(t_min-t_max);
    
    t_XRF_min = min(age_XRF);
    t_XRF_max = max(age_XRF);
    
    y_max_2 = t_XRF_max - 0.05*(t_XRF_min-t_XRF_max);
    y_min_2 = t_XRF_min + 0.05*(t_XRF_min-t_XRF_max);
    
    if(y_max_1 > y_max_2)
        y_max = y_max_1;
    else
        y_max = y_max_2;
    end
    
    if(y_min_1 < y_min_2)
        y_min = y_min_1;
    else
        y_min = y_min_2;
    end
    
    
    subplot(1,6,1);
    scatter(IsotopicValue, t, 'filled');
    set(gca, 'YDir','reverse');
    xlim([-35 -15]);
    ylabel('Time (my)', 'FontSize', 22);
    ylim([y_min y_max]);
    xlabel('δ13C (‰)', 'FontSize', 22);
    

    %{
    gym_conf_x_min = 0.8*min(ConiferInput);
    gym_conf_x_max = 1.2*max(ConiferInput);
    scatter(ConiferInput, t, 'filled');
    set(gca, 'YDir','reverse');
    line([0.1,0.1],[y_min,y_max]);
    xlim([0 gym_conf_x_max]);
    ylabel('Time (my)', 'FontSize', 24);
    ylim([y_min y_max]);
    %set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('Ret/(Ret+Σ(3-ring PAH)', 'FontSize', 24);
    %}
    
    
    subplot(1,6,2);
    gym_conf_x_min = 0.8*min(ConiferInput);
    gym_conf_x_max = 1.2*max(ConiferInput);
    scatter(ConiferInput, t, 'filled');
    line([0.1,0.1],[y_min,y_max]);
    xlim([0 gym_conf_x_max]);
    ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('Ret/(Ret+Σ(3-ring PAH)', 'FontSize', 22);
    
    
    
    subplot(1,6,3);
    scatter(FireInput, t, 'filled');
    set(gca,'xscale','log');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([0.1*min(FireInput), 10*max(FireInput)]);
    ylim([y_min y_max]);
    xlabel('Σ(PAH)/C31', 'FontSize', 22);
    xticks([0.001,0.01,0.1,1]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);%%comment out when d13C available
    
    
    %{
    subplot(1,7,4)
    ACL_x_min = 0.90*min(ACL);
    ACL_x_max = 1.10*max(ACL);
    scatter(ACL, t, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([ACL_x_min ACL_x_max]);
    ylim([y_min y_max]);
    xlabel('ACL');
    
    
    subplot(1,6,4)
    VDP_x_min = 0.90*min(VPD);
    VDP_x_max = 1.10*max(VPD);
    scatter(VPD, t, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([VDP_x_min VDP_x_max]);
    ylim([y_min y_max]);
    xlabel('VPD (kPa)');
    
    %}
    
    %%Mean Annual Precipitation
    subplot(1,6,4);
    
    hold on
    %Palo Pintado
    if strcmp(SideId,'PP')
        Modern_MAP = 139;
    end
    %La Vina
    if strcmp(SideId,'LV')
        Modern_MAP = 364;
    end
    %Rio Iruya
    if strcmp(SideId,'RI')
        Modern_MAP = 1118;
    end
    
    
    scatter(MAP, age_XRF, 'filled');
    MAP_uncertainity = 182;
    errMAP = MAP_uncertainity * ones(length(MAP),1);
    errorbar(MAP,age_XRF,errMAP, 'o', 'horizontal');
    
    MAP_x_min = 0.9*min(MAP) - MAP_uncertainity;
    MAP_x_max = 1.1*max(MAP) + MAP_uncertainity;
    
    %Handle for PP and LV abnormally low modern ppt values
    if Modern_MAP < MAP_x_min
        MAP_x_min = 0.50 * Modern_MAP;
    end
    
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([MAP_x_min, MAP_x_max]);
    ylim([y_min y_max]);
    xlabel('MAP (mm)', 'FontSize', 22);
    line([Modern_MAP,Modern_MAP],[y_min,y_max],'Color','#7E2F8E','LineStyle','--');
    hold off
    
    
    %%Salinization Index MAT
    subplot(1,6,5);
    hold on
    
    scatter(MAT_Sal, age_XRF, 'filled');
    
    %Palo Pintado
    if strcmp(SideId,'PP')
        Modern_MAT = 16.29; 
    end
    %La Vina
    if strcmp(SideId,'LV')
        Modern_MAT = 17.98;
    end
    %Rio Iruya
    if strcmp(SideId,'RI')
        Modern_MAT = 21.7;
    end
    
    MAT_Sal_uncertainity = 4.4;
    errMAT_Sal = MAT_Sal_uncertainity * ones(length(MAT_Sal),1);
    errorbar(MAT_Sal,age_XRF,errMAT_Sal, 'o', 'horizontal')
   
    MAT_x_min = 0.9*min(MAT_Sal)-MAT_Sal_uncertainity;
    MAT_x_max = 1.1*max(MAT_Sal)+MAT_Sal_uncertainity;
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([MAT_x_min, 25]);
    ylim([y_min y_max]);
    xlabel('MAT (°C) Sal', 'FontSize', 22);
    
    line([Modern_MAT,Modern_MAT],[y_min,y_max],'Color','#7E2F8E','LineStyle','--');
    
    hold off
    
    
    %%PWI  MAT
    subplot(1,6,6);
    hold on
    
    scatter(MAT_PWI, age_XRF, 'filled');
    %Palo Pintado
    if strcmp(SideId,'PP')
        Modern_MAT = 16.29; 
    end
    %La Vina
    if strcmp(SideId,'LV')
        Modern_MAT = 17.98;
    end
    %Rio Iruya
    if strcmp(SideId,'RI')
        Modern_MAT = 21.7;
    end
        
    MAT_PWI_uncertainity = 2.1;
    errMAT_PWI = MAT_PWI_uncertainity * ones(length(MAT_PWI),1);
    errorbar(MAT_PWI,age_XRF,errMAT_PWI, 'o', 'horizontal')
   
    MAT_x_min = 0.9*min(MAT_PWI) - MAT_PWI_uncertainity;
    MAT_x_max = 1.1*max(MAT_PWI) + MAT_PWI_uncertainity;
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([MAT_x_min, 25]);
    ylim([y_min y_max]);
    xlabel('MAT (°C) PWI', 'FontSize', 22);
    
    line([Modern_MAT,Modern_MAT],[y_min,y_max],'Color','#7E2F8E','LineStyle','--');
    
     %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Consolidated_temporal_stratigraphic_column.jpg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    

    
    hold off
    
    
  
end