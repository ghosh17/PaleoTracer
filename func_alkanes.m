function [ACL, CPI, C31_by_C29, Sum_odd, Sum_even] = func_alkanes(C_20, C_21, C_22, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38)
    %C_20, C_21, C_22, C_23, C_23, C_24, C_25, C_26, C_27, C_28, C_29, C_30, C_31, C_32, C_33, C_34, C_35, C_36, C_37, C_38
    Sum_odd = C_21 + C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35 + C_37;
    Sum_even =  C_22 + C_24 + C_26 + C_28 + C_30 + C_32 + C_34 + C_36;


    %ACL: Bush and McInerney
    ACL = (21 .* C_21 + 23 .* C_23 + 25 .* C_25 + 27 .* C_27 + 29 .* C_29 + 31 .* C_31 + 33 .* C_33 + 35 .* C_35 + 37 .* C_37)./Sum_odd;
    
    %CPI: Marzi et. al
    %CPI =((C_21 + C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35) + (C_23 + C_25 + C_27 + C_29 + C_31 + C_33 + C_35 + C_37) ) ./ (2 .* Sum_even);
    
    %CPI Freeman and Pancost (2014) used in Allison Karp paper
    CPI = 0.5 .* ((C_29+C_31+C_33) + (C_31+C_33+C_35))./(C_30+C_32+C_34);
    %ACL, CPI, C31_by_C29, Sum_odd, Sum_even = Alkanes_func(alkanes_matrix);
    C31_by_C29 = C_31./C_29;
    
    

end
