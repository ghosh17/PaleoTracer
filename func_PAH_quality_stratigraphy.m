function [] = func_PAH_quality_stratigraphy(siteId, ADPI_pyro_petro_index, MPh_Ph, petro_PAH, weathered_PAH, LMW, t, age_XRF, numsamples)

    

    f1 = figure('Name', 'Consolidated PAH quality Stratigraphy');
    
    grid on;
    t_min = min(t);
    t_max = max(t);
    y_max_1 = t_max - 0.05*(t_min-t_max);
    y_min_1 = t_min + 0.05*(t_min-t_max);
    
    t_XRF_min = min(age_XRF);
    t_XRF_max = max(age_XRF);
    
    y_max_2 = t_XRF_max - 0.05*(t_XRF_min-t_XRF_max);
    y_min_2 = t_XRF_min + 0.05*(t_XRF_min-t_XRF_max);
    
    if(y_max_1 > y_max_2)
        y_max = y_max_1;
    else
        y_max = y_max_2;
    end
    
    if(y_min_1 < y_min_2)
        y_min = y_min_1;
    else
        y_min = y_min_2;
    end
    
    %%%%%%%%%%%%%%%%%%
    subplot(1,5,1);
    
    %sort data
    [t_sorted, sortIndex] = sort(t);
    ADPI_pyro_petro_index_sorted = ADPI_pyro_petro_index(sortIndex);
    
    hold on
    la = ~(isnan(ADPI_pyro_petro_index_sorted)|isinf(ADPI_pyro_petro_index_sorted)|not(ADPI_pyro_petro_index_sorted));
    
    plot(ADPI_pyro_petro_index_sorted(la), t_sorted(la), 'b-');
    
    scatter(ADPI_pyro_petro_index_sorted(la), t_sorted(la), 'filled', 'bo');
    
    hold off
    
    
    set(gca, 'YDir','reverse');
    ylabel('Time (my)', 'FontSize', 22);
    ylim([y_min y_max]);
    
    xt_ADPI_mid = (min(ADPI_pyro_petro_index_sorted)+max(ADPI_pyro_petro_index_sorted))/2;
    xlim([1.1*min(ADPI_pyro_petro_index_sorted), 1.1*max(ADPI_pyro_petro_index_sorted)]);
    xlabel('ADPI', 'FontSize', 22);
    line([0,0],[y_min,y_max]);
    
    yt_mid = (y_min + y_max)/2;
    set(gca, 'XDir','reverse');
    
    xt = [(min(ADPI_pyro_petro_index_sorted)/2) (max(ADPI_pyro_petro_index_sorted)/2)];
    yt = [yt_mid yt_mid];
    str = {'Petrogenic' 'Pyrogenic'};
    h1 = text(xt,yt,str);
    set(h1,'Rotation',90);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%
    subplot(1,5,2);
    
    %sort data
    [t_sorted, sortIndex] = sort(t);
    MPh_Ph_sorted = MPh_Ph(sortIndex);
    
    scatter(MPh_Ph_sorted, t_sorted, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    ylim([y_min y_max]);
    xlim([0, 1.1*max(MPh_Ph)]);
    xlabel('MPh/Ph', 'FontSize', 22);
    line([2.43,2.43],[y_min,y_max]);
    
    yt_mid = (y_min + y_max)/2;

    xt = [1 3.5];
    yt = [yt_mid yt_mid];
    str = {'Pyrogenic' 'Petrogenic'};
    h2 = text(xt,yt,str);
    set(h2,'Rotation',90);
    
    hold on
    la = ~isnan(MPh_Ph_sorted);
    
    plot(MPh_Ph_sorted(la), t_sorted(la), 'b-');
    
    hold off
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    s3 = subplot(1,5,3);
    
    %Sort time and Petrogenic PAH
    [t_sorted, sortIndex] = sort(t);
    petro_PAH_sorted = log10(petro_PAH(sortIndex));
    
    scatter(petro_PAH_sorted, t_sorted, 'filled');
    %set(gca,'xscale','log');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([min(petro_PAH_sorted), max(petro_PAH_sorted)]);
    ylim([y_min y_max]);
    xlabel('Pet. Σ(PAH)/C31', 'FontSize', 22);
    %xticks([0.001,0.01,0.1,1]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);%%comment out when d13C available
    
    hold on
    
    for ii = 1:numsamples
        if petro_PAH_sorted(ii) == 0
            isZero(ii,1) = 1;
        else 
            isZero(ii,1) = 0;
        end
    end
    
    s3.XTickLabels = cellstr(num2str(round((s3.XTick(:))), '10^{%d}'));

    la = ~(isnan(petro_PAH_sorted)|isinf(petro_PAH_sorted)|(isZero==1));
    
    %ap = fit(t_sorted(la),petro_PAH_sorted(la),'exp1')
    ap = polyfit(t_sorted(la),petro_PAH_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    plot(petro_PAH_sorted(la), t_sorted(la), 'b-');
    
    R = corrcoef([petro_PAH_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;

    text(mean(petro_PAH_sorted(la)),min(t_sorted(la)),num2str(Rsq))
    
    hold off
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    s4 = subplot(1,5,4);
    
    %Sort time and Petrogenic PAH
    [t_sorted, sortIndex] = sort(t);
    weathered_PAH_sorted = log10(weathered_PAH(sortIndex));
    
    scatter(weathered_PAH_sorted, t_sorted, 'filled');
    %set(gca,'xscale','log');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([min(weathered_PAH_sorted) max(weathered_PAH_sorted)]);
    ylim([y_min y_max]);
    xlabel('Weath. Σ(PAH)/C31', 'FontSize', 22);
    %xticks([0.001,0.01,0.1,1]);
    %set(gca, 'YDir','reverse', 'YTickLabel',[]);%%comment out when d13C available
    
    hold on
    
    %xticks([-2,-1,0,1]);
    
    s4.XTickLabels = cellstr(num2str(round((s4.XTick(:))), '10^{%d}'));

    
    for ii = 1:numsamples
        if weathered_PAH_sorted(ii) == 0
            isZero(ii,1) = 1;
        else 
            isZero(ii,1) = 0;
        end
    end
    la = ~(isnan(weathered_PAH_sorted)|isinf(weathered_PAH_sorted)|(isZero==1));
    ap = polyfit(t_sorted(la),weathered_PAH_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    plot(weathered_PAH_sorted(la), t_sorted(la), 'b-');
    
    R = corrcoef([weathered_PAH_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;

    text(mean(weathered_PAH_sorted(la)),min(t_sorted(la)),num2str(Rsq))
    
    %s4.XTickLabel = [{'10^{-2}'} {'10^{-1}'} {'10^{0}'} {'10^{1}'}];
    
    hold off
    
    subplot(1,5,5);
    
    %sort data
    [t_sorted, sortIndex] = sort(t);
    LMW_sorted = LMW(sortIndex);
    
    scatter(LMW_sorted, t_sorted, 'filled');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([0, 1]);
    ylim([y_min y_max]);
    xlabel('LMW', 'FontSize', 22);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xt = [0.7 0.9];
    yt = [yt_mid yt_mid];
    str = {'In-place residue' 'Smoke'};
    h2 = text(xt,yt,str);
    set(h2,'Rotation',90);
    line([0.75,0.75],[y_min,y_max]);
    
    hold on
    la = ~isnan(LMW_sorted);
    
    plot(LMW_sorted(la), t_sorted(la), 'b-');
    
    hold off
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'PAH_quality_stratigraphy.svg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));

end