function [] = func_plot_confier_input(ConiferInput, IsotopicValue, numsamples, t)
    hold on
    grid on;
    yyaxis left;
    c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Confier Input: Retene/3RingSum');
    conifer_plot = scatter(t, ConiferInput,[],c);
    xlabel('Time');
    ylabel('Retene/3RingSum');
    
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([conifer_plot,isotope_plot], {'Conifer fire input' , 'δ13C of Bulk Organic Matter'})
    hold off
end