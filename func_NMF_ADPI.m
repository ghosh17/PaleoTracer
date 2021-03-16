function [pyr_frac, petro_frac, weathered_frac] = func_NMF_ADPI(site_id,TPh, t, numsamples)
    
    %{
    %%Add end members to TPh to allow ML algorithm to train
   
    %Petrogenic end member
    pet_end = [0.1 0.25 0.6 0.02];
    TPh = [TPh; pet_end];
    
    %Pyrogenic end member
    pyr_end = [0.7 0.3 0.02 0];
    TPh = [TPh; pyr_end];
    
    %Weathered end member
    weath_end = [0.05 0.25 0.3 0.4];
    TPh = [TPh; weath_end];
    %}
    H0 = [0.7 0.27 0.02 0.01; 0.05 0.25 0.32 0.38; 0.1 0.25 0.6 0.02];
    if strcmp(site_id,'PP')
        rng_num = 5;
    elseif strcmp(site_id,'LV')
        rng_num = 4;
    elseif strcmp(site_id,'RI')
        rng_num = 8;
    end
    
    rng(rng_num);
    
    x = [0 1 2 3];
    [H,W,err] = nnmf(TPh,3,'H0',H0);
    err;
    
    
    figure('Name', 'W')
    plot(x,W(1,:),x,W(2,:),x,W(3,:))
    xlabel('Number of methyl groups');
    ylabel('Fraction of total PHE group concentration');
    legend('PYR', 'PET','WEATH');
    xticks([0,1,2,3]);

    figure('Name', 'Normalized abundance of end members')
    
    %Q. How do I know which fraction corresponds to
    %pyrogenic/petrogenic/weathred?
    %Ans: Have to do it manually and verify
    
    if strcmp(site_id,'PP') || strcmp(site_id,'LV')
        pyr_frac = H(:,1) ./ (H(:,1)+ H(:,2)+H(:,3));
        petro_frac = H(:,2) ./ (H(:,1)+ H(:,2)+H(:,3));
        weathered_frac = H(:,3) ./ (H(:,1)+ H(:,2)+H(:,3));
    
    elseif strcmp(site_id,'RI')
        pyr_frac = H(:,2) ./ (H(:,1)+ H(:,2)+H(:,3));
        petro_frac = H(:,3) ./ (H(:,1)+ H(:,2)+H(:,3));
        weathered_frac = H(:,1) ./ (H(:,1)+ H(:,2)+H(:,3));
        
    end
        
    

    
    %%NaN HANDLING
   
    la = ~(isnan(pyr_frac)&isnan(petro_frac)&isnan(weathered_frac));
    %area(t(la), PAH_source_frac(la));
    t_area = t(la);
    pyr_frac_area = pyr_frac(la);
    petro_frac__area = petro_frac(la);
    weathered_frac_area = weathered_frac(la);
    PAH_source_frac_area = [pyr_frac_area, petro_frac__area, weathered_frac_area];
    
    area(t_area, PAH_source_frac_area);
    ylim([0, 1]);
    if strcmp(site_id,'PP') || strcmp(site_id,'LV')
        legend('PYR', 'PET', 'WX');
    elseif strcmp(site_id,'RI')
        legend('WX','PYR','PET');
    end
    axis tight;
    set(gca, 'XDir','reverse');
    
    
    %plot(pyr_frac,t,petro_frac,t,weathered_frac,t,'.-');
    xlabel('Age (Ma)');
    ylabel('Factor abundance (norm)');
    
    
    %%Bar plot
    figure('Name', 'End member distribution');
    bar(x,W');
    if strcmp(site_id,'PP') || strcmp(site_id,'LV')
        legend('PYR','PET','WX');
    elseif strcmp(site_id,'RI')
        legend('WX','PYR','PET');
    end
        
    set(gca,'xticklabel',{'Ph','MPh','DMP', 'TMP'})
    
    print('BarPlot','-dpng');
    
    
    
end