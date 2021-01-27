function [] = func_plot_confier_input(Gym_Ang_ConiferInput, IsotopicValue, numsamples, t)
   
    grid on;
    %xxaxis left;
    %c = linspace(t(1),t(numsamples),length(t));
    figure('Name', 'Confier/Gym/Ang Input: Retene/3RingSum');
    Gym_Ang_conifer_plot = scatter(Gym_Ang_ConiferInput, t, 'r');
    xlabel('Retene/(Retene + PHE + ANT)');
    ylabel('Time (Ma)');
    set(gca, 'YDir','reverse');
    
    %{
    xxaxis right;
    isotope_plot = scatter(IsotopicValue, t,'*','r');
    ylabel('δ13C (‰)');
    ylim([-35, -10]);
    legend([Gym_Ang_conifer_plot,isotope_plot], {'Conifer/Gymnosperm/Angiosperm fire input' , 'δ13C of Bulk Organic Matter'})
    
    %}
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Gym_Ang_Confier_input.jpg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));
    
end