function [] = func_plot_ACL_CPI_C31C29(ACL,CPI,C31_by_C29,IsotopicValue, numsamples, t)
    

    c = linspace(t(1),t(numsamples),length(t));
    %ACL
    hold on;
    grid on;    
    yyaxis left;
    figure('Name', 'Temporal ACL');
    ACL_plot = scatter(t, ACL, [], c);
    xlabel('time');
    ylabel('ACL');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([ACL_plot,isotope_plot], {'ACL' , 'δ13C of Bulk Organic Matter'})
    hold off
    
    %CPI
    hold on;
    grid on;
    yyaxis left;
    figure('Name', 'Temporal CPI');
    CPI_plot = scatter(t, CPI, [], c);
    xlabel('time');
    ylabel('CPI');
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([CPI_plot,isotope_plot], {'CPI' , 'δ13C of Bulk Organic Matter'})
    hold off
    
    %C31/C29
    hold on;
    grid on;
    yyaxis left
    figure('Name', 'Temporal C31/C29 ratio');
    C31_C29_plot = scatter(t, C31_by_C29, [], c);
    xlabel('time');
    ylabel('C31/C29');
    
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([C31_C29_plot,isotope_plot], {'C31/C29' , 'δ13C of Bulk Organic Matter'})
    hold off
    

end