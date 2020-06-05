%%Calculate Ages for paleosol outcrops assuming constant sedimentation rate

%%Palo Pintado
function [return_matrix,return_ages,return_Sample_name] = func_age(site_id)

if strcmp(site_id,'PP') || strcmp(site_id,'all')
    Stratigraphic_height = [2,2,10,10,12,12,25,25,47.5,47.5,54.5,54.5,60,60,60,66.5,66.5,90.5,90.5,120,120,158,158,164,164,185,185,210,210,232.5,232.5,290,290,290,338,338,401,401,401,461.5,461.5,460,929,929,952,952,1008,1008,1030,1030,1067.5,1067.5,1067.5,1104,1104,1140.5,1140.5,1204.5,1204.5,1244,1244,1244,1293,1293,1338,1338,512,512,529.5,529.5,557,557,592,592,630,630,672.5,672.5,744,744,744,831,831,872,872,1367,1367,1367,1422,1422,1432,1432,1432,1480.5,1480.5,1535,1535,1577,1577,1577,1599,1599,1599,1641,1641,1641,1735,1735,1735,1751,1751];

    PP = [1:1:length(Stratigraphic_height)];

    Palo_pintado_constant = 'PP_';

    for i=1:length(Stratigraphic_height)
        PP_Sample_name(i) = Palo_pintado_constant + string(PP(i));
        return_Sample_name(i) = PP_Sample_name(i);
    end
    

    % We know two ash layers in this section, one at 7.24Ma at 8m in our column
    % and 5.98Ma at 1730m in our column. Assuming constant sedimentation rate,
    % this implies, an increase in age of 7.317e-4 Ma
    % per m increase in section. 


    PP_ages = 7.24 - ((1.26/1722) * (Stratigraphic_height - 8));%Ma
    return_ages = PP_ages;
    for j=1:2
        for k=1:length(Stratigraphic_height)
            if j == 1
                Palo_pintado_matrix(j,k) = PP_Sample_name(k);
            else
                Palo_pintado_matrix(j,k) = PP_ages(k);
            end
        end
    end

    %assign to return variable
    
    for j=1:2
        for k=1:length(Stratigraphic_height)
            return_matrix(j,k) = Palo_pintado_matrix(j,k);
        end
    end
    
    %test loop
    for j=1:2
        for k=1:length(Stratigraphic_height)
            if j == 1
                Palo_pintado_test(j,k) = PP_Sample_name(k);
            else
                Palo_pintado_test(j,k) = Stratigraphic_height(k);
            end
        end
    end
    
    
end

%%La Vina

if strcmp(site_id,'LV') || strcmp(site_id,'all')

    Stratigraphic_height = [0,0,0,6.5,6.5,6.5,9.5,9.5,9.5,9.5,9.5,14.5,14.5,29.5,29.5,46,62,62,75,75,82.5,82.5,82.5,88,88,92,92,98,98,104,104,113,113,122.5,122.5,129,129,129,155,155,250+3,250+3,250+8,250+8,250+18,250+18,250+95,250+95,250+107.5,250+107.5,missing,250+172,250+172,250+172,250+175,250+175,250+180,250+180,250+185,250+185,250+188,250+188,250+192.5,250+192.5,250+220,250+220,250+220,250+223,250+223,250+250+104.5,250+250+142];
    
    LV = [1:1:length(Stratigraphic_height)];

    La_vina_constant = 'LV_';

    for i=1:length(Stratigraphic_height)
        LV_Sample_name(i) = La_vina_constant + string(LV(i));
        return_Sample_name(i) = LV_Sample_name(i);
    end


    % 1. We know the Guanaco Formation has been dated at 8.73 ± 0.25 Ma by K/Ar on biotite from an ash (Del Papa et al ., 1993).
    % Therefore, ash A5 is 8.73 Ma ± 0.25 Ma by K/Ar as this is the only
    % ash layer in the identified stratigraphy. @161 of Guanaco =
    % 161 + 250(of Jesus Maria)
    % 2. A4 is LVT‐006 identified in Carrapa et. al, becasue it lies
    % somewhat midsection and overlayen by crossbedded sand stone. @129m
    %
    % This makes sense, if we assume uniform deposition; our time inteval of
    % transition (7.48 Ma-4.8 Ma) between Guanoco and the Piquete formation and the end member in the 
    % Piquete formation (4.8 Ma,4 Ma) correspond to expected ages.
    % Therefore, identified ash layer A4 must be the paleosol identified by
    % Carrera et. al

    LV_ages = 14.4 - ((14.4 - 8.73) / ((161+250)-129.5)*(Stratigraphic_height-129.5));%Ma
    return_ages = LV_ages;
    
    
    for j=1:2
        for k=1:length(Stratigraphic_height)
            if j == 1
                La_vina_matrix(j,k) = LV_Sample_name(k);
            else
                La_vina_matrix(j,k) = LV_ages(k);
            end
        end
    end

    %assign to return variable
    
    for j=1:2
        for k=1:length(Stratigraphic_height)
            return_matrix(j,k) = La_vina_matrix(j,k);
        end
    end
    
    %test loop
    for j=1:2
        for k=1:length(Stratigraphic_height)
            if j == 1
                La_vina_test(j,k) = LV_Sample_name(k);
            else
                La_vina_test(j,k) = Stratigraphic_height(k);
            end
        end
    end
end

