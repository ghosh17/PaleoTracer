function [] = func_plot_methyl_PHE_veg_proxy(DMP_x, DMP_y, numsamples, t)

    hold on
    grid on;
    c = linspace(min(t),max(t),length(t));
    figure('Name', 'M-PHE vegetation proxy');
    
    MPHE_veg_proxy = scatter(DMP_x, DMP_y, [], c, 'filled');
    ylabel('(1,7-DMP+2,6|3,5-DMP)/(1,7-DMP+1,2-DMP+2,6|3,5-DMP)', 'FontSize', 24);
    xlabel('1,7-DMP/1,2-DMP', 'FontSize', 24);
    xlim([0.4 1]);
    ylim([0 20]);
    
    line([0.4,0.95],[8, 8]);
    line([0.6,0.6],[0, 8]);
    line([0.95,0.95],[0,20]);
    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'MPHE_veg_proxy.jpg';
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