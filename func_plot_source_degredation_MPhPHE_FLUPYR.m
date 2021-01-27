function [] = func_plot_source_degredation_MPhPHE_FLUPYR(MPh_PHE, FLU_FLUPYR)

    c = linspace(0,length(MPh_PHE),length(MPh_PHE)); 
    hold on;
    grid on;
    figure('Name', 'source_degredation');
    scatter(MPh_PHE, FLU_FLUPYR, [], c, 'filled');
    hold on;
    line([1,1],[0,1],'Color', 'blue','LineStyle','--');
    line([0,5],[0.5,0.5],'Color','red','LineStyle','-');
    line([2.43,2.43],[0,1], 'Color','red','LineStyle','-');
    hold off;
    xlabel('MPh/PHE');
    ylabel('FLU/(FLU+PYR)');
    xt = [0.2 0.2 2.6 2.6];
    yt = [0.8 0.2 0.2 0.8];
    str = {'Pyrogenic & Primary','Pyrogenic & Degraded','Petrogenic & Degraded','Petrogenic & Primary'};
    text(xt,yt,str)
    %xlim([0 5]);
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Source_degredation_MPhPHE_FLUPYR.jpg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    hold off;
end