function [] = func_plot_ACL_CPI_C31C29(ACL,CPI,C31_by_C29,IsotopicValue, numsamples, t)
    

    c = linspace(t(1),t(numsamples),length(t));
    %ACL
    hold on;
    grid on;    
    yyaxis left;
    figure('Name', 'Temporal ACL');
    ACL_plot = scatter(t, ACL, [], c);
    xlabel('Time (Ma)');
    ylabel('ACL');
    set(gca, 'XDir','reverse');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([ACL_plot,isotope_plot], {'ACL' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'ACL_temporal';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %CPI
    hold on;
    grid on;
    yyaxis left;
    figure('Name', 'Temporal CPI');
    CPI_plot = scatter(t, CPI, [], c);
    xlabel('Time (Ma)');
    ylabel('CPI');
    set(gca, 'XDir','reverse');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([CPI_plot,isotope_plot], {'CPI' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'CPI_temporal';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
    hold off
    
    %C31/C29
    hold on;
    grid on;
    yyaxis left
    figure('Name', 'Temporal C31/C29 ratio');
    C31_C29_plot = scatter(t, C31_by_C29, [], c);
    xlabel('Time (Ma)');
    ylabel('C31/C29');
    set(gca, 'XDir','reverse');    
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([C31_C29_plot,isotope_plot], {'C31/C29' , 'δ13C of Bulk Organic Matter'})
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'C31_C29_temporal';
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