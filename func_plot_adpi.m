function [ADPI_source, ADPI_pyro_petro_index, isADPIpyrogenic, TPh] = func_plot_adpi(PHE, MPh1, MPh2, MPh3, numsamples)
    
    for ii = 1:numsamples
        x = [0 1 2 3];
        y = [PHE(ii) MPh1(ii) MPh2(ii) MPh3(ii)];

        %figure('Name', 'ADPI');

        %Handling empty
        if ((PHE(ii) == 0)&&(MPh1(ii) == 0)&&(MPh2(ii) == 0)&&(MPh3(ii) == 0))
            %{
            ADPI_pyro_petro_index = NaN;
            ADPI_source = NaN;
            isADPIpyrogenic = NaN;
            TPh = NaN;
            %}
            ADPI_pyro_petro_index (ii) = Inf;%Why should this be Inf and not NaN??
            isADPIpyrogenic(ii) = NaN;
            TPh (ii,1) = PHE(ii); 
            TPh (ii,2) = MPh1(ii); 
            TPh (ii,3) = MPh2(ii);
            TPh (ii,4) = MPh3(ii);
            continue;
            
        end

        hold on
        %plot(x,y, 'ro');
        hold on
        p2 = polyfit(x,y,2);
        xc = 1 : .1 : 4; 
        [y2] = polyval(p2, xc);

        %plot(xc, y2, 'g.-');
        hold off

        hold off
        TPh (ii,1) = PHE(ii); 
        TPh (ii,2) = MPh1(ii); 
        TPh (ii,3) = MPh2(ii);
        TPh (ii,4) = MPh3(ii);
        
        ADPI_source(ii,:) = [p2];
        
        a = ADPI_source(ii,1);
        
        b = ADPI_source(ii,2);
        
        c = ADPI_source(ii,3);
        
        ADPI_pyro_petro_index(ii,1) = 2*a - (4*a + b); %if >0 pyrogenic
        
        if (ADPI_pyro_petro_index(ii,1)>0)
            isADPIpyrogenic(ii) = 1;
        else
            isADPIpyrogenic(ii) = 0;
        end
    end
    
    
 
end