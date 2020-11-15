function [] = func_consolidated_temporal_plot(SideId, IsotopicValue, ConiferInput, FireInput, MAP, MAT_Sal, ACL, VPD, t, age_XRF, numsamples)

    %consolidated_XRF = [age_XRF, MAP, MAT_Sal];
    
    
    %tbl = [t, ConiferInput, FireInput, ACL, VDP];
    
    %File Name
    %consolidated_temporal_file = 'consolidated_temporal.xlsx';
    


    figure('Name', 'Consolidated Temporal Figure');
    
    grid on;
    
    y_min = t(numsamples) - 0.05*(t(1)-t(numsamples));
    y_max = t(1) + 0.05*(t(1)-t(numsamples));
    
    
    subplot(1,6,1);
    scatter(IsotopicValue, t, 'filled');
    set(gca, 'YDir','reverse');
    xlim([-35 -15]);
    ylabel('Time (my)');
    ylim([y_min y_max]);
    xlabel('δ13C (‰)');
    
    subplot(1,6,2);
    fire_x_min = 0.8*min(ConiferInput);
    fire_x_max = 1.2*max(ConiferInput);
    scatter(ConiferInput, t, 'filled');
    xlim([fire_x_min fire_x_max]);
    ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('Ret/(Ret+Σ(3-ring PAH)');
    
    
    
    subplot(1,6,3);
    scatter(FireInput, t, 'filled');
    set(gca,'xscale','log');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([0.1*min(FireInput), 10*max(FireInput)]);
    ylim([y_min y_max]);
    xlabel('Σ(PAH)/C31');
    xticks([0.001,0.01,0.1,1]);
    
    
    %{
    subplot(1,7,4)
    ACL_x_min = 0.90*min(ACL);
    ACL_x_max = 1.10*max(ACL);
    scatter(ACL, t, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([ACL_x_min ACL_x_max]);
    ylim([y_min y_max]);
    xlabel('ACL');
    %}
    
    subplot(1,6,4)
    VDP_x_min = 0.90*min(VPD);
    VDP_x_max = 1.10*max(VPD);
    scatter(VPD, t, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([VDP_x_min VDP_x_max]);
    ylim([y_min y_max]);
    xlabel('VPD (kPa)');
    
    %%Mean Annual Precipitation
    subplot(1,6,5);
    
    hold on
    scatter(MAP, age_XRF, 'filled');
    MAP_uncertainity = 182;
    errMAP = MAP_uncertainity * ones(length(MAP),1);
    errorbar(MAP,age_XRF,errMAP, 'o', 'horizontal');
    
    MAP_x_min = 0.9*min(MAP) - MAP_uncertainity;
    MAP_x_max = 1.1*max(MAP) + MAP_uncertainity;
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([MAP_x_min, MAP_x_max]);
    ylim([y_min y_max]);
    xlabel('MAP (mm)');
    hold off
    
    
    %%Salinization Index MAT
    subplot(1,6,6);
    hold on
    
    scatter(MAT_Sal, age_XRF, 'filled');
    
    MAT_Sal_uncertainity = 4.4;
    errMAT_Sal = MAT_Sal_uncertainity * ones(length(MAT_Sal),1);
    errorbar(MAT_Sal,age_XRF,errMAT_Sal, 'o', 'horizontal')
   
    MAT_x_min = 0.9*min(MAT_Sal)-MAT_Sal_uncertainity;
    MAT_x_max = 1.1*max(MAT_Sal)+MAT_Sal_uncertainity;
    
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([MAT_x_min, MAT_x_max]);
    ylim([y_min y_max]);
    xlabel('MAT (°C)');
    
    hold off
    
    
    
  
end