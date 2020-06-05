function [] = func_plot_fire_input(Fire_input, IsotopicValue, t)
    c = linspace(0,length(Fire_input),length(Fire_input));
    hold on
    grid on;
    
    yyaxis left;
    figure('Name', 'Fire Input');
    fire_freequency_plot = scatter(t, Fire_input,[],c);
    set(gca,'yscale','log')
    xlabel('Time');
    ylabel('Sum(PAH)/C31 (log scale)');
   
    %set(gca, 'XDir','reverse')
    
    yyaxis right;
    isotope_plot = scatter(t,IsotopicValue,'*','r');
    ylabel('δ13C');
    ylim([-35, -10]);
    legend([fire_freequency_plot,isotope_plot], {'Fire freequency' , 'δ13C of Bulk Organic Matter'})
    hold off
    
end