function [] = func_plot_FLU_FLUPYR_temporal(FLU_FLUPYR, IsotopicValue, numsamples, t)

    c = linspace(t(1),t(numsamples),length(t));
    hold on
    grid on;
    
    yyaxis left;
    figure('Name', 'FLU/FLUPYR temporal');
    fire_freequency_plot = scatter(t, FLU_FLUPYR,[],c);
    %set(gca,'yscale','log')
    xlabel('Time (Ma)');
    ylabel('FLU/(FLU+PYR)');
   
    set(gca, 'XDir','reverse')
    
    %Secondary plot showing Carbon isotopic ratios
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([fire_freequency_plot,isotope_plot], {'Fire freequency' , 'δ13C of Bulk Organic Matter'})
    
 
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Combustion_Character_Flu_Pyr_Temporal';
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