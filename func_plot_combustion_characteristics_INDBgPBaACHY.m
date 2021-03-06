function [] = func_plot_combustion_characteristics_INDBgPBaACHY(IND_INDBgP, BaA_BaACHY)
c = linspace(0,length(IND_INDBgP),length(IND_INDBgP));
hold on;
grid on;    
figure('Name', 'Combustion_characteristics_INDBgPBaACHY');
scatter(IND_INDBgP, BaA_BaACHY, [], c);
xlabel('IND/(IND+BgP)');
ylabel('BaA/(BaA+CHY)');
line([0.2,0.2],[0,1]);
line([0.5,0.5],[0,1]);
line([0,1],[0.2,0.2]);
line([0,1],[0.35,0.35]);

%%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Combustion_characteristics_INDBgPBaACHY';
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