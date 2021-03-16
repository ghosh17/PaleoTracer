function [] = func_plot_LMW(LMW, IsotopicValue, numsamples, t)

    hold on
    grid on;
    figure('Name', 'LMW: Smoke v/s combustion residue');
    lmw_plot = scatter(t, LMW, 'filled');
    xlabel('Time (Ma)');
    ylabel('LMW');
    set(gca, 'XDir','reverse');
    
    x_h_lim = 1.1*max(t);
    x_l_lim = 0.9*min(t);

    
    line([x_l_lim,x_h_lim],[0.75,0.75], 'Color','red','LineStyle','--');
    line([x_l_lim,x_h_lim],[0.95,0.95], 'Color','red','LineStyle','--');
    
    line([x_l_lim,x_h_lim],[0.8,0.8], 'Color','blue','LineStyle','-');
    line([x_l_lim,x_h_lim],[0.35,0.35], 'Color','blue','LineStyle','-');
    
    xlim([x_l_lim x_h_lim]);
    ylim([0 1]);
    
    xt_mid = (min(t) + max(t))/2;
    xt = [xt_mid xt_mid];
    yt = [0.9 0.6];
    str = {'Smoke','Residue'};
    text(xt,yt,str)
   
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'lmw.jpg';
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