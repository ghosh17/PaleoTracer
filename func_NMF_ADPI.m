function [pyr_frac, petro_frac, weathered_frac] = func_NMF_ADPI(site_id, TPh, t, numsamples, sample_name)
    
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


                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%nnmf MLearning%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    W0 = [0.7 0.27 0.02 0.01; 0.05 0.25 0.32 0.38; 0.1 0.25 0.6 0.02];
    if strcmp(site_id,'PP')
        rng_num = 5;
    elseif strcmp(site_id,'LV')
        rng_num = 4;
    elseif strcmp(site_id,'RI')
        rng_num = 2;
    end
    
    rng(rng_num);
    
    opt = statset('MaxIter',500,'TolFun',1e-25,'Tolx',1e-25,'Display','final');
    
    %Append TPh from LV PP
    
    x = [0 1 2 3];
    [H,W,err] = nnmf(TPh,3,'h0',W0,'Options',opt); %problem with code they call w0 h0 for some reason
    err;
    
    
%     figure('Name', 'W')
%     plot(x,W(1,:),x,W(2,:),x,W(3,:))
%     xlabel('Number of methyl groups');
%     ylabel('Fraction of total PHE group concentration');
%     legend('PYR', 'PET','WEATH');
%     xticks([0,1,2,3]);

                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%Area plot%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    figure('Name', 'Normalized abundance of end members')
    
    %Q. How do I know which fraction (W(1:)/H(1:),... etc) corresponds to
    %pyrogenic/petrogenic/weathred?
    %Ans: Have to manually verify for each site. 
    
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
    sample_name_la = sample_name(la);
    pyr_frac_area = pyr_frac(la);
    petro_frac__area = petro_frac(la);
    weathered_frac_area = weathered_frac(la);
    PAH_source_frac_area = [pyr_frac_area, petro_frac__area, weathered_frac_area];
    
    ylim([0, 1]);
    if strcmp(site_id,'PP') || strcmp(site_id,'LV')
        bar( PAH_source_frac_area, 'stacked');
        l1 = legend('PYR', 'PET', 'WX');
    elseif strcmp(site_id,'RI')
        %area(t_area, PAH_source_frac_area);
        bar(PAH_source_frac_area, 'stacked');
        l1 = legend('PYR', 'PET', 'WX');
    end
    set(gca, 'XTickLabel',sample_name_la, 'XTick',1:numel(sample_name_la));
    axis tight;
    set(gca,'FontSize',20);
    l1.FontSize = 18;
    ylabel('Factor abundance (norm)', 'FontSize', 22);
    xlabel('Sample ID', 'FontSize', 22);
    
    %set(gca, 'XDir','reverse');
    
    

    
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%Bar plot%%%%%%%%%%%%%%%%%%%%%%
                    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    figure('Name', 'End member distribution');
    b1 = bar(x,W');
    set(gca,'FontSize',20);
    if strcmp(site_id,'PP') || strcmp(site_id,'LV')
        l2 = legend('PYR','PET','WX');
    elseif strcmp(site_id,'RI')
    	b1(1).FaceColor = [0.9290    0.6940    0.1250];
        b1(2).FaceColor = [0    0.4470    0.7410];
        b1(3).FaceColor = [0.8500    0.3250    0.0980];
        l2 = legend('WX','PYR','PET');
    end
    l2.FontSize = 18;
        
    set(gca,'xticklabel',{'Ph','MPh','DMP', 'TMP'});
    ylabel('Abundance of total Ph', 'FontSize', 22);
    xlabel('Ph homologues', 'FontSize', 22);
    
    print('BarPlot','-dpng');
    
    
    
end