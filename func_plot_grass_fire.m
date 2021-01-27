function [] = func_plot_grass_fire(GrassInput_pyrene, FireInput, numsamples, t)

    grid on
    
    %hold on
    %grid on;
    %yyaxis left;
    %c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Fire v/s Grass Proliferation');
    Fire_Grass_plot = scatter(GrassInput_pyrene, FireInput, 'r','filled');
    set(gca,'yscale','log');
    xlabel('Grass burn input (Pyrene-3ring PAH)');
    ylabel('Sum(PAH)/C31 (Increasing fire frequency)');
    xlim([0.9*min(GrassInput_pyrene) 1.1*max(GrassInput_pyrene)]);
    ylim([0.9*min(FireInput) 1.1*max(FireInput)]);
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
    filename = 'plot_grass_fire.jpg';
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