function [] = func_plot_combustion_characteristics(FLU_FLUPYR, ANT_ANTPHE)
    c = linspace(0,length(FLU_FLUPYR),length(FLU_FLUPYR));
    hold on
    figure('Name', 'Combustion characteristics');
    scatter(FLU_FLUPYR, ANT_ANTPHE,[],c);
    xlabel('FLU/(FLU+PYR)');
    ylabel('Anthracene/(Anthracene + Phenantherene)');
    legend('Combustion characteristics');
    hold off
    
    %Temporal combustion characteristics 
    combustion_ratios = ANT_ANTPHE./FLU_FLUPYR;
    
    %Plot temporal combustion characteristics
    
    %{
    t = [length(FLU_FLUPYR):-1:1];
    figure(3);
    hold on;
    scatter(t,combustion_ratios);
    hold off
    %}
    
    
end