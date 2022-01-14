function [] = func_climate_stratigraphy(SideId, IsotopicValue, ConiferInput, FireInput, MAP, MAT_Sal, MAT_PWI, ACL, VPD, t, age_XRF, numsamples)

    

    figure('Name', 'Consolidated Climatic Stratigraphy');
    
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
    
    %%Mean Annual Precipitation from CIA-K
    subplot(1,3,1);
    
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
    
    %sort data
    [age_XRF_sorted, sortIndex] = sort(age_XRF);
    MAP_sorted = MAP(sortIndex);
    
    
    MAP_uncertainity = 182;
    errMAP = MAP_uncertainity * ones(length(MAP),1);
    errorbar(MAP_sorted,age_XRF_sorted,errMAP, 'bo', 'horizontal');
    hold on
    scatter(MAP_sorted, age_XRF_sorted, 'b', 'filled');
    hold off
    set(gca, 'YDir','reverse');
    ylabel('Time (my)', 'FontSize', 22);
    ylim([y_min y_max]);
    MAP_x_min = 0.9*min(MAP_sorted) - MAP_uncertainity;
    MAP_x_max = 1.1*max(MAP_sorted) + MAP_uncertainity;
    
    %Handle for PP and LV abnormally low modern ppt values
    if Modern_MAP < MAP_x_min
        MAP_x_min = 0.50 * Modern_MAP;
    end
    
    
    set(gca, 'YDir','reverse');
    xlim([MAP_x_min, MAP_x_max]);
    ylim([y_min y_max]);
    xlabel('MAP (mm)', 'FontSize', 22);
    line([Modern_MAP,Modern_MAP],[y_min,y_max],'Color','#7E2F8E','LineStyle','-.');
    
    hold on
    la = ~isnan(MAP_sorted);
    ap = polyfit(age_XRF_sorted(la),MAP_sorted(la),1);

    pp = polyval(ap,age_XRF_sorted(la));

    plot(pp,age_XRF_sorted(la),'m--');
    
    plot(MAP_sorted(la), age_XRF_sorted(la), 'b-');
    
    R = corrcoef([MAP_sorted(la)],[age_XRF_sorted(la)']);
    
    Rsq = R(1,2).^2;
    
    text(mean(MAP_sorted(la)),min(age_XRF_sorted(la)),num2str(Rsq));
    
    hold off
 
    
    
    
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
    

    
 
    
    %%Salinization Index MAT
    subplot(1,3,2);

    %sort data
    [age_XRF_sorted, sortIndex] = sort(age_XRF);
    MAT_Sal_sorted = MAT_Sal(sortIndex);
    
    scatter(MAT_Sal_sorted, age_XRF_sorted, 'filled');
    
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
    errMAT_Sal = MAT_Sal_uncertainity * ones(length(MAT_Sal_sorted),1);
    errorbar(MAT_Sal_sorted,age_XRF_sorted,errMAT_Sal, 'bo', 'horizontal')
    hold on
    scatter(MAT_Sal_sorted, age_XRF_sorted, 'b', 'filled');
    hold off
    MAT_x_min = 0.9*min(MAT_Sal_sorted)-MAT_Sal_uncertainity;
    MAT_x_max = 1.1*max(MAT_Sal_sorted)+MAT_Sal_uncertainity;
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([MAT_x_min, 25]);
    ylim([y_min y_max]);
    xlabel('MAT (°C) Sal', 'FontSize', 22);
    
    line([Modern_MAT,Modern_MAT],[y_min,y_max],'Color','#7E2F8E','LineStyle','-.');
    
    hold on
    la = ~isnan(MAT_Sal_sorted);
    ap = polyfit(age_XRF_sorted(la),MAT_Sal_sorted(la),1);

    pp = polyval(ap,age_XRF_sorted(la));

    plot(pp,age_XRF_sorted(la),'m--');
    
    plot(MAT_Sal_sorted(la), age_XRF_sorted(la), 'b-');
    
    R = corrcoef([MAT_Sal_sorted(la)],[age_XRF_sorted(la)']);
    
    Rsq = R(1,2).^2;
    
    text(mean(MAT_Sal_sorted(la)),min(age_XRF_sorted(la)),num2str(Rsq));
    
    hold off
    

    
    %%PWI  MAT
    subplot(1,3,3);
   
    %sort data
    [age_XRF_sorted, sortIndex] = sort(age_XRF);
    MAT_PWI_sorted = MAT_PWI(sortIndex);
    
    scatter(MAT_PWI_sorted, age_XRF_sorted, 'filled');
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
    errMAT_PWI = MAT_PWI_uncertainity * ones(length(MAT_PWI_sorted),1);
    errorbar(MAT_PWI_sorted,age_XRF_sorted,errMAT_PWI, 'bo', 'horizontal');
    hold on
    scatter(MAT_PWI_sorted, age_XRF_sorted, 'b', 'filled');
    hold off
    MAT_x_min = 0.9*min(MAT_PWI_sorted) - MAT_PWI_uncertainity;
    MAT_x_max = 1.1*max(MAT_PWI_sorted) + MAT_PWI_uncertainity;
    
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([MAT_x_min, 25]);
    ylim([y_min y_max]);
    xlabel('MAT (°C) PWI', 'FontSize', 22);
    
    line([Modern_MAT,Modern_MAT],[y_min,y_max],'Color','#7E2F8E','LineStyle','-.');
    
    hold on
    la = ~isnan(MAT_PWI_sorted);
    ap = polyfit(age_XRF_sorted(la),MAT_PWI_sorted(la),1);

    pp = polyval(ap,age_XRF_sorted(la));

    plot(pp,age_XRF_sorted(la),'m--');
    
    plot(MAT_PWI_sorted(la), age_XRF_sorted(la), 'b-');
    
    R = corrcoef([MAT_PWI_sorted(la)],[age_XRF_sorted(la)']);
    
    Rsq = R(1,2).^2;
    
    text(mean(MAT_PWI_sorted(la)),min(age_XRF_sorted(la)),num2str(Rsq));
    
    hold off
    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Climate_stratigraphy.svg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
 
    
    
  
end