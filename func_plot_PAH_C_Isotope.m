function [] = func_plot_PAH_C_Isotope(FireInput, isotopic_value, numsamples, t)

    
    grid on
    
    %hold on
    %grid on;
    %yyaxis left;
    %c = linspace(t(1),t(numsamples),length(t));
    errBOM = 0.5;
    figure('Name', 'Fire v/s Vegetation Change');
    PAH_C_isotope_plot = scatter(isotopic_value, FireInput, 'r','filled');
    
    set(gca,'yscale','log');
    xlabel('δ13C (‰)');
    ylabel('Sum(PAH)/C31 (Increasing fire frequency)');
    xlim([0.9*min(isotopic_value) 1.1*max(isotopic_value)]);
    ylim([0.9*min(FireInput) 1.1*max(FireInput)]);
    ymin=0.2*min(FireInput);
    ymax=2*max(FireInput);
    %line([-28,-28],[ymin,ymax]);
    line([-22.3,-22.3],[ymin,ymax]);
    xmin = min(isotopic_value) - 0.6;
    xmax = max(isotopic_value) + 0.6;
    xlim([xmin xmax]);
    
    %ylim([ymin,ymax]);
    
    %legend([PAH_C_isotope_plot], {'Bulkδ13C v/s Fire input'})

    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'PAH_vs_C_isotopic.jpg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    
    
    %hold off

end