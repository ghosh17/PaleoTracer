function [] = func_plot_fire_input(Fire_input, IsotopicValue, numsamples, t)
    c = linspace(t(1),t(numsamples),length(t));
    hold on
    grid on;
    
    yyaxis left;
    figure('Name', 'Fire Input');
    fire_freequency_plot = scatter(t, Fire_input,[],c);
    set(gca,'yscale','log')
    xlabel('Time (Ma)');
    ylabel('Sum(PAH)/C31 (log scale)');
   
    set(gca, 'XDir','reverse')
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([fire_freequency_plot,isotope_plot], {'Fire freequency' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Fire_regime_temporal';
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