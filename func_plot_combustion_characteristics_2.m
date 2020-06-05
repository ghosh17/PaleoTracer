function [] = func_plot_combustion_characteristics_2(IND_INDBgP, BaA_BaACHY)
c = linspace(0,length(IND_INDBgP),length(IND_INDBgP));
hold on;
grid on;    
figure('Name', 'combustion_characteristics_2');
scatter(IND_INDBgP, BaA_BaACHY, [], c);
xlabel('IND/(IND+BgP)');
ylabel('BaA/(BaA+CHY)');
hold off;
    
end