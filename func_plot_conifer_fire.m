function [] = func_plot_conifer_fire(ConiferInput_retene, DMP_y, FireInput, numsamples, t)

grid on
    
    %hold on
    %grid on;
    %yyaxis left;
    %c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Fire v/s Gymnnosperm/Conifer Proliferation');
    Fire_Conifer_plot = scatter(ConiferInput_retene, FireInput, 'r','filled');
    set(gca,'yscale','log');
    xlabel('Gymnosperm/Conifer burn input (Retene-3ring PAH)');
    ylabel('Sum(PAH)/C31 (Increasing fire frequency)');
    xlim([0.9*min(ConiferInput_retene) 1.1*max(ConiferInput_retene)]);
    ylim([0.9*min(FireInput) 1.1*max(FireInput)]);
    %ymin=0.2*min(FireInput);
    %ymax=2*max(FireInput);
    %line([-28,-28],[ymin,ymax]);
    %line([-24,-24],[ymin,ymax]);
    %xlim([-35, -10]);
    
    %ylim([ymin,ymax]);
    
    %legend([PAH_C_isotope_plot], {'Bulkδ13C v/s Fire input'})
    figure('Name', 'Fire v/s Gymnnosperm/Conifer Proliferation');
    Fire_DMP_y_Conifer_plot = scatter(DMP_y, FireInput, 'r','filled');
    set(gca,'yscale','log');
    xlabel('Gymnosperm/Conifer burn input (DMP-y)');
    ylabel('Sum(PAH)/C31 (Increasing fire frequency)');
    xlim([0.9*min(DMP_y) 1.1*max(DMP_y)]);
    ylim([0.9*min(FireInput) 1.1*max(FireInput)]);
    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'plot_conifer_fire.jpg';
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