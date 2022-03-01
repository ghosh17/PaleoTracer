function [] = func_vegetation_stratigraphy(SideId, IsotopicValue, ConiferInput, DMP_x, DMP_y, FireInput, Alkane_veg_ratio, ACL, VPD, t, age_XRF, numsamples, age_min, age_max)

    

    figure('Name', 'Consolidated Vegetation Stratigraphy');
    
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
    
    
    subplot(1,5,1);
    
    %Sort time and isotopic value
   %{ 
    sorted_isotopic=sortrows([t' IsotopicValue']);
    t_sorted = sorted_isotopic(:,1);
    IsotopicValue_sorted = sorted_isotopic(:,2);
    %}
    
    [t_sorted, sortIndex] = sort(t);
    IsotopicValue_sorted = IsotopicValue(sortIndex);

    scatter(IsotopicValue_sorted, t_sorted, 'filled');
    set(gca, 'YDir','reverse');
    xmin = min(IsotopicValue_sorted) - 0.6;
    xmax = max(IsotopicValue_sorted) + 0.6;
    xlim([xmin xmax]);
    ylabel('Time (my)', 'FontSize', 22);
    ylim([age_min age_max]); %ylim([y_min y_max]);
    xlabel('δ13C (‰)', 'FontSize', 22);
    
    yt_mid = (y_min + y_max)/2;
    xt = [-31 -17];
    yt = [yt_mid yt_mid];
    str = {'C3' 'C4'};
    h1 = text(xt,yt,str);
    set(h1,'Rotation',90);
    line([-22.3,-22.3],[y_min,y_max]);
    
    
    hold on
    la = ~isnan(IsotopicValue_sorted);
    ap = polyfit(t_sorted(la),IsotopicValue_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    BOM_uncertainity = 0.5;
    
    errBOM = BOM_uncertainity * ones(length(IsotopicValue_sorted),1);
    
    errorbar(IsotopicValue_sorted,t_sorted,errBOM, 'bo', 'horizontal');

    hold on
    
    scatter(IsotopicValue_sorted, t_sorted, 'b', 'filled');
    
    hold off
    
    hold on
    plot(IsotopicValue_sorted(la), t_sorted(la), 'b-');
    hold off
    
    R = corrcoef([IsotopicValue_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;
    
    text(mean(IsotopicValue_sorted(la)),min(t_sorted(la)),num2str(Rsq));
    
    hold off
    
    
    subplot(1,5,2);
   
    
    %Sort time and Retene Conifer input
    [t_sorted, sortIndex] = sort(t);
    ConiferInput_sorted = ConiferInput(sortIndex);
    
    gym_conf_x_min = 0.8*min(ConiferInput_sorted);
    gym_conf_x_max = 1.2*max(ConiferInput_sorted);
    
    scatter(ConiferInput_sorted, t_sorted, 'filled');
    
    %line([0.1,0.1],[y_min,y_max]);
    %line([0.5,0.5],[y_min,y_max]);
    xlim([0 gym_conf_x_max]);
    ylim([age_min age_max]); %ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('Ret/Σ(Pyrogenic PAH)', 'FontSize', 22);
    xt = [0.7*gym_conf_x_max];
    yt = [yt_mid];
    str = {'Increasing Gymnosperm burn input'};
    h2 = text(xt,yt,str);
    set(h2,'Rotation',270);
   
    hold on
    la = ~isnan(ConiferInput_sorted);
    
    ap = polyfit(t_sorted(la),ConiferInput_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    
    plot(ConiferInput_sorted(la), t_sorted(la), 'b-');
    
    R = corrcoef([ConiferInput_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;

    text(mean(ConiferInput_sorted(la)),min(t_sorted(la)),num2str(Rsq))
    
    hold off
    
    
    subplot(1,5,3);
    DMP_y_x_min = 0.8*min(DMP_y);
    DMP_y_x_max = 1.2*max(DMP_y);
    
    %Sort time and DMP_y input
    [t_sorted, sortIndex] = sort(t);
    DMP_y_sorted = DMP_y(sortIndex);
    
    scatter(DMP_y_sorted, t_sorted, 'filled');
    
    set(gca,'xscale','log');
    xticks([0,2,10,20]);
    line([2,2],[y_min,y_max]);
    line([10,10],[y_min,y_max]);
    xlim([0 DMP_y_x_max]);
    ylim([age_min age_max]); %ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('DMP_y', 'FontSize', 22);
    xt = [1 6 11];
    yt = [yt_mid yt_mid yt_mid];
    str = {'Hardwood' 'Grass' 'Softwood'};
    h3 = text(xt,yt,str);
    set(h3,'Rotation',90);
    
    hold on
    la = ~(isnan(DMP_y_sorted)|isinf(DMP_y_sorted));
    %ap = polyfit(t_sorted(la),DMP_y_sorted(la),1);

    %pp = polyval(ap,t_sorted(la));

    %plot(pp,t_sorted(la),'m--');
    
    plot(DMP_y_sorted(la), t_sorted(la), 'b-');
    
    %R = corrcoef([DMP_y_sorted(la)],[t_sorted(la)']);
    
    %Rsq = R(1,2).^2;

    %text(mean(DMP_y_sorted(la)),min(t_sorted(la)),num2str(Rsq))
    
    hold off
    
    subplot(1,5,4);
    DMP_x_x_min = 0.8*min(DMP_x);
    DMP_x_x_max = 1.2*max(DMP_x);
    
    %Sort time and DMP_y input
    [t_sorted, sortIndex] = sort(t);
    DMP_x_sorted = DMP_x(sortIndex);
    
    scatter(DMP_x_sorted, t_sorted, 'filled');
    
    line([2,2],[y_min,y_max]);
    line([10,10],[y_min,y_max]);
    xlim([DMP_x_x_min DMP_x_x_max]);
    ylim([age_min age_max]); %ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('DMP_x', 'FontSize', 22);
    line([0.6,0.6],[y_min,y_max]);
    line([0.8,0.8],[y_min,y_max]);
    line([0.95,0.95],[y_min,y_max]);
    
    xt = [0.4 0.7 0.85 1];
    yt = [yt_mid yt_mid yt_mid yt_mid];
    str = {'Hardwood' 'Mixed' 'Grass' 'Softwood'};
    h4 = text(xt,yt,str);
    set(h4,'Rotation',90);

    hold on
    la = ~(isnan(DMP_x_sorted)|isinf(DMP_x_sorted));
    %ap = polyfit(t_sorted(la),DMP_x_sorted(la),1);

%     pp = polyval(ap,t_sorted(la));

%     plot(pp,t_sorted(la),'m--');
    
    plot(DMP_x_sorted(la), t_sorted(la), 'b-');
    
%     R = corrcoef([DMP_x_sorted(la)],[t_sorted(la)']);
    
%     Rsq = R(1,2).^2;

%     text(mean(DMP_x_sorted(la)),min(t_sorted(la)),num2str(Rsq));
    
    hold off
    
    %{
    subplot(1,6,5);
    Alkane_x_min = 0.8*min(Alkane_veg_ratio);
    Alkane_x_max = 1.2*max(Alkane_veg_ratio);
    
    %Sort time and Alkane input
    [t_sorted, sortIndex] = sort(t);
    Alkane_veg_ratio_sorted = Alkane_veg_ratio(sortIndex);
    
    scatter(Alkane_veg_ratio_sorted, t_sorted, 'filled');
    
    line([2,2],[y_min,y_max]);
    line([10,10],[y_min,y_max]);
    xlim([0 Alkane_x_max]);
    ylim([y_min y_max]);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlabel('C33/(C33+C29)', 'FontSize', 22);
   

    hold on
    la = ~isnan(Alkane_veg_ratio_sorted);
    ap = polyfit(t_sorted(la),Alkane_veg_ratio_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    plot(Alkane_veg_ratio_sorted(la), t_sorted(la), 'b-');
    
    R = corrcoef([Alkane_veg_ratio_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;

    text(mean(Alkane_veg_ratio_sorted(la)),min(t_sorted(la)),num2str(Rsq));
    
    
    hold off
    
    %}
    
    
    s6 = subplot(1,5,5);
    
    %Sort time and Alkane input
    [t_sorted, sortIndex] = sort(t);
    Fire_temp = FireInput(sortIndex);
    FireInput_sorted = log10(FireInput(sortIndex));
    
    scatter(FireInput_sorted, t_sorted, 'filled');
    
    %set(gca,'xscale','log');
    set(gca, 'YDir','reverse', 'YTickLabel',[]);
    xlim([min(FireInput_sorted), max(FireInput_sorted)]);
    ylim([age_min age_max]); %ylim([y_min y_max]);
    xlabel('Pyr. Σ(PAH)/C31', 'FontSize', 22);
    set(gca, 'YDir','reverse', 'YTickLabel',[]);%%comment out when d13C available
    
    hold on
    
    for ii = 1:numsamples
        if FireInput_sorted(ii) == 0
            isZero(ii,1) = 1;
        else 
            isZero(ii,1) = 0;
        end
    end
    
    s6.XTickLabels = cellstr(num2str(round((s6.XTick(:))), '10^{%d}'));
    
    la = ~(isnan(FireInput_sorted)|isinf(FireInput_sorted)|(isZero==1));
    
    %f = fit(FireInput_sorted(la),t_sorted(la),'exp1');
    
    %plot(f, FireInput_sorted(la), t_sorted(la), 'm--');
    
    ap = polyfit(t_sorted(la),FireInput_sorted(la),1);

    pp = polyval(ap,t_sorted(la));

    plot(pp,t_sorted(la),'m--');
    
    plot(FireInput_sorted(la), t_sorted(la), 'b-');
    
    R = corrcoef([FireInput_sorted(la)],[t_sorted(la)']);
    
    Rsq = R(1,2).^2;
    
    text(mean(FireInput_sorted(la)),min(t_sorted(la)),num2str(Rsq))
    
    %ap = polyfit(t(la),FireInput(la),1);%fit (FORM OF EQ, )

    %pp = polyval(ap,t(la));

    %plot(pp,t(la),'-');
    
    
    hold off
    
    %%Save plot file
    %Location to save Plots
    PlotFolder = strcat(pwd,'/Plots/');
    filename = 'Vegetation_fire_stratigraphy.svg';
    %Corner case handling
    %if no Plot folder exists
    if ~exist(PlotFolder, 'dir')
        %create a figure folder
        mkdir(PlotFolder);
    end
    %Save all figures to this folder
    saveas(gcf, fullfile(PlotFolder, filename));

end