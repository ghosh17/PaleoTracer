function [ADPI_source] = func_plot_adpi(PHE, MPh1, MPh2, MPh3)
    
    x = [1 2 3 4];
    y = [PHE(1) MPh1(1) MPh2(1) MPh3(1)];
   
    figure('Name', 'ADPI');
    
    hold on
    plot(x,y, 'ro');
    hold on
    p2 = polyfit(x,y,2);
    xc = 1 : .1 : 4; 
    y2 = polyval(p2, xc);
    plot(xc, y2, 'g.-')
    
    hold off
    ADPI_source = 0;
    hold off
 
end