function [] = func_turnplot_alkanes(C_27,C_29,C_31,C_33,C_35,numsamples,t)
    
    C27 = C_27 ./(C_27 + C_29 + C_31);
    
    C29 = C_29 ./(C_27 + C_29 + C_31);
    
    C31 = C_31 ./(C_27 + C_29 + C_31);

    c = linspace(t(1),t(numsamples),length(t));
    hold on;
    figure('Name', 'C27-C29-C31');
    added_path = [pwd,'/ternary2']; %change to: added_path = '/path' for your required path
    addpath(added_path);
    terplot();
    ternaryc(C27, C29, C31, c, 'o');
    terlabel('C27', 'C29', 'C31');
    hold off;
    % Remove path (at end of script/script clean-up)
    rmpath(added_path);
    
    C27 = C_27 ./(C_27 + C_29 + C_33);
    
    C29 = C_29 ./(C_27 + C_29 + C_33);
    
    C33 = C_33 ./(C_27 + C_29 + C_33);
    
    hold on;
    figure('Name', 'C27-C29-C33');
    added_path = [pwd,'/ternary2']; %change to: added_path = '/path' for your required path
    addpath(added_path);
    terplot();
    ternaryc(C27, C29, C33, c, 'o');
    terlabel('C27', 'C29', 'C33');
    hold off;
    % Remove path (at end of script/script clean-up)
    rmpath(added_path);
    
    
    C27 = C_27 ./(C_27 + C_29 + C_35);
    
    C29 = C_29 ./(C_27 + C_29 + C_35);
    
    C35 = C_35 ./(C_27 + C_29 + C_35);
    hold on;
    figure('Name', 'C27-C29-C35');
    added_path = [pwd,'/ternary2']; %change to: added_path = '/path' for your required path
    addpath(added_path);
    terplot();
    ternaryc(C27, C29, C35, c, 'o');
    terlabel('C27', 'C29', 'C35');
    hold off;
    % Remove path (at end of script/script clean-up)
    rmpath(added_path);
    
end
