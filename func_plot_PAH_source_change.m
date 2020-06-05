function [] = func_plot_PAH_source_change(PAHSourceChange, IsotopicValue, t)
    c = linspace(0,length(PAHSourceChange),length(PAHSourceChange));
    hold on
    grid on;
    
    yyaxis left
    figure('Name', '3RingSum/Sum(PAH)');
    PAH_source=scatter(t, PAHSourceChange,[],c);
    xlabel('Time');
    ylabel('Sum(3-ring-PAH)/sum(PAH)');
    legend('Fire Input');
    
    
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([PAH_source,isotope_plot], {'Source of PAH' , 'δ13C of Bulk Organic Matter'})
    hold off
end