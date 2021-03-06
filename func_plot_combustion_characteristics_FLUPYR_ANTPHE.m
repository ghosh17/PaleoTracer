function [] = func_plot_combustion_characteristics_FLUPYR_ANTPHE(FLU_FLUPYR, ANT_ANTPHE)
    c = linspace(0,length(FLU_FLUPYR),length(FLU_FLUPYR));
    hold on
    figure('Name', 'Combustion Combustion_characteristics_FLUPYR_ANTPHE');
    CC = scatter(FLU_FLUPYR, ANT_ANTPHE,[],c);
    xlabel('FLU/(FLU+PYR)');
    ylabel('Anthracene/(Anthracene + Phenantherene)');
    
    
    
    line([0.4,1],[0.1,0.1]);
    line([0.4,0.4],[0.1,1]);
    line([0.5,0.5],[0.1,1]);
    
    
    legend([CC], {'Combustion characteristics'});
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Combustion_characteristics_FLUPYR_ANTPHE';
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