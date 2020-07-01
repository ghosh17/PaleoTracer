function [] = func_plot_source_degredation_MPhPHE_FLUPYR(MPh_PHE, FLU_FLUPYR)

    c = linspace(0,length(MPh_PHE),length(MPh_PHE)); 
    hold on;
    grid on;
    figure('Name', 'source_degredation');
    scatter(MPh_PHE, FLU_FLUPYR, [], c);
    hold on;
    plot(1,0);
    plot(0,0.5);
    hold off;
    xlabel('MPh/PHE');
    ylabel('FLU/(FLU+PYR)');
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Source_degredation_MPhPHE_FLUPYR';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    hold off;
end