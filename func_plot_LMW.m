function [] = func_plot_LMW(LMW, IsotopicValue, numsamples, t)

 hold on
    grid on;
    yyaxis left;
    c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'LMW: Smoke v/s combustion residue');
    lmw_plot = scatter(t, LMW,[],c);
    xlabel('Time (Ma)');
    ylabel('LMW');
    set(gca, 'XDir','reverse');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([lmw_plot,isotope_plot], {'LMW' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'lmw';
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