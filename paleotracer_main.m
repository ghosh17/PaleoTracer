%%Author: Adit Ghosh
%%Email: aditghosh94@gmail.com or adit.ghosh.605@my.csun.edu
%github: github.com/ghosh17
%California State University, Northridge

%{

#######

Description:
 
Input arguments:

Output(s):

Version: 0.1

#######

%}


%%Main file

%%Clear memory

clear all
close all
clf


siteId = 'PP';

%%Reading Excel

%Read experiment parameter files

%This read experiment parameters v_tot, v_spe, RV, Mass
experiment_parameter_file = strcat(siteId,'_Biomarkers_experiment_parameters');
[num_exp_parameter, ~, data_exp_para_all] = xlsread(experiment_parameter_file);

%Read biomarkers experiment data

file_name = strcat(siteId,'_Raw_data.xlsx');
[~, ~, data_all] = xlsread(file_name);

%Read D13C isotopic signature for bulk organic carbon

isotopic_ratio_file = strcat(siteId,'_isotopic_ratio.xlsx');
[~, ~, isotopic_data_all] = xlsread(isotopic_ratio_file); 
%Null handling in isotopic values
[~, ~, isotopic_value_temp] = xlsread(isotopic_ratio_file,'B:B');
isotopic_value = str2double(string(isotopic_value_temp));


%%Initializations

%Initialization of variables
j = 1;
i = 1;
[row,col] = size(data_all);
numsamples = col/6;
sample_name = strings(numsamples);
sample_run = 1;
run_samples = zeros(numsamples,1);
t = zeros(numsamples,1);


%Initializing alkanes concentrations
C_20 = zeros(numsamples,1);
C_21 = zeros(numsamples,1);
C_22 = zeros(numsamples,1);
C_23 = zeros(numsamples,1);
C_24 = zeros(numsamples,1);
C_25 = zeros(numsamples,1);
C_26 = zeros(numsamples,1);
C_27 = zeros(numsamples,1);
C_28 = zeros(numsamples,1);
C_29 = zeros(numsamples,1);
C_30 = zeros(numsamples,1);
C_31 = zeros(numsamples,1);
C_32 = zeros(numsamples,1);
C_33 = zeros(numsamples,1);
C_34 = zeros(numsamples,1);
C_35 = zeros(numsamples,1);
C_36 = zeros(numsamples,1);
C_37 = zeros(numsamples,1);
C_38 = zeros(numsamples,1);


%Initialize PAH concentrations
ACE = zeros(numsamples,1);
ACY = zeros(numsamples,1);
ANT = zeros(numsamples,1);
BaA = zeros(numsamples,1);
BaP = zeros(numsamples,1);
BbF = zeros(numsamples,1);
BgP = zeros(numsamples,1);
BkF = zeros(numsamples,1);
CHY = zeros(numsamples,1);
DaA = zeros(numsamples,1);
FLU = zeros(numsamples,1);
FLE = zeros(numsamples,1);
IND = zeros(numsamples,1);
MPh = zeros(numsamples,1);
NAP = zeros(numsamples,1);
PHE = zeros(numsamples,1);
PYR = zeros(numsamples,1);
Retene = zeros(numsamples,1);




%%Calculate concentrations

while j < col
    while (i < row)
            if (i == 1)
                s1 = string(data_all(i,j));
                sample_name (sample_run) = s1;
            end
            
            Mass_net = num_exp_parameter(sample_run, 4) * num_exp_parameter(sample_run, 2) / num_exp_parameter(sample_run, 1);
            
            %DELETE CONDITIONALS BELOW WHEN PP PARAMETERS KNOWN
            if strcmp(siteId,'PP')
                if (sample_run == 1)
                    Mass_net = 0.01008;
                end
                if (sample_run == 3)
                    Mass_net = 0.01;
                end
                if (sample_run == 6)
                    Mass_net = 0.01008;
                end
                if (sample_run == 7)
                    Mass_net = 0.0051935;
                end
                if (sample_run == 10)
                    Mass_net = 0.01009;
                end
            end
            %
            
            conversion_factor = (num_exp_parameter(sample_run, 3) * 1000) / (Mass_net * 1000);
            
            
            
            %Alkanes
            
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
            
            %PAH
            
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
            
            if (strcmp(data_all(i,j),'BaP'))
                BaP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
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
                NAP(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
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
            
            if (strcmp(data_all(i,j),'C1-PHE1'))
                MPh(sample_run) = cell2mat(data_all(i,j+5)) * conversion_factor;
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
    t(ind) = (-1) * age_array(run_samples(ind));
end

%%Isotopic signature


func_plot_isotopic_ratio(t, isotopic_value);


%%Alkanes

alkanes_matrix = [C_20, C_21, C_22, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38];


[ACL, CPI, C31_by_C29, Sum_odd_alkanes, Sum_even_alkanes] = func_alkanes(C_20, C_21, C_22, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38);

%Function to plot ternary plot for C31,C29,C27;C33,C29,C27;C35,C29,C27; Bush,
%McInerney, et.al
%Color per isotopic ratio. I want to be able to visualize how C3/C4
%corresponds to aridity.


%Function to plot ACL&d13C vs t; CPI&d13C vs t; C31_by_C29&d13C vs t;
%OddAlkanes&d13C vs t; EvenAlkanes&d13C vs t;





func_plot_ACL_CPI_C31C29(ACL,CPI,C31_by_C29,isotopic_value,t);


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

PAH_matrix  = [ACY, ANT, BaA, CHY, FLU, IND, PHE, PYR];

FLU_FLUPYR = FLU ./ (FLU + PYR);

MPh_PHE = MPh ./ PHE;

ANT_ANTPHE = ANT ./ (ANT + PHE);

IND_INDBgP = IND ./ (IND + BgP);

BaA_BaACHY = BaA ./ (BaA + CHY);

Sum3Ring = ACY + ACE + ANT + FLE + PHE + Retene; %sum of 3 ring PAH

TotalPAH = NAP + Sum3Ring + FLU + PYR + BaA + CHY + BkF + BbF + BaP + IND +DaA + BgP;

PAHSourceChange = Sum3Ring./TotalPAH;

FireInput = TotalPAH./C_31;

ConiferInput = Retene./(Sum3Ring);

func_plot_source_and_degredation(MPh_PHE, FLU_FLUPYR);

func_plot_combustion_characteristics(FLU_FLUPYR, ANT_ANTPHE);

func_plot_combustion_characteristics_2(IND_INDBgP, BaA_BaACHY);

func_plot_fire_input(FireInput, isotopic_value, t);

func_plot_PAH_source_change(PAHSourceChange, isotopic_value, t);

func_plot_confier_input(ConiferInput, isotopic_value, t)


