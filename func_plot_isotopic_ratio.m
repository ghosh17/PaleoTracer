function [] = func_plot_isotopic_ratio(t,numsamples,IsotopicRatios)
    %c = linspace(t(1),t(numsamples),length(t));
    hold on
    grid on;
    figure('Name', 'δ13C Isotopic ratio');
    %scatter(t,IsotopicRatios,'*','r');
    plot(t,IsotopicRatios,'*r');
    
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
    xlabel('Time');
    ylabel('δ13C');
    legend('Bulk Organic Matter δ13C');
    hold off;
end