function [] = func_plot_PAH_C_Isotope(FireInput, isotopic_value, numsamples, t)


    hold on
    grid on;
    yyaxis left;
    c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Fire v/s Vegetation Change');
    PAH_C_isotope_plot = scatter(isotopic_value, FireInput,[],c);
    set(gca,'yscale','log')
    xlabel('δ13C (‰)');
    ylabel('Sum(PAH)/C31 (log scale)');
    ymin=0.2*min(FireInput);
    ymax=2*max(FireInput);
    line([-28,-28],[ymin,ymax]);
    line([-24,-24],[ymin,ymax]);
    xlim([-35, -10]);
    
    ylim([ymin,ymax]);
    
    %legend([PAH_C_isotope_plot], {'Bulkδ13C v/s Fire input'})

    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'PAH_vs_C_isotopic';
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