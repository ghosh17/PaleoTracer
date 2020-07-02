function [] = func_plot_isotopic_ratio(t,numsamples,IsotopicRatios)
    %c = linspace(t(1),t(numsamples),length(t));
    hold on
    grid on;
    figure('Name', 'δ13C Isotopic ratio');
    %scatter(t,IsotopicRatios,'*','r');
    plot(t,IsotopicRatios,'*r');
    set(gca, 'XDir','reverse');
    
    
    buffer = (t(1)-t(numsamples))/numsamples;
    line([t(1)+buffer, t(numsamples)-buffer], [-24,-24],'Color','red','LineStyle','--');
    line([t(1)+buffer,t(numsamples)-buffer], [-28,-28],'Color','red','LineStyle','--');
    
    %{
    %%Best fit to data
    %We use Robust regression inplace of Ordinary Least Square (OLS), as outlyers
    %in the later have huge influence on fit. This is becasue OLS uses 
    %square difference term instead of absolute value for regression. 
    %In our Bulk Organic data we expect the healthy presence of outlyers, as 
    %terrestrial vegitation tends to be patchy. This would result in 
    %outlyers in the δ13C isotopic signature of these BOM. 
    idxValid = ~isnan(IsotopicRatios);
    [foo, gof] = fit(t(idxValid),IsotopicRatios(idxValid),'loess','Robust','LAR');
    hold on;
    plot(foo);
    hold off;
    %}
    
    %%Plot properties
    ylim([-35, -10]);
    xlabel('Time (Ma)');
    ylabel('δ13C (‰)');
    legend('Bulk Organic Matter δ13C');
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'δ13C_temporal';
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