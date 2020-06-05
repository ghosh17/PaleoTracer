function [] = func_plot_confier_input(ConiferInput, IsotopicValue, t)
    hold on
    grid on;
    yyaxis left;
    c = linspace(0,length(ConiferInput),length(ConiferInput));
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