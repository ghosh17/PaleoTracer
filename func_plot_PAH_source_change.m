function [] = func_plot_PAH_source_change(PAHSourceChange, IsotopicValue, numsamples, t)
    c = linspace(t(1),t(numsamples),length(t));
    hold on
    grid on;
    
    yyaxis left
    figure('Name', '3RingSum/Sum(PAH)');
    PAH_source=scatter(t, PAHSourceChange,[],c);
    xlabel('Time (Ma)');
    ylabel('Sum(3-ring-PAH)/sum(PAH)');
    line([t(1),t(numsamples)], [0.5,0.5]);
    legend('Fire Input');
    set(gca, 'XDir','reverse');
    
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([PAH_source,isotope_plot], {'Source of PAH' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'PAH_provenance';
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