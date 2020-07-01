function [] = func_plot_confier_input(ConiferInput, IsotopicValue, numsamples, t)
    hold on
    grid on;
    yyaxis left;
    c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Confier Input: Retene/3RingSum');
    conifer_plot = scatter(t, ConiferInput,[],c);
    xlabel('Time (Ma)');
    ylabel('Retene/3RingSum');
    set(gca, 'XDir','reverse');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([conifer_plot,isotope_plot], {'Conifer fire input' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Confier_input';
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