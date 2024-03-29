%%Author: Adit Ghosh
%%Email: aditghosh94@gmail.com or adit.ghosh.605@my.csun.edu
%%Github: github.com/ghosh17
%%California State University, Northridge
%%Website: https://geoecology.wixsite.com/aditghosh

%{

#######

Description:
This program is intended to help visualize trends and automate the processing of Carbon 
Isotopic ratios and molecular biomarkers like lipid biomarkers (wax n-alkanes) 
and Poly Aromatic Hyrocarbons (PAH) from Bulk Organic Matter(BOM) 
sampled from dated paleosol outcrops or sediment cores. 
The ultimate goal is to discern patterns in terrestrial paleoecology, 
paleofire regimes and paleoclimatology.
 
Input arguments:
XX_Biomarkers_experiment_parameters.xlsx
XX_Raw_data.xlsx
XX_isotopic_ratio.xlsx

Where XX is a alias for site name. This alias can be changed in 
this program by changing the variable for 'siteID'.


Output(s):
15 separate plots in foleder Plots located in pwd/Plots.


Version: 0.99

#######

%}


%%Main file

%%Clear memory

clear all
close all
clf


siteId = 'RI';

%%Remove figure folder (output folder) if it exists
PlotFolder = strcat(pwd,'/Plots');
if exist(PlotFolder, 'dir')
    rmdir(PlotFolder, 's');
end

%%Reading Excel

%Read experiment parameter files

%This read experiment parameters v_tot, v_spe, RV, Mass
experiment_parameter_file = strcat(siteId,'_Biomarkers_experiment_parameters');
[num_exp_parameter, ~, data_exp_para_all] = xlsread(experiment_parameter_file);

%Read biomarkers experiment data

file_name = strcat(siteId,'_Raw_data.xlsx');
[~, ~, data_all] = xlsread(file_name);


%%%%%%%%%%%%%%%%%
%Read D13C isotopic signature for bulk organic carbon

isotopic_ratio_file = strcat(siteId,'_isotopic_ratio.xlsx');
[~, ~, isotopic_data_all] = xlsread(isotopic_ratio_file); 
%Null handling in isotopic values
[~, ~, isotopic_value_temp] = xlsread(isotopic_ratio_file,'B:B');
isotopic_value = str2double(string(isotopic_value_temp));

%%%%%%%%%%%%%%%%%%%
%Read Bulk Geochemistry XRF data
xrf_file = strcat(siteId,'_XRF.xlsx');
[~, ~, xrf_all] = xlsread(xrf_file); 


%%Initializations

%Initialization of variables
j = 1;
i = 1;
[row,col] = size(data_all); % This is the size of the HP gas chromatograph output file
numsamples = col/6; 
sample_name = strings(numsamples); %Initializing sample name matrix
sample_run = 1; 
run_samples = zeros(numsamples,1); %Initializing sample matrix
t = zeros(numsamples,1); %Initializing time matrix


%Initializing n-alkanes concentrations
C_20 = zeros(numsamples,1); % n-alkane C20
C_21 = zeros(numsamples,1); % n-alkane C21
C_22 = zeros(numsamples,1); % n-alkane C22
C_23 = zeros(numsamples,1); % n-alkane C23
C_24 = zeros(numsamples,1); % n-alkane C24
C_25 = zeros(numsamples,1); % n-alkane C25
C_26 = zeros(numsamples,1); % n-alkane C26
C_27 = zeros(numsamples,1); % n-alkane C27
C_28 = zeros(numsamples,1); % n-alkane C28
C_29 = zeros(numsamples,1); % n-alkane C29
C_30 = zeros(numsamples,1); % n-alkane C30
C_31 = zeros(numsamples,1); % n-alkane C31
C_32 = zeros(numsamples,1); % n-alkane C32
C_33 = zeros(numsamples,1); % n-alkane C33
C_34 = zeros(numsamples,1); % n-alkane C34
C_35 = zeros(numsamples,1); % n-alkane C35
C_36 = zeros(numsamples,1); % n-alkane C36
C_37 = zeros(numsamples,1); % n-alkane C37
C_38 = zeros(numsamples,1); % n-alkane C38


%Initialize PAH concentrations
ACE = zeros(numsamples,1); %
ACY = zeros(numsamples,1); %
ANT = zeros(numsamples,1); %Anthracene
BaA = zeros(numsamples,1); %Benzo[a]anthracene
BeA = zeros(numsamples,1); %Benzo[e]anthracene
BaP = zeros(numsamples,1); %Benzo[a]pyrene
BeP = zeros(numsamples,1); %Benzo[e]pyrene
BbF = zeros(numsamples,1); %Benzo[b]fluoranthrene
BgP = zeros(numsamples,1); %Benzo[g]perylene
BkF = zeros(numsamples,1); %Benzo[k]fluoranthrene
CHY = zeros(numsamples,1); %Chrysene
DaA = zeros(numsamples,1); %Dibenz[a]anthracene
FLU = zeros(numsamples,1); %Fluoranthrene
FLE = zeros(numsamples,1); %
IND = zeros(numsamples,1); %indeno[1,2,3-cd]pyrene
C1_MPh1 = zeros(numsamples,1);
C1_MPh2 = zeros(numsamples,1);
C1_MPh3 = zeros(numsamples,1);
C1_MPh4 = zeros(numsamples,1);
C1_MPh5 = zeros(numsamples,1);
C2_MPh1 = zeros(numsamples,1);
C2_MPh3 = zeros(numsamples,1);
C2_MPh4 = zeros(numsamples,1);
C2_MPh5 = zeros(numsamples,1);
C2_MPh6B = zeros(numsamples,1);
C2_MPh6D = zeros(numsamples,1);
C3_MPh1 = zeros(numsamples,1);
C3_MPh2 = zeros(numsamples,1);
C3_MPh3 = zeros(numsamples,1);
C3_MPh4 = zeros(numsamples,1);
C3_MPh5 = zeros(numsamples,1);
C3_MPh6 = zeros(numsamples,1);
C3_MPh7 = zeros(numsamples,1);
DMP_1_7 = zeros(numsamples,1);%C2 methylated PAH
DMP_2_6_DMP_3_5 = zeros(numsamples,1);%C2 Methylated PAH
DMP_1_2 = zeros(numsamples,1);%C2 Methylated PAH
MPh = zeros(numsamples,1); %C1 Methyl Phenantherene
NAP = zeros(numsamples,1); %Naphthelene 
PHE = zeros(numsamples,1); %Phenanthrene
PYR = zeros(numsamples,1); %Pyrene
Retene = zeros(numsamples,1); %Retene




%%Calculate concentrations

while j < col
    while (i < row)
            if (i == 1)
                s1 = string(data_all(i,j));
                sample_name (sample_run) = s1;
            end
            
          
            bio_extract = num_exp_parameter(sample_run, 1);
            
            bulk_extract = num_exp_parameter(sample_run, 2);
            
            Mass_net = num_exp_parameter(sample_run, 3);
            
            conversion_factor = (bio_extract + bulk_extract)/ Mass_net;
            
            
            
            %%Convert to  concentration within sample
            
            %n-Alkanes 
            
            if (strcmp(data_all(i,j),'C20'))
                C_20(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C21'))
                C_21(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C22'))
                C_22(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C23'))
                C_23(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C24'))
                C_24(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C25'))
                C_25(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C26'))
                C_26(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C27'))
                C_27(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C28'))
                C_28(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
           
            
            if (strcmp(data_all(i,j),'C29'))
                C_29(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C30'))
                C_30(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C31'))
                C_31(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C32'))
                C_32(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C33'))
                C_33(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C34'))
                C_34(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C35'))
                C_35(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C36'))
                C_36(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C37'))
                C_37(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C38'))
                C_38(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            %Poly Aromatic Hydrocarbon
            
            if (strcmp(data_all(i,j),'ACE'))
                ACE(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            
            if (strcmp(data_all(i,j),'ANT'))
                ANT(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'ACY'))
                ACY(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BaA'))
                BaA(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
                      
            if (strcmp(data_all(i,j),'BeA'))
                BaP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BaP'))
                BaP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BeP'))
                BeP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BbF'))
                BbF(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BgP'))
                BgP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'BkF'))
                BkF(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
         
            if (strcmp(data_all(i,j),'CHY'))
                CHY(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
           if (strcmp(data_all(i,j),'DaA'))
                DaA(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'FLE'))
                FLE(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'FLU'))
                FLU(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'IND'))
                IND(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'NAP'))
                NAP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'PHE'))
                PHE(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C1-PHE1 (3-MP)'))
                C1_MPh1(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C1-PHE2 (2-MP)'))
                C1_MPh2(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C1-PHE3'))
                C1_MPh3(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C1-PHE4 (9-MP)'))
                C1_MPh4(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
    
            if (strcmp(data_all(i,j),'C1-PHE5 (1-MP)'))
                C1_MPh5(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE1 (9-/2-/1-EP+3,6-DMP)'))
                C2_MPh1(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE3 (2,7-DMP)'))
                C2_MPh3(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE4 (1,3-/3,9-/2,10-/3,10-DMP)'))
                C2_MPh4(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE5 (2,5-/2,9-/1,6-DMP)'))
                C2_MPh5(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE6B (2,3-DMP)'))
                C2_MPh6B(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE6d (1,8-DMP)'))
                C2_MPh6D(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE1 (1,3,6-/1,3,10-/2,6,10-TMP)'))
                C3_MPh1(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE2 (1,3,7/2,6,9,2,7,9-TMP)'))
                C3_MPh2(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE3 (1,3,9/2,3,6-TMP)'))
                C3_MPh3(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE4 (1,6,9/1,7,9/2,3,7-TMP)'))
                C3_MPh4(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
           
            if (strcmp(data_all(i,j),'C3-PHE5 (1,3,8/2,3,10-TMP)'))
                C3_MPh5(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE6 (1,6,7-TMP)'))
                C3_MPh6(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C3-PHE7 (1,2,6-TMP)'))
                C3_MPh7(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            %%%%
            
            if (strcmp(data_all(i,j),'C2-PHE6 (1,7-DMP)'))
                DMP_1_7(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE2 (3,5/2,6-DMP)'))
                DMP_2_6_DMP_3_5(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'C2-PHE7 (1,2-DMP)'))
                DMP_1_2(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
           
            if (strcmp(data_all(i,j),'PYR'))
                PYR(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            if (strcmp(data_all(i,j),'RETENE'))
                Retene(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
            end
            
            
           i = i + 1;
    end
    sample_run = sample_run + 1;
    i = 1; %resest row counter
    j = j+6; %update column counter
 
end

%%Age determination


[Age_matrix,age_array,Sample_name_array] = func_age(siteId);

for ind = 1:numsamples
    temp_extract  = regexp(sample_name(ind), '\d+', 'match');
    run_samples(ind) = str2double(temp_extract);
end 

for ind = 1:length(run_samples)
    
    t(ind) = age_array(run_samples(ind));
end

age_min = min(age_array);
age_max = max(age_array);

%%Isotopic signature

%{
func_plot_isotopic_ratio(t, numsamples, isotopic_value);

%}

%%Alkanes

alkanes_matrix = [C_20, C_21, C_22, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38];

[ACL, CPI, C31_by_C29, Sum_odd_alkanes, Sum_even_alkanes] = func_alkanes(C_20, C_21, C_22, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38);

VPD = 1.3125 - sqrt(14.1208 - 0.4629*ACL);

Alkane_veg_ratio = C_33./(C_33+C_29);

%Function to plot ternary plot for C31,C29,C27;C33,C29,C27;C35,C29,C27; Bush,
%McInerney, et.al
%Color per isotopic ratio. I want to be able to visualize how C3/C4
%corresponds to aridity.
%{
func_turnplot_alkanes(C_27,C_29,C_31,C_33,C_35,numsamples,t);

%Function to plot ACL&d13C vs t; CPI&d13C vs t; C31_by_C29&d13C vs t;
%OddAlkanes&d13C vs t; EvenAlkanes&d13C vs t;





func_plot_ACL_VPD_CPI_C31C29(ACL, VPD, CPI,C31_by_C29,isotopic_value,numsamples,t);

%}

%{

Sum_odd = C_21 + C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35 + C_37;
Sum_even =  C_22 + C_24 + C_26 + C_28 + C_30 + C_32 + C_34 + C_36;


%ACL: Bush and McInerney
ACL = (21 .* C_21 + 23 .* C_23 + 25 .* C_25 + 27 .* C_27 + 29 .* C_29 + 31 .* C_31 + 33 .* C_33 + 35 .* C_35 + 37 .* C_37)./Sum_odd;
%CPI: Marzi et. al
CPI =((C_21 + C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35) + (C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35 + C_37) ) ./ (2 * Sum_even);
%ACL, CPI, C31_by_C29, Sum_odd, Sum_even = Alkanes_func(alkanes_matrix);
C31_by_C29 = C_31./C_29;

 %}

%%PAH

MPh1 = C1_MPh1 + C1_MPh2 + C1_MPh3 + C1_MPh4 + C1_MPh5; 
MPh2 = C2_MPh1 + DMP_2_6_DMP_3_5 + C2_MPh3 + C2_MPh4 + C2_MPh5 + DMP_1_7 + C2_MPh6B + C2_MPh6D + DMP_1_2;
MPh3 = C3_MPh1 + C3_MPh2 + C3_MPh3 + C3_MPh4 + C3_MPh5 + C3_MPh6 + C3_MPh7;
MPh = MPh1; %+ MPh2 + MPh3;
MTPh = MPh1 + MPh2 + MPh3;

TotalPAH = (MTPh + PHE + ANT + FLU + PYR + BaA + CHY + BkF + BeP + BeA + BaP + IND + BgP); % Karp et. al 2020 


%%%%%%%%%%%%
[ADPI_source, ADPI_pyro_petro_index, isADPIpyrogenic, TPh] = func_plot_adpi(PHE, MPh1, MPh2, MPh3, numsamples);

[pyr_frac, petro_frac, weathered_frac] = func_NMF_ADPI(siteId, TPh, t, numsamples, sample_name);

pyr_PAH = pyr_frac .* TotalPAH;

petro_PAH = petro_frac .* TotalPAH;

petro_PAH_normalized = petro_PAH./C_31;

weathered_PAH = weathered_frac .* TotalPAH;

weathered_PAH_normalized = weathered_PAH./C_31;
%%%%%%%%%%%%

PAH_matrix  = [ACY, ANT, BaA, CHY, FLU, IND, PHE, PYR];

FLU_FLUPYR = FLU ./ (FLU + PYR);

MPh_PHE = MPh ./ PHE;

ANT_ANTPHE = ANT ./ (ANT + PHE);

IND_INDBgP = IND ./ (IND + BgP);

BaA_BaACHY = BaA ./ (BaA + CHY);

Sum3Ring = ANT + PHE + Retene; %sum of 3 ring PAH

PAHSourceChange = Sum3Ring ./pyr_PAH;

FireInput = pyr_PAH ./C_31;

ConiferInput_retene = Retene ./ pyr_PAH; %Ghosh, Hauswirth, Cotton Retene proxy definition  %Retene./Sum3Ring; % Karp et al., 2020; Karp et al., 2018 => Retene./(Sum3Ring)

GrassInput_pyrene = PYR ./ Sum3Ring;

LMW = (PHE + ANT + FLU + PYR) ./ TotalPAH;

DMP_y = DMP_1_7 ./ DMP_1_2;

DMP_x = (DMP_1_7 + DMP_2_6_DMP_3_5) ./ (DMP_1_7 + DMP_2_6_DMP_3_5 + DMP_1_2);

MPh_Ph = MPh./PHE;

%func_plot_source_degredation_MPhPHE_FLUPYR(MPh_PHE, FLU_FLUPYR, t);

%func_plot_FLU_FLUPYR_temporal(FLU_FLUPYR, isotopic_value, numsamples, t);

%func_plot_combustion_characteristics_FLUPYR_ANTPHE(FLU_FLUPYR, ANT_ANTPHE);

%func_plot_combustion_characteristics_INDBgPBaACHY(IND_INDBgP, BaA_BaACHY);

%func_plot_fire_input(FireInput, isotopic_value, numsamples, t);

%func_plot_PAH_source_change(PAHSourceChange, isotopic_value, numsamples, t);

%func_plot_confier_input(ConiferInput_retene, isotopic_value, numsamples, t);
%}


%func_plot_methyl_PHE_veg_proxy(DMP_x, DMP_y, numsamples, t);

func_plot_PAH_C_Isotope(FireInput, isotopic_value, numsamples, t);

func_plot_conifer_fire(ConiferInput_retene, DMP_y, FireInput, numsamples, t); 

%func_plot_grass_fire(GrassInput_pyrene, FireInput, numsamples, t);

%func_plot_grass_vs_conifer(ConiferInput_retene, GrassInput_pyrene, numsamples, t);

%func_plot_LMW(LMW, isotopic_value, numsamples, t);

[MAP, MAP_PPM, MAP_PPM_MIN, MAP_PPM_MAX, MAT_Sal, MAT_PPM, MAT_PPM_MIN, MAT_PPM_MAX, MAT_PWI, age_XRF, age_PPM] = func_plot_XRF(siteId);

func_PAH_quality_stratigraphy(siteId, ADPI_pyro_petro_index, MPh_Ph, petro_PAH_normalized, weathered_PAH_normalized, LMW, t, age_XRF, numsamples);

func_vegetation_stratigraphy(siteId, isotopic_value, ConiferInput_retene, DMP_x, DMP_y, FireInput, Alkane_veg_ratio, ACL, VPD, t, age_XRF, numsamples, age_min, age_max);

func_climate_stratigraphy(siteId, isotopic_value, ConiferInput_retene, FireInput, MAP, MAT_Sal, MAT_PWI, ACL, VPD, t, age_XRF, numsamples);

func_PPM_climate_stratigraphy(siteId, MAP_PPM, MAP_PPM_MIN, MAP_PPM_MAX, MAT_PPM, MAT_PPM_MIN, MAT_PPM_MAX, t, age_PPM, numsamples);




