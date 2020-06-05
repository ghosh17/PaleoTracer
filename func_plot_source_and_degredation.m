function [] = func_plot_source_and_degredation(MPh_PHE, FLU_FLUPYR)

    c = linspace(0,length(MPh_PHE),length(MPh_PHE)); 
    hold on;
    grid on;
    figure('Name', 'source_degredation');
    scatter(MPh_PHE, FLU_FLUPYR, [], c);
    hold on;
    plot(1,0);
    plot(0,0.5);
    hold off;
    xlabel('MPh/PHE');
    ylabel('FLU/(FLU+PYR)');
    legend('La Vina paleosol');
    hold off;
    
    %Plot temporal source/degredation plot
    
end