function [] = func_plot_grass_vs_conifer(ConiferInput_retene, GrassInput_pyrene, numsamples, t)

    grid on
    
    %hold on
    %grid on;
    %yyaxis left;
    %c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Conifer v/s Grass Proliferation');
   
    Fire_Grass_plot = scatter(GrassInput_pyrene, ConiferInput_retene, 'r','filled');

    
    xlabel('Grass burn input (Pyrene-3ring PAH)');
    ylabel('Conifer burn input (Retene-3ring PAH)');
    xlim([0.9*min(GrassInput_pyrene) 1.1*max(GrassInput_pyrene)]);
    ylim([0.9*min(ConiferInput_retene) 1.1*max(ConiferInput_retene)]);
    %ymin=0.2*min(FireInput);
    %ymax=2*max(FireInput);
    %line([-28,-28],[ymin,ymax]);
    %line([-24,-24],[ymin,ymax]);
    %xlim([-35, -10]);
    
    %ylim([ymin,ymax]);
    
    %legend([PAH_C_isotope_plot], {'Bulkδ13C v/s Fire input'})

    
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'grass_vs_conifer.jpg';
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