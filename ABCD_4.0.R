setwd("/Users/amiikeda/Desktop/ABCD4.0") #sets working directory- laptop
setwd("/Volumes/bga_lab/DATA_REPOSITORIES/ABCD/ABCD_4.0") #BGA server

library(dplyr)

#Propensity Score ---- 
#Developmental History- Propensity Score ----

#Add path and file name
dev_history  = read.delim(file("dhx01.txt"))
dev_history = dev_history[-c(1),]
dim(dev_history) 
#11876   263

#Look at column names to determine which variables to remove
colnames(dev_history)
# [1] "collection_id"              "dhx01_id"                   "dataset_id"                
# [4] "subjectkey"                 "src_subject_id"             "interview_date"            
# [7] "interview_age"              "sex"                        "visit"                     
# [10] "accult_select_language"     "devhx_1_p"                  "birth_weight_lbs"          
# [13] "devhx_2_p_dk"               "birth_weight_oz"            "devhx_2b_p_dk"             
# [16] "devhx_3_p"                  "devhx_3_p_dk"               "devhx_4_p"                 
# [19] "devhx_4_p_dk"               "devhx_5_p"                  "devhx_6_p"                 
# [22] "devhx_7_p"                  "devhx_7_p_dk"               "devhx_8_prescript_yes"     
# [25] "devhx_8_prescript_med"      "devhx_8_rxnorm_med1"        "devhx_8_med1_prn"          
# [28] "devhx_8_med1_times"         "devhx_8_med1_times_dk"      "devhx_8_med1_how_much"     
# [31] "devhx_8_med1_how_much_dk"   "devhx_8_med1_unit"          "devhx_8_med1_fu"           
# [34] "devhx_8_rxnorm_med2"        "devhx_8_med2_prn"           "devhx_8_med2_times"        
# [37] "devhx_8_med2_times_dk"      "devhx_8_med2_how_much"      "devhx_8_med2_how_much_dk"  
# [40] "devhx_8_med2_unit"          "devhx_8_med2_fu"            "devhx_8_rxnorm_med3"       
# [43] "devhx_8_med3_prn"           "devhx_8_med3_times"         "devhx_8_med3_times_dk"     
# [46] "devhx_8_med3_how_much"      "devhx_8_med3_how_much_dk"   "devhx_8_med3_unit"         
# [49] "devhx_8_tobacco"            "devhx_8_cigs_per_day"       "devhx_8_cigs_per_day_dk"   
# [52] "devhx_8_alcohol"            "devhx_8_alchohol_max"       "devhx_8_alchohol_max_dk"   
# [55] "devhx_8_alchohol_avg"       "devhx_8_alchohol_avg_dk"    "devhx_8_alcohol_effects"   
# [58] "devhx_8_alcohol_effects_dk" "devhx_8_marijuana"          "devhx_8_marijuana_amt"     
# [61] "devhx_8_marijuana_amt_dk"   "devhx_8_coc_crack"          "devhx_8_coc_crack_amt"     
# [64] "devhx_8_coc_crack_amt_dk"   "devhx_8_her_morph"          "devhx_8_her_morph_amt"     
# [67] "devhx_8_her_morph_amt_dk"   "devhx_8_oxycont"            "devhx_8_oxycont_amt"       
# [70] "devhx_8_oxycont_amt_dk"     "devhx_8_other_drugs"        "devhx_8_other1_name_2"     
# [73] "devhx_8_other1_name_oth"    "devhx_8_other1_times"       "devhx_8_other1_times_dk"   
# [76] "devhx_8_other1_amt"         "devhx_8_other1_amt_dk"      "devhx_8_other1_unit"       
# [79] "devhx_8_other2_name_2"      "devhx_8_other2_name_oth"    "devhx_8_other2_times"      
# [82] "devhx_8_other2_times_dk"    "devhx_8_other2_amt"         "devhx_8_other2_amt_dk"     
# [85] "devhx_8_other2_unit"        "devhx_8_other3_name_2"      "devhx_8_other3_name_oth"   
# [88] "devhx_8_other3_times"       "devhx_8_other3_times_dk"    "devhx_8_other3_amt"        
# [91] "devhx_8_other3_amt_dk"      "devhx_8_other3_unit"        "devhx_8_other4_name_2"     
# [94] "devhx_8_other4_name_oth"    "devhx_8_other4_times"       "devhx_8_other4_times_dk"   
# [97] "devhx_8_other4_amt"         "devhx_8_other4_amt_dk"      "devhx_8_other4_unit"       
# [100] "devhx_8_other5_name_2"      "devhx_8_other5_name_oth"    "devhx_8_other5_times"      
# [103] "devhx_8_other5_times_dk"    "devhx_8_other5_amt"         "devhx_8_other5_amt_dk"     
# [106] "devhx_8_other5_unit"        "devhx_9_prescript_med"      "devhx_9_med1_rxnorm"       
# [109] "devhx_9_med1_prn"           "devhx_9_med1_times"         "devhx_9_med1_times_dk"     
# [112] "devhx_9_med1_how_much"      "devhx_9_med1_how_much_dk"   "devhx_9_med1_unit"         
# [115] "devhx_9_med1_fu"            "devhx_9_med2_rxnorm"        "devhx_9_med2_prn"          
# [118] "devhx_9_med2_times"         "devhx_9_med2_rxnorm_dk"     "devhx_9_med2_how_much"     
# [121] "devhx_9_med2_how_much_dk"   "devhx_9_med2_unit"          "devhx_9_med2_fu2"          
# [124] "devhx_9_med3_rxnorm"        "devhx_9_med3_prn"           "devhx_9_med3_times"        
# [127] "devhx_9_med3_times_dk"      "devhx_9_med3_how_much"      "devhx_9_med3_how_much_dk"  
# [130] "devhx_9_med3_unit"          "devhx_9_med3_fu"            "devhx_9_med4_rxnorm"       
# [133] "devhx_9_med4_prn"           "devhx_9_med4_times"         "devhx_9_med4_times_dk"     
# [136] "devhx_9_med4_how_much"      "devhx_9_med4_how_much_dk"   "devhx_9_med4_unit"         
# [139] "devhx_9_med4_fu"            "devhx_9_med5_rxnorm"        "devhx_9_med5_prn"          
# [142] "devhx_9_med5_times"         "devhx_9_med5_times_dk"      "devhx_9_med5_how_much"     
# [145] "devhx_9_med5_how_much_dk"   "devhx_9_med5_unit"          "devhx_9_tobacco"           
# [148] "devhx_9_cigs_per_day"       "devhx_9_cigs_per_day_dk"    "devhx_9_alcohol"           
# [151] "devhx_9_alchohol_max"       "devhx_9_alchohol_max_dk"    "devhx_9_alchohol_avg"      
# [154] "devhx_9_alchohol_avg_dk"    "devhx_9_alcohol_effects"    "devhx_9_alcohol_effects_dk"
# [157] "devhx_9_marijuana"          "devhx_9_marijuana_amt"      "devhx_9_marijuana_amt_dk"  
# [160] "devhx_9_coc_crack"          "devhx_9_coc_crack_amt"      "devhx_9_coc_crack_amt_dk"  
# [163] "devhx_9_her_morph"          "devhx_9_her_morph_amt"      "devhx_9_her_morph_amt_dk"  
# [166] "devhx_9_oxycont"            "devhx_9_oxycont_amt"        "devhx_9_oxycont_amt_dk"    
# [169] "devhx_9_other_drugs"        "devhx_9_other1_name_2"      "devhx_9_other1_name_oth"   
# [172] "devhx_9_other1_times"       "devhx_9_other1_times_dk"    "devhx_9_other1_amt"        
# [175] "devhx_9_other1_amt_dk"      "devhx_9_other1_unit"        "devhx_9_other2_name_2"     
# [178] "devhx_9_other2_name_oth"    "devhx_9_other2_times"       "devhx_9_other2_times_dk"   
# [181] "devhx_9_other2_amt"         "devhx_9_other2_amt_dk"      "devhx_9_other2_unit"       
# [184] "devhx_9_other3_name_2"      "devhx_9_other3_name_oth"    "devhx_9_other3_times"      
# [187] "devhx_9_other3_times_dk"    "devhx_9_other3_unit"        "devhx_9_other3_amt"        
# [190] "devhx_9_other3_amt_dk"      "devhx_9_other4_name_2"      "devhx_9_other4_name_oth"   
# [193] "devhx_9_other4_times"       "devhx_9_other4_times_dk"    "devhx_9_other4_amt"        
# [196] "devhx_9_other4_amt_dk"      "devhx_9_other4_unit"        "devhx_9_other5_name_2"     
# [199] "devhx_9_other5_name_oth"    "devhx_9_other5_times"       "devhx_9_other5_times_dk"   
# [202] "devhx_9_other5_amt"         "devhx_9_other5_amt_dk"      "devhx_9_other5_unit"       
# [205] "devhx_10"                   "devhx_caffeine_11"          "devhx_caffeine_amt"        
# [208] "devhx_caffeine_amt_dk"      "devhx_caff_amt_week"        "devhx_caff_amt_week_dk"    
# [211] "devhx_caff_amt_month"       "devhx_caff_amt_month_dk"    "devhx_10a3_p"              
# [214] "devhx_10b3_p"               "devhx_10c3_p"               "devhx_10d3_p"              
# [217] "devhx_10e3_p"               "devhx_10f3_p"               "devhx_10g3_p"              
# [220] "devhx_10h3_p"               "devhx_10i3_p"               "devhx_10j3_p"              
# [223] "devhx_10k3_p"               "devhx_10l3_p"               "devhx_10m3_p"              
# [226] "devhx_11_p"                 "devhx_11_p_dk"              "devhx_12a_p"               
# [229] "devhx_12_p"                 "devhx_13_3_p"               "devhx_14a3_p"              
# [232] "devhx_14b3_p"               "devhx_14c3_p"               "devhx_14d3_p"              
# [235] "devhx_14e3_p"               "devhx_14f3_p"               "devhx_14g3_p"              
# [238] "devhx_14h3_p"               "devhx_15"                   "devhx_15_dk"               
# [241] "devhx_16_p"                 "devhx_16_p_dk"              "devhx_17_p"                
# [244] "devhx_17_p_dk"              "devhx_18_p"                 "devhx_18_p_dk"             
# [247] "devhx_19a_p"                "devhx_19a_p_dk"             "devhx_19b_p"               
# [250] "devhx_19b_p_dk"             "devhx_19c_p"                "devhx_19c_p_dk"            
# [253] "devhx_19d_p"                "devhx_19d_p_dk"             "devhx_20_p"                
# [256] "devhx_21_p"                 "devhx_22_3_p"               "devhx_23b_p"               
# [259] "devhx_10c3_c_p"             "devhx_10c3_a_p"             "devhx_10c3_b_p"            
# [262] "collection_title"           "study_cohort_name"    

#Remove variables that will not be included in analysis
dev_history = dev_history[,-c(1:3, 5, 6, 9:10, 13:15, 17, 19:20, 23:48, 62:146, 160:204, 206:212,
                              214:225, 227, 230:244, 246, 259:263)]
colnames(dev_history)
# [1] "subjectkey"                 "interview_age"              "sex"                       
# [4] "devhx_1_p"                  "birth_weight_lbs"           "devhx_3_p"                 
# [7] "devhx_4_p"                  "devhx_6_p"                  "devhx_7_p"                 
# [10] "devhx_8_tobacco"            "devhx_8_cigs_per_day"       "devhx_8_cigs_per_day_dk"   
# [13] "devhx_8_alcohol"            "devhx_8_alchohol_max"       "devhx_8_alchohol_max_dk"   
# [16] "devhx_8_alchohol_avg"       "devhx_8_alchohol_avg_dk"    "devhx_8_alcohol_effects"   
# [19] "devhx_8_alcohol_effects_dk" "devhx_8_marijuana"          "devhx_8_marijuana_amt"     
# [22] "devhx_8_marijuana_amt_dk"   "devhx_9_tobacco"            "devhx_9_cigs_per_day"      
# [25] "devhx_9_cigs_per_day_dk"    "devhx_9_alcohol"            "devhx_9_alchohol_max"      
# [28] "devhx_9_alchohol_max_dk"    "devhx_9_alchohol_avg"       "devhx_9_alchohol_avg_dk"   
# [31] "devhx_9_alcohol_effects"    "devhx_9_alcohol_effects_dk" "devhx_9_marijuana"         
# [34] "devhx_9_marijuana_amt"      "devhx_9_marijuana_amt_dk"   "devhx_10"                  
# [37] "devhx_10a3_p"               "devhx_11_p"                 "devhx_12a_p"               
# [40] "devhx_12_p"                 "devhx_18_p"                 "devhx_19a_p"               
# [43] "devhx_19a_p_dk"             "devhx_19b_p"                "devhx_19b_p_dk"            
# [46] "devhx_19c_p"                "devhx_19c_p_dk"             "devhx_19d_p"               
# [49] "devhx_19d_p_dk"             "devhx_20_p"                 "devhx_21_p"                
# [52] "devhx_22_3_p"               "devhx_23b_p"                    

#Rename variables
names(dev_history)[names(dev_history) == "subjectkey"] = "id"
names(dev_history)[names(dev_history) == "devhx_1_p"] = "biomom"
names(dev_history)[names(dev_history) == "devhx_8_tobacco"] = "b_tobacco"
names(dev_history)[names(dev_history) == "devhx_8_alcohol"] = "b_alcohol"
names(dev_history)[names(dev_history) == "devhx_8_marijuana"] = "b_THC"
names(dev_history)[names(dev_history) == "devhx_9_tobacco"] = "a_tobacco"
names(dev_history)[names(dev_history) == "devhx_9_alcohol"] = "a_alcohol"
names(dev_history)[names(dev_history) == "devhx_9_marijuana"] = "a_THC"
names(dev_history)[names(dev_history) == "interview_age"] = "age"
names(dev_history)[names(dev_history) == "birth_weight_lbs"] = "weight"
names(dev_history)[names(dev_history) == "devhx_3_p"] = "m_age"
names(dev_history)[names(dev_history) == "devhx_4_p"] = "p_age"
names(dev_history)[names(dev_history) == "devhx_6_p"] = "plan_preg"
names(dev_history)[names(dev_history) == "devhx_7_p"] = "weeks_preg"
names(dev_history)[names(dev_history) == "devhx_8_cigs_per_day"] = "b_tob_cigspday"
names(dev_history)[names(dev_history) == "devhx_8_alchohol_max"] = "b_alc_max"
names(dev_history)[names(dev_history) == "devhx_8_alchohol_avg"] = "b_alc_avgpwk"
names(dev_history)[names(dev_history) == "devhx_8_alcohol_effects"] = "b_alc_drinkseff"
names(dev_history)[names(dev_history) == "devhx_8_marijuana_amt"] = "b_THC_amtpday"
names(dev_history)[names(dev_history) == "devhx_9_cigs_per_day"] = "a_tob_cigspday"
names(dev_history)[names(dev_history) == "devhx_9_alchohol_max"] = "a_alc_max"
names(dev_history)[names(dev_history) == "devhx_9_alchohol_avg"] = "a_alc_avgpwk"
names(dev_history)[names(dev_history) == "devhx_9_alcohol_effects"] = "a_alc_drinkseff"
names(dev_history)[names(dev_history) == "devhx_9_marijuana_amt"] = "a_THC_amtpday"
names(dev_history)[names(dev_history) == "devhx_10"] = "prenatal"
names(dev_history)[names(dev_history) == "devhx_10a3_p"] = "nausea"
names(dev_history)[names(dev_history) == "devhx_11_p"] = "doctor_visit"
names(dev_history)[names(dev_history) == "devhx_12a_p"] = "premature"
names(dev_history)[names(dev_history) == "devhx_12_p"] = "wks_premature"
names(dev_history)[names(dev_history) == "devhx_18_p"] = "months_breastfed"
names(dev_history)[names(dev_history) == "devhx_19a_p"] = "rollover"
names(dev_history)[names(dev_history) == "devhx_19b_p"] = "sit"
names(dev_history)[names(dev_history) == "devhx_19c_p"] = "walk"
names(dev_history)[names(dev_history) == "devhx_19d_p"] = "firstword"
names(dev_history)[names(dev_history) == "devhx_20_p"] = "motordev"
names(dev_history)[names(dev_history) == "devhx_21_p"] = "speechdev"
names(dev_history)[names(dev_history) == "devhx_22_3_p"] = "wetbed"
names(dev_history)[names(dev_history) == "devhx_23b_p"] = "age_stopwetbed"

colnames(dev_history)
# [1] "id"                         "age"                        "sex"                       
# [4] "biomom"                     "weight"                     "m_age"                     
# [7] "p_age"                      "plan_preg"                  "weeks_preg"                
# [10] "b_tobacco"                  "b_tob_cigspday"             "devhx_8_cigs_per_day_dk"   
# [13] "b_alcohol"                  "b_alc_max"                  "devhx_8_alchohol_max_dk"   
# [16] "b_alc_avgpwk"               "devhx_8_alchohol_avg_dk"    "b_alc_drinkseff"           
# [19] "devhx_8_alcohol_effects_dk" "b_THC"                      "b_THC_amtpday"             
# [22] "devhx_8_marijuana_amt_dk"   "a_tobacco"                  "a_tob_cigspday"            
# [25] "devhx_9_cigs_per_day_dk"    "a_alcohol"                  "a_alc_max"                 
# [28] "devhx_9_alchohol_max_dk"    "a_alc_avgpwk"               "devhx_9_alchohol_avg_dk"   
# [31] "a_alc_drinkseff"            "devhx_9_alcohol_effects_dk" "a_THC"                     
# [34] "a_THC_amtpday"              "devhx_9_marijuana_amt_dk"   "prenatal"                  
# [37] "nausea"                     "doctor_visit"               "premature"                 
# [40] "wks_premature"              "months_breastfed"           "rollover"                  
# [43] "devhx_19a_p_dk"             "sit"                        "devhx_19b_p_dk"            
# [46] "walk"                       "devhx_19c_p_dk"             "firstword"                 
# [49] "devhx_19d_p_dk"             "motordev"                   "speechdev"                 
# [52] "wetbed"                     "age_stopwetbed"     

#Use table function to check how variables are coded
table(dev_history$age, useNA = "ifany")
#age in months
# 107 108 109 110 111 112 113 114 115 116 117 118 119 120 121 122 123 124 125 126 127 
# 141 876 670 562 473 392 411 441 443 464 467 461 441 448 455 433 438 439 446 441 432 
# 128 129 130 131 132 133 
# 396 467 452 657 129   1 

table(dev_history$weight, useNA = "ifany")
#        1   10   11   12   13   14    2    3    4    5    6    7    8    9 
# 517    2  134   21    5    3    2   48  300  636 1369 2607 3405 2155  672 

table(dev_history$m_age, useNA = "ifany")
#         13    14    15    16    17    18    19    20    21    22    23    24    25 
# 264     4    14    38    77   123   218   260   326   386   369   428   431   549 

# 26    27    28    29    30    31    32    33    34    35    36    37    38    39 
# 573   640   606   715   755   680   692   611   575   513   479   388   311   266 

# 40    41 41.75    42    43    44    45    46    47    48    49    52    57    60 
# 177   159     1    88    69    36    20     6    17     7     1     2     1     1 

table(dev_history$p_age, useNA = "ifany")
#       13   14   15   16   17   18   19   20   21   22   23   24   25   26   27   28 
# 643    1    4   13   25   65  114  149  196  243  259  281  357  467  428  535  534 

# 28.5   29   30   31   32   33  332   34   35   36   37   38  389   39   40   41   42 
# 1  605  636  629  659  615    1  580  593  557  495  367    1  344  299  212  214 

# 43   44   45   46   47   48   49   50   51   52   53   54   55   56   57   58   59 
# 137  130  112   85   53   54   30   46   24   13   14   12   12    8    5    3    7 

# 60   61   64   67   68 
# 3    1    1    1    3 

table(dev_history$biomom, useNA = "ifany")
#       0     1 
# 3  1617 10256 

table(dev_history$weeks_preg, useNA = "ifany")
#         1   10   11   12   13   14   15   16   17   18   19    2   20   21   22   23 
# 1387  228  211   46  324   54   32   22   86   11   19    4  709   43    4    9    3 

# 24   25   26   27   28   29    3   30   31   32   33   34   35   36   37   38   39 
# 25    5    5    3    5    3  825    9    7   17    8   10   21   43   53   68   56 

#   4   40    5    6    7    8    9 
# 2339   96 1347 2021  405 1118  195 

table(dev_history$b_tob_cigspday, useNA = "ifany")
#           .5     0     1    10    12    13    14    15    16    17    18     2    20 
# 10453     1     4    83   316    31     2     1    95     3     1     8   111   132 

# 24    25     3    30     4    40     5    50     6     7     8    80     9 
# 3     6   140     9   109     3   200     1    70    31    60     1     2 

table(dev_history$devhx_8_cigs_per_day_dk, useNA = "ifany")

table(dev_history$b_tobacco, useNA = "ifany")
#     0    1  999 
# 6 9987 1610  273 

table(dev_history$b_alcohol, useNA = "ifany")
#     0    1   999 
# 6 8311 2882  677 

table(dev_history$b_alc_max, useNA = "ifany")
#         .5    0    1   10   12   15    2   20    3    4    5    6    7    8 
# 9334    3    3  651    8    6    1 1005    1  503  186   96   54    4   21 

table(dev_history$b_THC, useNA = "ifany")
#       0     1   999 
# 5 10849   687   335 

table(dev_history$a_tobacco, useNA = "ifany")
#       0     1   999 
# 6 10991   620   259 

table(dev_history$a_alcohol, useNA = "ifany")
#       0     1   999 
# 5 11268   315   288 

table(dev_history$a_THC, useNA = "ifany")
#       0     1   999 
# 5 11354   245   272 

#Rescale variables- make "" and 999 into NA 
colnames(dev_history)
dev_history[, c(1:53)][dev_history[, c(1:53)] == ""] <- NA
dev_history[, c(1:53)][dev_history[, c(1:53)] == 999] <- NA

#Check if NA's have been changed
table(dev_history$b_alcohol, useNA = "ifany")
#       0    1 <NA> 
#   8311 2882  683 

table(dev_history$b_alc_max, useNA = "ifany")
#   .5    0    1   10   12   15    2   20    3    4    5    6    7    8 <NA> 
#   3    3  651    8    6    1 1005    1  503  186   96   54    4   21 9334 

table(dev_history$b_tobacco, useNA = "ifany")
#       0    1 <NA> 
#   9987 1610  279 

table(dev_history$b_alcohol, useNA = "ifany")
#       0    1 <NA> 
#   8311 2882  683 

table(dev_history$b_THC, useNA = "ifany")
#       0     1  <NA> 
#   10849   687   340 

table(dev_history$a_tobacco, useNA = "ifany")
#       0     1  <NA> 
#   10991   620   265

table(dev_history$a_alcohol, useNA = "ifany")
#       0     1  <NA> 
#   11268   315   293 

table(dev_history$a_THC, useNA = "ifany")
#       0     1  <NA> 
#   11354   245   277 

#Change variables to be numeric
colnames(dev_history)
dev_history = dev_history[,-c(12, 15, 17, 19, 22, 25, 28, 30, 32, 35, 43, 45, 47, 49)]
colnames(dev_history)
# [1] "id"               "age"              "sex"              "biomom"           "weight"          
# [6] "m_age"            "p_age"            "plan_preg"        "weeks_preg"       "b_tobacco"       
# [11] "b_tob_cigspday"   "b_alcohol"        "b_alc_max"        "b_alc_avgpwk"     "b_alc_drinkseff" 
# [16] "b_THC"            "b_THC_amtpday"    "a_tobacco"        "a_tob_cigspday"   "a_alcohol"       
# [21] "a_alc_max"        "a_alc_avgpwk"     "a_alc_drinkseff"  "a_THC"            "a_THC_amtpday"   
# [26] "prenatal"         "nausea"           "doctor_visit"     "premature"        "wks_premature"   
# [31] "months_breastfed" "rollover"         "sit"              "walk"             "firstword"       
# [36] "motordev"         "speechdev"        "wetbed"           "age_stopwetbed"  

dev_history$age = as.numeric(dev_history$age)
dev_history$weight = as.numeric(dev_history$weight)
dev_history$m_age = as.numeric(dev_history$m_age)
dev_history$p_age = as.numeric(dev_history$p_age)
dev_history$weeks_preg = as.numeric(dev_history$weeks_preg)
dev_history$b_tob_cigspday = as.numeric(dev_history$b_tob_cigspday)
dev_history$b_alc_max = as.numeric(dev_history$b_alc_max)
dev_history$b_alc_avgpwk = as.numeric(dev_history$b_alc_avgpwk)
dev_history$b_alc_drinkseff = as.numeric(dev_history$b_alc_drinkseff)
dev_history$b_THC_amtpday = as.numeric(dev_history$b_THC_amtpday)
dev_history$a_tob_cigspday = as.numeric(dev_history$a_tob_cigspday)
dev_history$a_alc_max = as.numeric(dev_history$a_alc_max)
dev_history$a_alc_avgpwk = as.numeric(dev_history$a_alc_avgpwk)
dev_history$a_alc_drinkseff = as.numeric(dev_history$a_alc_drinkseff)
dev_history$a_THC_amtpday = as.numeric(dev_history$a_THC_amtpday)
dev_history$doctor_visit = as.numeric(dev_history$doctor_visit)
dev_history$wks_premature = as.numeric(dev_history$wks_premature)
dev_history$months_breastfed = as.numeric(dev_history$months_breastfed)
dev_history$rollover = as.numeric(dev_history$rollover)
dev_history$sit = as.numeric(dev_history$sit)
dev_history$walk = as.numeric(dev_history$walk)
dev_history$firstword = as.numeric(dev_history$firstword)
dev_history$motordev = as.numeric(dev_history$motordev)
dev_history$speechdev = as.numeric(dev_history$speechdev)
dev_history$wetbed = as.numeric(dev_history$wetbed)
dev_history$age_stopwetbed = as.numeric(dev_history$age_stopwetbed)


#Prenatal Exposure Variables
dev_history[which(dev_history$b_tobacco == 0 & dev_history$a_tobacco == 0),  "Pre_Tobacco"] = 0
dev_history[which(dev_history$b_tobacco == 1 | dev_history$a_tobacco == 1),  "Pre_Tobacco"] = 1
table(dev_history$Pre_Tobacco, useNA = "ifany")
#     0    1 <NA> 
#   9960 1625  291 

dev_history[which(dev_history$b_alcohol == 0 & dev_history$a_alcohol == 0),  "Pre_Alcohol"] = 0
dev_history[which(dev_history$b_alcohol == 1 | dev_history$a_alcohol == 1),  "Pre_Alcohol"] = 1
table(dev_history$Pre_Alcohol, useNA = "ifany")
#       0    1 <NA> 
#   8275 2925  676 

dev_history[which(dev_history$b_THC == 0 & dev_history$a_THC == 0),  "Pre_THC"] = 0
dev_history[which(dev_history$b_THC == 1 | dev_history$a_THC == 1),  "Pre_THC"] = 1
table(dev_history$Pre_THC, useNA = "ifany")
#       0     1  <NA> 
#   10834   697   345 

dev_history[which(dev_history$Pre_Alcohol == 0 & dev_history$Pre_Tobacco == 0),  "Pre_AlcTob"] = 0
dev_history[which(dev_history$Pre_Alcohol == 1 & dev_history$Pre_Tobacco == 1 & dev_history$Pre_THC == 0),  "Pre_AlcTob"] = 1
table(dev_history$Pre_AlcTob, useNA = "ifany")
#     0    1 <NA> 
#   7489  456 3931 

dev_history[which(dev_history$Pre_Alcohol ==0 & dev_history$Pre_THC == 0),  "Pre_AlcTHC"] = 0
dev_history[which(dev_history$Pre_Alcohol == 1 & dev_history$Pre_THC == 1 & dev_history$Pre_Tobacco == 0),  "Pre_AlcTHC"] = 1
table(dev_history$Pre_AlcTHC, useNA = "ifany")
#       0    1 <NA> 
#   8014  136 3726 

dev_history[which(dev_history$Pre_Tobacco == 0 & dev_history$Pre_THC == 0),  "Pre_TobTHC"] = 0
dev_history[which(dev_history$Pre_Tobacco == 1 & dev_history$Pre_THC == 1 & dev_history$Pre_Alcohol == 0),  "Pre_TobTHC"] = 1
table(dev_history$Pre_TobTHC, useNA = "ifany")
#       0    1 <NA> 
#   9660  136 2080 

dev_history[which(dev_history$Pre_Tobacco == 0 & dev_history$Pre_THC == 0 & dev_history$Pre_Alcohol == 0),  "Pre_AlcTobTHC"] = 0
dev_history[which(dev_history$Pre_Tobacco == 1 & dev_history$Pre_THC == 1 & dev_history$Pre_Alcohol == 1),  "Pre_AlcTobTHC"] = 1
table(dev_history$Pre_AlcTobTHC, useNA = "ifany")
#       0    1 <NA> 
#   7368  264 4244 


#Descriptives
round(mean(dev_history$m_age, na.rm=T), digits = 2)
# 29.4
min(dev_history$m_age, na.rm=T)
#13
max(dev_history$m_age, na.rm=T)
#60
round(sd(dev_history$m_age, na.rm=T), digits = 2)
#6.27




#mean, min, max, sd for Prenatal THC and propensity score variables ----

#mean, min, max sd for maternal age
round(mean(dev_history$m_age[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development 
round(mean(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)

#1 = Much earlier 
#2 = Somewhat earlier 
#3 = About average
#4 = Somewhat later
#5 = Much later
#999 = Don't know

#Rescale motor development and speech development variables 
table(dev_history$motordev, useNA = "ifany")
#     1    2    3    4    5 <NA> 
#   1124 3281 6285  909  136  141 

table(dev_history$speechdev, useNA = "ifany")
#       1    2    3    4    5 <NA> 
#   1396 3001 5351 1432  565  131 

dev_history[which(dev_history$motordev == 1),  "motordev"] = 0
dev_history[which(dev_history$motordev == 2),  "motordev"] = 1
dev_history[which(dev_history$motordev == 3),  "motordev"] = 2
dev_history[which(dev_history$motordev == 4),  "motordev"] = 3
dev_history[which(dev_history$motordev == 5),  "motordev"] = 4

table(dev_history$motordev, useNA = "ifany")
#     0    1    2    3    4 <NA> 
#   1124 3281 6285  909  136  141 


dev_history[which(dev_history$speechdev == 1),  "speechdev"] = 0
dev_history[which(dev_history$speechdev == 2),  "speechdev"] = 1
dev_history[which(dev_history$speechdev == 3),  "speechdev"] = 2
dev_history[which(dev_history$speechdev == 4),  "speechdev"] = 3
dev_history[which(dev_history$speechdev == 5),  "speechdev"] = 4

table(dev_history$speechdev, useNA = "ifany")
#       0    1    2    3    4 <NA> 
#   1396 3001 5351 1432  565  131 



#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's speech development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_THC==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_THC==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_THC==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_THC==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_THC==1)], na.rm=T), digits = 2)




#mean, min, max, sd for Prenatal Alcohol and propensity score variables ----

#mean, min, max sd for maternal age
round(mean(dev_history$m_age[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_Alcohol==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_Alcohol==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_Alcohol==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_Alcohol==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_Alcohol==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_Alcohol==1)], na.rm=T), digits = 2)










#mean, min, max, sd for Prenatal Tobacco and propensity score variables ----

#mean, min, max, sd for maternal age 
round(mean(dev_history$m_age[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_Tobacco==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_Tobacco==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_Tobacco==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_Tobacco==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_Tobacco==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_Tobacco==1)], na.rm=T), digits = 2)















#mean, min, max, sd for Prenatal Alcohol + Prenatal Tobacco and propensity score variables ----

#mean, min, max, sd for maternal age 
round(mean(dev_history$m_age[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTob==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTob==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTob==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTob==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTob==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTob==1)], na.rm=T), digits = 2)



#mean, min, max, sd for Prenatal Alcohol + Prenatal Cannabis and propensity score variables ----

#mean, min, max, sd for maternal age 
round(mean(dev_history$m_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTHC==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTHC==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTHC==1)], na.rm=T), digits = 2)













#mean, min, max, sd for Prenatal Tobacco + Prenatal Cannabis and propensity score variables ---- 

#mean, min, max, sd for maternal age 
round(mean(dev_history$m_age[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's speech development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_TobTHC==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_TobTHC==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_TobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_TobTHC==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_TobTHC==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_TobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for Prenatal Tobacco + Prenatal Alcohol + Prenatal Cannabis and propensity score variables ----

#mean, min, max, sd for maternal age 
round(mean(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$m_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$p_age[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for infant weight
round(mean(dev_history$weight[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$weight[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$weight[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$weight[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$weight[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of doctors visits
round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$doctor_visit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of weeks premature
round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$wks_premature[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months infants was breastfed
round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$months_breastfed[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to roll over
#CDC averafe = 4 months
round(mean(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$rollover[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for number of months child was first able to sit without assistance 
#CDC average = 9 months
round(mean(dev_history$sit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$sit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$sit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$sit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$sit[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child first able to walk without assistance 
#CDC average = 18 months
round(mean(dev_history$walk[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$walk[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$walk[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$walk[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$walk[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child able to say first word 
#CDC average = 12 months
round(mean(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$firstword[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)


#mean, min, max, sd for child's motor development (rescaled variables)
round(mean(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$motordev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for child's speech development (rescaled variables)
round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==0)], na.rm=T), digits = 2)

round(mean(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)
min(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
max(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T)
round(sd(dev_history$speechdev[which(dev_history$Pre_AlcTobTHC==1)], na.rm=T), digits = 2)

#Post Stratification Weights- For cluster by family ID and include Propensity Score ----
#Add path and file name
stratweights  = read.delim(file("acspsw03.txt"))
stratweights = stratweights[-c(1),] 
dim(stratweights) 
#[1] 23101    34

colnames(stratweights)
# [1] "collection_id"              "acspsw03_id"                "dataset_id"                
# [4] "subjectkey"                 "src_subject_id"             "interview_date"            
# [7] "interview_age"              "sex"                        "eventname"                 
# [10] "race_ethnicity"             "rel_family_id"              "rel_group_id"              
# [13] "rel_ingroup_order"          "rel_relationship"           "rel_same_sex"              
# [16] "acs_raked_propensity_score" "genetic_paired_subjectid_4" "genetic_pi_hat_1"          
# [19] "genetic_pi_hat_2"           "genetic_pi_hat_3"           "genetic_pi_hat_4"          
# [22] "genetic_zygosity_status_1"  "genetic_zygosity_status_2"  "genetic_zygosity_status_3" 
# [25] "genetic_zygosity_status_4"  "genetic_af_african"         "genetic_af_european"       
# [28] "genetic_af_east_asian"      "genetic_af_american"        "genetic_paired_subjectid_1"
# [31] "genetic_paired_subjectid_2" "genetic_paired_subjectid_3" "collection_title"          
# [34] "study_cohort_name"         

#Remove variables that will not be included in analysis
stratweights = stratweights[,-c(1:3, 5, 6, 8, 10, 12, 13, 15, 17:34)]
colnames(stratweights)
# [1] "subjectkey"                 "interview_age"              "eventname"                  "rel_family_id"             
# [5] "rel_relationship"           "acs_raked_propensity_score"

#Rename variables
names(stratweights)[names(stratweights) == "subjectkey"] = "id"
names(stratweights)[names(stratweights) == "interview_age"] = "age"
names(stratweights)[names(stratweights) == "eventname"] = "timepoint"
names(stratweights)[names(stratweights) == "rel_family_id"] = "fam_id"
names(stratweights)[names(stratweights) == "rel_relationship"] = "fam_rel"
names(stratweights)[names(stratweights) == "acs_raked_propensity_score"] = "weight_ps"

colnames(stratweights)
# [1] "id"        "age"       "timepoint" "fam_id"    "fam_rel"   "weight_ps"

table(stratweights$timepoint, useNA = "ifany")
#1_year_follow_up_y_arm_1    baseline_year_1_arm_1 
#11225                       11876 

#Label timepoint data 
stratweights[which(stratweights$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
stratweights[which(stratweights$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1

table(stratweights$timepoint, useNA = "ifany")
# 0     1 
# 11876 11225 

#Double check that an additional variable was not made
colnames(stratweights)
# [1] "id"        "age"       "timepoint" "fam_id"    "fam_rel"   "weight_ps"

#Reshape data to wide 
library(reshape)
weights_wide = reshape(stratweights, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(weights_wide)
# [1] "id"          "age.1"       "fam_id.1"    "fam_rel.1"   "weight_ps.1" "age.0"       "fam_id.0"    "fam_rel.0"  
# [9] "weight_ps.0"

weights_wide = weights_wide[,-c(3, 4)]

colnames(weights_wide)
# [1] "id"          "age.1"       "weight_ps.1" "age.0"       "fam_id.0"    "fam_rel.0"   "weight_ps.0"

#Parent Demographics + Child Demographics- Propensity Score ----

#Add path and file name
demograph  = read.delim(file("pdem02.txt"))
demograph = demograph[-c(1),]
dim(demograph) 
# [1] 11876   135

colnames(demograph)
# [1] "collection_id"               "pdem02_id"                   "dataset_id"                 
# [4] "subjectkey"                  "src_subject_id"              "interview_date"             
# [7] "interview_age"               "sex"                         "demoi_p_select_language___1"
# [10] "demo_prim"                   "demo_brthdat_v2"             "demo_ed_v2"                 
# [13] "demo_adopt_agex_v2"          "demo_adopt_agex_v2_bl_dk"    "demo_sex_v2"                
# [16] "demo_gender_id_v2"           "demo_race_a_p___10"          "demo_race_a_p___11"         
# [19] "demo_race_a_p___12"          "demo_race_a_p___13"          "demo_race_a_p___14"         
# [22] "demo_race_a_p___15"          "demo_race_a_p___16"          "demo_race_a_p___17"         
# [25] "demo_race_a_p___18"          "demo_race_a_p___19"          "demo_race_a_p___20"         
# [28] "demo_race_a_p___21"          "demo_race_a_p___22"          "demo_race_a_p___23"         
# [31] "demo_race_a_p___24"          "demo_race_a_p___25"          "demo_race_a_p___77"         
# [34] "demo_race_a_p___99"          "demo_race_notes_v2"          "demo_ethn_v2"               
# [37] "demo_ethn2_v2"               "demo_origin_v2"              "demo_years_us_v2"           
# [40] "demo_years_us_v2_dk"         "demo_relig_v2"               "demo_relig2_v2"             
# [43] "demo_prnt_age_v2"            "demo_prnt_age_v2_bl_refuse"  "demo_prnt_gender_id_v2"     
# [46] "demo_prnt_race_a_v2___10"    "demo_prnt_race_a_v2___11"    "demo_prnt_race_a_v2___12"   
# [49] "demo_prnt_race_a_v2___13"    "demo_prnt_race_a_v2___14"    "demo_prnt_race_a_v2___15"   
# [52] "demo_prnt_race_a_v2___16"    "demo_prnt_race_a_v2___17"    "demo_prnt_race_a_v2___18"   
# [55] "demo_prnt_race_a_v2___19"    "demo_prnt_race_a_v2___20"    "demo_prnt_race_a_v2___21"   
# [58] "demo_prnt_race_a_v2___22"    "demo_prnt_race_a_v2___23"    "demo_prnt_race_a_v2___24"   
# [61] "demo_prnt_race_a_v2___25"    "demo_prnt_race_a_v2___77"    "demo_prnt_race_a_v2___99"   
# [64] "naas_id"                     "naas_mom_id"                 "naas_id_dad"                
# [67] "naas_birthplace"             "naas_raised"                 "naas_comm_contact"          
# [70] "naas_pride"                  "naas_self_rating"            "naas_traditions"            
# [73] "demo_prnt_ethn_v2"           "demo_prnt_ethn2_v2"          "demo_prnt_16"               
# [76] "demo_prnt_16a"               "demo_prnt_origin_v2"         "demo_biofather_v2"          
# [79] "demo_biomother_v2"           "demo_matgrandm_v2"           "demo_matgrandf_v2"          
# [82] "demo_patgrandm_v2"           "demo_patgrandf_v2"           "demo_prnt_years_us_v2"      
# [85] "demo_prnt_years_us_v2_dk"    "demo_prnt_marital_v2"        "demo_prnt_ed_v2"            
# [88] "demo_prnt_empl_v2"           "demo_prnt_empl_time"         "demo_prnt_income_v2"        
# [91] "demo_prnt_prtnr_v2"          "demo_prnt_prtnr_bio"         "demo_prnt_prtnr_adopt"      
# [94] "demo_prtnr_ed_v2"            "demo_prtnr_empl_v2"          "demo_prtnr_empl_time"       
# [97] "demo_prtnr_income_v2"        "demo_comb_income_v2"         "demo_fam_exp1_v2"           
# [100] "demo_fam_exp2_v2"            "demo_fam_exp3_v2"            "demo_fam_exp4_v2"           
# [103] "demo_fam_exp5_v2"            "demo_fam_exp6_v2"            "demo_fam_exp7_v2"           
# [106] "demo_roster_v2"              "demo_roster_v2_refuse"       "fam_roster_2c_v2"           
# [109] "fam_roster_3c_v2"            "fam_roster_4c_v2"            "fam_roster_5c_v2"           
# [112] "fam_roster_6c_v2"            "fam_roster_7c_v2"            "fam_roster_8c_v2"           
# [115] "fam_roster_9c_v2"            "fam_roster_10c_v2"           "fam_roster_11c_v2"          
# [118] "fam_roster_12c_v2"           "fam_roster_13c_v2"           "fam_roster_14c_v2"          
# [121] "fam_roster_15c_v2"           "demo_child_time_v2"          "demo_child_time2_v2"        
# [124] "demo_child_time2_v2_dk"      "demo_child_time3_v2"         "demo_yrs_1"                 
# [127] "demo_yrs_2"                  "eventname"                   "demo_yrs_2a_2"              
# [130] "demo_yrs_2b_2"               "demo_yrs_2_no_display___1"   "demo_race_a_p___0"          
# [133] "demo_yrs_2_2"                "collection_title"            "study_cohort_name"    

#Remove variables that will not be included in analysis
demograph = demograph[,-c(1:3, 5:9,11:16, 33:35, 37:42, 44, 45, 62:72, 74:86, 88:93, 95:135 )]

colnames(demograph)
# [1] "subjectkey"               "demo_prim"                "demo_race_a_p___10"       "demo_race_a_p___11"      
# [5] "demo_race_a_p___12"       "demo_race_a_p___13"       "demo_race_a_p___14"       "demo_race_a_p___15"      
# [9] "demo_race_a_p___16"       "demo_race_a_p___17"       "demo_race_a_p___18"       "demo_race_a_p___19"      
# [13] "demo_race_a_p___20"       "demo_race_a_p___21"       "demo_race_a_p___22"       "demo_race_a_p___23"      
# [17] "demo_race_a_p___24"       "demo_race_a_p___25"       "demo_ethn_v2"             "demo_prnt_age_v2"        
# [21] "demo_prnt_race_a_v2___10" "demo_prnt_race_a_v2___11" "demo_prnt_race_a_v2___12" "demo_prnt_race_a_v2___13"
# [25] "demo_prnt_race_a_v2___14" "demo_prnt_race_a_v2___15" "demo_prnt_race_a_v2___16" "demo_prnt_race_a_v2___17"
# [29] "demo_prnt_race_a_v2___18" "demo_prnt_race_a_v2___19" "demo_prnt_race_a_v2___20" "demo_prnt_race_a_v2___21"
# [33] "demo_prnt_race_a_v2___22" "demo_prnt_race_a_v2___23" "demo_prnt_race_a_v2___24" "demo_prnt_race_a_v2___25"
# [37] "demo_prnt_ethn_v2"        "demo_prnt_ed_v2"          "demo_prtnr_ed_v2"        

#Rename variables
names(demograph)[names(demograph) == "subjectkey"] = "id"
names(demograph)[names(demograph) == "demo_prim"] = "caretaker"
names(demograph)[names(demograph) == "demo_race_a_p___10"] = "c_white"
names(demograph)[names(demograph) == "demo_race_a_p___11"] = "c_black"
names(demograph)[names(demograph) == "demo_race_a_p___12"] = "c_AI"
names(demograph)[names(demograph) == "demo_race_a_p___13"] = "c_alaska"
names(demograph)[names(demograph) == "demo_race_a_p___14"] = "c_hawaii"
names(demograph)[names(demograph) == "demo_race_a_p___15"] = "c_guam"
names(demograph)[names(demograph) == "demo_race_a_p___16"] = "c_samo"
names(demograph)[names(demograph) == "demo_race_a_p___17"] = "c_o_pacific"
names(demograph)[names(demograph) == "demo_race_a_p___18"] = "c_asiani"
names(demograph)[names(demograph) == "demo_race_a_p___19"] = "c_china"
names(demograph)[names(demograph) == "demo_race_a_p___20"] = "c_fili"
names(demograph)[names(demograph) == "demo_race_a_p___21"] = "c_japan"
names(demograph)[names(demograph) == "demo_race_a_p___22"] = "c_korean"
names(demograph)[names(demograph) == "demo_race_a_p___23"] = "c_viet"
names(demograph)[names(demograph) == "demo_race_a_p___24"] = "c_other_a"
names(demograph)[names(demograph) == "demo_race_a_p___25"] = "c_other"
names(demograph)[names(demograph) == "demo_ethn_v2"] = "c_latin"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___10"] = "p_white"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___11"] = "p_black"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___12"] = "p_AI"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___13"] = "p_alaska"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___14"] = "p_hawaii"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___15"] = "p_guam"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___16"] = "p_samo"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___17"] = "p_o_pacific"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___18"] = "p_asiani"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___19"] = "p_china"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___20"] = "p_fili"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___21"] = "p_japan"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___22"] = "p_korean"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___23"] = "p_viet"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___24"] = "p_other_a"
names(demograph)[names(demograph) == "demo_prnt_race_a_v2___25"] = "p_other"
names(demograph)[names(demograph) == "demo_prnt_ethn_v2"] = "p_latin"
names(demograph)[names(demograph) == "demo_prnt_ed_v2"] = "m_educ"
names(demograph)[names(demograph) == "demo_prtnr_ed_v2"] = "p_educ"

colnames(demograph)
# [1] "id"               "caretaker"        "c_white"          "c_black"          "c_AI"             "c_alaska"        
# [7] "c_hawaii"         "c_guam"           "c_samo"           "c_o_pacific"      "c_asiani"         "c_china"         
# [13] "c_fili"           "c_japan"          "c_korean"         "c_viet"           "c_other_a"        "c_other"         
# [19] "c_latin"          "demo_prnt_age_v2" "p_white"          "p_black"          "p_AI"             "p_alaska"        
# [25] "p_hawaii"         "p_guam"           "p_samo"           "p_o_pacific"      "p_asiani"         "p_china"         
# [31] "p_fili"           "p_japan"          "p_korean"         "p_viet"           "p_other_a"        "p_other"         
# [37] "p_latin"          "m_educ"           "p_educ"

#Remove reporter age variable, already have maternal and paternal age in dev_history
demograph = demograph[,-c(20 )]

colnames(demograph)
# [1] "id"          "caretaker"   "c_white"     "c_black"     "c_AI"        "c_alaska"    "c_hawaii"    "c_guam"     
# [9] "c_samo"      "c_o_pacific" "c_asiani"    "c_china"     "c_fili"      "c_japan"     "c_korean"    "c_viet"     
# [17] "c_other_a"   "c_other"     "c_latin"     "p_white"     "p_black"     "p_AI"        "p_alaska"    "p_hawaii"   
# [25] "p_guam"      "p_samo"      "p_o_pacific" "p_asiani"    "p_china"     "p_fili"      "p_japan"     "p_korean"   
# [33] "p_viet"      "p_other_a"   "p_other"     "p_latin"     "m_educ"      "p_educ" 

table(demograph$caretaker, useNA = "ifany")
#     1     2     3     4     5 
# 10135  1182   278   118   163 
#1 = bio mom
#2 = bio dad
#3 = adoptive parent
#4 = custody 
#5 = other

#Recode new variable to be bio mom vs. caretaker 
demograph[which(demograph$caretaker == 5),  "biomom"] = 0
demograph[which(demograph$caretaker == 4),  "biomom"] = 0
demograph[which(demograph$caretaker == 3),  "biomom"] = 0
demograph[which(demograph$caretaker == 2),  "biomom"] = 0
demograph[which(demograph$caretaker == 1),  "biomom"] = 1

table(demograph$biomom, useNA = "ifany")
#   0     1 
# 1741 10135 
#0 = caretaker
#1 = bio mom

#Recode variables into mother, father, and caretaker 
demograph[which(demograph$caretaker == 5),  "caretaker"] = 0
demograph[which(demograph$caretaker == 4),  "caretaker"] = 0
demograph[which(demograph$caretaker == 3),  "caretaker"] = 0

table(demograph$caretaker, useNA = "ifany")
#  0     1     2 
# 559 10135  1182 
#0 = caretaker
#1 = bio mom 
#2 = bio dad

colnames(demograph)
# [1] "id"          "caretaker"   "c_white"     "c_black"     "c_AI"        "c_alaska"    "c_hawaii"    "c_guam"     
# [9] "c_samo"      "c_o_pacific" "c_asiani"    "c_china"     "c_fili"      "c_japan"     "c_korean"    "c_viet"     
# [17] "c_other_a"   "c_other"     "c_latin"     "p_white"     "p_black"     "p_AI"        "p_alaska"    "p_hawaii"   
# [25] "p_guam"      "p_samo"      "p_o_pacific" "p_asiani"    "p_china"     "p_fili"      "p_japan"     "p_korean"   
# [33] "p_viet"      "p_other_a"   "p_other"     "p_latin"     "m_educ"      "p_educ"      "biomom"     

#Child Race Variable
table(demograph$c_white, useNA = "ifany")
#   0    1 
# 3072 8804 

table(demograph$c_black, useNA = "ifany")
# 0    1 
# 9358 2518 

table(demograph$c_AI, useNA = "ifany")
#  0     1 
# 11470   406 

table(demograph$c_alaska, useNA = "ifany")
#     0     1 
# 11871     5 

demograph$c_asian = "0"
demograph[which(demograph$c_asiani == 1 | demograph$c_china == 1 | demograph$c_fili == 1 | demograph$c_japan == 1 | 
                  demograph$c_korean == 1 | demograph$c_viet == 1 | demograph$c_other_a == 1 & 
                  demograph$c_white == 0 & demograph$c_black == 0 & demograph$c_AI == 0 &
                  demograph$c_alaska == 0 & demograph$c_hawaii == 0 & demograph$c_guam == 0 &
                  demograph$c_samo == 0 & demograph$c_o_pacific == 0 & demograph$c_other == 0 &
                  demograph$c_latin == 0),  "c_asian"] = 1

table(demograph$c_asian, useNA = "ifany")
#     0     1 
# 11197   679 

demograph$c_pacific_islander = "0"
demograph[which(demograph$c_hawaii == 1 | demograph$c_guam == 1 | demograph$c_samo == 1 | demograph$c_o_pacific == 1 & 
                  demograph$c_white == 0 & demograph$c_black == 0 & demograph$c_AI == 0 &
                  demograph$c_alaska == 0 & demograph$c_asiani == 0 & demograph$c_china == 0 &
                  demograph$c_fili == 0 & demograph$c_japan == 0 & demograph$c_korean == 0 &
                  demograph$c_viet == 0 & demograph$c_other_a == 0 & demograph$c_other == 0 & 
                  demograph$c_latin == 0),  "c_pacific_islander"] = 1

table(demograph$c_pacific_islander, useNA = "ifany")
#     0     1 
# 11839    37

demograph$c_alaska_nativea = "0"
demograph[which(demograph$c_AI == 1 | demograph$c_alaska == 1 & 
                  demograph$c_white == 0 & demograph$c_black == 0 & demograph$c_AI == 0 &
                  demograph$c_alaska == 0 & demograph$c_asiani == 0 & demograph$c_china == 0 &
                  demograph$c_fili == 0 & demograph$c_japan == 0 & demograph$c_korean == 0 &
                  demograph$c_viet == 0 & demograph$c_other_a == 0 & demograph$c_other == 0 & 
                  demograph$c_latin == 0 & demograph$c_hawaii == 0 & demograph$c_guam == 0 &
                  demograph$c_samo == 0 & demograph$c_o_pacific == 0),  "c_alaska_nativea"] = 1

table(demograph$c_alaska_nativea, useNA = "ifany")
#     0     1 
# 11470   406 

table(demograph$c_latin, useNA = "ifany")
#       1    2  777  999 
# 10 2411 9312   47   96 
#1 = Yes
#2 = No
#777 = Refuse to answer
#999 = Don't Know

#Rescale child latin variable
demograph[which(demograph$c_latin == 2),  "c_latin"] = 0
demograph[which(demograph$c_latin == 777),  "c_latin"] = NA
demograph[which(demograph$c_latin == 999),  "c_latin"] = NA
demograph[which(demograph$c_latin == ""),  "c_latin"] = NA

table(demograph$c_latin, useNA = "ifany")
#       0    1 <NA> 
#   9312 2411  153 
#0 = No
#1 = Yes

#Create a new variable for Mixed race
demograph$c_mixed = "0"
demograph[which(demograph$c_white == 1 & demograph$c_black == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_white == 1 & demograph$c_asian == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_white == 1 & demograph$c_pacific_islander == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_white == 1 & demograph$c_alaska_nativea == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_white == 1 & demograph$c_latin == 1), "c_mixed"] = 1
demograph[which(demograph$c_white == 1 & demograph$c_other == 1), "c_mixed"] = 1
 
demograph[which(demograph$c_black == 1 & demograph$c_asian == 1), "c_mixed"] = 1
demograph[which(demograph$c_black == 1 & demograph$c_pacific_islander == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_black == 1 & demograph$c_latin == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_black == 1 & demograph$c_alaska_nativea == 1), "c_mixed"] = 1
demograph[which(demograph$c_black == 1 & demograph$c_other == 1), "c_mixed"] = 1
 
demograph[which(demograph$c_asian == 1 & demograph$c_pacific_islander == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_asian == 1 & demograph$c_alaska_nativea == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_asian == 1 & demograph$c_latin == 1), "c_mixed"] = 1
demograph[which(demograph$c_asian == 1 & demograph$c_other == 1), "c_mixed"] = 1
 
demograph[which(demograph$c_pacific_islander == 1 & demograph$c_alaska_nativea == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_pacific_islander == 1 & demograph$c_latin == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_pacific_islander == 1 & demograph$c_other == 1), "c_mixed"] = 1
 
demograph[which(demograph$c_alaska_nativea == 1 & demograph$c_latin == 1 ), "c_mixed"] = 1
demograph[which(demograph$c_alaska_nativea == 1 & demograph$c_other == 1), "c_mixed"] = 1
 
demograph[which(demograph$c_latin == 1 & demograph$c_other == 1 ), "c_mixed"] = 1

table(demograph$c_mixed, useNA = "ifany")
#   0    1 
# 8562 3314 
 
#Nested race category (order is important!)- this will be mutually exclusive
demograph$c_race <- ifelse(
   (demograph$c_white == 1), 0, 
      ifelse((demograph$c_black==1),1,
          ifelse((demograph$c_mixed==1),2, 
                ifelse((demograph$c_asian==1),3, 
                        ifelse((demograph$c_latin==1),4,
                              ifelse((demograph$c_alaska_nativea==1),5, 
                                      ifelse((demograph$c_pacific_islander==1),6,    
                                             ifelse((demograph$c_other==1),7, NA)
                                      )))))))
 
table(demograph$c_race, useNA = "ifany")
#       0    1    2    3    4    5    6    7 <NA> 
#   8804 1991  522  231  129   38    5   58   98 
#0 = white
#1 = black 
#2 = mixed
#3 = asian 
#4 = latin 
#5 = alaska + native american 
#6 = pacific islander 
#7 = other 

colnames(demograph)
# [1] "id"                 "caretaker"          "c_white"            "c_black"            "c_AI"              
# [6] "c_alaska"           "c_hawaii"           "c_guam"             "c_samo"             "c_o_pacific"       
# [11] "c_asiani"           "c_china"            "c_fili"             "c_japan"            "c_korean"          
# [16] "c_viet"             "c_other_a"          "c_other"            "c_latin"            "p_white"           
# [21] "p_black"            "p_AI"               "p_alaska"           "p_hawaii"           "p_guam"            
# [26] "p_samo"             "p_o_pacific"        "p_asiani"           "p_china"            "p_fili"            
# [31] "p_japan"            "p_korean"           "p_viet"             "p_other_a"          "p_other"           
# [36] "p_latin"            "m_educ"             "p_educ"             "biomom"             "c_asian"           
# [41] "c_pacific_islander" "c_alaska_nativea"   "c_mixed"            "c_race"         

#Parent Race Variable
table(demograph$p_white, useNA = "ifany")
#   0    1 
# 3216 8660 

table(demograph$p_black, useNA = "ifany")
#   0    1 
# 9840 2036 

demograph$p_asian = "0"
demograph[which(demograph$p_asiani == 1 | demograph$p_china == 1 | demograph$p_fili == 1 | demograph$p_japan == 1 | 
                  demograph$p_korean == 1 | demograph$p_viet == 1 | demograph$p_other_a == 1 & 
                  demograph$p_white == 0 & demograph$p_black == 0 & demograph$p_AI == 0 &
                  demograph$p_alaska == 0 & demograph$p_hawaii == 0 & demograph$p_guam == 0 &
                  demograph$p_samo == 0 & demograph$p_o_pacific == 0 & demograph$p_other == 0 &
                  demograph$p_latin == 0),  "p_asian"] = 1

table(demograph$p_asian, useNA = "ifany")
#     0     1 
# 11394   482 

demograph$p_pacific_islander = "0"
demograph[which(demograph$p_hawaii == 1 | demograph$p_guam == 1 | demograph$p_samo == 1 | demograph$p_o_pacific == 1 & 
                  demograph$p_white == 0 & demograph$p_black == 0 & demograph$p_AI == 0 &
                  demograph$p_alaska == 0 & demograph$p_asiani == 0 & demograph$p_china == 0 &
                  demograph$p_fili == 0 & demograph$p_japan == 0 & demograph$p_korean == 0 &
                  demograph$p_viet == 0 & demograph$p_other_a == 0 & demograph$p_other == 0 & 
                  demograph$p_latin == 0),  "p_pacific_islander"] = 1

table(demograph$p_pacific_islander, useNA = "ifany")
#    0     1 
# 11852    24 

demograph$p_alaska_nativea = "0"
demograph[which(demograph$p_AI == 1 | demograph$p_alaska == 1 & 
                  demograph$p_white == 0 & demograph$p_black == 0 & demograph$p_AI == 0 &
                  demograph$p_alaska == 0 & demograph$p_asiani == 0 & demograph$p_china == 0 &
                  demograph$p_fili == 0 & demograph$p_japan == 0 & demograph$p_korean == 0 &
                  demograph$p_viet == 0 & demograph$p_other_a == 0 & demograph$p_other == 0 & 
                  demograph$p_latin == 0 & demograph$p_hawaii == 0 & demograph$p_guam == 0 &
                  demograph$p_samo == 0 & demograph$p_o_pacific == 0),  "p_alaska_nativea"] = 1

table(demograph$p_alaska_nativea, useNA = "ifany")
#     0     1 
# 11571   305 

table(demograph$p_latin, useNA = "ifany")
#       1    2  777  999 
# 2 2034 9770   23   47 
#1 = Yes
#2 = No
#777 = Refuse to answer
#999 = Don't Know

#Rescale parent latin variable
demograph[which(demograph$p_latin == 2),  "p_latin"] = 0
demograph[which(demograph$p_latin == 777),  "p_latin"] = NA
demograph[which(demograph$p_latin == 999),  "p_latin"] = NA
demograph[which(demograph$p_latin == ""),  "p_latin"] = NA

table(demograph$p_latin, useNA = "ifany")
#      0    1 <NA> 
#   9770 2034   72 
#0 = No
#1 = Yes

#Create a new variable for Mixed race
demograph$p_mixed = "0"
demograph[which(demograph$p_white == 1 & demograph$p_black == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_white == 1 & demograph$p_asian == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_white == 1 & demograph$p_pacifip_islander == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_white == 1 & demograph$p_alaska_nativea == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_white == 1 & demograph$p_latin == 1), "p_mixed"] = 1
demograph[which(demograph$p_white == 1 & demograph$p_other == 1), "p_mixed"] = 1

demograph[which(demograph$p_black == 1 & demograph$p_asian == 1), "p_mixed"] = 1
demograph[which(demograph$p_black == 1 & demograph$p_pacifip_islander == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_black == 1 & demograph$p_latin == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_black == 1 & demograph$p_alaska_nativea == 1), "p_mixed"] = 1
demograph[which(demograph$p_black == 1 & demograph$p_other == 1), "p_mixed"] = 1

demograph[which(demograph$p_asian == 1 & demograph$p_pacifip_islander == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_asian == 1 & demograph$p_alaska_nativea == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_asian == 1 & demograph$p_latin == 1), "p_mixed"] = 1
demograph[which(demograph$p_asian == 1 & demograph$p_other == 1), "p_mixed"] = 1

demograph[which(demograph$p_pacifip_islander == 1 & demograph$p_alaska_nativea == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_pacifip_islander == 1 & demograph$p_latin == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_pacifip_islander == 1 & demograph$p_other == 1), "p_mixed"] = 1

demograph[which(demograph$p_alaska_nativea == 1 & demograph$p_latin == 1 ), "p_mixed"] = 1
demograph[which(demograph$p_alaska_nativea == 1 & demograph$p_other == 1), "p_mixed"] = 1

demograph[which(demograph$p_latin == 1 & demograph$p_other == 1 ), "p_mixed"] = 1

# table(demograph$p_mixed, useNA = "ifany")
#   0    1 
# 9564 2312

#Nested race category (order is important!)- this will be mutually exclusive
demograph$p_race <- ifelse(
  (demograph$p_white == 1), 0, 
  ifelse((demograph$p_black==1),1,
         ifelse((demograph$p_mixed==1),2, 
                ifelse((demograph$p_asian==1),3, 
                       ifelse((demograph$p_latin==1),4,
                              ifelse((demograph$p_alaska_nativea==1),5, 
                                     ifelse((demograph$p_pacific_islander==1),6,    
                                            ifelse((demograph$p_other==1),7, NA)
                                     )))))))

table(demograph$p_race, useNA = "ifany")
#      0    1    2    3    4    5    6    7 <NA> 
#   8660 1888  551  355  170   35    5   47  165 
#0 = white
#1 = black 
#2 = mixed
#3 = asian 
#4 = latin 
#5 = alaska + native american 
#6 = pacific islander 
#7 = other 

colnames(demograph)
# [1] "id"                 "caretaker"          "c_white"            "c_black"            "c_AI"              
# [6] "c_alaska"           "c_hawaii"           "c_guam"             "c_samo"             "c_o_pacific"       
# [11] "c_asiani"           "c_china"            "c_fili"             "c_japan"            "c_korean"          
# [16] "c_viet"             "c_other_a"          "c_other"            "c_latin"            "p_white"           
# [21] "p_black"            "p_AI"               "p_alaska"           "p_hawaii"           "p_guam"            
# [26] "p_samo"             "p_o_pacific"        "p_asiani"           "p_china"            "p_fili"            
# [31] "p_japan"            "p_korean"           "p_viet"             "p_other_a"          "p_other"           
# [36] "p_latin"            "m_educ"             "p_educ"             "biomom"             "c_asian"           
# [41] "c_pacific_islander" "c_alaska_nativea"   "c_mixed"            "c_race"             "p_asian"           
# [46] "p_pacific_islander" "p_alaska_nativea"   "p_mixed"            "p_race"      

#Remove extra race variables now that new race variable created
demograph = demograph[,-c(3:36, 40:43, 45:48)]

colnames(demograph)
# [1] "id"        "caretaker" "m_educ"    "p_educ"    "biomom"    "c_race"    "p_race"   

#Table to look at education variables
table(demograph$m_educ, useNA = "ifany")
# 1   10   11   12   13   14   15   16   17   18   19    2   20   21    3    4    5    6    7  777    8    9 
# 2  107  193  182  992  268 1949  874  664 3333 2279    1  334  380   10    8    3   62   21   17   61  136 
#0 = Never attended/ Kindergarten only 
#1 = 1st grade
#2 = 2nd grade
#3 = 3rd grade
#4 = 4th grade
#5 = 5th grade
#6 = 6th grade
#7 = 7th grade
#8 = 8th grade
#9 = 9th grade
#10 = 10th grade
#11 = 11th grade
#12 = 12th grade
#13 = High school graduate 
#14 = GED or equivalent 
#15 = Some college 
#16 = Associate degree
#17 = Associate degree
#18 = Bachelor's degree
#19 = Master's degree
#20 = Professional School degree
#21 = Doctoral degree
#777 = Refused to answer

table(demograph$p_educ, useNA = "ifany")
#         0    1   10   11   12   13   14   15   16   17   18   19    2   20   21    3    4    5    6    7  777    8 
# 2400    4    6  100  107  240 1083  338 1289  656  394 2595 1537    4  397  366   18   10   16   66   22   13   50 
#   9  999 
# 112   53 
#0 = Never attended/ Kindergarten only 
#1 = 1st grade
#2 = 2nd grade
#3 = 3rd grade
#4 = 4th grade
#5 = 5th grade
#6 = 6th grade
#7 = 7th grade
#8 = 8th grade
#9 = 9th grade
#10 = 10th grade
#11 = 11th grade
#12 = 12th grade
#13 = High school graduate 
#14 = GED or equivalent 
#15 = Some college 
#16 = Associate degree
#17 = Associate degree
#18 = Bachelor's degree
#19 = Master's degree
#20 = Professional School degree
#21 = Doctoral degree
#777 = Refused to answer
#999 = Don't know

#Rescale variables so 777 is NA
demograph[which(demograph$m_educ == 777),  "m_educ"] = NA
demograph[which(demograph$p_educ == 777),  "p_educ"] = NA
demograph[which(demograph$p_educ == 999),  "p_educ"] = NA
demograph[which(demograph$p_educ == ""),  "p_educ"] = NA

table(demograph$m_educ, useNA = "ifany")
#   1   10   11   12   13   14   15   16   17   18   19    2   20   21    3    4    5    6    7    8    9 <NA> 
#   2  107  193  182  992  268 1949  874  664 3333 2279    1  334  380   10    8    3   62   21   61  136   17 

table(demograph$p_educ, useNA = "ifany")
#   0    1   10   11   12   13   14   15   16   17   18   19    2   20   21    3    4    5    6    7    8    9 <NA> 
#   4    6  100  107  240 1083  338 1289  656  394 2595 1537    4  397  366   18   10   16   66   22   50  112 2466 



#Breastfeeding Questionnaire- 3 year follow-up only (cannot use, too much missingness) ----

#Add path and file name
bfeed  = read.delim(file("breast_feeding01.txt"))
bfeed = bfeed[-c(1),]
dim(bfeed) 
# [1] 6251  100





#Neighborhood Safety Variables to be included within the Propensity Score ----

neighborhood  = read.delim(file("abcd_pnsc01.txt"))
neighborhood = neighborhood[-c(1),]
dim(neighborhood) 
# [1] 33515    15

colnames(neighborhood)
# [1] "collection_id"             "abcd_pnsc01_id"            "dataset_id"                "subjectkey"               
# [5] "src_subject_id"            "interview_date"            "interview_age"             "sex"                      
# [9] "eventname"                 "nei_p_select_language___1" "neighborhood1r_p"          "neighborhood2r_p"         
# [13] "neighborhood3r_p"          "collection_title"          "study_cohort_name"   

neighborhood = neighborhood[,-c(1:3, 5, 6, 8, 10, 14, 15)]

colnames(neighborhood)
# [1] "subjectkey"       "interview_age"    "eventname"        "neighborhood1r_p" "neighborhood2r_p" "neighborhood3r_p"

#Rename variables
names(neighborhood)[names(neighborhood) == "subjectkey"] = "id"
names(neighborhood)[names(neighborhood) == "interview_age"] = "age"
names(neighborhood)[names(neighborhood) == "eventname"] = "timepoint"
names(neighborhood)[names(neighborhood) == "neighborhood1r_p"] = "safe_walk"
names(neighborhood)[names(neighborhood) == "neighborhood2r_p"] = "violence"
names(neighborhood)[names(neighborhood) == "neighborhood3r_p"] = "safe_crime"

colnames(neighborhood)
# [1] "id"         "age"        "timepoint"  "safe_walk"  "violence"   "safe_crime"

table(neighborhood$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1  2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                     10414                       11876 


table(neighborhood$safe_walk, useNA = "ifany")
#       1     2     3     4     5 
# 114   872  1510  4420 12491 14108 

table(neighborhood$violence, useNA = "ifany")
#       1     2     3     4     5 
# 149  1459  2277  5141 11920 12569

table(neighborhood$safe_crime, useNA = "ifany")
#        1     2     3     4     5 
# 179  1726  4071  8420 11521  7598 

#Rescale variables- make "" into NA 
colnames(neighborhood)
neighborhood[, c(4:6)][neighborhood[, c(4:6)] == ""] <- NA

table(neighborhood$safe_walk, useNA = "ifany")
#     1     2     3     4     5  <NA> 
#   872  1510  4420 12491 14108   114  

table(neighborhood$violence, useNA = "ifany")
#       1     2     3     4     5  <NA> 
#   1459  2277  5141 11920 12569   149 

table(neighborhood$safe_crime, useNA = "ifany")
#     1     2     3     4     5  <NA> 
#   1726  4071  8420 11521  7598   179 

#Rescale neighborhood variables

table(neighborhood$safe_walk, useNA = "ifany")
#     1     2     3     4     5  <NA> 
#   872  1510  4420 12491 14108   114  
#1 = Strongly Disagree
#2 = Disagree
#3 = Neutral
#4 = Agree
#5 = Strongly Agree

neighborhood[which(neighborhood$safe_walk == 1),  "safe_walk"] = 0
neighborhood[which(neighborhood$safe_walk == 2),  "safe_walk"] = 1
neighborhood[which(neighborhood$safe_walk == 3),  "safe_walk"] = 2
neighborhood[which(neighborhood$safe_walk == 4),  "safe_walk"] = 3
neighborhood[which(neighborhood$safe_walk == 5),  "safe_walk"] = 4

table(neighborhood$safe_walk, useNA = "ifany")
#   0     1     2     3     4  <NA> 
# 872  1510  4420 12491 14108   114 
#0 = Strongly Disagree
#1 = Disagree
#2 = Neutral
#3 = Agree
#4 = Strongly Agree

table(neighborhood$violence, useNA = "ifany")
#       1     2     3     4     5  <NA> 
#   1459  2277  5141 11920 12569   149 
#1 = Strongly Disagree
#2 = Disagree
#3 = Neutral
#4 = Agree
#5 = Strongly Agree

neighborhood[which(neighborhood$violence == 1),  "violence"] = 0
neighborhood[which(neighborhood$violence == 2),  "violence"] = 1
neighborhood[which(neighborhood$violence == 3),  "violence"] = 2
neighborhood[which(neighborhood$violence == 4),  "violence"] = 3
neighborhood[which(neighborhood$violence == 5),  "violence"] = 4

table(neighborhood$violence, useNA = "ifany")
#     0     1     2     3     4  <NA> 
#   1459  2277  5141 11920 12569   149 
#0 = Strongly Disagree
#1 = Disagree
#2 = Neutral
#3 = Agree
#4 = Strongly Agree

table(neighborhood$safe_crime, useNA = "ifany")
#     1     2     3     4     5  <NA> 
#   1726  4071  8420 11521  7598   179 
#1 = Strongly Disagree
#2 = Disagree
#3 = Neutral
#4 = Agree
#5 = Strongly Agree

neighborhood[which(neighborhood$safe_crime == 1),  "safe_crime"] = 0
neighborhood[which(neighborhood$safe_crime == 2),  "safe_crime"] = 1
neighborhood[which(neighborhood$safe_crime == 3),  "safe_crime"] = 2
neighborhood[which(neighborhood$safe_crime == 4),  "safe_crime"] = 3
neighborhood[which(neighborhood$safe_crime == 5),  "safe_crime"] = 4

table(neighborhood$safe_crime, useNA = "ifany")
#     0     1     2     3     4  <NA> 
#   1726  4071  8420 11521  7598   179 
#0 = Strongly Disagree
#1 = Disagree
#2 = Neutral
#3 = Agree
#4 = Strongly Agree

table(neighborhood$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                        11876 

#Label timepoint data 
neighborhood[which(neighborhood$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
neighborhood[which(neighborhood$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
neighborhood[which(neighborhood$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2

table(neighborhood$timepoint, useNA = "ifany")
# 0     1     2 
# 11876 11225 10414 

#Double check that an additional variable was not made
colnames(neighborhood)
# [1] "id"         "age"        "timepoint"  "safe_walk"  "violence"   "safe_crime"

#Reshape data to wide 
neigh_wide = reshape(neighborhood, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(neigh_wide)
# [1] "id"           "age.0"        "safe_walk.0"  "violence.0"   "safe_crime.0" "age.2"        "safe_walk.2" 
# [8] "violence.2"   "safe_crime.2" "age.1"        "safe_walk.1"  "violence.1"   "safe_crime.1"

#Change variables into numeric in order to create summary scores
neigh_wide$safe_walk.0 = as.numeric(neigh_wide$safe_walk.0)
neigh_wide$violence.0 = as.numeric(neigh_wide$violence.0)
neigh_wide$safe_crime.0 = as.numeric(neigh_wide$safe_crime.0)
neigh_wide$safe_walk.2 = as.numeric(neigh_wide$safe_walk.2)
neigh_wide$violence.2 = as.numeric(neigh_wide$violence.2)
neigh_wide$safe_crime.2 = as.numeric(neigh_wide$safe_crime.2)
neigh_wide$safe_walk.1 = as.numeric(neigh_wide$safe_walk.1)
neigh_wide$violence.1 = as.numeric(neigh_wide$violence.1)
neigh_wide$safe_crime.1 = as.numeric(neigh_wide$safe_crime.1)

colnames(neigh_wide)

#summary scores (na.rm=T would only calculate the scores for the participants you have)
neigh_wide$total_neigh.0 = round(rowMeans(neigh_wide[,c(3,4,5)], na.rm=T))
neigh_wide$total_neigh.1 = round(rowMeans(neigh_wide[,c(11,12,13)], na.rm=T))
neigh_wide$total_neigh.2 = round(rowMeans(neigh_wide[,c(7,8,9)], na.rm=T))

colnames(neigh_wide)

table(neigh_wide$total_neigh.0, useNA = "ifany")
#   0    1    2    3    4  NaN 
# 320  857 2312 4498 3881    8 

table(neigh_wide$total_neigh.1, useNA = "ifany")
#   0    1    2    3    4  NaN 
# 266  790 2222 4333 3596  669 

table(neigh_wide$total_neigh.2, useNA = "ifany")
#   0    1    2    3    4  NaN 
# 234  659 2215 4116 3102 1550 








#Parent Family History- Alcohol, drug use, depression- Propensity Score ----

#Add path and file name
fam_history  = read.delim(file("abcd_fhxssp01.txt"))
fam_history = fam_history[-c(1),]
dim(fam_history) 
# [1] 11876   491

colnames(fam_history)
# [1] "collection_id"                 "abcd_fhxssp01_id"              "dataset_id"                   
# [4] "subjectkey"                    "src_subject_id"                "interview_date"               
# [7] "interview_age"                 "sex"                           "eventname"                    
# [10] "famhx_ss_fath_prob_alc_p"      "famhx_ss_patgf_prob_alc_p"     "famhx_ss_patgm_prob_alc_p"    
# [13] "famhx_ss_moth_prob_alc_p"      "famhx_ss_matgf_prob_alc_p"     "famhx_ss_matgm_prob_alc_p"    
# [16] "famhx_ss_patunc1_prob_alc_p"   "famhx_ss_patunc2_prob_alc_p"   "famhx_ss_patunc3_prob_alc_p"  
# [19] "famhx_ss_patunc4_prob_alc_p"   "famhx_ss_patunc5_prob_alc_p"   "famhx_ss_patant1_prob_alc_p"  
# [22] "famhx_ss_patant2_prob_alc_p"   "famhx_ss_patant3_prob_alc_p"   "famhx_ss_patant4_prob_alc_p"  
# [25] "famhx_ss_patant5_prob_alc_p"   "famhx_ss_matunc1_prob_alc_p"   "famhx_ss_matunc2_prob_alc_p"  
# [28] "famhx_ss_matunc3_prob_alc_p"   "famhx_ss_matunc4_prob_alc_p"   "famhx_ss_matunc5_prob_alc_p"  
# [31] "famhx_ss_matant1_prob_alc_p"   "famhx_ss_matant2_prob_alc_p"   "famhx_ss_matant3_prob_alc_p"  
# [34] "famhx_ss_matant4_prob_alc_p"   "famhx_ss_matant5_prob_alc_p"   "famhx_ss_fulsiby1_prob_alc_p" 
# [37] "famhx_ss_fulsiby2_prob_alc_p"  "famhx_ss_fulsiby3_prob_alc_p"  "famhx_ss_fulsiby4_prob_alc_p" 
# [40] "famhx_ss_fulsiby5_prob_alc_p"  "famhx_ss_fulsibo1_prob_alc_p"  "famhx_ss_fulsibo2_prob_alc_p" 
# [43] "famhx_ss_fulsibo3_prob_alc_p"  "famhx_ss_fulsibo4_prob_alc_p"  "famhx_ss_fulsibo5_prob_alc_p" 
# [46] "famhx_ss_hlfsiby1_prob_alc_p"  "famhx_ss_hlfsiby2_prob_alc_p"  "famhx_ss_hlfsiby3_prob_alc_p" 
# [49] "famhx_ss_hlfsiby4_prob_alc_p"  "famhx_ss_hlfsiby5_prob_alc_p"  "famhx_ss_hlfsibo1_prob_alc_p" 
# [52] "famhx_ss_hlfsibo2_prob_alc_p"  "famhx_ss_hlfsibo3_prob_alc_p"  "famhx_ss_hlfsibo4_prob_alc_p" 
# [55] "famhx_ss_hlfsibo5_prob_alc_p"  "famhx_ss_momdad_alc_p"         "famhx_ss_parent_alc_p"        
# [58] "famhx_ss_fath_prob_dg_p"       "famhx_ss_patgf_prob_dg_p"      "famhx_ss_patgm_prob_dg_p"     
# [61] "famhx_ss_moth_prob_dg_p"       "famhx_ss_matgf_prob_dg_p"      "famhx_ss_matgm_prob_dg_p"     
# [64] "famhx_ss_patunc1_prob_dg_p"    "famhx_ss_patunc2_prob_dg_p"    "famhx_ss_patunc3_prob_dg_p"   
# [67] "famhx_ss_patunc4_prob_dg_p"    "famhx_ss_patunc5_prob_dg_p"    "famhx_ss_patant1_prob_dg_p"   
# [70] "famhx_ss_patant2_prob_dg_p"    "famhx_ss_patant3_prob_dg_p"    "famhx_ss_patant4_prob_dg_p"   
# [73] "famhx_ss_patant5_prob_dg_p"    "famhx_ss_matunc1_prob_dg_p"    "famhx_ss_matunc2_prob_dg_p"   
# [76] "famhx_ss_matunc3_prob_dg_p"    "famhx_ss_matunc4_prob_dg_p"    "famhx_ss_matunc5_prob_dg_p"   
# [79] "famhx_ss_matant1_prob_dg_p"    "famhx_ss_matant2_prob_dg_p"    "famhx_ss_matant3_prob_dg_p"   
# [82] "famhx_ss_matant4_prob_dg_p"    "famhx_ss_matant5_prob_dg_p"    "famhx_ss_fulsiby1_prob_dg_p"  
# [85] "famhx_ss_fulsiby2_prob_dg_p"   "famhx_ss_fulsiby3_prob_dg_p"   "famhx_ss_fulsiby4_prob_dg_p"  
# [88] "famhx_ss_fulsiby5_prob_dg_p"   "famhx_ss_fulsibo1_prob_dg_p"   "famhx_ss_fulsibo2_prob_dg_p"  
# [91] "famhx_ss_fulsibo3_prob_dg_p"   "famhx_ss_fulsibo4_prob_dg_p"   "famhx_ss_fulsibo5_prob_dg_p"  
# [94] "famhx_ss_hlfsiby1_prob_dg_p"   "famhx_ss_hlfsiby2_prob_dg_p"   "famhx_ss_hlfsiby3_prob_dg_p"  
# [97] "famhx_ss_hlfsiby4_prob_dg_p"   "famhx_ss_hlfsiby5_prob_dg_p"   "famhx_ss_hlfsibo1_prob_dg_p"  
# [100] "famhx_ss_hlfsibo2_prob_dg_p"   "famhx_ss_hlfsibo3_prob_dg_p"   "famhx_ss_hlfsibo4_prob_dg_p"  
# [103] "famhx_ss_hlfsibo5_prob_dg_p"   "famhx_ss_momdad_dg_p"          "famhx_ss_parent_dg_p"         
# [106] "famhx_ss_fath_prob_dprs_p"     "famhx_ss_patgf_prob_dprs_p"    "famhx_ss_patgm_prob_dprs_p"   
# [109] "famhx_ss_moth_prob_dprs_p"     "famhx_ss_matgf_prob_dprs_p"    "famhx_ss_matgm_prob_dprs_p"   
# [112] "famhx_ss_patunc1_prob_dprs_p"  "famhx_ss_patunc2_prob_dprs_p"  "famhx_ss_patunc3_prob_dprs_p" 
# [115] "famhx_ss_patunc4_prob_dprs_p"  "famhx_ss_patunc5_prob_dprs_p"  "famhx_ss_patant1_prob_dprs_p" 
# [118] "famhx_ss_patant2_prob_dprs_p"  "famhx_ss_patant3_prob_dprs_p"  "famhx_ss_patant4_prob_dprs_p" 
# [121] "famhx_ss_patant5_prob_dprs_p"  "famhx_ss_matunc1_prob_dprs_p"  "famhx_ss_matunc2_prob_dprs_p" 
# [124] "famhx_ss_matunc3_prob_dprs_p"  "famhx_ss_matunc4_prob_dprs_p"  "famhx_ss_matunc5_prob_dprs_p" 
# [127] "famhx_ss_matant1_prob_dprs_p"  "famhx_ss_matant2_prob_dprs_p"  "famhx_ss_matant3_prob_dprs_p" 
# [130] "famhx_ss_matant4_prob_dprs_p"  "famhx_ss_matant5_prob_dprs_p"  "famhx_ss_fulsiby1_prob_dprs_p"
# [133] "famhx_ss_fulsiby2_prob_dprs_p" "famhx_ss_fulsiby3_prob_dprs_p" "famhx_ss_fulsiby4_prob_dprs_p"
# [136] "famhx_ss_fulsiby5_prob_dprs_p" "famhx_ss_fulsibo1_prob_dprs_p" "famhx_ss_fulsibo2_prob_dprs_p"
# [139] "famhx_ss_fulsibo3_prob_dprs_p" "famhx_ss_fulsibo4_prob_dprs_p" "famhx_ss_fulsibo5_prob_dprs_p"
# [142] "famhx_ss_hlfsiby1_prob_dprs_p" "famhx_ss_hlfsiby2_prob_dprs_p" "famhx_ss_hlfsiby3_prob_dprs_p"
# [145] "famhx_ss_hlfsiby4_prob_dprs_p" "famhx_ss_hlfsiby5_prob_dprs_p" "famhx_ss_hlfsibo1_prob_dprs_p"
# [148] "famhx_ss_hlfsibo2_prob_dprs_p" "famhx_ss_hlfsibo3_prob_dprs_p" "famhx_ss_hlfsibo4_prob_dprs_p"
# [151] "famhx_ss_hlfsibo5_prob_dprs_p" "famhx_ss_momdad_dprs_p"        "famhx_ss_parent_dprs_p"       
# [154] "famhx_ss_fath_prob_ma_p"       "famhx_ss_patgf_prob_ma_p"      "famhx_ss_patgm_prob_ma_p"     
# [157] "famhx_ss_moth_prob_ma_p"       "famhx_ss_matgf_prob_ma_p"      "famhx_ss_matgm_prob_ma_p"     
# [160] "famhx_ss_patunc1_prob_ma_p"    "famhx_ss_patunc2_prob_ma_p"    "famhx_ss_patunc3_prob_ma_p"   
# [163] "famhx_ss_patunc4_prob_ma_p"    "famhx_ss_patunc5_prob_ma_p"    "famhx_ss_patant1_prob_ma_p"   
# [166] "famhx_ss_patant2_prob_ma_p"    "famhx_ss_patant3_prob_ma_p"    "famhx_ss_patant4_prob_ma_p"   
# [169] "famhx_ss_patant5_prob_ma_p"    "famhx_ss_matunc1_prob_ma_p"    "famhx_ss_matunc2_prob_ma_p"   
# [172] "famhx_ss_matunc3_prob_ma_p"    "famhx_ss_matunc4_prob_ma_p"    "famhx_ss_matunc5_prob_ma_p"   
# [175] "famhx_ss_matant1_prob_ma_p"    "famhx_ss_matant2_prob_ma_p"    "famhx_ss_matant3_prob_ma_p"   
# [178] "famhx_ss_matant4_prob_ma_p"    "famhx_ss_matant5_prob_ma_p"    "famhx_ss_fulsiby1_prob_ma_p"  
# [181] "famhx_ss_fulsiby2_prob_ma_p"   "famhx_ss_fulsiby3_prob_ma_p"   "famhx_ss_fulsiby4_prob_ma_p"  
# [184] "famhx_ss_fulsiby5_prob_ma_p"   "famhx_ss_fulsibo1_prob_ma_p"   "famhx_ss_fulsibo2_prob_ma_p"  
# [187] "famhx_ss_fulsibo3_prob_ma_p"   "famhx_ss_fulsibo4_prob_ma_p"   "famhx_ss_fulsibo5_prob_ma_p"  
# [190] "famhx_ss_hlfsiby1_prob_ma_p"   "famhx_ss_hlfsiby2_prob_ma_p"   "famhx_ss_hlfsiby3_prob_ma_p"  
# [193] "famhx_ss_hlfsiby4_prob_ma_p"   "famhx_ss_hlfsiby5_prob_ma_p"   "famhx_ss_hlfsibo1_prob_ma_p"  
# [196] "famhx_ss_hlfsibo2_prob_ma_p"   "famhx_ss_hlfsibo3_prob_ma_p"   "famhx_ss_hlfsibo4_prob_ma_p"  
# [199] "famhx_ss_hlfsibo5_prob_ma_p"   "famhx_ss_momdad_ma_p"          "famhx_ss_parent_ma_p"         
# [202] "famhx_ss_fath_prob_vs_p"       "famhx_ss_patgf_prob_vs_p"      "famhx_ss_patgm_prob_vs_p"     
# [205] "famhx_ss_moth_prob_vs_p"       "famhx_ss_matgf_prob_vs_p"      "famhx_ss_matgm_prob_vs_p"     
# [208] "famhx_ss_patunc1_prob_vs_p"    "famhx_ss_patunc2_prob_vs_p"    "famhx_ss_patunc3_prob_vs_p"   
# [211] "famhx_ss_patunc4_prob_vs_p"    "famhx_ss_patunc5_prob_vs_p"    "famhx_ss_patant1_prob_vs_p"   
# [214] "famhx_ss_patant2_prob_vs_p"    "famhx_ss_patant3_prob_vs_p"    "famhx_ss_patant4_prob_vs_p"   
# [217] "famhx_ss_patant5_prob_vs_p"    "famhx_ss_matunc1_prob_vs_p"    "famhx_ss_matunc2_prob_vs_p"   
# [220] "famhx_ss_matunc3_prob_vs_p"    "famhx_ss_matunc4_prob_vs_p"    "famhx_ss_matunc5_prob_vs_p"   
# [223] "famhx_ss_matant1_prob_vs_p"    "famhx_ss_matant2_prob_vs_p"    "famhx_ss_matant3_prob_vs_p"   
# [226] "famhx_ss_matant4_prob_vs_p"    "famhx_ss_matant5_prob_vs_p"    "famhx_ss_fulsiby1_prob_vs_p"  
# [229] "famhx_ss_fulsiby2_prob_vs_p"   "famhx_ss_fulsiby3_prob_vs_p"   "famhx_ss_fulsiby4_prob_vs_p"  
# [232] "famhx_ss_fulsiby5_prob_vs_p"   "famhx_ss_fulsibo1_prob_vs_p"   "famhx_ss_fulsibo2_prob_vs_p"  
# [235] "famhx_ss_fulsibo3_prob_vs_p"   "famhx_ss_fulsibo4_prob_vs_p"   "famhx_ss_fulsibo5_prob_vs_p"  
# [238] "famhx_ss_hlfsiby1_prob_vs_p"   "famhx_ss_hlfsiby2_prob_vs_p"   "famhx_ss_hlfsiby3_prob_vs_p"  
# [241] "famhx_ss_hlfsiby4_prob_vs_p"   "famhx_ss_hlfsiby5_prob_vs_p"   "famhx_ss_hlfsibo1_prob_vs_p"  
# [244] "famhx_ss_hlfsibo2_prob_vs_p"   "famhx_ss_hlfsibo3_prob_vs_p"   "famhx_ss_hlfsibo4_prob_vs_p"  
# [247] "famhx_ss_hlfsibo5_prob_vs_p"   "famhx_ss_momdad_vs_p"          "famhx_ss_parent_vs_p"         
# [250] "famhx_ss_fath_prob_trb_p"      "famhx_ss_patgf_prob_trb_p"     "famhx_ss_patgm_prob_trb_p"    
# [253] "famhx_ss_moth_prob_trb_p"      "famhx_ss_matgf_prob_trb_p"     "famhx_ss_matgm_prob_trb_p"    
# [256] "famhx_ss_patunc1_prob_trb_p"   "famhx_ss_patunc2_prob_trb_p"   "famhx_ss_patunc3_prob_trb_p"  
# [259] "famhx_ss_patunc4_prob_trb_p"   "famhx_ss_patunc5_prob_trb_p"   "famhx_ss_patant1_prob_trb_p"  
# [262] "famhx_ss_patant2_prob_trb_p"   "famhx_ss_patant3_prob_trb_p"   "famhx_ss_patant4_prob_trb_p"  
# [265] "famhx_ss_patant5_prob_trb_p"   "famhx_ss_matunc1_prob_trb_p"   "famhx_ss_matunc2_prob_trb_p"  
# [268] "famhx_ss_matunc3_prob_trb_p"   "famhx_ss_matunc4_prob_trb_p"   "famhx_ss_matunc5_prob_trb_p"  
# [271] "famhx_ss_matant1_prob_trb_p"   "famhx_ss_matant2_prob_trb_p"   "famhx_ss_matant3_prob_trb_p"  
# [274] "famhx_ss_matant4_prob_trb_p"   "famhx_ss_matant5_prob_trb_p"   "famhx_ss_fulsiby1_prob_trb_p" 
# [277] "famhx_ss_fulsiby2_prob_trb_p"  "famhx_ss_fulsiby3_prob_trb_p"  "famhx_ss_fulsiby4_prob_trb_p" 
# [280] "famhx_ss_fulsiby5_prob_trb_p"  "famhx_ss_fulsibo1_prob_trb_p"  "famhx_ss_fulsibo2_prob_trb_p" 
# [283] "famhx_ss_fulsibo3_prob_trb_p"  "famhx_ss_fulsibo4_prob_trb_p"  "famhx_ss_fulsibo5_prob_trb_p" 
# [286] "famhx_ss_hlfsiby1_prob_trb_p"  "famhx_ss_hlfsiby2_prob_trb_p"  "famhx_ss_hlfsiby3_prob_trb_p" 
# [289] "famhx_ss_hlfsiby4_prob_trb_p"  "famhx_ss_hlfsiby5_prob_trb_p"  "famhx_ss_hlfsibo1_prob_trb_p" 
# [292] "famhx_ss_hlfsibo2_prob_trb_p"  "famhx_ss_hlfsibo3_prob_trb_p"  "famhx_ss_hlfsibo4_prob_trb_p" 
# [295] "famhx_ss_hlfsibo5_prob_trb_p"  "famhx_ss_momdad_trb_p"         "famhx_ss_parent_trb_p"        
# [298] "famhx_ss_fath_prob_nrv_p"      "famhx_ss_patgf_prob_nrv_p"     "famhx_ss_patgm_prob_nrv_p"    
# [301] "famhx_ss_moth_prob_nrv_p"      "famhx_ss_matgf_prob_nrv_p"     "famhx_ss_matgm_prob_nrv_p"    
# [304] "famhx_ss_patunc1_prob_nrv_p"   "famhx_ss_patunc2_prob_nrv_p"   "famhx_ss_patunc3_prob_nrv_p"  
# [307] "famhx_ss_patunc4_prob_nrv_p"   "famhx_ss_patunc5_prob_nrv_p"   "famhx_ss_patant1_prob_nrv_p"  
# [310] "famhx_ss_patant2_prob_nrv_p"   "famhx_ss_patant3_prob_nrv_p"   "famhx_ss_patant4_prob_nrv_p"  
# [313] "famhx_ss_patant5_prob_nrv_p"   "famhx_ss_matunc1_prob_nrv_p"   "famhx_ss_matunc2_prob_nrv_p"  
# [316] "famhx_ss_matunc3_prob_nrv_p"   "famhx_ss_matunc4_prob_nrv_p"   "famhx_ss_matunc5_prob_nrv_p"  
# [319] "famhx_ss_matant1_prob_nrv_p"   "famhx_ss_matant2_prob_nrv_p"   "famhx_ss_matant3_prob_nrv_p"  
# [322] "famhx_ss_matant4_prob_nrv_p"   "famhx_ss_matant5_prob_nrv_p"   "famhx_ss_fulsiby1_prob_nrv_p" 
# [325] "famhx_ss_fulsiby2_prob_nrv_p"  "famhx_ss_fulsiby3_prob_nrv_p"  "famhx_ss_fulsiby4_prob_nrv_p" 
# [328] "famhx_ss_fulsiby5_prob_nrv_p"  "famhx_ss_fulsibo1_prob_nrv_p"  "famhx_ss_fulsibo2_prob_nrv_p" 
# [331] "famhx_ss_fulsibo3_prob_nrv_p"  "famhx_ss_fulsibo4_prob_nrv_p"  "famhx_ss_fulsibo5_prob_nrv_p" 
# [334] "famhx_ss_hlfsiby1_prob_nrv_p"  "famhx_ss_hlfsiby2_prob_nrv_p"  "famhx_ss_hlfsiby3_prob_nrv_p" 
# [337] "famhx_ss_hlfsiby4_prob_nrv_p"  "famhx_ss_hlfsiby5_prob_nrv_p"  "famhx_ss_hlfsibo1_prob_nrv_p" 
# [340] "famhx_ss_hlfsibo2_prob_nrv_p"  "famhx_ss_hlfsibo3_prob_nrv_p"  "famhx_ss_hlfsibo4_prob_nrv_p" 
# [343] "famhx_ss_hlfsibo5_prob_nrv_p"  "famhx_ss_momdad_nrv_p"         "famhx_ss_parent_nrv_p"        
# [346] "famhx_ss_fath_prob_prf_p"      "famhx_ss_patgf_prob_prf_p"     "famhx_ss_patgm_prob_prf_p"    
# [349] "famhx_ss_moth_prob_prf_p"      "famhx_ss_matgf_prob_prf_p"     "famhx_ss_matgm_prob_prf_p"    
# [352] "famhx_ss_patunc1_prob_prf_p"   "famhx_ss_patunc2_prob_prf_p"   "famhx_ss_patunc3_prob_prf_p"  
# [355] "famhx_ss_patunc4_prob_prf_p"   "famhx_ss_patunc5_prob_prf_p"   "famhx_ss_patant1_prob_prf_p"  
# [358] "famhx_ss_patant2_prob_prf_p"   "famhx_ss_patant3_prob_prf_p"   "famhx_ss_patant4_prob_prf_p"  
# [361] "famhx_ss_patant5_prob_prf_p"   "famhx_ss_matunc1_prob_prf_p"   "famhx_ss_matunc2_prob_prf_p"  
# [364] "famhx_ss_matunc3_prob_prf_p"   "famhx_ss_matunc4_prob_prf_p"   "famhx_ss_matunc5_prob_prf_p"  
# [367] "famhx_ss_matant1_prob_prf_p"   "famhx_ss_matant2_prob_prf_p"   "famhx_ss_matant3_prob_prf_p"  
# [370] "famhx_ss_matant4_prob_prf_p"   "famhx_ss_matant5_prob_prf_p"   "famhx_ss_fulsiby1_prob_prf_p" 
# [373] "famhx_ss_fulsiby2_prob_prf_p"  "famhx_ss_fulsiby3_prob_prf_p"  "famhx_ss_fulsiby4_prob_prf_p" 
# [376] "famhx_ss_fulsiby5_prob_prf_p"  "famhx_ss_fulsibo1_prob_prf_p"  "famhx_ss_fulsibo2_prob_prf_p" 
# [379] "famhx_ss_fulsibo3_prob_prf_p"  "famhx_ss_fulsibo4_prob_prf_p"  "famhx_ss_fulsibo5_prob_prf_p" 
# [382] "famhx_ss_hlfsiby1_prob_prf_p"  "famhx_ss_hlfsiby2_prob_prf_p"  "famhx_ss_hlfsiby3_prob_prf_p" 
# [385] "famhx_ss_hlfsiby4_prob_prf_p"  "famhx_ss_hlfsiby5_prob_prf_p"  "famhx_ss_hlfsibo1_prob_prf_p" 
# [388] "famhx_ss_hlfsibo2_prob_prf_p"  "famhx_ss_hlfsibo3_prob_prf_p"  "famhx_ss_hlfsibo4_prob_prf_p" 
# [391] "famhx_ss_hlfsibo5_prob_prf_p"  "famhx_ss_momdad_prf_p"         "famhx_ss_parent_prf_p"        
# [394] "famhx_ss_fath_prob_hspd_p"     "famhx_ss_patgf_prob_hspd_p"    "famhx_ss_patgm_prob_hspd_p"   
# [397] "famhx_ss_moth_prob_hspd_p"     "famhx_ss_matgf_prob_hspd_p"    "famhx_ss_matgm_prob_hspd_p"   
# [400] "famhx_ss_patunc1_prob_hspd_p"  "famhx_ss_patunc2_prob_hspd_p"  "famhx_ss_patunc3_prob_hspd_p" 
# [403] "famhx_ss_patunc4_prob_hspd_p"  "famhx_ss_patunc5_prob_hspd_p"  "famhx_ss_patant1_prob_hspd_p" 
# [406] "famhx_ss_patant2_prob_hspd_p"  "famhx_ss_patant3_prob_hspd_p"  "famhx_ss_patant4_prob_hspd_p" 
# [409] "famhx_ss_patant5_prob_hspd_p"  "famhx_ss_matunc1_prob_hspd_p"  "famhx_ss_matunc2_prob_hspd_p" 
# [412] "famhx_ss_matunc3_prob_hspd_p"  "famhx_ss_matunc4_prob_hspd_p"  "famhx_ss_matunc5_prob_hspd_p" 
# [415] "famhx_ss_matant1_prob_hspd_p"  "famhx_ss_matant2_prob_hspd_p"  "famhx_ss_matant3_prob_hspd_p" 
# [418] "famhx_ss_matant4_prob_hspd_p"  "famhx_ss_matant5_prob_hspd_p"  "famhx_ss_fulsiby1_prob_hspd_p"
# [421] "famhx_ss_fulsiby2_prob_hspd_p" "famhx_ss_fulsiby3_prob_hspd_p" "famhx_ss_fulsiby4_prob_hspd_p"
# [424] "famhx_ss_fulsiby5_prob_hspd_p" "famhx_ss_fulsibo1_prob_hspd_p" "famhx_ss_fulsibo2_prob_hspd_p"
# [427] "famhx_ss_fulsibo3_prob_hspd_p" "famhx_ss_fulsibo4_prob_hspd_p" "famhx_ss_fulsibo5_prob_hspd_p"
# [430] "famhx_ss_hlfsiby1_prob_hspd_p" "famhx_ss_hlfsiby2_prob_hspd_p" "famhx_ss_hlfsiby3_prob_hspd_p"
# [433] "famhx_ss_hlfsiby4_prob_hspd_p" "famhx_ss_hlfsiby5_prob_hspd_p" "famhx_ss_hlfsibo1_prob_hspd_p"
# [436] "famhx_ss_hlfsibo2_prob_hspd_p" "famhx_ss_hlfsibo3_prob_hspd_p" "famhx_ss_hlfsibo4_prob_hspd_p"
# [439] "famhx_ss_hlfsibo5_prob_hspd_p" "famhx_ss_momdad_hspd_p"        "famhx_ss_parent_hspd_p"       
# [442] "famhx_ss_fath_prob_scd_p"      "famhx_ss_patgf_prob_scd_p"     "famhx_ss_patgm_prob_scd_p"    
# [445] "famhx_ss_moth_prob_scd_p"      "famhx_ss_matgf_prob_scd_p"     "famhx_ss_matgm_prob_scd_p"    
# [448] "famhx_ss_patunc1_prob_scd_p"   "famhx_ss_patunc2_prob_scd_p"   "famhx_ss_patunc3_prob_scd_p"  
# [451] "famhx_ss_patunc4_prob_scd_p"   "famhx_ss_patunc5_prob_scd_p"   "famhx_ss_patant1_prob_scd_p"  
# [454] "famhx_ss_patant2_prob_scd_p"   "famhx_ss_patant3_prob_scd_p"   "famhx_ss_patant4_prob_scd_p"  
# [457] "famhx_ss_patant5_prob_scd_p"   "famhx_ss_matunc1_prob_scd_p"   "famhx_ss_matunc2_prob_scd_p"  
# [460] "famhx_ss_matunc3_prob_scd_p"   "famhx_ss_matunc4_prob_scd_p"   "famhx_ss_matunc5_prob_scd_p"  
# [463] "famhx_ss_matant1_prob_scd_p"   "famhx_ss_matant2_prob_scd_p"   "famhx_ss_matant3_prob_scd_p"  
# [466] "famhx_ss_matant4_prob_scd_p"   "famhx_ss_matant5_prob_scd_p"   "famhx_ss_fulsiby1_prob_scd_p" 
# [469] "famhx_ss_fulsiby2_prob_scd_p"  "famhx_ss_fulsiby3_prob_scd_p"  "famhx_ss_fulsiby4_prob_scd_p" 
# [472] "famhx_ss_fulsiby5_prob_scd_p"  "famhx_ss_fulsibo1_prob_scd_p"  "famhx_ss_fulsibo2_prob_scd_p" 
# [475] "famhx_ss_fulsibo3_prob_scd_p"  "famhx_ss_fulsibo4_prob_scd_p"  "famhx_ss_fulsibo5_prob_scd_p" 
# [478] "famhx_ss_hlfsiby1_prob_scd_p"  "famhx_ss_hlfsiby2_prob_scd_p"  "famhx_ss_hlfsiby3_prob_scd_p" 
# [481] "famhx_ss_hlfsiby4_prob_scd_p"  "famhx_ss_hlfsiby5_prob_scd_p"  "famhx_ss_hlfsibo1_prob_scd_p" 
# [484] "famhx_ss_hlfsibo2_prob_scd_p"  "famhx_ss_hlfsibo3_prob_scd_p"  "famhx_ss_hlfsibo4_prob_scd_p" 
# [487] "famhx_ss_hlfsibo5_prob_scd_p"  "famhx_ss_momdad_scd_p"         "famhx_ss_parent_scd_p"        
# [490] "collection_title"              "study_cohort_name"     

#Remove variables that will not be included in analysis
fam_history = fam_history[,-c(1:3, 5:9, 16:57, 64:105, 112:491)]

colnames(fam_history)
# [1] "subjectkey"                 "famhx_ss_fath_prob_alc_p"   "famhx_ss_patgf_prob_alc_p" 
# [4] "famhx_ss_patgm_prob_alc_p"  "famhx_ss_moth_prob_alc_p"   "famhx_ss_matgf_prob_alc_p" 
# [7] "famhx_ss_matgm_prob_alc_p"  "famhx_ss_fath_prob_dg_p"    "famhx_ss_patgf_prob_dg_p"  
# [10] "famhx_ss_patgm_prob_dg_p"   "famhx_ss_moth_prob_dg_p"    "famhx_ss_matgf_prob_dg_p"  
# [13] "famhx_ss_matgm_prob_dg_p"   "famhx_ss_fath_prob_dprs_p"  "famhx_ss_patgf_prob_dprs_p"
# [16] "famhx_ss_patgm_prob_dprs_p" "famhx_ss_moth_prob_dprs_p"  "famhx_ss_matgf_prob_dprs_p"
# [19] "famhx_ss_matgm_prob_dprs_p"                

#Rename variables
names(fam_history)[names(fam_history) == "subjectkey"] = "id"
names(fam_history)[names(fam_history) == "famhx_ss_fath_prob_alc_p"] = "p_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_patgf_prob_alc_p"] = "pgf_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_patgm_prob_alc_p"] = "pgm_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_moth_prob_alc_p"] = "m_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_matgm_prob_alc_p"] = "mgm_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_matgf_prob_alc_p"] = "mgf_alcohol"
names(fam_history)[names(fam_history) == "famhx_ss_fath_prob_dg_p"] = "p_drug"
names(fam_history)[names(fam_history) == "famhx_ss_patgf_prob_dg_p"] = "pgf_drug"
names(fam_history)[names(fam_history) == "famhx_ss_patgm_prob_dg_p"] = "pgm_drug"
names(fam_history)[names(fam_history) == "famhx_ss_moth_prob_dg_p"] = "m_drug"
names(fam_history)[names(fam_history) == "famhx_ss_matgf_prob_dg_p"] = "mgf_drug"
names(fam_history)[names(fam_history) == "famhx_ss_matgm_prob_dg_p"] = "mgm_drug"
names(fam_history)[names(fam_history) == "famhx_ss_fath_prob_dprs_p"] = "p_depres"
names(fam_history)[names(fam_history) == "famhx_ss_patgf_prob_dprs_p"] = "pgf_depres"
names(fam_history)[names(fam_history) == "famhx_ss_patgm_prob_dprs_p"] = "pmg_depres"
names(fam_history)[names(fam_history) == "famhx_ss_moth_prob_dprs_p"] = "m_depres"
names(fam_history)[names(fam_history) == "famhx_ss_matgf_prob_dprs_p"] = "mpgf_depres"
names(fam_history)[names(fam_history) == "famhx_ss_matgm_prob_dprs_p"] = "mgm_depres"

colnames(fam_history)
# [1] "id"          "p_alcohol"   "pgf_alcohol" "pgm_alcohol" "m_alcohol"   "mgf_alcohol" "mgm_alcohol" "p_drug"     
# [9] "pgf_drug"    "pgm_drug"    "m_drug"      "mgf_drug"    "mgm_drug"    "p_depres"    "pgf_depres"  "pmg_depres" 
# [17] "m_depres"    "mpgf_depres" "mgm_depres" 

table(fam_history$p_alcohol, useNA = "ifany")
#       0    1 
# 478 9929 1469 

#Rescale variables- make "" and 999 into NA 
fam_history[, c(2:19)][fam_history[, c(2:19)] == ""] <- NA
fam_history[, c(2:19)][fam_history[, c(2:19)] == 999] <- NA

table(fam_history$p_alcohol, useNA = "ifany")
#       0    1 <NA> 
#   9929 1469  478 

#Create dichotomous immediate family alcohol use variable 
fam_history[which(fam_history$m_alcohol == 0 & fam_history$mgf_alcohol == 0 & fam_history$mgm_alcohol == 0),  "m_imed_alcohol"] = 0
fam_history[which(fam_history$m_alcohol == 1 | fam_history$mgf_alcohol == 1 | fam_history$mgm_alcohol == 1),  "m_imed_alcohol"] = 1
colnames(fam_history)
table(fam_history$m_imed_alcohol, useNA = "ifany")
#   0    1   NA 
# 9193 2176  507 


fam_history[which(fam_history$p_alcohol == 0 & fam_history$pgf_alcohol == 0 & fam_history$pgm_alcohol == 0),  "p_imed_alcohol"] = 0
fam_history[which(fam_history$p_alcohol == 1 | fam_history$pgf_alcohol == 1 | fam_history$pgm_alcohol == 1),  "p_imed_alcohol"] = 1
colnames(fam_history)
table(fam_history$p_imed_alcohol, useNA = "ifany")
#   0    1   NA 
# 8704 2512  660 

#Creating dichotomous immediate family drug use variable 
fam_history[which(fam_history$m_drug == 0 & fam_history$mgf_drug == 0 & fam_history$mgm_drug == 0),  "m_imed_drug"] = 0
fam_history[which(fam_history$m_drug == 1 | fam_history$mgf_drug == 1 | fam_history$mgm_drug == 1),  "m_imed_drug"] = 1
colnames(fam_history)
table(fam_history$m_imed_drug, useNA = "ifany")
#     0     1    NA 
# 10278  1170   428 

fam_history[which(fam_history$p_drug == 0 & fam_history$pgf_drug == 0 & fam_history$pgm_drug == 0),  "p_imed_drug"] = 0
fam_history[which(fam_history$p_drug == 1 | fam_history$pgf_drug == 1 | fam_history$pgm_drug == 1),  "p_imed_drug"] = 1
colnames(fam_history)
table(fam_history$p_imed_drug, useNA = "ifany")
#   0    1   NA 
# 9887 1403  586 

#Creating dichotomous immediate family depression variable 
fam_history[which(fam_history$m_depres == 0 & fam_history$mpgf_depres == 0 & fam_history$mgm_depres == 0),  "m_imed_depres"] = 0
fam_history[which(fam_history$m_depres == 1 | fam_history$mpgf_depres == 1 | fam_history$mgm_depres == 1),  "m_imed_depres"] = 1
colnames(fam_history)
table(fam_history$m_imed_depres, useNA = "ifany")
#     0    1 <NA> 
#   7229 3984  663 

fam_history[which(fam_history$p_depres == 0 & fam_history$pgf_depres == 0 & fam_history$pmg_depres == 0),  "p_imed_depres"] = 0
fam_history[which(fam_history$p_depres == 1 | fam_history$pgf_depres == 1 | fam_history$pmg_depres == 1),  "p_imed_depres"] = 1
colnames(fam_history)
table(fam_history$p_imed_depres, useNA = "ifany")
#     0    1 <NA> 
#   8255 2549 1072 

#Write out file to manually check dichotomous variables before removing the columns
#write.csv(fam_history, "fam_history.csv", row.names=FALSE, quote = FALSE, na="NA" )

#Create subsetted data set that excludes variables we do not need
sub_famhist = fam_history %>% select(id, m_imed_alcohol, p_imed_alcohol, m_imed_drug, p_imed_drug,
                                         m_imed_depres, p_imed_depres)



#Site ID ----

#Add path and file name
site = read.delim(file("abcd_lt01.txt"))
site = site[-c(1),]
dim(site) 
# [1] 74167    14

colnames(site)
# [1] "collection_id"     "abcd_lt01_id"      "dataset_id"        "subjectkey"        "src_subject_id"   
# [6] "interview_date"    "interview_age"     "sex"               "eventname"         "site_id_l"        
# [11] "sched_delay"       "sched_hybrid"      "collection_title"  "study_cohort_name"

#Remove variables we will not use in the analysis
site = site[,-c(1:3, 5:6, 8, 11:14)]

colnames(site)
# [1] "subjectkey"    "interview_age" "eventname"     "site_id_l"   

#Rename variables 
names(site)[names(site) == "subjectkey"] = "id"
names(site)[names(site) == "interview_age"] = "age"
names(site)[names(site) == "eventname"] = "timepoint"
names(site)[names(site) == "site_id_l"] = "site_id"

colnames(site)
# [1] "id"        "age"       "timepoint" "site_id"  

table(site$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 18_month_follow_up_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                    11089                    10414                     6251 
# 30_month_follow_up_arm_1 42_month_follow_up_arm_1  6_month_follow_up_arm_1    baseline_year_1_arm_1 
# 8551                     3365                    11396                    11876 

#Label timepoints
site[which(site$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
site[which(site$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
site[which(site$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
site[which(site$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3
site[which(site$timepoint == "18_month_follow_up_arm_1"),  "timepoint"] = 18
site[which(site$timepoint == "30_month_follow_up_arm_1"),  "timepoint"] = 30
site[which(site$timepoint == "42_month_follow_up_arm_1"),  "timepoint"] = 42
site[which(site$timepoint == "6_month_follow_up_arm_1"),  "timepoint"] = 6

table(site$timepoint, useNA = "ifany")
#     0     1    18     2     3    30    42     6 
# 11876 11225 11089 10414  6251  8551  3365 11396 

#Reshape data to wide 
library(reshape)
site_wide = reshape(site, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(site_wide)
# [1] "id"         "age.0"      "site_id.0"  "age.18"     "site_id.18" "age.2"      "site_id.2"  "age.1"     
# [9] "site_id.1"  "age.3"      "site_id.3"  "age.6"      "site_id.6"  "age.30"     "site_id.30" "age.42"    
# [17] "site_id.42"          

#Remove variables- only keep site id for baseline, 1 year, and 2 year follow-up (3 year follow up has too much missingness)
site_wide = site_wide[,-c(4:5, 10:17)]

colnames(site_wide)
# [1] "id"        "age.0"     "site_id.0" "age.2"     "site_id.2" "age.1"     "site_id.1"



#Neurobehavioral Disinhibition ----

#Barkley Executive Functioning Scale- ND (cannot use measure, only 3 year available- too much missing) ----

#Add path and file name
barkley_exec  = read.delim(file("barkley_exec_func01.txt"))
barkley_exec = barkley_exec[-c(1),]
dim(barkley_exec) 
# 6251   27

colnames(barkley_exec)
# [1] "collection_id"               "barkley_exec_func01_id"      "dataset_id"                 
# [4] "subjectkey"                  "src_subject_id"              "interview_date"             
# [7] "interview_age"               "sex"                         "eventname"                  
# [10] "bdefs_calm_down_p"           "bdefs_consequences_p"        "bdefs_distract_upset_p"     
# [13] "bdefs_explain_idea_p"        "bdefs_explain_pt_p"          "bdefs_explain_seq_p"        
# [16] "bdefs_impulsive_action_p"    "bdefs_inconsistant_p"        "bdefs_lazy_p"               
# [19] "bdefs_p_select_language___1" "bdefs_process_info_p"        "bdefs_rechannel_p"          
# [22] "bdefs_sense_time_p"          "bdefs_shortcuts_p"           "bdefs_start_time"           
# [25] "bdefs_stop_think_p"          "collection_title"            "study_cohort_name"          

# table(barkley_exec$eventname, useNA = "ifany")
# 3_year_follow_up_y_arm_1 
# 6251 

table(barkley_exec$bdefs_calm_down_p, useNA = "ifany" )
#       1    2    3    4  777 
# 105 3519 1869  466  269   23 
# 1 = Never or Rarely
# 2 = Sometimes
# 3 = Often 
# 4 = Very Often 
# 777 = Refuse to Answer

barkley_exec$calm_down = "0"
barkley_exec[is.na(barkley_exec$calm_down)] = NA
barkley_exec[which(barkley_exec$bdefs_calm_down_p == 1),  "calm_down"] = 0
barkley_exec[which(barkley_exec$bdefs_calm_down_p == 2),  "calm_down"] = 1
barkley_exec[which(barkley_exec$bdefs_calm_down_p == 3),  "calm_down"] = 2
barkley_exec[which(barkley_exec$bdefs_calm_down_p == 4),  "calm_down"] = 3
barkley_exec[which(barkley_exec$bdefs_calm_down_p == 777),  "calm_down"] = "NA"
barkley_exec[which(barkley_exec$bdefs_calm_down_p == ""),  "calm_down"] = "NA"

table(barkley_exec$calm_down, useNA = "ifany")
#   0    1    2    3   NA 
# 3519 1869  466  269  128 

# 0 = Never or Rarely
# 1 = Sometimes
# 2 = Often 
# 3 = Very Often 
# NA = Refuse to Answer






#Early Adolescent Temperament Questionnaire (2 year follow-up only)- ND ----

#Add path and file name
temperament  = read.delim(file("abcd_eatqp01.txt"))
temperament = temperament[-c(1),]
dim(temperament) 
# [1] 10414    74

colnames(temperament)
# [1] "collection_id"          "abcd_eatqp01_id"        "dataset_id"             "subjectkey"            
# [5] "src_subject_id"         "interview_date"         "interview_age"          "sex"                   
# [9] "eventname"              "eatq_select_language"   "eatq_trouble_p"         "eatq_insult_p"         
# [13] "eatq_finish_p"          "eatq_africa_p"          "eatq_deal_p"            "eatq_turn_taking_p"    
# [17] "eatq_enjoy_p"           "eatq_open_present_p"    "eatq_ski_slope_p"       "eatq_cry_p"            
# [21] "eatq_angry_hit_p"       "eatq_care_p"            "eatq_share_p"           "eatq_before_hw_p"      
# [25] "eatq_concentrate_p"     "eatq_city_move_p"       "eatq_right_away_p"      "eatq_spend_time_p"     
# [29] "eatq_rude_p"            "eatq_annoyed_p"         "eatq_irritated_crit_p"  "eatq_distracted_p"     
# [33] "eatq_impulse_p"         "eatq_hugs_p"            "eatq_blame_p"           "eatq_sad_p"            
# [37] "eatq_social_p"          "eatq_sea_dive_p"        "eatq_travel_p"          "eatq_worry_p"          
# [41] "eatq_irritated_place_p" "eatq_doorslam_p"        "eatq_hardly_sad_p"      "eatq_race_car_p"       
# [45] "eatq_try_focus_p"       "eatq_finish_hw_p"       "eatq_school_excite_p"   "eatq_early_start_p"    
# [49] "eatq_peripheral_p"      "eatq_energized_p"       "eatq_makes_fun_p"       "eatq_no_criticize_p"   
# [53] "eatq_close_rel_p"       "eatq_is_shy_p"          "eatq_irritated_enjoy_p" "eatq_puts_off_p"       
# [57] "eatq_laugh_control_p"   "eatq_attachment_p"      "eatq_sidetracked_p"     "eatq_not_shy_p"        
# [61] "eatq_friendly_p"        "eatq_seems_sad_p"       "eatq_ball_scared_p"     "eatq_meet_p"           
# [65] "eatq_dark_scared_p"     "eatq_rides_scared_p"    "eatq_disagree_p"        "eatq_frustrated_p"     
# [69] "eatq_stick_to_plan_p"   "eatq_close_attention_p" "eatq_alone_p"           "eatq_shy_meet_p"       
# [73] "collection_title"       "study_cohort_name"     

table(temperament$eventname, useNA = "ifany")
# 2_year_follow_up_y_arm_1 
# 10414 

#Remove variables we will not use in the analysis
temperament = temperament[,-c(1:3, 5:10, 73:74)]

colnames(temperament)
# [1] "subjectkey"             "eatq_trouble_p"         "eatq_insult_p"          "eatq_finish_p"         
# [5] "eatq_africa_p"          "eatq_deal_p"            "eatq_turn_taking_p"     "eatq_enjoy_p"          
# [9] "eatq_open_present_p"    "eatq_ski_slope_p"       "eatq_cry_p"             "eatq_angry_hit_p"      
# [13] "eatq_care_p"            "eatq_share_p"           "eatq_before_hw_p"       "eatq_concentrate_p"    
# [17] "eatq_city_move_p"       "eatq_right_away_p"      "eatq_spend_time_p"      "eatq_rude_p"           
# [21] "eatq_annoyed_p"         "eatq_irritated_crit_p"  "eatq_distracted_p"      "eatq_impulse_p"        
# [25] "eatq_hugs_p"            "eatq_blame_p"           "eatq_sad_p"             "eatq_social_p"         
# [29] "eatq_sea_dive_p"        "eatq_travel_p"          "eatq_worry_p"           "eatq_irritated_place_p"
# [33] "eatq_doorslam_p"        "eatq_hardly_sad_p"      "eatq_race_car_p"        "eatq_try_focus_p"      
# [37] "eatq_finish_hw_p"       "eatq_school_excite_p"   "eatq_early_start_p"     "eatq_peripheral_p"     
# [41] "eatq_energized_p"       "eatq_makes_fun_p"       "eatq_no_criticize_p"    "eatq_close_rel_p"      
# [45] "eatq_is_shy_p"          "eatq_irritated_enjoy_p" "eatq_puts_off_p"        "eatq_laugh_control_p"  
# [49] "eatq_attachment_p"      "eatq_sidetracked_p"     "eatq_not_shy_p"         "eatq_friendly_p"       
# [53] "eatq_seems_sad_p"       "eatq_ball_scared_p"     "eatq_meet_p"            "eatq_dark_scared_p"    
# [57] "eatq_rides_scared_p"    "eatq_disagree_p"        "eatq_frustrated_p"      "eatq_stick_to_plan_p"  
# [61] "eatq_close_attention_p" "eatq_alone_p"        

#Rename variables 
names(temperament)[names(temperament) == "subjectkey"] = "id"
names(temperament)[names(temperament) == "eatq_trouble_p"] = "trouble"
names(temperament)[names(temperament) == "eatq_insult_p"] = "insult"
names(temperament)[names(temperament) == "eatq_finish_p"] = "finish"
names(temperament)[names(temperament) == "eatq_africa_p"] = "africa"
names(temperament)[names(temperament) == "eatq_deal_p"] = "deal"
names(temperament)[names(temperament) == "eatq_turn_taking_p"] = "turn_taking"
names(temperament)[names(temperament) == "eatq_enjoy_p"] = "enjoy"
names(temperament)[names(temperament) == "eatq_open_present_p"] = "open_present"
names(temperament)[names(temperament) == "eatq_ski_slope_p"] = "ski_slope"
names(temperament)[names(temperament) == "eatq_cry_p"] = "cry"
names(temperament)[names(temperament) == "eatq_angry_hit_p"] = "angry_hit"
names(temperament)[names(temperament) == "eatq_care_p"] = "care"
names(temperament)[names(temperament) == "eatq_share_p"] = "share"
names(temperament)[names(temperament) == "eatq_before_hw_p"] = "before_hw"
names(temperament)[names(temperament) == "eatq_concentrate_p"] = "concentrate"
names(temperament)[names(temperament) == "eatq_city_move_p"] = "city_move"
names(temperament)[names(temperament) == "eatq_right_away_p"] = "right_away"
names(temperament)[names(temperament) == "eatq_spend_time_p"] = "spend_time"
names(temperament)[names(temperament) == "eatq_rude_p"] = "rude"
names(temperament)[names(temperament) == "eatq_annoyed_p"] = "annoyed"
names(temperament)[names(temperament) == "eatq_irritated_crit_p"] = "irritate_crit"
names(temperament)[names(temperament) == "eatq_distracted_p"] = "distracted"
names(temperament)[names(temperament) == "eatq_impulse_p"] = "impulse"
names(temperament)[names(temperament) == "eatq_hugs_p"] = "hugs"
names(temperament)[names(temperament) == "eatq_blame_p"] = "blame"
names(temperament)[names(temperament) == "eatq_sad_p"] = "sad"
names(temperament)[names(temperament) == "eatq_social_p"] = "social"
names(temperament)[names(temperament) == "eatq_sea_dive_p"] = "sea_dive"
names(temperament)[names(temperament) == "eatq_travel_p"] = "travel"
names(temperament)[names(temperament) == "eatq_worry_p"] = "worry"
names(temperament)[names(temperament) == "eatq_irritated_place_p"] = "irritated_place"
names(temperament)[names(temperament) == "eatq_doorslam_p"] = "doorslam"
names(temperament)[names(temperament) == "eatq_hardly_sad_p"] = "hardly_sad"
names(temperament)[names(temperament) == "eatq_race_car_p"] = "race_car"
names(temperament)[names(temperament) == "eatq_try_focus_p"] = "try_focus"
names(temperament)[names(temperament) == "eatq_finish_hw_p"] = "finish_hw"
names(temperament)[names(temperament) == "eatq_school_excite_p"] = "school_excite"
names(temperament)[names(temperament) == "eatq_early_start_p"] = "early_start"
names(temperament)[names(temperament) == "eatq_peripheral_p"] = "peripheral"
names(temperament)[names(temperament) == "eatq_energized_p"] = "energized"
names(temperament)[names(temperament) == "eatq_makes_fun_p"] = "makes_fun"
names(temperament)[names(temperament) == "eatq_no_criticize_p"] = "no_criticize"
names(temperament)[names(temperament) == "eatq_close_rel_p"] = "close_rel"
names(temperament)[names(temperament) == "eatq_is_shy_p"] = "is_shy"
names(temperament)[names(temperament) == "eatq_irritated_enjoy_p"] = "irritated_enjoy"
names(temperament)[names(temperament) == "eatq_puts_off_p"] = "puts_off"
names(temperament)[names(temperament) == "eatq_laugh_control_p"] = "laugh_control"
names(temperament)[names(temperament) == "eatq_attachment_p"] = "attachement"
names(temperament)[names(temperament) == "eatq_sidetracked_p"] = "sidetracked"
names(temperament)[names(temperament) == "eatq_not_shy_p"] = "not_shy"
names(temperament)[names(temperament) == "eatq_friendly_p"] = "friendly"
names(temperament)[names(temperament) == "eatq_seems_sad_p"] = "seems_sad"
names(temperament)[names(temperament) == "eatq_ball_scared_p"] = "ball_scared"
names(temperament)[names(temperament) == "eatq_meet_p"] = "meet"
names(temperament)[names(temperament) == "eatq_dark_scared_p"] = "dark_scared"
names(temperament)[names(temperament) == "eatq_rides_scared_p"] = "rides_scared"
names(temperament)[names(temperament) == "eatq_disagree_p"] = "disagree"
names(temperament)[names(temperament) == "eatq_frustrated_p"] = "frustrated"
names(temperament)[names(temperament) == "eatq_stick_to_plan_p"] = "stick_to_plan"
names(temperament)[names(temperament) == "eatq_close_attention_p"] = "close_attention"
names(temperament)[names(temperament) == "eatq_alone_p"] = "alone"
names(temperament)[names(temperament) == "eatq_shy_meet_p"] = "shy_meet"

colnames(temperament)
# [1] "id"                 "trouble"            "insult"             "finish"             "africa"            
# [6] "deal"               "turn_taking"        "enjoy"              "open_present"       "ski_slope"         
# [11] "cry"                "angry_hit"          "care"               "share"              "before_hw"         
# [16] "concentrate"        "city_move"          "right_away"         "spend_time"         "rude"              
# [21] "annoyed"            "irritate_crit"      "distracted"         "impulse"            "hugs"              
# [26] "blame"              "sad"                "social"             "sea_dive"           "travel"            
# [31] "worry"              "irritated_place"    "doorslam"           "hardly_sad"         "race_car"          
# [36] "try_focus"          "finish_hw"          "school_excite"      "early_start"        "peripheral"        
# [41] "energized"          "makes_fun"          "no_criticize"       "close_rel"          "is_shy"            
# [46] "irritated_enjot"    "puts_off"           "laugh_control"      "attachement"        "sidetracked"       
# [51] "not_shy"            "friendly"           "seems_sad"          "ball_scared"        "meet"              
# [56] "eatq_dark_scared_p" "rides_scared"       "disagree"           "frustrated"         "stick_to_plan"     
# [61] "close_attention"    "alone"              "shy_meet"   

table(temperament$trouble, useNA = "ifany")
#       1    2    3    4    5 
# 79 3053 2368 3128 1324  462 

#1 = Almost always untrue
#2 = Usually untrue
#3 = Sometimes true
#4 = Usually true 
#5 = Almost always true 

#Rescale variables so there is a true 0 
colnames(temperament)
temperament[, c(2:63)][temperament[, c(2:63)] == ""] <- NA
temperament[, c(2:63)][temperament[, c(2:63)] == 1] <- 0
temperament[, c(2:63)][temperament[, c(2:63)] == 2] <- 1
temperament[, c(2:63)][temperament[, c(2:63)] == 3] <- 2
temperament[, c(2:63)][temperament[, c(2:63)] == 4] <- 3
temperament[, c(2:63)][temperament[, c(2:63)] == 5] <- 4

table(temperament$trouble, useNA = "ifany")
#       0    1    2    3    4 <NA> 
#   3053 2368 3128 1324  462   79 

#0 = Almost always untrue
#1 = Usually untrue
#2 = Sometimes true
#3 = Usually true 
#4 = Almost always true 

#Change variables into numeric in order to create summary scores
temperament$trouble = as.numeric(temperament$trouble)
temperament$insult = as.numeric(temperament$insult)
temperament$finish = as.numeric(temperament$finish)
temperament$africa = as.numeric(temperament$africa)
temperament$deal = as.numeric(temperament$deal)
temperament$turn_taking = as.numeric(temperament$turn_taking)
temperament$enjoy = as.numeric(temperament$enjoy)
temperament$open_present = as.numeric(temperament$open_present)
temperament$ski_slope = as.numeric(temperament$ski_slope)
temperament$cry = as.numeric(temperament$cry)
temperament$angry_hit = as.numeric(temperament$angry_hit)
temperament$care = as.numeric(temperament$care)
temperament$share = as.numeric(temperament$share)
temperament$before_hw = as.numeric(temperament$before_hw)
temperament$concentrate = as.numeric(temperament$concentrate)
temperament$city_move = as.numeric(temperament$city_move)
temperament$right_away = as.numeric(temperament$right_away)
temperament$spend_time = as.numeric(temperament$spend_time)
temperament$rude = as.numeric(temperament$rude)
temperament$annoyed = as.numeric(temperament$annoyed)
temperament$irritate_crit = as.numeric(temperament$irritate_crit)
temperament$distracted = as.numeric(temperament$distracted)
temperament$impulse = as.numeric(temperament$impulse)
temperament$hugs = as.numeric(temperament$hugs)
temperament$blame = as.numeric(temperament$blame)
temperament$sad = as.numeric(temperament$sad)
temperament$social = as.numeric(temperament$social)
temperament$sea_dive = as.numeric(temperament$sea_dive)
temperament$travel= as.numeric(temperament$travel)
temperament$worry = as.numeric(temperament$worry)
temperament$irritated_place = as.numeric(temperament$irritated_place)
temperament$doorslam = as.numeric(temperament$doorslam)
temperament$hardly_sad = as.numeric(temperament$hardly_sad)
temperament$race_car = as.numeric(temperament$race_car)
temperament$try_focus = as.numeric(temperament$try_focus)
temperament$finish_hw = as.numeric(temperament$finish_hw)
temperament$school_excite = as.numeric(temperament$school_excite)
temperament$early_start = as.numeric(temperament$early_start)
temperament$peripheral = as.numeric(temperament$peripheral)
temperament$energized = as.numeric(temperament$energized)
temperament$makes_fun = as.numeric(temperament$makes_fun)
temperament$no_criticize = as.numeric(temperament$no_criticize)
temperament$close_rel = as.numeric(temperament$close_rel)
temperament$is_shy = as.numeric(temperament$is_shy)
temperament$irritated_enjoy = as.numeric(temperament$irritated_enjoy)
temperament$puts_off = as.numeric(temperament$puts_off)
temperament$laugh_control = as.numeric(temperament$laugh_control)
temperament$attachement = as.numeric(temperament$attachement)
temperament$sidetracked= as.numeric(temperament$sidetracked)
temperament$not_shy = as.numeric(temperament$not_shy)
temperament$friendly = as.numeric(temperament$friendly)
temperament$seems_sad = as.numeric(temperament$seems_sad)
temperament$ball_scared = as.numeric(temperament$ball_scared)
temperament$meet = as.numeric(temperament$meet)
temperament$dark_scared = as.numeric(temperament$dark_scared)
temperament$rides_scared = as.numeric(temperament$rides_scared)
temperament$disagree = as.numeric(temperament$disagree)
temperament$frustrated = as.numeric(temperament$frustrated)
temperament$stick_to_plan = as.numeric(temperament$stick_to_plan)
temperament$close_attention = as.numeric(temperament$close_attention)
temperament$alone = as.numeric(temperament$alone)
temperament$shy_meet = as.numeric(temperament$shy_meet)

colnames(temperament)
# [1] "id"              "trouble"         "insult"          "finish"          "africa"          "deal"           
# [7] "turn_taking"     "enjoy"           "open_present"    "ski_slope"       "cry"             "angry_hit"      
# [13] "care"            "share"           "before_hw"       "concentrate"     "city_move"       "right_away"     
# [19] "spend_time"      "rude"            "annoyed"         "irritate_crit"   "distracted"      "impulse"        
# [25] "hugs"            "blame"           "sad"             "social"          "sea_dive"        "travel"         
# [31] "worry"           "irritated_place" "doorslam"        "hardly_sad"      "race_car"        "try_focus"      
# [37] "finish_hw"       "school_excite"   "early_start"     "peripheral"      "energized"       "makes_fun"      
# [43] "no_criticize"    "close_rel"       "is_shy"          "irritated_enjoy" "puts_off"        "laugh_control"  
# [49] "attachement"     "sidetracked"     "not_shy"         "friendly"        "seems_sad"       "ball_scared"    
# [55] "meet"            "dark_scared"     "rides_scared"    "disagree"        "frustrated"      "stick_to_plan"  
# [61] "close_attention" "alone"           "shy_meet"    

#summary scores (na.rm=T would only calculate the scores for the participants you have)
# temperament$total_neigh.0 = round(rowMeans(temperament[,c(3,4,5)], na.rm=T))
# temperament$total_neigh.1 = round(rowMeans(temperament[,c(11,12,13)], na.rm=T))
# temperament$total_neigh.2 = round(rowMeans(temperament[,c(7,8,9)], na.rm=T))







#Mental Health Youth Summary Scores- ND ----

#Add path and file name
mhealth_youth  = read.delim(file("abcd_mhy02.txt"))
mhealth_youth = mhealth_youth[-c(1),]
dim(mhealth_youth) 
# [1] 39766   111

colnames(mhealth_youth)
# [1] "collection_id"                  "abcd_mhy02_id"                  "dataset_id"                    
# [4] "subjectkey"                     "src_subject_id"                 "interview_age"                 
# [7] "interview_date"                 "sex"                            "eventname"                     
# [10] "ple_y_ss_total_number"          "ple_y_ss_total_number_nm"       "ple_y_ss_total_number_nt"      
# [13] "ple_y_ss_total_good"            "ple_y_ss_total_good_nt"         "ple_y_ss_total_bad"            
# [16] "ple_y_ss_total_bad_nt"          "ple_y_ss_affect_sum"            "ple_y_ss_affect_sum_nt"        
# [19] "ple_y_ss_affected_mean_nt"      "ple_y_ss_affected_good_sum"     "ple_y_ss_affected_good_sum_nt" 
# [22] "ple_y_ss_affected_good_mean"    "ple_y_ss_affected_good_mean_nt" "ple_y_ss_affected_bad_sum"     
# [25] "ple_y_ss_affected_bad_sum_nt"   "ple_y_ss_affected_bad_mean"     "ple_y_ss_affected_bad_mean_nt" 
# [28] "pps_y_ss_number"                "pps_y_ss_number_nm"             "pps_y_ss_number_nt"            
# [31] "pps_y_ss_bother_sum"            "pps_y_ss_bother_sum_nm"         "pps_y_ss_bother_sum_nt"        
# [34] "pps_y_ss_bother_n_1"            "pps_y_ss_bother_n_1_nm"         "pps_y_ss_bother_n_1_nt"        
# [37] "pps_y_ss_severity_score"        "pps_y_ss_severity_score_nm"     "pps_y_ss_severity_score_nt"    
# [40] "pps_ss_mean_severity"           "upps_y_ss_negative_urgency"     "upps_y_ss_negative_urgency_nm" 
# [43] "upps_y_ss_negative_urgency_nt"  "upps_y_ss_lack_of_planning"     "upps_y_ss_lack_of_planning_nm" 
# [46] "upps_y_ss_lack_of_planning_nt"  "upps_y_ss_sensation_seeking"    "upps_y_ss_sensation_seeking_nm"
# [49] "upps_y_ss_sensation_seeking_nt" "upps_y_ss_positive_urgency"     "upps_y_ss_positive_urgency_nm" 
# [52] "upps_y_ss_positive_urgency_nt"  "upps_y_ss_lack_of_perseverance" "upps_y_ss_lack_of_pers_nm"     
# [55] "upps_y_ss_lack_of_pers_nt"      "bis_y_ss_bis_sum"               "bis_y_ss_bis_sum_nm"           
# [58] "bis_y_ss_bis_sum_nt"            "bis_y_ss_bas_rr"                "bis_y_ss_bas_rr_nm"            
# [61] "bis_y_ss_bas_rr_nt"             "bis_y_ss_bas_drive"             "bis_y_ss_bas_drive_nm"         
# [64] "bis_y_ss_bas_drive_nt"          "bis_y_ss_bas_fs"                "bis_y_ss_bas_fs_nm"            
# [67] "bis_y_ss_bas_fs_nt"             "bis_y_ss_bism_sum"              "bis_y_ss_bism_sum_nm"          
# [70] "bis_y_ss_bism_sum_nt"           "bis_y_ss_basm_rr"               "bis_y_ss_basm_rr_nm"           
# [73] "bis_y_ss_basm_rr_nt"            "bis_y_ss_basm_drive"            "bis_y_ss_basm_drive_nm"        
# [76] "bis_y_ss_basm_drive_nt"         "delq_y_ss_sum"                  "delq_y_ss_sum_nm"              
# [79] "delq_y_ss_sum_nt"               "sup_y_ss_sum"                   "sup_y_ss_sum_nm"               
# [82] "sup_y_ss_sum_nt"                "gish_y_ss_m_sum"                "gish_y_ss_m_sum_nm"            
# [85] "gish_y_ss_m_sum_nt"             "gish_y_ss_f_sum"                "gish_y_ss_f_sum_nm"            
# [88] "gish_y_ss_f_sum_nt"             "peq_ss_relational_aggs_nm"      "peq_ss_relational_aggs_nt"     
# [91] "peq_ss_relational_victim"       "peq_ss_relational_victim_nm"    "peq_ss_relational_victim_nt"   
# [94] "peq_ss_reputation_aggs"         "peq_ss_reputation_aggs_nm"      "peq_ss_reputation_aggs_nt"     
# [97] "peq_ss_reputation_victim"       "peq_ss_reputation_victim_nm"    "peq_ss_reputation_victim_nt"   
# [100] "peq_ss_overt_aggression"        "peq_ss_overt_aggression_nm"     "peq_ss_overt_aggression_nt"    
# [103] "peq_ss_overt_victim"            "peq_ss_overt_victim_nm"         "peq_ss_overt_victim_nt"        
# [106] "peq_ss_relational_aggs"         "pstr_ss_pr"                     "erq_ss_reappraisal_pr"         
# [109] "erq_ss_suppress_pr"             "collection_title"               "study_cohort_name" 

table(mhealth_youth$eventname, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

mhealth_youth = mhealth_youth[,-c(1:3, 5:8, 10:40, 80:88, 107:111)]

colnames(mhealth_youth)
# [1] "subjectkey"                     "eventname"                      "upps_y_ss_negative_urgency"    
# [4] "upps_y_ss_negative_urgency_nm"  "upps_y_ss_negative_urgency_nt"  "upps_y_ss_lack_of_planning"    
# [7] "upps_y_ss_lack_of_planning_nm"  "upps_y_ss_lack_of_planning_nt"  "upps_y_ss_sensation_seeking"   
# [10] "upps_y_ss_sensation_seeking_nm" "upps_y_ss_sensation_seeking_nt" "upps_y_ss_positive_urgency"    
# [13] "upps_y_ss_positive_urgency_nm"  "upps_y_ss_positive_urgency_nt"  "upps_y_ss_lack_of_perseverance"
# [16] "upps_y_ss_lack_of_pers_nm"      "upps_y_ss_lack_of_pers_nt"      "bis_y_ss_bis_sum"              
# [19] "bis_y_ss_bis_sum_nm"            "bis_y_ss_bis_sum_nt"            "bis_y_ss_bas_rr"               
# [22] "bis_y_ss_bas_rr_nm"             "bis_y_ss_bas_rr_nt"             "bis_y_ss_bas_drive"            
# [25] "bis_y_ss_bas_drive_nm"          "bis_y_ss_bas_drive_nt"          "bis_y_ss_bas_fs"               
# [28] "bis_y_ss_bas_fs_nm"             "bis_y_ss_bas_fs_nt"             "bis_y_ss_bism_sum"             
# [31] "bis_y_ss_bism_sum_nm"           "bis_y_ss_bism_sum_nt"           "bis_y_ss_basm_rr"              
# [34] "bis_y_ss_basm_rr_nm"            "bis_y_ss_basm_rr_nt"            "bis_y_ss_basm_drive"           
# [37] "bis_y_ss_basm_drive_nm"         "bis_y_ss_basm_drive_nt"         "delq_y_ss_sum"                 
# [40] "delq_y_ss_sum_nm"               "delq_y_ss_sum_nt"               "peq_ss_relational_aggs_nm"     
# [43] "peq_ss_relational_aggs_nt"      "peq_ss_relational_victim"       "peq_ss_relational_victim_nm"   
# [46] "peq_ss_relational_victim_nt"    "peq_ss_reputation_aggs"         "peq_ss_reputation_aggs_nm"     
# [49] "peq_ss_reputation_aggs_nt"      "peq_ss_reputation_victim"       "peq_ss_reputation_victim_nm"   
# [52] "peq_ss_reputation_victim_nt"    "peq_ss_overt_aggression"        "peq_ss_overt_aggression_nm"    
# [55] "peq_ss_overt_aggression_nt"     "peq_ss_overt_victim"            "peq_ss_overt_victim_nm"        
# [58] "peq_ss_overt_victim_nt"         "peq_ss_relational_aggs"        

#Remove variables number of missing and total questions
mhealth_youth = mhealth_youth[,-c(4,5,7,8,10,11,13,14,16,17,19,20,22,23,25,26,28,29,
                                  31,32,34,35,37,38,40,41,42,43,45,46,48,49,51,52,54,55,57,58)]

colnames(mhealth_youth)
# [1] "subjectkey"                     "eventname"                      "upps_y_ss_negative_urgency"    
# [4] "upps_y_ss_lack_of_planning"     "upps_y_ss_sensation_seeking"    "upps_y_ss_positive_urgency"    
# [7] "upps_y_ss_lack_of_perseverance" "bis_y_ss_bis_sum"               "bis_y_ss_bas_rr"               
# [10] "bis_y_ss_bas_drive"             "bis_y_ss_bas_fs"                "bis_y_ss_bism_sum"             
# [13] "bis_y_ss_basm_rr"               "bis_y_ss_basm_drive"            "delq_y_ss_sum"                 
# [16] "peq_ss_relational_victim"       "peq_ss_reputation_aggs"         "peq_ss_reputation_victim"      
# [19] "peq_ss_overt_aggression"        "peq_ss_overt_victim"            "peq_ss_relational_aggs" 

#Rename variables
names(mhealth_youth)[names(mhealth_youth) == "subjectkey"] = "id"
names(mhealth_youth)[names(mhealth_youth) == "eventname"] = "timepoint"
names(mhealth_youth)[names(mhealth_youth) == "upps_y_ss_negative_urgency"] = "upps_neg_urgency"
names(mhealth_youth)[names(mhealth_youth) == "upps_y_ss_lack_of_planning"] = "upps_lack_of_planning"
names(mhealth_youth)[names(mhealth_youth) == "upps_y_ss_sensation_seeking"] = "upps_sensation_seek"
names(mhealth_youth)[names(mhealth_youth) == "upps_y_ss_positive_urgency"] = "upps_pos_urgency"
names(mhealth_youth)[names(mhealth_youth) == "upps_y_ss_lack_of_perseverance"] = "upps_lack_of_perseverance"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_bis_sum"] = "bis"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_bas_rr"] = "bas_reward_respon"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_bas_drive"] = "bas_drive"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_bas_fs"] = "bas_fun_seek"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_bism_sum"] = "bis_mod"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_basm_rr"] = "bas_mod_reward_respon"
names(mhealth_youth)[names(mhealth_youth) == "bis_y_ss_basm_drive"] = "bas_mod_drive"
names(mhealth_youth)[names(mhealth_youth) == "delq_y_ss_sum"] = "delinq"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_relational_victim"] = "pexp_relational_victim"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_reputation_aggs"] = "pexp_reputation"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_reputation_victim"] = "pexp_reptuation_vict"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_overt_aggression"] = "pexp_overt_aggres"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_overt_victim"] = "pexp_overt_vict"
names(mhealth_youth)[names(mhealth_youth) == "peq_ss_relational_aggs"] = "pexp_relational_aggres"

colnames(mhealth_youth)
# [1] "id"                        "timepoint"                 "upps_neg_urgency"          "upps_lack_of_planning"    
# [5] "upps_sensation_seek"       "upps_pos_urgency"          "upps_lack_of_perseverance" "bis"                      
# [9] "bas_reward_respon"         "bas_drive"                 "bas_fun_seek"              "bis_mod"                  
# [13] "bas_mod_reward_respon"     "bas_mod_drive"             "delinq"                    "pexp_relational_victim"   
# [17] "pexp_reputation"           "pexp_reptuation_vict"      "pexp_overt_aggres"         "pexp_overt_vict"          
# [21] "pexp_relational_aggres"   

table(mhealth_youth$pexp_overt_aggres, useNA = "ifany")
#         10    11    12    13    14    15     3     4     5     6     7     8     9 
# 23137    13    10     5     3     1     2 14189  1345   543   246   148    81    43 

#Rescale variables so "" is NA
colnames(mhealth_youth)
mhealth_youth[, c(3:21)][mhealth_youth[, c(3:21)] == ""] <- NA

table(mhealth_youth$pexp_overt_aggres, useNA = "ifany")
#   10    11    12    13    14    15     3     4     5     6     7     8     9  <NA> 
#   13    10     5     3     1     2 14189  1345   543   246   148    81    43 23137 

#Identify the number of timepoints in dataset
table(mhealth_youth$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

#Label timepoints
mhealth_youth[which(mhealth_youth$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
mhealth_youth[which(mhealth_youth$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
mhealth_youth[which(mhealth_youth$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
mhealth_youth[which(mhealth_youth$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3

table(mhealth_youth$timepoint, useNA = "ifany")
#   0     1     2     3 
# 11876 11225 10414  6251 

#Reshape data to wide 
library(reshape)
mhealth_youth_wide = reshape(mhealth_youth, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(mhealth_youth_wide)
# [1] "id"                          "upps_neg_urgency.2"          "upps_lack_of_planning.2"    
# [4] "upps_sensation_seek.2"       "upps_pos_urgency.2"          "upps_lack_of_perseverance.2"
# [7] "bis.2"                       "bas_reward_respon.2"         "bas_drive.2"                
# [10] "bas_fun_seek.2"              "bis_mod.2"                   "bas_mod_reward_respon.2"    
# [13] "bas_mod_drive.2"             "delinq.2"                    "pexp_relational_victim.2"   
# [16] "pexp_reputation.2"           "pexp_reptuation_vict.2"      "pexp_overt_aggres.2"        
# [19] "pexp_overt_vict.2"           "pexp_relational_aggres.2"    "upps_neg_urgency.1"         
# [22] "upps_lack_of_planning.1"     "upps_sensation_seek.1"       "upps_pos_urgency.1"         
# [25] "upps_lack_of_perseverance.1" "bis.1"                       "bas_reward_respon.1"        
# [28] "bas_drive.1"                 "bas_fun_seek.1"              "bis_mod.1"                  
# [31] "bas_mod_reward_respon.1"     "bas_mod_drive.1"             "delinq.1"                   
# [34] "pexp_relational_victim.1"    "pexp_reputation.1"           "pexp_reptuation_vict.1"     
# [37] "pexp_overt_aggres.1"         "pexp_overt_vict.1"           "pexp_relational_aggres.1"   
# [40] "upps_neg_urgency.0"          "upps_lack_of_planning.0"     "upps_sensation_seek.0"      
# [43] "upps_pos_urgency.0"          "upps_lack_of_perseverance.0" "bis.0"                      
# [46] "bas_reward_respon.0"         "bas_drive.0"                 "bas_fun_seek.0"             
# [49] "bis_mod.0"                   "bas_mod_reward_respon.0"     "bas_mod_drive.0"            
# [52] "delinq.0"                    "pexp_relational_victim.0"    "pexp_reputation.0"          
# [55] "pexp_reptuation_vict.0"      "pexp_overt_aggres.0"         "pexp_overt_vict.0"          
# [58] "pexp_relational_aggres.0"    "upps_neg_urgency.3"          "upps_lack_of_planning.3"    
# [61] "upps_sensation_seek.3"       "upps_pos_urgency.3"          "upps_lack_of_perseverance.3"
# [64] "bis.3"                       "bas_reward_respon.3"         "bas_drive.3"                
# [67] "bas_fun_seek.3"              "bis_mod.3"                   "bas_mod_reward_respon.3"    
# [70] "bas_mod_drive.3"             "delinq.3"                    "pexp_relational_victim.3"   
# [73] "pexp_reputation.3"           "pexp_reptuation_vict.3"      "pexp_overt_aggres.3"        
# [76] "pexp_overt_vict.3"           "pexp_relational_aggres.3"      


#Mental Health Parent Report Summary Scores- ND (Cannot use, no data available for temperament questionnaire) ----

#Add path and file name
mhealth_parent  = read.delim(file("abcd_mhp02.txt"))
mhealth_parent = mhealth_parent[-c(1),]
dim(mhealth_parent) 
# [1] 39766    87

colnames(mhealth_parent)
# [1] "collection_id"                  "abcd_mhp02_id"                  "dataset_id"                    
# [4] "subjectkey"                     "src_subject_id"                 "interview_age"                 
# [7] "interview_date"                 "sex"                            "eventname"                     
# [10] "pgbi_p_ss_score"                "pgbi_p_ss_score_nm"             "pgbi_p_ss_score_nt"            
# [13] "ple_p_ss_total_number"          "ple_p_ss_total_number_nm"       "ple_p_ss_total_number_nt"      
# [16] "ple_p_ss_total_good"            "ple_p_ss_total_good_nt"         "ple_p_ss_total_bad"            
# [19] "ple_p_ss_total_bad_nt"          "ple_p_ss_affected_good_sum"     "ple_p_ss_affected_good_sum_nt" 
# [22] "ple_p_ss_affected_good_mean"    "ple_p_ss_affected_good_mean_nt" "ple_p_ss_affected_bad_sum"     
# [25] "ple_p_ss_affected_bad_sum_nt"   "ple_p_ss_affected_bad_mean"     "ple_p_ss_affected_bad_mean_nt" 
# [28] "ple_p_ss_affected_mean"         "ple_p_ss_affected_mean_nt"      "ple_p_ss_affect_sum"           
# [31] "ple_p_ss_affect_sum_nt"         "ssrs_p_ss_sum"                  "ssrs_p_ss_sum_nm"              
# [34] "ssrs_ss_sum_nt"                 "gish_p_ss_m_sum"                "gish_p_ss_m_sum_nm"            
# [37] "gish_p_ss_m_sum_nt"             "gish_p_ss_f_sum"                "gish_p_ss_f_sum_nm"            
# [40] "gish_p_ss_f_sum_nt"             "eatq_p_ss_aggression_nm"        "eatq_p_ss_aggression_nt"       
# [43] "eatq_p_ss_attention"            "eatq_p_ss_attention_nm"         "eatq_p_ss_attention_nt"        
# [46] "eatq_p_ss_depressive_mood"      "eatq_p_ss_depressive_mood_nm"   "eatq_p_ss_depressive_mood_nt"  
# [49] "eatq_p_ss_effort_cont_ss"       "eatq_p_ss_effort_cont_ss_nm"    "eatq_p_ss_effort_cont_ss_nt"   
# [52] "eatq_p_ss_fear"                 "eatq_p_ss_fear_nm"              "eatq_p_ss_fear_nt"             
# [55] "eatq_p_ss_frustration"          "eatq_p_ss_frustration_nm"       "eatq_p_ss_frustration_nt"      
# [58] "eatq_p_ss_inhibitory"           "eatq_p_ss_inhibitory_nm"        "eatq_p_ss_inhibitory_nt"       
# [61] "eatq_p_ss_activation"           "eatq_p_ss_neg_affect_ss"        "eatq_p_ss_neg_affect_ss_nm"    
# [64] "eatq_p_ss_neg_affect_ss_nt"     "eatq_p_ss_shyness"              "eatq_p_ss_shyness_nm"          
# [67] "eatq_p_ss_shyness_nt"           "eatq_p_ss_surgency"             "eatq_p_ss_surgency_nm"         
# [70] "eatq_p_ss_surgency_nt"          "eatq_p_ss_surgency_ss"          "eatq_p_ss_activation_nm"       
# [73] "eatq_p_ss_surgency_ss_nm"       "eatq_p_ss_surgency_ss_nt"       "gish_p_ss_f_sum2"              
# [76] "gish_p_ss_f_sum2_nm"            "gish_p_ss_f_sum2_nt"            "gish_p_ss_m_sum2"              
# [79] "gish_p_ss_m_sum2_nm"            "gish_p_ss_m_sum2_nt"            "eatq_p_ss_activation_nt"       
# [82] "eatq_p_ss_affiliation"          "eatq_p_ss_affiliation_nm"       "eatq_p_ss_affiliation_nt"      
# [85] "eatq_p_ss_aggression"           "collection_title"               "study_cohort_name"             

table(mhealth_parent$eventname, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

mhealth_parent = mhealth_parent[,-c(1:3, 5:8, 10:42, 44, 45, 47, 48, 50, 51, 53, 54, 56, 57, 
                                    59, 60, 63, 64, 66, 67, 69, 70, 72, 73, 74:81, 83, 84, 86:87)]

colnames(mhealth_parent)
# [1] "subjectkey"                "eventname"                 "eatq_p_ss_attention"       "eatq_p_ss_depressive_mood"
# [5] "eatq_p_ss_effort_cont_ss"  "eatq_p_ss_fear"            "eatq_p_ss_frustration"     "eatq_p_ss_inhibitory"     
# [9] "eatq_p_ss_activation"      "eatq_p_ss_neg_affect_ss"   "eatq_p_ss_shyness"         "eatq_p_ss_surgency"       
# [13] "eatq_p_ss_surgency_ss"     "eatq_p_ss_affiliation"     "eatq_p_ss_aggression"    

#Rename variables
names(mhealth_parent)[names(mhealth_parent) == "subjectkey"] = "id"
names(mhealth_parent)[names(mhealth_parent) == "eventname"] = "timepoint"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_attention"] = "eatq_attent"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_depressive_mood"] = "eatq_depress"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_effort_cont_ss"] = "eatq_control"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_fear"] = "eatq_fear"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_frustration"] = "eatq_frustration"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_inhibitory"] = "eatq_inhibitory"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_activation"] = "eatq_activation"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_neg_affect_ss"] = "eatq_negaffect"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_shyness"] = "eatq_shy"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_surgency"] = "eatq_surgency"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_surgency_ss"] = "eatq_supscal_surgency"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_affiliation"] = "eatq_affiliation"
names(mhealth_parent)[names(mhealth_parent) == "eatq_p_ss_aggression"] = "eatq_aggres"

colnames(mhealth_parent)
# [1] "id"                    "timepoint"             "eatq_attent"           "eatq_depress"         
# [5] "eatq_control"          "eatq_fear"             "eatq_frustration"      "eatq_inhibitory"      
# [9] "eatq_activation"       "eatq_negaffect"        "eatq_shy"              "eatq_surgency"        
# [13] "eatq_supscal_surgency" "eatq_affiliation"      "eatq_aggres"     

table(mhealth_parent$eatq_control, useNA = "ifany")
#         10    11    12    13    14    15     3     4     5     6     7     8     9 
# 23137    13    10     5     3     1     2 14189  1345   543   246   148    81    43 

#Rescale variables so "" is NA
colnames(mhealth_youth)
mhealth_youth[, c(3:21)][mhealth_youth[, c(3:21)] == ""] <- NA

table(mhealth_youth$pexp_overt_aggres, useNA = "ifany")
#   10    11    12    13    14    15     3     4     5     6     7     8     9  <NA> 
#   13    10     5     3     1     2 14189  1345   543   246   148    81    43 23137 

#Identify the number of timepoints in dataset
table(mhealth_youth$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

#Label timepoints
mhealth_youth[which(mhealth_youth$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
mhealth_youth[which(mhealth_youth$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
mhealth_youth[which(mhealth_youth$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
mhealth_youth[which(mhealth_youth$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3

table(mhealth_youth$timepoint, useNA = "ifany")
#   0     1     2     3 
# 11876 11225 10414  6251 

#Reshape data to wide 
library(reshape)
mhealth_youth_wide = reshape(mhealth_youth, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(mhealth_youth_wide)
# [1] "id"                          "upps_neg_urgency.2"          "upps_lack_of_planning.2"    
# [4] "upps_sensation_seek.2"       "upps_pos_urgency.2"          "upps_lack_of_perseverance.2"
# [7] "bis.2"                       "bas_reward_respon.2"         "bas_drive.2"                
# [10] "bas_fun_seek.2"              "bis_mod.2"                   "bas_mod_reward_respon.2"    
# [13] "bas_mod_drive.2"             "delinq.2"                    "pexp_relational_victim.2"   
# [16] "pexp_reputation.2"           "pexp_reptuation_vict.2"      "pexp_overt_aggres.2"        
# [19] "pexp_overt_vict.2"           "pexp_relational_aggres.2"    "upps_neg_urgency.1"         
# [22] "upps_lack_of_planning.1"     "upps_sensation_seek.1"       "upps_pos_urgency.1"         
# [25] "upps_lack_of_perseverance.1" "bis.1"                       "bas_reward_respon.1"        
# [28] "bas_drive.1"                 "bas_fun_seek.1"              "bis_mod.1"                  
# [31] "bas_mod_reward_respon.1"     "bas_mod_drive.1"             "delinq.1"                   
# [34] "pexp_relational_victim.1"    "pexp_reputation.1"           "pexp_reptuation_vict.1"     
# [37] "pexp_overt_aggres.1"         "pexp_overt_vict.1"           "pexp_relational_aggres.1"   
# [40] "upps_neg_urgency.0"          "upps_lack_of_planning.0"     "upps_sensation_seek.0"      
# [43] "upps_pos_urgency.0"          "upps_lack_of_perseverance.0" "bis.0"                      
# [46] "bas_reward_respon.0"         "bas_drive.0"                 "bas_fun_seek.0"             
# [49] "bis_mod.0"                   "bas_mod_reward_respon.0"     "bas_mod_drive.0"            
# [52] "delinq.0"                    "pexp_relational_victim.0"    "pexp_reputation.0"          
# [55] "pexp_reptuation_vict.0"      "pexp_overt_aggres.0"         "pexp_overt_vict.0"          
# [58] "pexp_relational_aggres.0"    "upps_neg_urgency.3"          "upps_lack_of_planning.3"    
# [61] "upps_sensation_seek.3"       "upps_pos_urgency.3"          "upps_lack_of_perseverance.3"
# [64] "bis.3"                       "bas_reward_respon.3"         "bas_drive.3"                
# [67] "bas_fun_seek.3"              "bis_mod.3"                   "bas_mod_reward_respon.3"    
# [70] "bas_mod_drive.3"             "delinq.3"                    "pexp_relational_victim.3"   
# [73] "pexp_reputation.3"           "pexp_reptuation_vict.3"      "pexp_overt_aggres.3"        
# [76] "pexp_overt_vict.3"           "pexp_relational_aggres.3"      


































#NIH TB Summary Scores- ND ----

#Add path and file name
nih  = read.delim(file("abcd_tbss01.txt"))
nih = nih[-c(1),]
dim(nih) 
# [1] 22290   108

colnames(nih)
# [1] "collection_id"                 "abcd_tbss01_id"                "dataset_id"                   
# [4] "subjectkey"                    "src_subject_id"                "interview_date"               
# [7] "interview_age"                 "sex"                           "eventname"                    
# [10] "nihtbx_picvocab_date"          "nihtbx_picvocab_language"      "nihtbx_picvocab_uncorrected"  
# [13] "nihtbx_picvocab_agecorrected"  "nihtbx_picvocab_v"             "nihtbx_flanker_date"          
# [16] "nihtbx_flanker_language"       "nihtbx_flanker_uncorrected"    "nihtbx_flanker_agecorrected"  
# [19] "nihtbx_flanker_v"              "nihtbx_list_date"              "nihtbx_list_language"         
# [22] "nihtbx_list_uncorrected"       "nihtbx_list_agecorrected"      "nihtbx_list_v"                
# [25] "nihtbx_cardsort_date"          "nihtbx_cardsort_language"      "nihtbx_cardsort_uncorrected"  
# [28] "nihtbx_cardsort_agecorrected"  "nihtbx_cardsort_v"             "nihtbx_pattern_date"          
# [31] "nihtbx_pattern_language"       "nihtbx_pattern_uncorrected"    "nihtbx_pattern_agecorrected"  
# [34] "nihtbx_pattern_v"              "nihtbx_picture_date"           "nihtbx_picture_language"      
# [37] "nihtbx_picture_uncorrected"    "nihtbx_picture_agecorrected"   "nihtbx_picture_v"             
# [40] "nihtbx_reading_date"           "nihtbx_reading_language"       "nihtbx_reading_uncorrected"   
# [43] "nihtbx_reading_agecorrected"   "nihtbx_reading_v"              "nihtbx_fluidcomp_language"    
# [46] "nihtbx_fluidcomp_uncorrected"  "nihtbx_fluidcomp_agecorrected" "nihtbx_fluidcomp_v"           
# [49] "nihtbx_cryst_language"         "nihtbx_cryst_uncorrected"      "nihtbx_cryst_agecorrected"    
# [52] "nihtbx_cryst_v"                "nihtbx_totalcomp_language"     "nihtbx_totalcomp_uncorrected" 
# [55] "nihtbx_totalcomp_agecorrected" "nihtbx_totalcomp_v"            "nihtbx_picvocab_rs"           
# [58] "nihtbx_picvocab_theta"         "nihtbx_picvocab_itmcnt"        "nihtbx_picvocab_cs"           
# [61] "nihtbx_picvocab_fc"            "nihtbx_flanker_rawscore"       "nihtbx_flanker_theta"         
# [64] "nihtbx_flanker_itmcnt"         "nihtbx_flanker_cs"             "nihtbx_flanker_fc"            
# [67] "nihtbx_list_rawscore"          "nihtbx_list_theta"             "nihtbx_list_itmcnt"           
# [70] "nihtbx_list_cs"                "nihtbx_list_fc"                "nihtbx_cardsort_rawscore"     
# [73] "nihtbx_cardsort_theta"         "nihtbx_cardsort_itmcnt"        "nihtbx_cardsort_cs"           
# [76] "nihtbx_cardsort_fc"            "nihtbx_pattern_rawscore"       "nihtbx_pattern_theta"         
# [79] "nihtbx_pattern_itmcnt"         "nihtbx_pattern_cs"             "nihtbx_pattern_fc"            
# [82] "nihtbx_picture_rawscore"       "nihtbx_picture_theta"          "nihtbx_picture_itmcnt"        
# [85] "nihtbx_picture_cs"             "nihtbx_picture_fc"             "nihtbx_reading_rawscore"      
# [88] "nihtbx_reading_theta"          "nihtbx_reading_itmcnt"         "nihtbx_reading_cs"            
# [91] "nihtbx_reading_fc"             "nihtbx_fluidcomp_rs"           "nihtbx_fluidcomp_theta"       
# [94] "nihtbx_fluidcomp_itmcnt"       "nihtbx_fluidcomp_cs"           "nihtbx_fluidcomp_fc"          
# [97] "nihtbx_cryst_rawscore"         "nihtbx_cryst_theta"            "nihtbx_cryst_itmcnt"          
# [100] "nihtbx_cryst_cs"               "nihtbx_cryst_fc"               "nihtbx_totalcomp_rawscore"    
# [103] "nihtbx_totalcomp_theta"        "nihtbx_totalcomp_itmcnt"       "nihtbx_totalcomp_cs"          
# [106] "nihtbx_totalcomp_fc"           "collection_title"              "study_cohort_name"    

table(nih$eventname, useNA = "ifany")
# 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 10414                       11876

nih = nih[,-c(1:3, 5:8, 10:16, 19:26, 29:65, 67:75, 77:108)]

colnames(nih)
# [1] "subjectkey"                   "eventname"                    "nihtbx_flanker_uncorrected"  
# [4] "nihtbx_flanker_agecorrected"  "nihtbx_cardsort_uncorrected"  "nihtbx_cardsort_agecorrected"
# [7] "nihtbx_flanker_fc"            "nihtbx_cardsort_fc"    

#Rename variables
names(nih)[names(nih) == "subjectkey"] = "id"
names(nih)[names(nih) == "eventname"] = "timepoint"
names(nih)[names(nih) == "nihtbx_flanker_uncorrected"] = "flanker_uncor"
names(nih)[names(nih) == "nihtbx_flanker_agecorrected"] = "flanker_agecor"
names(nih)[names(nih) == "nihtbx_cardsort_uncorrected"] = "dccs_uncor"
names(nih)[names(nih) == "nihtbx_cardsort_agecorrected"] = "dccs_agecor"
names(nih)[names(nih) == "nihtbx_flanker_fc"] = "flanker_cortscore"
names(nih)[names(nih) == "nihtbx_cardsort_fc"] = "dccs_cortscore"

colnames(nih)
# [1] "id"                "timepoint"         "flanker_uncor"     "flanker_agecor"    "dccs_uncor"       
# [6] "dccs_agecor"       "flanker_cortscore" "dccs_cortscore" 

table(nih$flanker_cortscore, useNA = "ifany")
#         10.0 100.0 101.0 112.0 113.0  12.0  13.0  15.0  16.0  17.0  19.0  20.0  21.0  22.0  23.0  24.0  25.0  26.0 
# 3355     7     1     1     1     1     1     1     1     9     4    32    13     5    21     7    24     6    69 
# 27.0  28.0  29.0  30.0  31.0  32.0  33.0  34.0  35.0  36.0  37.0  38.0  39.0  40.0  41.0  42.0  43.0  43.9  44.0 
# 33   104   121   124   229   184   336   346   556   400   513   603   617   739   817   766   676     1   943 
# 45.0  46.0  47.0  48.0  49.0  50.0  51.0  52.0  52.8  53.0  54.0  55.0  56.0  57.0  57.1  58.0  59.0  60.0  61.0 
# 920   576   825  1022   812   725   641   460     1   614   739   405   567   316     1   218   283   212   265 
# 62.0  63.0  64.0  65.0  66.0  67.0  68.0  69.0  70.0  71.0  72.0  73.0  74.0  75.0  76.0  77.0  78.0  79.0  80.0 
# 172   119   122    92    98    63    70    47    41    17    21    19    31    14     9     9     6    14     5 
# 81.0  82.0  83.0  84.0  85.0  89.0  90.0  93.0  96.0 
# 41     2     1     2     1     1     2     1     1 

#Rescale variables so "" is NA
colnames(nih)
nih[, c(3:8)][nih[, c(3:8)] == ""] <- NA

table(nih$dccs_agecor, useNA = "ifany")
# 100.0 103.0 106.0 108.7 109.0 110.0 112.0 115.0 117.0 118.0 120.0 123.0 125.0 127.0 129.0 131.0 134.0 135.0 136.0 
# 1381   907    45     1   824     1   561    31     1   358   284     8    10   179   152     6     3     3    89 
# 137.8 138.0 143.0 145.0 146.0 146.4 148.0 154.0 155.0 163.0 164.0 165.0 172.0 181.0 191.0  63.0  65.0  68.0  72.0 
# 1    82     2    46    46     1     1    13    19     4     5     1     5     4     1     1     1    70   152 
# 73.0  77.0  81.0  82.0  86.0  87.0  90.0  90.4  94.0  96.0  98.0  <NA> 
#   13   721  1216    25  1375    38  1786     1  1252    35    29 10500 

#Identify the number of timepoints in dataset
table(nih$timepoint, useNA = "ifany")
# 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 10414                       11876 

#Label timepoints
nih[which(nih$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
nih[which(nih$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2

table(nih$timepoint, useNA = "ifany")
# 0     2 
# 11876 10414 

#Reshape data to wide 
library(reshape)
nih_wide = reshape(nih, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(nih_wide)
# [1] "id"                  "flanker_uncor.0"     "flanker_agecor.0"    "dccs_uncor.0"        "dccs_agecor.0"      
# [6] "flanker_cortscore.0" "dccs_cortscore.0"    "flanker_uncor.2"     "flanker_agecor.2"    "dccs_uncor.2"       
# [11] "dccs_agecor.2"       "flanker_cortscore.2" "dccs_cortscore.2"  


#Brief Problem Monitor Summary Scores- Teacher Report- ND ----

#Add path and file name
brief_teach  = read.delim(file("abcd_ssbpmtf01.txt"))
brief_teach = brief_teach[-c(1),]
dim(brief_teach) 
# [1] 39766    39

colnames(brief_teach)
# [1] "collection_id"           "abcd_ssbpmtf01_id"       "dataset_id"              "subjectkey"             
# [5] "src_subject_id"          "interview_date"          "interview_age"           "sex"                    
# [9] "eventname"               "bpm_t_scr_attention_r"   "bpm_t_scr_attention_t"   "bpm_t_scr_attention_nm" 
# [13] "bpm_t_scr_attention_nt"  "bpm_t_ss_attention_mean" "bpm_t_ss_attention_nm"   "bpm_t_ss_attention_nt"  
# [17] "bpm_t_scr_internal_r"    "bpm_t_scr_internal_t"    "bpm_t_scr_internal_nm"   "bpm_t_scr_internal_nt"  
# [21] "bpm_t_ss_internal_mean"  "bpm_t_ss_internal_nm"    "bpm_t_ss_internal_nt"    "bpm_t_scr_external_r"   
# [25] "bpm_t_scr_external_t"    "bpm_t_scr_external_nm"   "bpm_t_scr_external_nt"   "bpm_t_ss_external_mean" 
# [29] "bpm_t_ss_external_nm"    "bpm_t_ss_external_nt"    "bpm_t_scr_totalprob_r"   "bpm_t_scr_totalprob_t"  
# [33] "bpm_t_scr_totalprob_nm"  "bpm_t_scr_totalprob_nt"  "bpm_t_ss_totalprob_mean" "bpm_t_ss_totalprob_nm"  
# [37] "bpm_t_ss_totalprob_nt"   "collection_title"        "study_cohort_name"      

brief_teach = brief_teach[,-c(1:3, 5:8, 10, 12:17, 19:24, 26:31, 33:39)]

colnames(brief_teach)
# [1] "subjectkey"            "eventname"             "bpm_t_scr_attention_t" "bpm_t_scr_internal_t" 
# [5] "bpm_t_scr_external_t"  "bpm_t_scr_totalprob_t"  

#Rename variables
names(brief_teach)[names(brief_teach) == "subjectkey"] = "id"
names(brief_teach)[names(brief_teach) == "eventname"] = "timepoint"
names(brief_teach)[names(brief_teach) == "bpm_t_scr_attention_t"] = "bpm_attention_t"
names(brief_teach)[names(brief_teach) == "bpm_t_scr_internal_t"] = "bpm_internal_t"
names(brief_teach)[names(brief_teach) == "bpm_t_scr_external_t"] = "bpm_external_t"
names(brief_teach)[names(brief_teach) == "bpm_t_scr_totalprob_t"] = "bpm_total_t"

colnames(brief_teach)
# [1] "id"              "timepoint"       "bpm_attention_t" "bpm_internal_t"  "bpm_external_t"  "bpm_total_t"  

table(brief_teach$bpm_attention_t, useNA = "ifany")
#         50    51    52    53    55    56    57    58    59    61    63    64    66    68    69    70    71    72 
# 24802  7080   684   513   984   689   592   556   519   465   755   319   301   223   450   115   247    88    63 
# 73    74    75 
# 180    46    95 

#Rescale variables so "" is NA
colnames(brief_teach)
brief_teach[, c(3:6)][brief_teach[, c(3:6)] == ""] <- NA

table(brief_teach$bpm_attention_t, useNA = "ifany")
# 50    51    52    53    55    56    57    58    59    61    63    64    66    68    69    70    71    72    73 
# 7080   684   513   984   689   592   556   519   465   755   319   301   223   450   115   247    88    63   180 
# 74    75  <NA> 
#   46    95 24802 

#Identify the number of timepoints in dataset
table(brief_teach$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

#Label timepoints
brief_teach[which(brief_teach$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
brief_teach[which(brief_teach$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
brief_teach[which(brief_teach$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
brief_teach[which(brief_teach$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3

table(brief_teach$timepoint, useNA = "ifany")
#   0     1     2     3 
# 11876 11225 10414  6251 

#Reshape data to wide 
library(reshape)
brief_teach_wide = reshape(brief_teach, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(brief_teach_wide)
# [1] "id"                "bpm_attention_t.3" "bpm_internal_t.3"  "bpm_external_t.3"  "bpm_total_t.3"    
# [6] "bpm_attention_t.0" "bpm_internal_t.0"  "bpm_external_t.0"  "bpm_total_t.0"     "bpm_attention_t.1"
# [11] "bpm_internal_t.1"  "bpm_external_t.1"  "bpm_total_t.1"     "bpm_attention_t.2" "bpm_internal_t.2" 
# [16] "bpm_external_t.2"  "bpm_total_t.2"  














#Youth Summary Scores Brief- ND ---- 

#Add path and file name
brief_youth  = read.delim(file("abcd_yssbpm01.txt"))
brief_youth = brief_youth[-c(1),]
dim(brief_youth) 
# [1] 58926    42

colnames(brief_youth)
# [1] "collection_id"           "abcd_yssbpm01_id"        "dataset_id"              "subjectkey"             
# [5] "src_subject_id"          "interview_date"          "interview_age"           "sex"                    
# [9] "eventname"               "bpm_y_scr_attention_r"   "bpm_y_scr_attention_t"   "bpm_y_scr_attention_nm" 
# [13] "bpm_y_scr_attention_nt"  "bpm_y_ss_attention_mean" "bpm_y_ss_attention_nm"   "bpm_y_ss_attention_nt"  
# [17] "bpm_y_scr_internal_r"    "bpm_y_scr_internal_t"    "bpm_y_scr_internal_nm"   "bpm_y_scr_internal_nt"  
# [21] "bpm_y_ss_internal_mean"  "bpm_y_ss_internal_nm"    "bpm_y_ss_internal_nt"    "bpm_y_scr_external_r"   
# [25] "bpm_y_scr_external_t"    "bpm_y_scr_external_nm"   "bpm_y_scr_external_nt"   "bpm_y_ss_external_mean" 
# [29] "bpm_y_ss_external_nm"    "bpm_y_ss_external_nt"    "bpm_y_scr_totalprob_r"   "bpm_y_scr_totalprob_t"  
# [33] "bpm_y_scr_totalprob_nm"  "bpm_y_scr_totalprob_nt"  "bpm_y_ss_totalprob_mean" "bpm_y_ss_totalprob_nm"  
# [37] "bpm_y_ss_totalprob_nt"   "poa_y_ss_sum"            "poa_y_ss_sum_nm"         "poa_y_ss_sum_nt"        
# [41] "collection_title"        "study_cohort_name"       

brief_youth = brief_youth[,-c(1:3, 5:8, 10, 12:17, 19:24, 26:31, 33:42)]

colnames(brief_youth)
# [1] "subjectkey"            "eventname"             "bpm_y_scr_attention_t" "bpm_y_scr_internal_t" 
# [5] "bpm_y_scr_external_t"  "bpm_y_scr_totalprob_t"

#Rename variables
names(brief_youth)[names(brief_youth) == "subjectkey"] = "id"
names(brief_youth)[names(brief_youth) == "eventname"] = "timepoint"
names(brief_youth)[names(brief_youth) == "bpm_y_scr_attention_t"] = "bpm_y_attention_t"
names(brief_youth)[names(brief_youth) == "bpm_y_scr_internal_t"] = "bpm_y_internal_t"
names(brief_youth)[names(brief_youth) == "bpm_y_scr_external_t"] = "bpm_y_external_t"
names(brief_youth)[names(brief_youth) == "bpm_y_scr_totalprob_t"] = "bpm_y_total_t"

colnames(brief_youth)
# [1] "id"                "timepoint"         "bpm_y_attention_t" "bpm_y_internal_t"  "bpm_y_external_t" 
# [6] "bpm_y_total_t"    

table(brief_youth$bpm_y_attention_t, useNA = "ifany")
#       50.0  51.0  53.0  54.0  56.0  57.0  61.0  62.0  64.0  66.0  67.0  68.0  69.0  70.0  71.0  72.0  73.0  74.0 
# 2928 18319  7791  3913  3424  3545  2990  2907  2291  2163  1777  1473  2308   859  1263   383   296   224    39 
# 75.0 
# 33 

#Rescale variables so "" is NA
colnames(brief_youth)
brief_youth[, c(3:6)][brief_youth[, c(3:6)] == ""] <- NA

table(brief_youth$bpm_y_attention_t, useNA = "ifany")
# 50.0  51.0  53.0  54.0  56.0  57.0  61.0  62.0  64.0  66.0  67.0  68.0  69.0  70.0  71.0  72.0  73.0  74.0  75.0 
# 18319  7791  3913  3424  3545  2990  2907  2291  2163  1777  1473  2308   859  1263   383   296   224    39    33 
#   <NA> 
#   2928 

#Identify the number of timepoints in dataset
# table(brief_youth$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 18_month_follow_up_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                    11089                    10414                     6251 
# 30_month_follow_up_arm_1  6_month_follow_up_arm_1 
# 8551                      11396 

#Label timepoints
brief_youth[which(brief_youth$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
brief_youth[which(brief_youth$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
brief_youth[which(brief_youth$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3
brief_youth[which(brief_youth$timepoint == "18_month_follow_up_arm_1"),  "timepoint"] = 18
brief_youth[which(brief_youth$timepoint == "30_month_follow_up_arm_1"),  "timepoint"] = 30
brief_youth[which(brief_youth$timepoint == "6_month_follow_up_arm_1"),  "timepoint"] = 6

table(brief_youth$timepoint, useNA = "ifany")
# 1    18     2     3    30     6 
# 11225 11089 10414  6251  8551 11396 

#Reshape data to wide 
library(reshape)
brief_youth_wide = reshape(brief_youth, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(brief_youth_wide)
# [1] "id"                   "bpm_y_attention_t.1"  "bpm_y_internal_t.1"   "bpm_y_external_t.1"   "bpm_y_total_t.1"     
# [6] "bpm_y_attention_t.18" "bpm_y_internal_t.18"  "bpm_y_external_t.18"  "bpm_y_total_t.18"     "bpm_y_attention_t.6" 
# [11] "bpm_y_internal_t.6"   "bpm_y_external_t.6"   "bpm_y_total_t.6"      "bpm_y_attention_t.2"  "bpm_y_internal_t.2"  
# [16] "bpm_y_external_t.2"   "bpm_y_total_t.2"      "bpm_y_attention_t.3"  "bpm_y_internal_t.3"   "bpm_y_external_t.3"  
# [21] "bpm_y_total_t.3"      "bpm_y_attention_t.30" "bpm_y_internal_t.30"  "bpm_y_external_t.30"  "bpm_y_total_t.30" 

#Remove 18 month, 6 month, and 30 month timepoint data
brief_youth_wide = brief_youth_wide[,-c(6:13, 22:25)]

colnames(brief_youth_wide)
# [1] "id"                  "bpm_y_attention_t.1" "bpm_y_internal_t.1"  "bpm_y_external_t.1"  "bpm_y_total_t.1"    
# [6] "bpm_y_attention_t.2" "bpm_y_internal_t.2"  "bpm_y_external_t.2"  "bpm_y_total_t.2"     "bpm_y_attention_t.3"
# [11] "bpm_y_internal_t.3"  "bpm_y_external_t.3"  "bpm_y_total_t.3"    




#Parent CBCL Scores- ND ---- 

#Add path and file name
p_cbcl  = read.delim(file("abcd_cbcls01.txt"))
p_cbcl = p_cbcl[-c(1),]
dim(p_cbcl) 
# [1] 39766    92

colnames(p_cbcl)
# [1] "collection_id"              "abcd_cbcls01_id"            "dataset_id"                
# [4] "subjectkey"                 "src_subject_id"             "interview_date"            
# [7] "interview_age"              "sex"                        "eventname"                 
# [10] "cbcl_scr_syn_anxdep_r"      "cbcl_scr_syn_anxdep_t"      "cbcl_scr_syn_anxdep_m"     
# [13] "cbcl_scr_syn_anxdep_nm"     "cbcl_scr_syn_withdep_r"     "cbcl_scr_syn_withdep_t"    
# [16] "cbcl_scr_syn_withdep_m"     "cbcl_scr_syn_withdep_nm"    "cbcl_scr_syn_somatic_r"    
# [19] "cbcl_scr_syn_somatic_t"     "cbcl_scr_syn_somatic_m"     "cbcl_scr_syn_somatic_nm"   
# [22] "cbcl_scr_syn_social_r"      "cbcl_scr_syn_social_t"      "cbcl_scr_syn_social_m"     
# [25] "cbcl_scr_syn_social_nm"     "cbcl_scr_syn_thought_r"     "cbcl_scr_syn_thought_t"    
# [28] "cbcl_scr_syn_thought_m"     "cbcl_scr_syn_thought_nm"    "cbcl_scr_syn_attention_r"  
# [31] "cbcl_scr_syn_attention_t"   "cbcl_scr_syn_attention_m"   "cbcl_scr_syn_attention_nm" 
# [34] "cbcl_scr_syn_rulebreak_r"   "cbcl_scr_syn_rulebreak_t"   "cbcl_scr_syn_rulebreak_m"  
# [37] "cbcl_scr_syn_rulebreak_nm"  "cbcl_scr_syn_aggressive_r"  "cbcl_scr_syn_aggressive_t" 
# [40] "cbcl_scr_syn_aggressive_m"  "cbcl_scr_syn_aggressive_nm" "cbcl_scr_syn_internal_r"   
# [43] "cbcl_scr_syn_internal_t"    "cbcl_scr_syn_internal_m"    "cbcl_scr_syn_internal_nm"  
# [46] "cbcl_scr_syn_external_r"    "cbcl_scr_syn_external_t"    "cbcl_scr_syn_external_m"   
# [49] "cbcl_scr_syn_external_nm"   "cbcl_scr_syn_totprob_r"     "cbcl_scr_syn_totprob_t"    
# [52] "cbcl_scr_syn_totprob_m"     "cbcl_scr_syn_totprob_nm"    "cbcl_scr_dsm5_depress_r"   
# [55] "cbcl_scr_dsm5_depress_t"    "cbcl_scr_dsm5_depress_m"    "cbcl_scr_dsm5_depress_nm"  
# [58] "cbcl_scr_dsm5_anxdisord_r"  "cbcl_scr_dsm5_anxdisord_t"  "cbcl_scr_dsm5_anxdisord_m" 
# [61] "cbcl_scr_dsm5_anxdisord_nm" "cbcl_scr_dsm5_somaticpr_r"  "cbcl_scr_dsm5_somaticpr_t" 
# [64] "cbcl_scr_dsm5_somaticpr_m"  "cbcl_scr_dsm5_somaticpr_nm" "cbcl_scr_dsm5_adhd_r"      
# [67] "cbcl_scr_dsm5_adhd_t"       "cbcl_scr_dsm5_adhd_m"       "cbcl_scr_dsm5_adhd_nm"     
# [70] "cbcl_scr_dsm5_opposit_r"    "cbcl_scr_dsm5_opposit_t"    "cbcl_scr_dsm5_opposit_m"   
# [73] "cbcl_scr_dsm5_opposit_nm"   "cbcl_scr_dsm5_conduct_r"    "cbcl_scr_dsm5_conduct_t"   
# [76] "cbcl_scr_dsm5_conduct_m"    "cbcl_scr_dsm5_conduct_nm"   "cbcl_scr_07_sct_r"         
# [79] "cbcl_scr_07_sct_t"          "cbcl_scr_07_sct_m"          "cbcl_scr_07_sct_nm"        
# [82] "cbcl_scr_07_ocd_r"          "cbcl_scr_07_ocd_t"          "cbcl_scr_07_ocd_m"         
# [85] "cbcl_scr_07_ocd_nm"         "cbcl_scr_07_stress_r"       "cbcl_scr_07_stress_t"      
# [88] "cbcl_scr_07_stress_m"       "cbcl_scr_07_stress_nm"      "cbcl_scr_07_stress_nm_2"   
# [91] "collection_title"           "study_cohort_name"     

p_cbcl = p_cbcl[,-c(1:3, 5:8, 10, 12:14, 16:18, 20:22, 24:26, 28:30, 32:34, 36:38, 40:42, 44:46, 48:50,
                    52:54, 56:58, 60:62, 64:66, 68:70, 72:74, 76:86, 88:92)]

colnames(p_cbcl)
# [1] "subjectkey"                "eventname"                 "cbcl_scr_syn_anxdep_t"     "cbcl_scr_syn_withdep_t"   
# [5] "cbcl_scr_syn_somatic_t"    "cbcl_scr_syn_social_t"     "cbcl_scr_syn_thought_t"    "cbcl_scr_syn_attention_t" 
# [9] "cbcl_scr_syn_rulebreak_t"  "cbcl_scr_syn_aggressive_t" "cbcl_scr_syn_internal_t"   "cbcl_scr_syn_external_t"  
# [13] "cbcl_scr_syn_totprob_t"    "cbcl_scr_dsm5_depress_t"   "cbcl_scr_dsm5_anxdisord_t" "cbcl_scr_dsm5_somaticpr_t"
# [17] "cbcl_scr_dsm5_adhd_t"      "cbcl_scr_dsm5_opposit_t"   "cbcl_scr_dsm5_conduct_t"   "cbcl_scr_07_stress_t" 

#Rename variables
names(p_cbcl)[names(p_cbcl) == "subjectkey"] = "id"
names(p_cbcl)[names(p_cbcl) == "eventname"] = "timepoint"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_anxdep_t"] = "cbcl_anxdep_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_withdep_t"] = "cbcl_withdep_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_somatic_t"] = "cbcl_somatic_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_social_t"] = "cbcl_social_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_thought_t"] = "cbcl_thought_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_attention_t"] = "cbcl_atten_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_rulebreak_t"] = "cbcl_rulebreak_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_aggressive_t"] = "cbcl_aggres_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_internal_t"] = "cbcl_internal_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_external_t"] = "cbcl_ext_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_syn_totprob_t"] = "cbcl_total_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_depress_t"] = "cbcl_depress_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_anxdisord_t"] = "cbcl_anxdisord_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_somaticpr_t"] = "cbcl_somatic_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_adhd_t"] = "cbcl_adhd_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_opposit_t"] = "cbcl_oppositdef_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_dsm5_conduct_t"] = "cbcl_conduct_t"
names(p_cbcl)[names(p_cbcl) == "cbcl_scr_07_stress_t"] = "cbcl_stress_t"

colnames(p_cbcl)
# [1] "id"                "timepoint"         "cbcl_anxdep_t"     "cbcl_withdep_t"    "cbcl_somatic_t"   
# [6] "cbcl_social_t"     "cbcl_thought_t"    "cbcl_atten_t"      "cbcl_rulebreak_t"  "cbcl_aggres_t"    
# [11] "cbcl_internal_t"   "cbcl_ext_t"        "cbcl_total_t"      "cbcl_depress_t"    "cbcl_anxdisord_t" 
# [16] "cbcl_somatic_t"    "cbcl_adhd_t"       "cbcl_oppositdef_t" "cbcl_conduct_t"    "cbcl_stress_t" 

table(p_cbcl$cbcl_anxdep_t, useNA = "ifany")
#         100    50    51    52    53    54    55    57    59    60    62    63    64    65    66    67    68    69 
# 2473     1 19182  4889  1815  1359  1421   351  2238   923   721   687   522   424   465   554   270   226   167 
# 70    72    74    76    78    79    80    81    82    83    84    85    86    87    88    89    90    91    92 
# 297   210   164   111    79     7    62     7    45     4    29     4    21     1    15     1    11     2     5 
# 93    94    98 
# 1     1     1 

#Rescale variables so "" is NA
colnames(p_cbcl)
p_cbcl[, c(3:20)][p_cbcl[, c(3:20)] == ""] <- NA

table(p_cbcl$cbcl_anxdep_t, useNA = "ifany")
# 100    50    51    52    53    54    55    57    59    60    62    63    64    65    66    67    68    69    70 
# 1 19182  4889  1815  1359  1421   351  2238   923   721   687   522   424   465   554   270   226   167   297 
# 72    74    76    78    79    80    81    82    83    84    85    86    87    88    89    90    91    92    93 
# 210   164   111    79     7    62     7    45     4    29     4    21     1    15     1    11     2     5     1 
# 94    98  <NA> 
#   1     1  2473 

#Identify the number of timepoints in dataset
table(p_cbcl$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                     6251                       11876 

#Label timepoints
p_cbcl[which(p_cbcl$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
p_cbcl[which(p_cbcl$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
p_cbcl[which(p_cbcl$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2
p_cbcl[which(p_cbcl$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3

table(p_cbcl$timepoint, useNA = "ifany")
# 0     1     2     3 
# 11876 11225 10414  6251

#Reshape data to wide 
library(reshape)
p_cbcl_wide = reshape(p_cbcl, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(p_cbcl_wide)
# [1] "id"                  "cbcl_anxdep_t.3"     "cbcl_withdep_t.3"    "cbcl_somatic_t.3"    "cbcl_social_t.3"    
# [6] "cbcl_thought_t.3"    "cbcl_atten_t.3"      "cbcl_rulebreak_t.3"  "cbcl_aggres_t.3"     "cbcl_internal_t.3"  
# [11] "cbcl_ext_t.3"        "cbcl_total_t.3"      "cbcl_depress_t.3"    "cbcl_anxdisord_t.3"  "cbcl_somatic_t.3.1" 
# [16] "cbcl_adhd_t.3"       "cbcl_oppositdef_t.3" "cbcl_conduct_t.3"    "cbcl_stress_t.3"     "cbcl_anxdep_t.2"    
# [21] "cbcl_withdep_t.2"    "cbcl_somatic_t.2"    "cbcl_social_t.2"     "cbcl_thought_t.2"    "cbcl_atten_t.2"     
# [26] "cbcl_rulebreak_t.2"  "cbcl_aggres_t.2"     "cbcl_internal_t.2"   "cbcl_ext_t.2"        "cbcl_total_t.2"     
# [31] "cbcl_depress_t.2"    "cbcl_anxdisord_t.2"  "cbcl_somatic_t.2.1"  "cbcl_adhd_t.2"       "cbcl_oppositdef_t.2"
# [36] "cbcl_conduct_t.2"    "cbcl_stress_t.2"     "cbcl_anxdep_t.1"     "cbcl_withdep_t.1"    "cbcl_somatic_t.1"   
# [41] "cbcl_social_t.1"     "cbcl_thought_t.1"    "cbcl_atten_t.1"      "cbcl_rulebreak_t.1"  "cbcl_aggres_t.1"    
# [46] "cbcl_internal_t.1"   "cbcl_ext_t.1"        "cbcl_total_t.1"      "cbcl_depress_t.1"    "cbcl_anxdisord_t.1" 
# [51] "cbcl_somatic_t.1.1"  "cbcl_adhd_t.1"       "cbcl_oppositdef_t.1" "cbcl_conduct_t.1"    "cbcl_stress_t.1"    
# [56] "cbcl_anxdep_t.0"     "cbcl_withdep_t.0"    "cbcl_somatic_t.0"    "cbcl_social_t.0"     "cbcl_thought_t.0"   
# [61] "cbcl_atten_t.0"      "cbcl_rulebreak_t.0"  "cbcl_aggres_t.0"     "cbcl_internal_t.0"   "cbcl_ext_t.0"       
# [66] "cbcl_total_t.0"      "cbcl_depress_t.0"    "cbcl_anxdisord_t.0"  "cbcl_somatic_t.0.1"  "cbcl_adhd_t.0"      
# [71] "cbcl_oppositdef_t.0" "cbcl_conduct_t.0"    "cbcl_stress_t.0" 








#Difficulty in Emotion Regulation - ND (cannot use measure, only 3 year available too much missing) ---- 

#Add path and file name
diff_emotion  = read.delim(file("diff_emotion_reg_p01.txt"))
diff_emotion = diff_emotion[-c(1),]
dim(diff_emotion) 
# [1] 39766    92

colnames(diff_emotion)





#ABCD Emotion Regulation Questionnaire- ND (cannot use measure, only 3 year available too much missing) ----

#Add path and file name
emot_reg  = read.delim(file("emotion_reg_erq_feelings01.txt"))
emot_reg = emot_reg[-c(1),]
dim(emot_reg) 
# [1] 39766    92

colnames(emot_reg)


#KSADS- Parent Report- ND ----

#Add path and file name
ksads_p  = read.delim(file("abcd_ksad01.txt"))
ksads_p = ksads_p[-c(1),]
dim(ksads_p) 
# [1] 33515   964

colnames(ksads_p)
# [1] "collection_id"     "abcd_ksad01_id"    "dataset_id"        "subjectkey"        "src_subject_id"   
# [6] "interview_date"    "interview_age"     "sex"               "eventname"         "ksads_import_id_p"
# [11] "ksads_1_843_p"     "ksads_1_845_p"     "ksads_1_844_p"     "ksads_1_840_p"     "ksads_1_841_p"    
# [16] "ksads_1_842_p"     "ksads_1_847_p"     "ksads_1_846_p"     "ksads_1_172_p"     "ksads_1_168_p"    
# [21] "ksads_1_171_p"     "ksads_1_167_p"     "ksads_1_3_p"       "ksads_1_4_p"       "ksads_1_156_p"    
# [26] "ksads_1_163_p"     "ksads_1_164_p"     "ksads_1_170_p"     "ksads_1_169_p"     "ksads_1_188_p"    
# [31] "ksads_1_187_p"     "ksads_1_175_p"     "ksads_1_176_p"     "ksads_1_173_p"     "ksads_1_174_p"    
# [36] "ksads_1_185_p"     "ksads_1_186_p"     "ksads_1_166_p"     "ksads_1_181_p"     "ksads_1_165_p"    
# [41] "ksads_1_182_p"     "ksads_1_1_p"       "ksads_1_2_p"       "ksads_1_5_p"       "ksads_1_6_p"      
# [46] "ksads_1_161_p"     "ksads_1_162_p"     "ksads_1_159_p"     "ksads_1_160_p"     "ksads_1_183_p"    
# [51] "ksads_1_184_p"     "ksads_1_180_p"     "ksads_1_179_p"     "ksads_1_157_p"     "ksads_1_158_p"    
# [56] "ksads_1_177_p"     "ksads_1_178_p"     "ksads_2_837_p"     "ksads_2_835_p"     "ksads_2_836_p"    
# [61] "ksads_2_831_p"     "ksads_2_832_p"     "ksads_2_830_p"     "ksads_2_833_p"     "ksads_2_834_p"    
# [66] "ksads_2_839_p"     "ksads_2_838_p"     "ksads_2_12_p"      "ksads_2_13_p"      "ksads_2_209_p"    
# [71] "ksads_2_211_p"     "ksads_2_195_p"     "ksads_2_196_p"     "ksads_2_14_p"      "ksads_2_15_p"     
# [76] "ksads_2_217_p"     "ksads_2_218_p"     "ksads_2_216_p"     "ksads_2_215_p"     "ksads_2_201_p"    
# [81] "ksads_2_202_p"     "ksads_2_213_p"     "ksads_2_214_p"     "ksads_2_11_p"      "ksads_2_10_p"     
# [86] "ksads_2_9_p"       "ksads_2_7_p"       "ksads_2_8_p"       "ksads_2_191_p"     "ksads_2_193_p"    
# [91] "ksads_2_189_p"     "ksads_2_190_p"     "ksads_2_197_p"     "ksads_2_198_p"     "ksads_2_207_p"    
# [96] "ksads_2_208_p"     "ksads_2_200_p"     "ksads_2_199_p"     "ksads_2_212_p"     "ksads_2_206_p"    
# [101] "ksads_2_210_p"     "ksads_2_203_p"     "ksads_2_204_p"     "ksads_2_205_p"     "ksads_2_221_p"    
# [106] "ksads_2_222_p"     "ksads_2_219_p"     "ksads_2_220_p"     "ksads_2_192_p"     "ksads_2_194_p"    
# [111] "ksads_3_848_p"     "ksads_3_228_p"     "ksads_3_227_p"     "ksads_3_229_p"     "ksads_3_226_p"    
# [116] "ksads_4_851_p"     "ksads_4_852_p"     "ksads_4_826_p"     "ksads_4_827_p"     "ksads_4_829_p"    
# [121] "ksads_4_828_p"     "ksads_4_850_p"     "ksads_4_849_p"     "ksads_4_258_p"     "ksads_4_259_p"    
# [126] "ksads_4_231_p"     "ksads_4_230_p"     "ksads_4_255_p"     "ksads_4_252_p"     "ksads_4_253_p"    
# [131] "ksads_4_254_p"     "ksads_4_243_p"     "ksads_4_244_p"     "ksads_4_241_p"     "ksads_4_242_p"    
# [136] "ksads_4_237_p"     "ksads_4_238_p"     "ksads_4_239_p"     "ksads_4_240_p"     "ksads_4_257_p"    
# [141] "ksads_4_256_p"     "ksads_4_247_p"     "ksads_4_245_p"     "ksads_4_246_p"     "ksads_4_16_p"     
# [146] "ksads_4_17_p"      "ksads_4_234_p"     "ksads_4_260_p"     "ksads_4_18_p"      "ksads_4_19_p"     
# [151] "ksads_4_236_p"     "ksads_4_235_p"     "ksads_4_232_p"     "ksads_4_233_p"     "ksads_4_249_p"    
# [156] "ksads_4_248_p"     "ksads_4_250_p"     "ksads_4_251_p"     "ksads_5_906_p"     "ksads_5_907_p"    
# [161] "ksads_5_857_p"     "ksads_5_858_p"     "ksads_5_261_p"     "ksads_5_262_p"     "ksads_5_264_p"    
# [166] "ksads_5_263_p"     "ksads_5_20_p"      "ksads_5_21_p"      "ksads_5_265_p"     "ksads_5_266_p"    
# [171] "ksads_5_267_p"     "ksads_5_268_p"     "ksads_5_269_p"     "ksads_5_270_p"     "ksads_6_908_p"    
# [176] "ksads_6_859_p"     "ksads_6_860_p"     "ksads_6_275_p"     "ksads_6_274_p"     "ksads_6_276_p"    
# [181] "ksads_6_278_p"     "ksads_6_279_p"     "ksads_6_22_p"      "ksads_6_23_p"      "ksads_6_277_p"    
# [186] "ksads_6_272_p"     "ksads_6_273_p"     "ksads_7_861_p"     "ksads_7_909_p"     "ksads_7_910_p"    
# [191] "ksads_7_862_p"     "ksads_7_300_p"     "ksads_7_27_p"      "ksads_7_26_p"      "ksads_7_288_p"    
# [196] "ksads_7_287_p"     "ksads_7_291_p"     "ksads_7_292_p"     "ksads_7_293_p"     "ksads_7_294_p"    
# [201] "ksads_7_289_p"     "ksads_7_290_p"     "ksads_7_296_p"     "ksads_7_295_p"     "ksads_7_24_p"     
# [206] "ksads_7_25_p"      "ksads_7_281_p"     "ksads_7_282_p"     "ksads_7_285_p"     "ksads_7_286_p"    
# [211] "ksads_7_297_p"     "ksads_7_299_p"     "ksads_7_298_p"     "ksads_7_284_p"     "ksads_7_283_p"    
# [216] "ksads_8_864_p"     "ksads_8_863_p"     "ksads_8_912_p"     "ksads_8_911_p"     "ksads_8_309_p"    
# [221] "ksads_8_310_p"     "ksads_8_29_p"      "ksads_8_31_p"      "ksads_8_313_p"     "ksads_8_30_p"     
# [226] "ksads_8_312_p"     "ksads_8_311_p"     "ksads_8_308_p"     "ksads_8_304_p"     "ksads_8_307_p"    
# [231] "ksads_8_302_p"     "ksads_8_303_p"     "ksads_8_301_p"     "ksads_9_868_p"     "ksads_9_867_p"    
# [236] "ksads_9_37_p"      "ksads_9_38_p"      "ksads_9_41_p"      "ksads_9_42_p"      "ksads_9_43_p"     
# [241] "ksads_9_44_p"      "ksads_9_40_p"      "ksads_9_39_p"      "ksads_9_34_p"      "ksads_9_35_p"     
# [246] "ksads_9_36_p"      "ksads_10_914_p"    "ksads_10_913_p"    "ksads_10_869_p"    "ksads_10_870_p"   
# [251] "ksads_10_45_p"     "ksads_10_46_p"     "ksads_10_320_p"    "ksads_10_321_p"    "ksads_10_325_p"   
# [256] "ksads_10_324_p"    "ksads_10_329_p"    "ksads_10_328_p"    "ksads_10_326_p"    "ksads_10_327_p"   
# [261] "ksads_10_323_p"    "ksads_10_47_p"     "ksads_10_330_p"    "ksads_10_322_p"    "ksads_11_917_p"   
# [266] "ksads_11_918_p"    "ksads_11_919_p"    "ksads_11_920_p"    "ksads_11_343_p"    "ksads_11_344_p"   
# [271] "ksads_11_331_p"    "ksads_11_332_p"    "ksads_11_48_p"     "ksads_11_49_p"     "ksads_11_335_p"   
# [276] "ksads_11_336_p"    "ksads_11_342_p"    "ksads_11_51_p"     "ksads_11_341_p"    "ksads_11_50_p"    
# [281] "ksads_11_339_p"    "ksads_11_340_p"    "ksads_11_347_p"    "ksads_11_348_p"    "ksads_11_333_p"   
# [286] "ksads_11_334_p"    "ksads_11_346_p"    "ksads_11_345_p"    "ksads_11_337_p"    "ksads_11_338_p"   
# [291] "ksads_12_928_p"    "ksads_12_927_p"    "ksads_12_925_p"    "ksads_12_926_p"    "ksads_12_53_p"    
# [296] "ksads_12_52_p"     "ksads_12_56_p"     "ksads_12_57_p"     "ksads_12_60_p"     "ksads_12_54_p"    
# [301] "ksads_12_55_p"     "ksads_12_61_p"     "ksads_12_64_p"     "ksads_12_65_p"     "ksads_12_62_p"    
# [306] "ksads_12_63_p"     "ksads_12_58_p"     "ksads_12_59_p"     "ksads_13_939_p"    "ksads_13_938_p"   
# [311] "ksads_13_929_p"    "ksads_13_934_p"    "ksads_13_933_p"    "ksads_13_932_p"    "ksads_13_931_p"   
# [316] "ksads_13_930_p"    "ksads_13_936_p"    "ksads_13_935_p"    "ksads_13_937_p"    "ksads_13_940_p"   
# [321] "ksads_13_943_p"    "ksads_13_942_p"    "ksads_13_944_p"    "ksads_13_941_p"    "ksads_13_469_p"   
# [326] "ksads_13_476_p"    "ksads_13_470_p"    "ksads_13_477_p"    "ksads_13_473_p"    "ksads_13_478_p"   
# [331] "ksads_13_471_p"    "ksads_13_474_p"    "ksads_13_74_p"     "ksads_13_75_p"     "ksads_13_472_p"   
# [336] "ksads_13_479_p"    "ksads_13_475_p"    "ksads_13_480_p"    "ksads_13_68_p"     "ksads_13_69_p"    
# [341] "ksads_13_66_p"     "ksads_13_67_p"     "ksads_13_70_p"     "ksads_13_71_p"     "ksads_13_72_p"    
# [346] "ksads_13_73_p"     "ksads_14_856_p"    "ksads_14_855_p"    "ksads_14_853_p"    "ksads_14_854_p"   
# [351] "ksads_14_398_p"    "ksads_14_414_p"    "ksads_14_403_p"    "ksads_14_419_p"    "ksads_14_405_p"   
# [356] "ksads_14_421_p"    "ksads_14_406_p"    "ksads_14_422_p"    "ksads_14_76_p"     "ksads_14_413_p"   
# [361] "ksads_14_396_p"    "ksads_14_420_p"    "ksads_14_397_p"    "ksads_14_87_p"     "ksads_14_404_p"   
# [366] "ksads_14_86_p"     "ksads_14_85_p"     "ksads_14_78_p"     "ksads_14_77_p"     "ksads_14_79_p"    
# [371] "ksads_14_84_p"     "ksads_14_412_p"    "ksads_14_401_p"    "ksads_14_417_p"    "ksads_14_80_p"    
# [376] "ksads_14_82_p"     "ksads_14_81_p"     "ksads_14_83_p"     "ksads_14_400_p"    "ksads_14_416_p"   
# [381] "ksads_14_88_p"     "ksads_14_89_p"     "ksads_14_90_p"     "ksads_14_399_p"    "ksads_14_415_p"   
# [386] "ksads_14_408_p"    "ksads_14_424_p"    "ksads_14_394_p"    "ksads_14_410_p"    "ksads_14_395_p"   
# [391] "ksads_14_411_p"    "ksads_14_407_p"    "ksads_14_423_p"    "ksads_14_402_p"    "ksads_14_418_p"   
# [396] "ksads_14_409_p"    "ksads_14_425_p"    "ksads_14_429_p"    "ksads_14_430_p"    "ksads_15_901_p"   
# [401] "ksads_15_902_p"    "ksads_15_95_p"     "ksads_15_436_p"    "ksads_15_442_p"    "ksads_15_96_p"    
# [406] "ksads_15_435_p"    "ksads_15_440_p"    "ksads_15_446_p"    "ksads_15_94_p"     "ksads_15_433_p"   
# [411] "ksads_15_443_p"    "ksads_15_93_p"     "ksads_15_432_p"    "ksads_15_439_p"    "ksads_15_91_p"    
# [416] "ksads_15_92_p"     "ksads_15_445_p"    "ksads_15_438_p"    "ksads_15_97_p"     "ksads_15_437_p"   
# [421] "ksads_15_444_p"    "ksads_15_431_p"    "ksads_15_441_p"    "ksads_15_434_p"    "ksads_16_900_p"   
# [426] "ksads_16_897_p"    "ksads_16_899_p"    "ksads_16_898_p"    "ksads_16_450_p"    "ksads_16_449_p"   
# [431] "ksads_16_463_p"    "ksads_16_464_p"    "ksads_16_453_p"    "ksads_16_454_p"    "ksads_16_461_p"   
# [436] "ksads_16_462_p"    "ksads_16_465_p"    "ksads_16_466_p"    "ksads_16_98_p"     "ksads_16_99_p"    
# [441] "ksads_16_104_p"    "ksads_16_105_p"    "ksads_16_102_p"    "ksads_16_103_p"    "ksads_16_458_p"   
# [446] "ksads_16_457_p"    "ksads_16_456_p"    "ksads_16_455_p"    "ksads_16_452_p"    "ksads_16_107_p"   
# [451] "ksads_16_451_p"    "ksads_16_106_p"    "ksads_16_100_p"    "ksads_16_101_p"    "ksads_16_447_p"   
# [456] "ksads_16_448_p"    "ksads_16_460_p"    "ksads_16_459_p"    "ksads_17_905_p"    "ksads_17_904_p"   
# [461] "ksads_17_110_p"    "ksads_17_111_p"    "ksads_17_109_p"    "ksads_17_108_p"    "ksads_18_903_p"   
# [466] "ksads_18_116_p"    "ksads_18_117_p"    "ksads_18_112_p"    "ksads_18_113_p"    "ksads_18_115_p"   
# [471] "ksads_18_114_p"    "ksads_19_895_p"    "ksads_19_896_p"    "ksads_19_891_p"    "ksads_19_892_p"   
# [476] "ksads_19_500_p"    "ksads_19_499_p"    "ksads_19_504_p"    "ksads_19_508_p"    "ksads_19_505_p"   
# [481] "ksads_19_494_p"    "ksads_19_493_p"    "ksads_19_481_p"    "ksads_19_124_p"    "ksads_19_501_p"   
# [486] "ksads_19_506_p"    "ksads_19_483_p"    "ksads_19_484_p"    "ksads_19_491_p"    "ksads_19_492_p"   
# [491] "ksads_19_489_p"    "ksads_19_487_p"    "ksads_19_490_p"    "ksads_19_485_p"    "ksads_19_502_p"   
# [496] "ksads_19_497_p"    "ksads_19_122_p"    "ksads_19_123_p"    "ksads_19_495_p"    "ksads_19_496_p"   
# [501] "ksads_19_120_p"    "ksads_19_482_p"    "ksads_19_121_p"    "ksads_19_503_p"    "ksads_19_498_p"   
# [506] "ksads_19_488_p"    "ksads_19_486_p"    "ksads_20_893_p"    "ksads_20_894_p"    "ksads_20_874_p"   
# [511] "ksads_20_883_p"    "ksads_20_872_p"    "ksads_20_881_p"    "ksads_20_889_p"    "ksads_20_890_p"   
# [516] "ksads_20_887_p"    "ksads_20_878_p"    "ksads_20_877_p"    "ksads_20_886_p"    "ksads_20_875_p"   
# [521] "ksads_20_884_p"    "ksads_20_876_p"    "ksads_20_885_p"    "ksads_20_879_p"    "ksads_20_888_p"   
# [526] "ksads_20_873_p"    "ksads_20_882_p"    "ksads_20_880_p"    "ksads_20_871_p"    "ksads_20_126_p"   
# [531] "ksads_20_680_p"    "ksads_20_725_p"    "ksads_20_545_p"    "ksads_20_755_p"    "ksads_20_590_p"   
# [536] "ksads_20_740_p"    "ksads_20_620_p"    "ksads_20_605_p"    "ksads_20_665_p"    "ksads_20_710_p"   
# [541] "ksads_20_800_p"    "ksads_20_785_p"    "ksads_20_575_p"    "ksads_20_650_p"    "ksads_20_695_p"   
# [546] "ksads_20_560_p"    "ksads_20_521_p"    "ksads_20_770_p"    "ksads_20_635_p"    "ksads_20_522_p"   
# [551] "ksads_20_538_p"    "ksads_20_673_p"    "ksads_20_613_p"    "ksads_20_748_p"    "ksads_20_583_p"   
# [556] "ksads_20_718_p"    "ksads_20_598_p"    "ksads_20_733_p"    "ksads_20_658_p"    "ksads_20_793_p"   
# [561] "ksads_20_703_p"    "ksads_20_643_p"    "ksads_20_778_p"    "ksads_20_568_p"    "ksads_20_553_p"   
# [566] "ksads_20_688_p"    "ksads_20_628_p"    "ksads_20_763_p"    "ksads_20_511_p"    "ksads_20_512_p"   
# [571] "ksads_20_551_p"    "ksads_20_686_p"    "ksads_20_596_p"    "ksads_20_731_p"    "ksads_20_626_p"   
# [576] "ksads_20_761_p"    "ksads_20_671_p"    "ksads_20_806_p"    "ksads_20_611_p"    "ksads_20_746_p"   
# [581] "ksads_20_129_p"    "ksads_20_128_p"    "ksads_20_127_p"    "ksads_20_529_p"    "ksads_20_534_p"   
# [586] "ksads_20_641_p"    "ksads_20_776_p"    "ksads_20_566_p"    "ksads_20_701_p"    "ksads_20_581_p"   
# [591] "ksads_20_716_p"    "ksads_20_656_p"    "ksads_20_791_p"    "ksads_20_634_p"    "ksads_20_520_p"   
# [596] "ksads_20_519_p"    "ksads_20_589_p"    "ksads_20_544_p"    "ksads_20_604_p"    "ksads_20_619_p"   
# [601] "ksads_20_694_p"    "ksads_20_574_p"    "ksads_20_724_p"    "ksads_20_754_p"    "ksads_20_739_p"   
# [606] "ksads_20_709_p"    "ksads_20_784_p"    "ksads_20_799_p"    "ksads_20_664_p"    "ksads_20_649_p"   
# [611] "ksads_20_559_p"    "ksads_20_679_p"    "ksads_20_769_p"    "ksads_20_517_p"    "ksads_20_518_p"   
# [616] "ksads_20_558_p"    "ksads_20_693_p"    "ksads_20_648_p"    "ksads_20_783_p"    "ksads_20_633_p"   
# [621] "ksads_20_768_p"    "ksads_20_588_p"    "ksads_20_723_p"    "ksads_20_618_p"    "ksads_20_753_p"   
# [626] "ksads_20_603_p"    "ksads_20_738_p"    "ksads_20_663_p"    "ksads_20_798_p"    "ksads_20_573_p"   
# [631] "ksads_20_708_p"    "ksads_20_509_p"    "ksads_20_510_p"    "ksads_20_630_p"    "ksads_20_765_p"   
# [636] "ksads_20_570_p"    "ksads_20_705_p"    "ksads_20_555_p"    "ksads_20_690_p"    "ksads_20_645_p"   
# [641] "ksads_20_780_p"    "ksads_20_543_p"    "ksads_20_678_p"    "ksads_20_525_p"    "ksads_20_530_p"   
# [646] "ksads_20_637_p"    "ksads_20_787_p"    "ksads_20_577_p"    "ksads_20_652_p"    "ksads_20_697_p"   
# [651] "ksads_20_772_p"    "ksads_20_562_p"    "ksads_20_682_p"    "ksads_20_727_p"    "ksads_20_547_p"   
# [656] "ksads_20_757_p"    "ksads_20_592_p"    "ksads_20_742_p"    "ksads_20_622_p"    "ksads_20_802_p"   
# [661] "ksads_20_607_p"    "ksads_20_667_p"    "ksads_20_712_p"    "ksads_20_132_p"    "ksads_20_674_p"   
# [666] "ksads_20_719_p"    "ksads_20_539_p"    "ksads_20_749_p"    "ksads_20_584_p"    "ksads_20_734_p"   
# [671] "ksads_20_614_p"    "ksads_20_794_p"    "ksads_20_599_p"    "ksads_20_133_p"    "ksads_20_546_p"   
# [676] "ksads_20_681_p"    "ksads_20_591_p"    "ksads_20_726_p"    "ksads_20_606_p"    "ksads_20_741_p"   
# [681] "ksads_20_621_p"    "ksads_20_756_p"    "ksads_20_666_p"    "ksads_20_801_p"    "ksads_20_576_p"   
# [686] "ksads_20_711_p"    "ksads_20_523_p"    "ksads_20_524_p"    "ksads_20_561_p"    "ksads_20_696_p"   
# [691] "ksads_20_651_p"    "ksads_20_786_p"    "ksads_20_636_p"    "ksads_20_771_p"    "ksads_20_615_p"   
# [696] "ksads_20_750_p"    "ksads_20_600_p"    "ksads_20_735_p"    "ksads_20_660_p"    "ksads_20_795_p"   
# [701] "ksads_20_585_p"    "ksads_20_720_p"    "ksads_20_675_p"    "ksads_20_540_p"    "ksads_20_130_p"   
# [706] "ksads_20_642_p"    "ksads_20_687_p"    "ksads_20_762_p"    "ksads_20_552_p"    "ksads_20_131_p"   
# [711] "ksads_20_627_p"    "ksads_20_659_p"    "ksads_20_704_p"    "ksads_20_779_p"    "ksads_20_569_p"   
# [716] "ksads_20_689_p"    "ksads_20_644_p"    "ksads_20_764_p"    "ksads_20_554_p"    "ksads_20_672_p"   
# [721] "ksads_20_629_p"    "ksads_20_747_p"    "ksads_20_582_p"    "ksads_20_717_p"    "ksads_20_537_p"   
# [726] "ksads_20_732_p"    "ksads_20_612_p"    "ksads_20_792_p"    "ksads_20_597_p"    "ksads_20_777_p"   
# [731] "ksads_20_567_p"    "ksads_20_657_p"    "ksads_20_702_p"    "ksads_20_542_p"    "ksads_20_677_p"   
# [736] "ksads_20_536_p"    "ksads_20_528_p"    "ksads_20_587_p"    "ksads_20_722_p"    "ksads_20_617_p"   
# [741] "ksads_20_752_p"    "ksads_20_602_p"    "ksads_20_737_p"    "ksads_20_670_p"    "ksads_20_715_p"   
# [746] "ksads_20_790_p"    "ksads_20_580_p"    "ksads_20_655_p"    "ksads_20_700_p"    "ksads_20_775_p"   
# [751] "ksads_20_565_p"    "ksads_20_640_p"    "ksads_20_533_p"    "ksads_20_662_p"    "ksads_20_797_p"   
# [756] "ksads_20_572_p"    "ksads_20_707_p"    "ksads_20_647_p"    "ksads_20_782_p"    "ksads_20_557_p"   
# [761] "ksads_20_692_p"    "ksads_20_632_p"    "ksads_20_767_p"    "ksads_20_513_p"    "ksads_20_515_p"   
# [766] "ksads_20_549_p"    "ksads_20_684_p"    "ksads_20_594_p"    "ksads_20_729_p"    "ksads_20_624_p"   
# [771] "ksads_20_759_p"    "ksads_20_609_p"    "ksads_20_744_p"    "ksads_20_685_p"    "ksads_20_730_p"   
# [776] "ksads_20_550_p"    "ksads_20_745_p"    "ksads_20_625_p"    "ksads_20_760_p"    "ksads_20_595_p"   
# [781] "ksads_20_805_p"    "ksads_20_610_p"    "ksads_20_683_p"    "ksads_20_728_p"    "ksads_20_548_p"   
# [786] "ksads_20_608_p"    "ksads_20_623_p"    "ksads_20_758_p"    "ksads_20_593_p"    "ksads_20_668_p"   
# [791] "ksads_20_803_p"    "ksads_20_578_p"    "ksads_20_713_p"    "ksads_20_669_p"    "ksads_20_804_p"   
# [796] "ksads_20_579_p"    "ksads_20_714_p"    "ksads_20_654_p"    "ksads_20_789_p"    "ksads_20_564_p"   
# [801] "ksads_20_699_p"    "ksads_20_527_p"    "ksads_20_532_p"    "ksads_20_639_p"    "ksads_20_774_p"   
# [806] "ksads_20_676_p"    "ksads_20_721_p"    "ksads_20_541_p"    "ksads_20_751_p"    "ksads_20_586_p"   
# [811] "ksads_20_736_p"    "ksads_20_616_p"    "ksads_20_526_p"    "ksads_20_531_p"    "ksads_20_743_p"   
# [816] "ksads_20_653_p"    "ksads_20_788_p"    "ksads_20_563_p"    "ksads_20_698_p"    "ksads_20_638_p"   
# [821] "ksads_20_773_p"    "ksads_20_631_p"    "ksads_20_516_p"    "ksads_20_514_p"    "ksads_20_796_p"   
# [826] "ksads_20_601_p"    "ksads_20_661_p"    "ksads_20_706_p"    "ksads_20_571_p"    "ksads_20_691_p"   
# [831] "ksads_20_646_p"    "ksads_20_781_p"    "ksads_20_766_p"    "ksads_20_556_p"    "ksads_21_923_p"   
# [836] "ksads_21_924_p"    "ksads_21_921_p"    "ksads_21_922_p"    "ksads_21_355_p"    "ksads_21_356_p"   
# [841] "ksads_21_374_p"    "ksads_21_373_p"    "ksads_21_360_p"    "ksads_21_359_p"    "ksads_21_365_p"   
# [846] "ksads_21_366_p"    "ksads_21_138_p"    "ksads_21_137_p"    "ksads_21_358_p"    "ksads_21_369_p"   
# [851] "ksads_21_370_p"    "ksads_21_357_p"    "ksads_21_350_p"    "ksads_21_349_p"    "ksads_21_371_p"   
# [856] "ksads_21_372_p"    "ksads_21_134_p"    "ksads_21_376_p"    "ksads_21_375_p"    "ksads_21_385_p"   
# [861] "ksads_21_386_p"    "ksads_21_367_p"    "ksads_21_368_p"    "ksads_21_383_p"    "ksads_21_384_p"   
# [866] "ksads_21_135_p"    "ksads_21_136_p"    "ksads_21_377_p"    "ksads_21_378_p"    "ksads_21_353_p"   
# [871] "ksads_21_354_p"    "ksads_21_139_p"    "ksads_21_140_p"    "ksads_21_391_p"    "ksads_21_392_p"   
# [876] "ksads_21_352_p"    "ksads_21_351_p"    "ksads_21_363_p"    "ksads_21_364_p"    "ksads_21_361_p"   
# [881] "ksads_21_362_p"    "ksads_21_379_p"    "ksads_21_380_p"    "ksads_21_388_p"    "ksads_21_387_p"   
# [886] "ksads_21_389_p"    "ksads_21_390_p"    "ksads_21_382_p"    "ksads_21_381_p"    "ksads_22_970_p"   
# [891] "ksads_22_969_p"    "ksads_22_141_p"    "ksads_22_142_p"    "ksads_23_946_p"    "ksads_23_957_p"   
# [896] "ksads_23_954_p"    "ksads_23_965_p"    "ksads_23_956_p"    "ksads_23_945_p"    "ksads_23_950_p"   
# [901] "ksads_23_961_p"    "ksads_23_947_p"    "ksads_23_958_p"    "ksads_23_948_p"    "ksads_23_959_p"   
# [906] "ksads_23_949_p"    "ksads_23_960_p"    "ksads_23_952_p"    "ksads_23_963_p"    "ksads_23_966_p"   
# [911] "ksads_23_955_p"    "ksads_23_951_p"    "ksads_23_962_p"    "ksads_23_953_p"    "ksads_23_964_p"   
# [916] "ksads_23_813_p"    "ksads_23_822_p"    "ksads_23_144_p"    "ksads_23_823_p"    "ksads_23_814_p"   
# [921] "ksads_23_809_p"    "ksads_23_818_p"    "ksads_23_825_p"    "ksads_23_149_p"    "ksads_23_150_p"   
# [926] "ksads_23_812_p"    "ksads_23_821_p"    "ksads_23_808_p"    "ksads_23_807_p"    "ksads_23_817_p"   
# [931] "ksads_23_816_p"    "ksads_23_143_p"    "ksads_23_146_p"    "ksads_23_145_p"    "ksads_23_810_p"   
# [936] "ksads_23_819_p"    "ksads_23_147_p"    "ksads_23_148_p"    "ksads_23_811_p"    "ksads_23_820_p"   
# [941] "ksads_23_815_p"    "ksads_23_824_p"    "ksads_24_968_p"    "ksads_24_967_p"    "ksads_24_152_p"   
# [946] "ksads_24_153_p"    "ksads_24_154_p"    "ksads_24_151_p"    "ksads_25_916_p"    "ksads_25_915_p"   
# [951] "ksads_25_866_p"    "ksads_25_865_p"    "ksads_25_314_p"    "ksads_25_315_p"    "ksads_25_316_p"   
# [956] "ksads_25_317_p"    "ksads_25_32_p"     "ksads_25_33_p"     "ksads_25_318_p"    "ksads_25_319_p"   
# [961] "ksads_timestamp_p" "ksads_duration_p"  "collection_title"  "study_cohort_name"

ksads_p = ksads_p[,-c(1:3, 5:8, 10, 17:110, 112:160, 163:175, 178:187, 189:190, 
                      192:215, 218:233, 236:248, 251:264, 267:347, 351:399,
                      402:424, 429:473, 476:509, 516:527, 530:836, 839:889, 
                      892:893, 900:964)]

colnames(ksads_p)
# [1] "subjectkey"     "eventname"      "ksads_1_843_p"  "ksads_1_845_p" 
# [5] "ksads_1_844_p"  "ksads_1_840_p"  "ksads_1_841_p"  "ksads_1_842_p" 
# [9] "ksads_3_848_p"  "ksads_5_857_p"  "ksads_5_858_p"  "ksads_6_859_p" 
# [13] "ksads_6_860_p"  "ksads_7_861_p"  "ksads_7_862_p"  "ksads_8_864_p" 
# [17] "ksads_8_863_p"  "ksads_9_868_p"  "ksads_9_867_p"  "ksads_10_869_p"
# [21] "ksads_10_870_p" "ksads_11_917_p" "ksads_11_918_p" "ksads_14_855_p"
# [25] "ksads_14_853_p" "ksads_14_854_p" "ksads_15_901_p" "ksads_15_902_p"
# [29] "ksads_16_900_p" "ksads_16_897_p" "ksads_16_899_p" "ksads_16_898_p"
# [33] "ksads_19_891_p" "ksads_19_892_p" "ksads_20_874_p" "ksads_20_883_p"
# [37] "ksads_20_872_p" "ksads_20_881_p" "ksads_20_889_p" "ksads_20_890_p"
# [41] "ksads_20_880_p" "ksads_20_871_p" "ksads_21_921_p" "ksads_21_922_p"
# [45] "ksads_22_970_p" "ksads_22_969_p" "ksads_23_946_p" "ksads_23_957_p"
# [49] "ksads_23_954_p" "ksads_23_965_p" "ksads_23_956_p" "ksads_23_945_p"

#Rename variables
names(ksads_p)[names(ksads_p) == "subjectkey"] = "id"
names(ksads_p)[names(ksads_p) == "eventname"] = "timepoint"
names(ksads_p)[names(ksads_p) == "ksads_1_843_p"] = "pers_dep_present"
names(ksads_p)[names(ksads_p) == "ksads_1_845_p"] = "pers_dep_past"
names(ksads_p)[names(ksads_p) == "ksads_1_844_p"] = "pers_dep_remi"
names(ksads_p)[names(ksads_p) == "ksads_1_840_p"] = "mdd_present"
names(ksads_p)[names(ksads_p) == "ksads_1_841_p"] = "mdd_remi"
names(ksads_p)[names(ksads_p) == "ksads_1_842_p"] = "mdd_past"
names(ksads_p)[names(ksads_p) == "ksads_3_848_p"] = "dmdd"
names(ksads_p)[names(ksads_p) == "ksads_5_857_p"] = "panic_present"
names(ksads_p)[names(ksads_p) == "ksads_5_858_p"] = "panic_past"
names(ksads_p)[names(ksads_p) == "ksads_6_859_p"] = "agroaphobia_present"
names(ksads_p)[names(ksads_p) == "ksads_6_860_p"] = "agroaphobia_past"
names(ksads_p)[names(ksads_p) == "ksads_7_861_p"] = "sep_anx_present"
names(ksads_p)[names(ksads_p) == "ksads_7_862_p"] = "sep_anx_past"
names(ksads_p)[names(ksads_p) == "ksads_8_864_p"] = "soc_anx_past"
names(ksads_p)[names(ksads_p) == "ksads_8_863_p"] = "soc_anx_present"
names(ksads_p)[names(ksads_p) == "ksads_9_868_p"] = "spec_phobia_past"
names(ksads_p)[names(ksads_p) == "ksads_9_867_p"] = "spec_phobia_present"
names(ksads_p)[names(ksads_p) == "ksads_10_869_p"] = "gad_present"
names(ksads_p)[names(ksads_p) == "ksads_10_870_p"] = "gad_past"
names(ksads_p)[names(ksads_p) == "ksads_11_917_p"] = "ocd_present"
names(ksads_p)[names(ksads_p) == "ksads_11_918_p"] = "ocd_past"
names(ksads_p)[names(ksads_p) == "ksads_14_855_p"] = "adhd_rem"
names(ksads_p)[names(ksads_p) == "ksads_14_853_p"] = "adhd_present"
names(ksads_p)[names(ksads_p) == "ksads_14_854_p"] = "adhd_past"
names(ksads_p)[names(ksads_p) == "ksads_15_901_p"] = "odd_present"
names(ksads_p)[names(ksads_p) == "ksads_15_902_p"] = "odd_past"
names(ksads_p)[names(ksads_p) == "ksads_16_900_p"] = "conduct_adol_past"
names(ksads_p)[names(ksads_p) == "ksads_16_897_p"] = "conduct_child_pres"
names(ksads_p)[names(ksads_p) == "ksads_16_899_p"] = "conduct_child_past"
names(ksads_p)[names(ksads_p) == "ksads_16_898_p"] = "conduct_adol_pres"
names(ksads_p)[names(ksads_p) == "ksads_19_891_p"] = "aud_present"
names(ksads_p)[names(ksads_p) == "ksads_19_892_p"] = "aud_past"
names(ksads_p)[names(ksads_p) == "ksads_20_874_p"] = "stimulant_coc_pres"
names(ksads_p)[names(ksads_p) == "ksads_20_883_p"] = "stimulant_coc_past"
names(ksads_p)[names(ksads_p) == "ksads_20_872_p"] = "stimulant_amph_pres"
names(ksads_p)[names(ksads_p) == "ksads_20_881_p"] = "stimulant_amph_past"
names(ksads_p)[names(ksads_p) == "ksads_20_889_p"] = "sud_present"
names(ksads_p)[names(ksads_p) == "ksads_20_890_p"] = "sud_past"
names(ksads_p)[names(ksads_p) == "ksads_20_880_p"] = "cud_past"
names(ksads_p)[names(ksads_p) == "ksads_20_871_p"] = "cud_present"
names(ksads_p)[names(ksads_p) == "ksads_21_921_p"] = "ptsd_present"
names(ksads_p)[names(ksads_p) == "ksads_21_922_p"] = "ptsd_past"
names(ksads_p)[names(ksads_p) == "ksads_22_970_p"] = "sleep_past"
names(ksads_p)[names(ksads_p) == "ksads_22_969_p"] = "sleep_present"
names(ksads_p)[names(ksads_p) == "ksads_23_946_p"] = "si_passive_present"
names(ksads_p)[names(ksads_p) == "ksads_23_957_p"] = "si_passsive_past"
names(ksads_p)[names(ksads_p) == "ksads_23_954_p"] = "si_present"
names(ksads_p)[names(ksads_p) == "ksads_23_965_p"] = "si_past"
names(ksads_p)[names(ksads_p) == "ksads_23_956_p"] = "self_inj_past"
names(ksads_p)[names(ksads_p) == "ksads_23_945_p"] = "self_inj_present"

colnames(ksads_p)
# [1] "id"                  "timepoint"           "pers_dep_present"   
# [4] "pers_dep_past"       "pers_dep_remi"       "mdd_present"        
# [7] "mdd_remi"            "mdd_past"            "dmdd"               
# [10] "panic_present"       "panic_past"          "agroaphobia_present"
# [13] "agroaphobia_past"    "sep_anx_present"     "sep_anx_past"       
# [16] "soc_anx_past"        "soc_anx_present"     "spec_phobia_past"   
# [19] "spec_phobia_present" "gad_present"         "gad_past"           
# [22] "ocd_present"         "ocd_past"            "adhd_rem"           
# [25] "adhd_present"        "adhd_past"           "odd_present"        
# [28] "odd_past"            "conduct_adol_past"   "conduct_child_pres" 
# [31] "conduct_child_past"  "conduct_adol_pres"   "aud_present"        
# [34] "aud_past"            "stimulant_coc_pres"  "stimulant_coc_past" 
# [37] "stimulant_amph_pres" "stimulant_amph_past" "sud_present"        
# [40] "sud_past"            "cud_past"            "cud_present"        
# [43] "ptsd_present"        "ptsd_past"           "sleep_past"         
# [46] "sleep_present"       "si_passive_present"  "si_passsive_past"   
# [49] "si_present"          "si_past"             "self_inj_past"      
# [52] "self_inj_present"   

table(ksads_p$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                        11876 

table(ksads_p$mdd_present, useNA = "ifany")
#       555 
# 22290 11225 

table(ksads_p$gad_past, useNA = "ifany")
#         0     1   555   888 
# 328 21110   841 11225    11 

#Rescale variables so "" is NA
colnames(ksads_p)
ksads_p[, c(3:52)][ksads_p[, c(3:52)] == ""] <- NA
ksads_p[, c(3:52)][ksads_p[, c(3:52)] == 555] <- NA
ksads_p[, c(3:52)][ksads_p[, c(3:52)] == 888] <- NA

table(ksads_p$mdd_present, useNA = "ifany")
#   <NA> 
#   33515 

#       0     1  <NA> 
#   21110   841 11564 

#Identify the number of timepoints in dataset
table(ksads_p$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                        11876       

#Label timepoints
ksads_p[which(ksads_p$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
ksads_p[which(ksads_p$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
ksads_p[which(ksads_p$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2

table(ksads_p$timepoint, useNA = "ifany")
# 0     1     2 
# 11876 11225 10414 

#Reshape data to wide 
library(reshape)
ksads_p_wide = reshape(ksads_p, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(ksads_p_wide)
# [1] "id"                    "pers_dep_present.1"    "pers_dep_past.1"      
# [4] "pers_dep_remi.1"       "mdd_present.1"         "mdd_remi.1"           
# [7] "mdd_past.1"            "dmdd.1"                "panic_present.1"      
# [10] "panic_past.1"          "agroaphobia_present.1" "agroaphobia_past.1"   
# [13] "sep_anx_present.1"     "sep_anx_past.1"        "soc_anx_past.1"       
# [16] "soc_anx_present.1"     "spec_phobia_past.1"    "spec_phobia_present.1"
# [19] "gad_present.1"         "gad_past.1"            "ocd_present.1"        
# [22] "ocd_past.1"            "adhd_rem.1"            "adhd_present.1"       
# [25] "adhd_past.1"           "odd_present.1"         "odd_past.1"           
# [28] "conduct_adol_past.1"   "conduct_child_pres.1"  "conduct_child_past.1" 
# [31] "conduct_adol_pres.1"   "aud_present.1"         "aud_past.1"           
# [34] "stimulant_coc_pres.1"  "stimulant_coc_past.1"  "stimulant_amph_pres.1"
# [37] "stimulant_amph_past.1" "sud_present.1"         "sud_past.1"           
# [40] "cud_past.1"            "cud_present.1"         "ptsd_present.1"       
# [43] "ptsd_past.1"           "sleep_past.1"          "sleep_present.1"      
# [46] "si_passive_present.1"  "si_passsive_past.1"    "si_present.1"         
# [49] "si_past.1"             "self_inj_past.1"       "self_inj_present.1"   
# [52] "pers_dep_present.2"    "pers_dep_past.2"       "pers_dep_remi.2"      
# [55] "mdd_present.2"         "mdd_remi.2"            "mdd_past.2"           
# [58] "dmdd.2"                "panic_present.2"       "panic_past.2"         
# [61] "agroaphobia_present.2" "agroaphobia_past.2"    "sep_anx_present.2"    
# [64] "sep_anx_past.2"        "soc_anx_past.2"        "soc_anx_present.2"    
# [67] "spec_phobia_past.2"    "spec_phobia_present.2" "gad_present.2"        
# [70] "gad_past.2"            "ocd_present.2"         "ocd_past.2"           
# [73] "adhd_rem.2"            "adhd_present.2"        "adhd_past.2"          
# [76] "odd_present.2"         "odd_past.2"            "conduct_adol_past.2"  
# [79] "conduct_child_pres.2"  "conduct_child_past.2"  "conduct_adol_pres.2"  
# [82] "aud_present.2"         "aud_past.2"            "stimulant_coc_pres.2" 
# [85] "stimulant_coc_past.2"  "stimulant_amph_pres.2" "stimulant_amph_past.2"
# [88] "sud_present.2"         "sud_past.2"            "cud_past.2"           
# [91] "cud_present.2"         "ptsd_present.2"        "ptsd_past.2"          
# [94] "sleep_past.2"          "sleep_present.2"       "si_passive_present.2" 
# [97] "si_passsive_past.2"    "si_present.2"          "si_past.2"            
# [100] "self_inj_past.2"       "self_inj_present.2"    "pers_dep_present.0"   
# [103] "pers_dep_past.0"       "pers_dep_remi.0"       "mdd_present.0"        
# [106] "mdd_remi.0"            "mdd_past.0"            "dmdd.0"               
# [109] "panic_present.0"       "panic_past.0"          "agroaphobia_present.0"
# [112] "agroaphobia_past.0"    "sep_anx_present.0"     "sep_anx_past.0"       
# [115] "soc_anx_past.0"        "soc_anx_present.0"     "spec_phobia_past.0"   
# [118] "spec_phobia_present.0" "gad_present.0"         "gad_past.0"           
# [121] "ocd_present.0"         "ocd_past.0"            "adhd_rem.0"           
# [124] "adhd_present.0"        "adhd_past.0"           "odd_present.0"        
# [127] "odd_past.0"            "conduct_adol_past.0"   "conduct_child_pres.0" 
# [130] "conduct_child_past.0"  "conduct_adol_pres.0"   "aud_present.0"        
# [133] "aud_past.0"            "stimulant_coc_pres.0"  "stimulant_coc_past.0" 
# [136] "stimulant_amph_pres.0" "stimulant_amph_past.0" "sud_present.0"        
# [139] "sud_past.0"            "cud_past.0"            "cud_present.0"        
# [142] "ptsd_present.0"        "ptsd_past.0"           "sleep_past.0"         
# [145] "sleep_present.0"       "si_passive_present.0"  "si_passsive_past.0"   
# [148] "si_present.0"          "si_past.0"             "self_inj_past.0"      
# [151] "self_inj_present.0"   

#KSADS- Youth Report- ND ----

#Add path and file name
ksads_y  = read.delim(file("abcd_ksad501.txt"))
ksads_y = ksads_y[-c(1),]
dim(ksads_y) 
# [1] 33515   965

colnames(ksads_y)
# [1] "collection_id"     "abcd_ksad501_id"   "dataset_id"       
# [4] "subjectkey"        "src_subject_id"    "interview_date"   
# [7] "interview_age"     "sex"               "eventname"        
# [10] "ksads_import_id_t" "ksads_1_1_t"       "ksads_1_2_t"      
# [13] "ksads_1_3_t"       "ksads_1_4_t"       "ksads_1_5_t"      
# [16] "ksads_1_6_t"       "ksads_2_7_t"       "ksads_2_8_t"      
# [19] "ksads_2_9_t"       "ksads_2_10_t"      "ksads_2_11_t"     
# [22] "ksads_2_12_t"      "ksads_2_13_t"      "ksads_2_14_t"     
# [25] "ksads_2_15_t"      "ksads_4_16_t"      "ksads_4_17_t"     
# [28] "ksads_4_18_t"      "ksads_4_19_t"      "ksads_5_20_t"     
# [31] "ksads_5_21_t"      "ksads_6_22_t"      "ksads_6_23_t"     
# [34] "ksads_7_24_t"      "ksads_7_25_t"      "ksads_7_26_t"     
# [37] "ksads_7_27_t"      "ksads_8_29_t"      "ksads_8_30_t"     
# [40] "ksads_25_32_t"     "ksads_9_34_t"      "ksads_9_35_t"     
# [43] "ksads_9_36_t"      "ksads_9_37_t"      "ksads_9_38_t"     
# [46] "ksads_9_39_t"      "ksads_9_40_t"      "ksads_9_41_t"     
# [49] "ksads_9_42_t"      "ksads_9_43_t"      "ksads_10_45_t"    
# [52] "ksads_10_46_t"     "ksads_11_48_t"     "ksads_11_49_t"    
# [55] "ksads_11_50_t"     "ksads_12_52_t"     "ksads_12_53_t"    
# [58] "ksads_12_54_t"     "ksads_12_55_t"     "ksads_12_56_t"    
# [61] "ksads_12_57_t"     "ksads_12_58_t"     "ksads_12_59_t"    
# [64] "ksads_12_60_t"     "ksads_12_61_t"     "ksads_12_62_t"    
# [67] "ksads_12_63_t"     "ksads_12_64_t"     "ksads_13_66_t"    
# [70] "ksads_13_67_t"     "ksads_13_68_t"     "ksads_13_69_t"    
# [73] "ksads_13_70_t"     "ksads_13_71_t"     "ksads_13_72_t"    
# [76] "ksads_13_73_t"     "ksads_13_74_t"     "ksads_14_76_t"    
# [79] "ksads_14_77_t"     "ksads_14_78_t"     "ksads_14_79_t"    
# [82] "ksads_14_80_t"     "ksads_14_81_t"     "ksads_14_82_t"    
# [85] "ksads_14_83_t"     "ksads_14_84_t"     "ksads_14_85_t"    
# [88] "ksads_14_86_t"     "ksads_14_87_t"     "ksads_14_88_t"    
# [91] "ksads_14_89_t"     "ksads_15_91_t"     "ksads_15_92_t"    
# [94] "ksads_15_93_t"     "ksads_15_94_t"     "ksads_15_95_t"    
# [97] "ksads_15_96_t"     "ksads_15_97_t"     "ksads_16_98_t"    
# [100] "ksads_16_99_t"     "ksads_16_100_t"    "ksads_16_101_t"   
# [103] "ksads_16_102_t"    "ksads_16_103_t"    "ksads_16_104_t"   
# [106] "ksads_16_105_t"    "ksads_16_106_t"    "ksads_16_107_t"   
# [109] "ksads_17_108_t"    "ksads_17_109_t"    "ksads_17_110_t"   
# [112] "ksads_17_111_t"    "ksads_18_112_t"    "ksads_18_113_t"   
# [115] "ksads_18_114_t"    "ksads_18_115_t"    "ksads_18_116_t"   
# [118] "ksads_18_117_t"    "ksads_19_120_t"    "ksads_19_121_t"   
# [121] "ksads_19_122_t"    "ksads_19_123_t"    "ksads_19_124_t"   
# [124] "ksads_20_126_t"    "ksads_20_127_t"    "ksads_20_128_t"   
# [127] "ksads_20_129_t"    "ksads_20_130_t"    "ksads_20_131_t"   
# [130] "ksads_20_132_t"    "ksads_20_133_t"    "ksads_21_134_t"   
# [133] "ksads_21_135_t"    "ksads_21_136_t"    "ksads_21_137_t"   
# [136] "ksads_21_138_t"    "ksads_21_139_t"    "ksads_21_140_t"   
# [139] "ksads_22_141_t"    "ksads_22_142_t"    "ksads_23_143_t"   
# [142] "ksads_23_144_t"    "ksads_23_145_t"    "ksads_23_146_t"   
# [145] "ksads_23_147_t"    "ksads_23_148_t"    "ksads_23_149_t"   
# [148] "ksads_23_150_t"    "ksads_24_151_t"    "ksads_24_152_t"   
# [151] "ksads_24_153_t"    "ksads_24_154_t"    "ksads_1_156_t"    
# [154] "ksads_1_157_t"     "ksads_1_158_t"     "ksads_1_159_t"    
# [157] "ksads_1_160_t"     "ksads_1_161_t"     "ksads_1_162_t"    
# [160] "ksads_1_163_t"     "ksads_1_164_t"     "ksads_1_165_t"    
# [163] "ksads_1_166_t"     "ksads_1_167_t"     "ksads_1_168_t"    
# [166] "ksads_1_169_t"     "ksads_1_170_t"     "ksads_1_171_t"    
# [169] "ksads_1_172_t"     "ksads_1_173_t"     "ksads_1_174_t"    
# [172] "ksads_1_175_t"     "ksads_1_176_t"     "ksads_1_177_t"    
# [175] "ksads_1_178_t"     "ksads_1_179_t"     "ksads_1_180_t"    
# [178] "ksads_1_181_t"     "ksads_1_182_t"     "ksads_1_183_t"    
# [181] "ksads_1_184_t"     "ksads_1_185_t"     "ksads_1_186_t"    
# [184] "ksads_1_187_t"     "ksads_1_188_t"     "ksads_2_189_t"    
# [187] "ksads_2_190_t"     "ksads_2_191_t"     "ksads_2_192_t"    
# [190] "ksads_2_193_t"     "ksads_2_194_t"     "ksads_2_195_t"    
# [193] "ksads_2_196_t"     "ksads_2_197_t"     "ksads_2_198_t"    
# [196] "ksads_2_199_t"     "ksads_2_200_t"     "ksads_2_201_t"    
# [199] "ksads_2_202_t"     "ksads_2_203_t"     "ksads_2_204_t"    
# [202] "ksads_2_205_t"     "ksads_2_206_t"     "ksads_2_207_t"    
# [205] "ksads_2_208_t"     "ksads_2_209_t"     "ksads_2_210_t"    
# [208] "ksads_2_211_t"     "ksads_2_212_t"     "ksads_2_213_t"    
# [211] "ksads_2_214_t"     "ksads_2_215_t"     "ksads_2_216_t"    
# [214] "ksads_2_217_t"     "ksads_2_218_t"     "ksads_2_219_t"    
# [217] "ksads_2_220_t"     "ksads_2_221_t"     "ksads_2_222_t"    
# [220] "ksads_3_226_t"     "ksads_3_227_t"     "ksads_3_228_t"    
# [223] "ksads_3_229_t"     "ksads_4_230_t"     "ksads_4_231_t"    
# [226] "ksads_4_232_t"     "ksads_4_233_t"     "ksads_4_234_t"    
# [229] "ksads_4_235_t"     "ksads_4_236_t"     "ksads_4_237_t"    
# [232] "ksads_4_238_t"     "ksads_4_239_t"     "ksads_4_240_t"    
# [235] "ksads_4_241_t"     "ksads_4_242_t"     "ksads_4_243_t"    
# [238] "ksads_4_244_t"     "ksads_4_245_t"     "ksads_4_246_t"    
# [241] "ksads_4_247_t"     "ksads_4_248_t"     "ksads_4_249_t"    
# [244] "ksads_4_250_t"     "ksads_4_251_t"     "ksads_4_252_t"    
# [247] "ksads_4_253_t"     "ksads_4_254_t"     "ksads_4_255_t"    
# [250] "ksads_4_256_t"     "ksads_4_257_t"     "ksads_4_258_t"    
# [253] "ksads_4_259_t"     "ksads_4_260_t"     "ksads_5_261_t"    
# [256] "ksads_5_262_t"     "ksads_5_263_t"     "ksads_5_264_t"    
# [259] "ksads_5_265_t"     "ksads_5_266_t"     "ksads_5_267_t"    
# [262] "ksads_5_268_t"     "ksads_5_269_t"     "ksads_5_270_t"    
# [265] "ksads_6_272_t"     "ksads_6_273_t"     "ksads_6_274_t"    
# [268] "ksads_6_275_t"     "ksads_6_276_t"     "ksads_6_277_t"    
# [271] "ksads_6_278_t"     "ksads_6_279_t"     "ksads_7_281_t"    
# [274] "ksads_7_282_t"     "ksads_7_283_t"     "ksads_7_284_t"    
# [277] "ksads_7_285_t"     "ksads_7_286_t"     "ksads_7_287_t"    
# [280] "ksads_7_288_t"     "ksads_7_289_t"     "ksads_7_290_t"    
# [283] "ksads_7_291_t"     "ksads_7_292_t"     "ksads_7_293_t"    
# [286] "ksads_7_294_t"     "ksads_7_295_t"     "ksads_7_296_t"    
# [289] "ksads_7_297_t"     "ksads_7_298_t"     "ksads_7_299_t"    
# [292] "ksads_7_300_t"     "ksads_8_301_t"     "ksads_8_302_t"    
# [295] "ksads_8_303_t"     "ksads_8_304_t"     "ksads_8_307_t"    
# [298] "ksads_8_308_t"     "ksads_8_309_t"     "ksads_8_310_t"    
# [301] "ksads_8_311_t"     "ksads_8_312_t"     "ksads_8_313a_t"   
# [304] "ksads_8_313b_t"    "ksads_25_314_t"    "ksads_25_315_t"   
# [307] "ksads_25_316_t"    "ksads_25_317_t"    "ksads_25_318_t"   
# [310] "ksads_25_319_t"    "ksads_10_320_t"    "ksads_10_321_t"   
# [313] "ksads_10_322_t"    "ksads_10_323_t"    "ksads_10_324_t"   
# [316] "ksads_10_325_t"    "ksads_10_326_t"    "ksads_10_327_t"   
# [319] "ksads_10_328_t"    "ksads_10_329_t"    "ksads_10_330_t"   
# [322] "ksads_11_331_t"    "ksads_11_332_t"    "ksads_11_333_t"   
# [325] "ksads_11_334_t"    "ksads_11_335_t"    "ksads_11_336_t"   
# [328] "ksads_11_337_t"    "ksads_11_338_t"    "ksads_11_339_t"   
# [331] "ksads_11_340_t"    "ksads_11_341_t"    "ksads_11_342_t"   
# [334] "ksads_11_343_t"    "ksads_11_344_t"    "ksads_11_345_t"   
# [337] "ksads_11_346_t"    "ksads_11_347_t"    "ksads_11_348_t"   
# [340] "ksads_21_349_t"    "ksads_21_350_t"    "ksads_21_351_t"   
# [343] "ksads_21_352_t"    "ksads_21_353_t"    "ksads_21_354_t"   
# [346] "ksads_21_355_t"    "ksads_21_356_t"    "ksads_21_357_t"   
# [349] "ksads_21_358_t"    "ksads_21_359_t"    "ksads_21_360_t"   
# [352] "ksads_21_361_t"    "ksads_21_362_t"    "ksads_21_363_t"   
# [355] "ksads_21_364_t"    "ksads_21_365_t"    "ksads_21_366_t"   
# [358] "ksads_21_367_t"    "ksads_21_368_t"    "ksads_21_369_t"   
# [361] "ksads_21_370_t"    "ksads_21_371_t"    "ksads_21_372_t"   
# [364] "ksads_21_373_t"    "ksads_21_374_t"    "ksads_21_375_t"   
# [367] "ksads_21_376_t"    "ksads_21_377_t"    "ksads_21_378_t"   
# [370] "ksads_21_379_t"    "ksads_21_380_t"    "ksads_21_381_t"   
# [373] "ksads_21_382_t"    "ksads_21_383_t"    "ksads_21_384_t"   
# [376] "ksads_21_385_t"    "ksads_21_386_t"    "ksads_21_387_t"   
# [379] "ksads_21_388_t"    "ksads_21_389_t"    "ksads_21_390_t"   
# [382] "ksads_21_391_t"    "ksads_21_392_t"    "ksads_14_394_t"   
# [385] "ksads_14_395_t"    "ksads_14_396_t"    "ksads_14_397_t"   
# [388] "ksads_14_398_t"    "ksads_14_399_t"    "ksads_14_400_t"   
# [391] "ksads_14_401_t"    "ksads_14_402_t"    "ksads_14_403_t"   
# [394] "ksads_14_404_t"    "ksads_14_405_t"    "ksads_14_406_t"   
# [397] "ksads_14_407_t"    "ksads_14_408_t"    "ksads_14_409_t"   
# [400] "ksads_14_410_t"    "ksads_14_411_t"    "ksads_14_412_t"   
# [403] "ksads_14_413_t"    "ksads_14_414_t"    "ksads_14_415_t"   
# [406] "ksads_14_416_t"    "ksads_14_417_t"    "ksads_14_418_t"   
# [409] "ksads_14_419_t"    "ksads_14_420_t"    "ksads_14_421_t"   
# [412] "ksads_14_422_t"    "ksads_14_423_t"    "ksads_14_424_t"   
# [415] "ksads_14_425_t"    "ksads_14_429_t"    "ksads_14_430_t"   
# [418] "ksads_15_431_t"    "ksads_15_432_t"    "ksads_15_433_t"   
# [421] "ksads_15_434_t"    "ksads_15_435_t"    "ksads_15_436_t"   
# [424] "ksads_15_437_t"    "ksads_15_438_t"    "ksads_15_439_t"   
# [427] "ksads_15_440_t"    "ksads_15_441_t"    "ksads_15_442_t"   
# [430] "ksads_15_443_t"    "ksads_15_444_t"    "ksads_15_445_t"   
# [433] "ksads_15_446_t"    "ksads_16_447_t"    "ksads_16_448_t"   
# [436] "ksads_16_449_t"    "ksads_16_450_t"    "ksads_16_451_t"   
# [439] "ksads_16_452_t"    "ksads_16_453_t"    "ksads_16_454_t"   
# [442] "ksads_16_455_t"    "ksads_16_456_t"    "ksads_16_457_t"   
# [445] "ksads_16_458_t"    "ksads_16_459_t"    "ksads_16_460_t"   
# [448] "ksads_16_461_t"    "ksads_16_462_t"    "ksads_16_463_t"   
# [451] "ksads_16_464_t"    "ksads_16_465_t"    "ksads_16_466_t"   
# [454] "ksads_13_469_t"    "ksads_13_470_t"    "ksads_13_471_t"   
# [457] "ksads_13_472_t"    "ksads_13_473_t"    "ksads_13_474_t"   
# [460] "ksads_13_475_t"    "ksads_13_476_t"    "ksads_13_477_t"   
# [463] "ksads_13_478_t"    "ksads_13_479_t"    "ksads_13_480_t"   
# [466] "ksads_19_481_t"    "ksads_19_482_t"    "ksads_19_483_t"   
# [469] "ksads_19_484_t"    "ksads_19_485_t"    "ksads_19_486_t"   
# [472] "ksads_19_487_t"    "ksads_19_488_t"    "ksads_19_489_t"   
# [475] "ksads_19_490_t"    "ksads_19_491_t"    "ksads_19_492_t"   
# [478] "ksads_19_493_t"    "ksads_19_494_t"    "ksads_19_495_t"   
# [481] "ksads_19_496_t"    "ksads_19_497_t"    "ksads_19_498_t"   
# [484] "ksads_19_499_t"    "ksads_19_500_t"    "ksads_19_501_t"   
# [487] "ksads_19_502_t"    "ksads_19_503_t"    "ksads_19_504_t"   
# [490] "ksads_19_505_t"    "ksads_19_506_t"    "ksads_19_508_t"   
# [493] "ksads_20_509_t"    "ksads_20_510_t"    "ksads_20_511_t"   
# [496] "ksads_20_512_t"    "ksads_20_513_t"    "ksads_20_514_t"   
# [499] "ksads_20_515_t"    "ksads_20_516_t"    "ksads_20_517_t"   
# [502] "ksads_20_518_t"    "ksads_20_519_t"    "ksads_20_520_t"   
# [505] "ksads_20_521_t"    "ksads_20_522_t"    "ksads_20_523_t"   
# [508] "ksads_20_524_t"    "ksads_20_525_t"    "ksads_20_526_t"   
# [511] "ksads_20_527_t"    "ksads_20_528_t"    "ksads_20_529_t"   
# [514] "ksads_20_530_t"    "ksads_20_531_t"    "ksads_20_532_t"   
# [517] "ksads_20_533_t"    "ksads_20_534_t"    "ksads_20_536_t"   
# [520] "ksads_20_537_t"    "ksads_20_538_t"    "ksads_20_539_t"   
# [523] "ksads_20_540_t"    "ksads_20_541_t"    "ksads_20_542_t"   
# [526] "ksads_20_543_t"    "ksads_20_544_t"    "ksads_20_545_t"   
# [529] "ksads_20_546_t"    "ksads_20_547_t"    "ksads_20_548_t"   
# [532] "ksads_20_549_t"    "ksads_20_550_t"    "ksads_20_551_t"   
# [535] "ksads_20_552_t"    "ksads_20_553_t"    "ksads_20_554_t"   
# [538] "ksads_20_555_t"    "ksads_20_556_t"    "ksads_20_557_t"   
# [541] "ksads_20_558_t"    "ksads_20_559_t"    "ksads_20_560_t"   
# [544] "ksads_20_561_t"    "ksads_20_562_t"    "ksads_20_563_t"   
# [547] "ksads_20_564_t"    "ksads_20_565_t"    "ksads_20_566_t"   
# [550] "ksads_20_567_t"    "ksads_20_568_t"    "ksads_20_569_t"   
# [553] "ksads_20_570_t"    "ksads_20_571_t"    "ksads_20_572_t"   
# [556] "ksads_20_573_t"    "ksads_20_574_t"    "ksads_20_575_t"   
# [559] "ksads_20_576_t"    "ksads_20_577_t"    "ksads_20_578_t"   
# [562] "ksads_20_579_t"    "ksads_20_580_t"    "ksads_20_581_t"   
# [565] "ksads_20_582_t"    "ksads_20_583_t"    "ksads_20_584_t"   
# [568] "ksads_20_585_t"    "ksads_20_586_t"    "ksads_20_587_t"   
# [571] "ksads_20_588_t"    "ksads_20_589_t"    "ksads_20_590_t"   
# [574] "ksads_20_591_t"    "ksads_20_592_t"    "ksads_20_593_t"   
# [577] "ksads_20_594_t"    "ksads_20_595_t"    "ksads_20_596_t"   
# [580] "ksads_20_597_t"    "ksads_20_598_t"    "ksads_20_599_t"   
# [583] "ksads_20_600_t"    "ksads_20_601_t"    "ksads_20_602_t"   
# [586] "ksads_20_603_t"    "ksads_20_604_t"    "ksads_20_605_t"   
# [589] "ksads_20_606_t"    "ksads_20_607_t"    "ksads_20_608_t"   
# [592] "ksads_20_609_t"    "ksads_20_610_t"    "ksads_20_611_t"   
# [595] "ksads_20_612_t"    "ksads_20_613_t"    "ksads_20_614_t"   
# [598] "ksads_20_615_t"    "ksads_20_616_t"    "ksads_20_617_t"   
# [601] "ksads_20_618_t"    "ksads_20_619_t"    "ksads_20_620_t"   
# [604] "ksads_20_621_t"    "ksads_20_622_t"    "ksads_20_623_t"   
# [607] "ksads_20_624_t"    "ksads_20_625_t"    "ksads_20_626_t"   
# [610] "ksads_20_627_t"    "ksads_20_628_t"    "ksads_20_629_t"   
# [613] "ksads_20_630_t"    "ksads_20_631_t"    "ksads_20_632_t"   
# [616] "ksads_20_633_t"    "ksads_20_634_t"    "ksads_20_635_t"   
# [619] "ksads_20_636_t"    "ksads_20_637_t"    "ksads_20_638_t"   
# [622] "ksads_20_639_t"    "ksads_20_640_t"    "ksads_20_641_t"   
# [625] "ksads_20_642_t"    "ksads_20_643_t"    "ksads_20_644_t"   
# [628] "ksads_20_645_t"    "ksads_20_646_t"    "ksads_20_647_t"   
# [631] "ksads_20_648_t"    "ksads_20_649_t"    "ksads_20_650_t"   
# [634] "ksads_20_651_t"    "ksads_20_652_t"    "ksads_20_653_t"   
# [637] "ksads_20_654_t"    "ksads_20_655_t"    "ksads_20_656_t"   
# [640] "ksads_20_657_t"    "ksads_20_658_t"    "ksads_20_659_t"   
# [643] "ksads_20_660_t"    "ksads_20_661_t"    "ksads_20_662_t"   
# [646] "ksads_20_663_t"    "ksads_20_664_t"    "ksads_20_665_t"   
# [649] "ksads_20_666_t"    "ksads_20_667_t"    "ksads_20_668_t"   
# [652] "ksads_20_669_t"    "ksads_20_670_t"    "ksads_20_671_t"   
# [655] "ksads_20_672_t"    "ksads_20_673_t"    "ksads_20_674_t"   
# [658] "ksads_20_675_t"    "ksads_20_676_t"    "ksads_20_677_t"   
# [661] "ksads_20_678_t"    "ksads_20_679_t"    "ksads_20_680_t"   
# [664] "ksads_20_681_t"    "ksads_20_682_t"    "ksads_20_683_t"   
# [667] "ksads_20_684_t"    "ksads_20_685_t"    "ksads_20_686_t"   
# [670] "ksads_20_687_t"    "ksads_20_688_t"    "ksads_20_689_t"   
# [673] "ksads_20_690_t"    "ksads_20_691_t"    "ksads_20_692_t"   
# [676] "ksads_20_693_t"    "ksads_20_694_t"    "ksads_20_695_t"   
# [679] "ksads_20_696_t"    "ksads_20_697_t"    "ksads_20_698_t"   
# [682] "ksads_20_699_t"    "ksads_20_700_t"    "ksads_20_701_t"   
# [685] "ksads_20_702_t"    "ksads_20_703_t"    "ksads_20_704_t"   
# [688] "ksads_20_705_t"    "ksads_20_706_t"    "ksads_20_707_t"   
# [691] "ksads_20_708_t"    "ksads_20_709_t"    "ksads_20_710_t"   
# [694] "ksads_20_711_t"    "ksads_20_712_t"    "ksads_20_713_t"   
# [697] "ksads_20_714_t"    "ksads_20_715_t"    "ksads_20_716_t"   
# [700] "ksads_20_717_t"    "ksads_20_718_t"    "ksads_20_719_t"   
# [703] "ksads_20_720_t"    "ksads_20_721_t"    "ksads_20_722_t"   
# [706] "ksads_20_723_t"    "ksads_20_724_t"    "ksads_20_725_t"   
# [709] "ksads_20_726_t"    "ksads_20_727_t"    "ksads_20_728_t"   
# [712] "ksads_20_729_t"    "ksads_20_730_t"    "ksads_20_731_t"   
# [715] "ksads_20_732_t"    "ksads_20_733_t"    "ksads_20_734_t"   
# [718] "ksads_20_735_t"    "ksads_20_736_t"    "ksads_20_737_t"   
# [721] "ksads_20_738_t"    "ksads_20_739_t"    "ksads_20_740_t"   
# [724] "ksads_20_741_t"    "ksads_20_742_t"    "ksads_20_743_t"   
# [727] "ksads_20_744_t"    "ksads_20_745_t"    "ksads_20_746_t"   
# [730] "ksads_20_747_t"    "ksads_20_748_t"    "ksads_20_749_t"   
# [733] "ksads_20_750_t"    "ksads_20_751_t"    "ksads_20_752_t"   
# [736] "ksads_20_753_t"    "ksads_20_754_t"    "ksads_20_755_t"   
# [739] "ksads_20_756_t"    "ksads_20_757_t"    "ksads_20_758_t"   
# [742] "ksads_20_759_t"    "ksads_20_760_t"    "ksads_20_761_t"   
# [745] "ksads_20_762_t"    "ksads_20_763_t"    "ksads_20_764_t"   
# [748] "ksads_20_765_t"    "ksads_20_766_t"    "ksads_20_767_t"   
# [751] "ksads_20_768_t"    "ksads_20_769_t"    "ksads_20_770_t"   
# [754] "ksads_20_771_t"    "ksads_20_772_t"    "ksads_20_773_t"   
# [757] "ksads_20_774_t"    "ksads_20_775_t"    "ksads_20_776_t"   
# [760] "ksads_20_777_t"    "ksads_20_778_t"    "ksads_20_779_t"   
# [763] "ksads_20_780_t"    "ksads_20_781_t"    "ksads_20_782_t"   
# [766] "ksads_20_783_t"    "ksads_20_784_t"    "ksads_20_785_t"   
# [769] "ksads_20_786_t"    "ksads_20_787_t"    "ksads_20_788_t"   
# [772] "ksads_20_789_t"    "ksads_20_790_t"    "ksads_20_791_t"   
# [775] "ksads_20_792_t"    "ksads_20_793_t"    "ksads_20_794_t"   
# [778] "ksads_20_795_t"    "ksads_20_796_t"    "ksads_20_797_t"   
# [781] "ksads_20_798_t"    "ksads_20_799_t"    "ksads_20_800_t"   
# [784] "ksads_20_801_t"    "ksads_20_802_t"    "ksads_20_803_t"   
# [787] "ksads_20_804_t"    "ksads_20_805_t"    "ksads_20_806_t"   
# [790] "ksads_23_807_t"    "ksads_23_808_t"    "ksads_23_809_t"   
# [793] "ksads_23_810_t"    "ksads_23_811_t"    "ksads_23_812_t"   
# [796] "ksads_23_813_t"    "ksads_23_814_t"    "ksads_23_815_t"   
# [799] "ksads_23_816_t"    "ksads_23_817_t"    "ksads_23_818_t"   
# [802] "ksads_23_819_t"    "ksads_23_820_t"    "ksads_23_821_t"   
# [805] "ksads_23_822_t"    "ksads_23_823_t"    "ksads_23_824_t"   
# [808] "ksads_23_825_t"    "ksads_4_826_t"     "ksads_4_827_t"    
# [811] "ksads_4_828_t"     "ksads_4_829_t"     "ksads_2_830_t"    
# [814] "ksads_2_831_t"     "ksads_2_832_t"     "ksads_2_833_t"    
# [817] "ksads_2_834_t"     "ksads_2_835_t"     "ksads_2_836_t"    
# [820] "ksads_2_837_t"     "ksads_2_838_t"     "ksads_2_839_t"    
# [823] "ksads_1_840_t"     "ksads_1_841_t"     "ksads_1_842_t"    
# [826] "ksads_1_843_t"     "ksads_1_844_t"     "ksads_1_845_t"    
# [829] "ksads_1_846_t"     "ksads_1_847_t"     "ksads_3_848_t"    
# [832] "ksads_4_849_t"     "ksads_4_850_t"     "ksads_4_851_t"    
# [835] "ksads_4_852_t"     "ksads_14_853_t"    "ksads_14_854_t"   
# [838] "ksads_14_855_t"    "ksads_14_856_t"    "ksads_5_857_t"    
# [841] "ksads_5_858_t"     "ksads_6_859_t"     "ksads_6_860_t"    
# [844] "ksads_7_861_t"     "ksads_7_862_t"     "ksads_8_863_t"    
# [847] "ksads_8_864_t"     "ksads_25_865_t"    "ksads_25_866_t"   
# [850] "ksads_9_867_t"     "ksads_9_868_t"     "ksads_10_869_t"   
# [853] "ksads_10_870_t"    "ksads_20_871_t"    "ksads_20_872_t"   
# [856] "ksads_20_873_t"    "ksads_20_874_t"    "ksads_20_875_t"   
# [859] "ksads_20_876_t"    "ksads_20_877_t"    "ksads_20_878_t"   
# [862] "ksads_20_879_t"    "ksads_20_880_t"    "ksads_20_881_t"   
# [865] "ksads_20_882_t"    "ksads_20_883_t"    "ksads_20_884_t"   
# [868] "ksads_20_885_t"    "ksads_20_886_t"    "ksads_20_887_t"   
# [871] "ksads_20_888_t"    "ksads_20_889_t"    "ksads_20_890_t"   
# [874] "ksads_19_891_t"    "ksads_19_892_t"    "ksads_20_893_t"   
# [877] "ksads_20_894_t"    "ksads_19_895_t"    "ksads_19_896_t"   
# [880] "ksads_16_897_t"    "ksads_16_898_t"    "ksads_16_899_t"   
# [883] "ksads_16_900_t"    "ksads_15_901_t"    "ksads_15_902_t"   
# [886] "ksads_18_903_t"    "ksads_17_904_t"    "ksads_17_905_t"   
# [889] "ksads_5_906_t"     "ksads_5_907_t"     "ksads_6_908_t"    
# [892] "ksads_7_909_t"     "ksads_7_910_t"     "ksads_8_911_t"    
# [895] "ksads_8_912_t"     "ksads_10_913_t"    "ksads_10_914_t"   
# [898] "ksads_25_915_t"    "ksads_25_916_t"    "ksads_11_917_t"   
# [901] "ksads_11_918_t"    "ksads_11_919_t"    "ksads_11_920_t"   
# [904] "ksads_21_921_t"    "ksads_21_922_t"    "ksads_21_923_t"   
# [907] "ksads_21_924_t"    "ksads_12_925_t"    "ksads_12_926_t"   
# [910] "ksads_12_927_t"    "ksads_12_928_t"    "ksads_13_929_t"   
# [913] "ksads_13_930_t"    "ksads_13_931_t"    "ksads_13_932_t"   
# [916] "ksads_13_933_t"    "ksads_13_934_t"    "ksads_13_935_t"   
# [919] "ksads_13_936_t"    "ksads_13_937_t"    "ksads_13_938_t"   
# [922] "ksads_13_939_t"    "ksads_13_940_t"    "ksads_13_941_t"   
# [925] "ksads_13_942_t"    "ksads_13_943_t"    "ksads_13_944_t"   
# [928] "ksads_23_945_t"    "ksads_23_946_t"    "ksads_23_947_t"   
# [931] "ksads_23_948_t"    "ksads_23_949_t"    "ksads_23_950_t"   
# [934] "ksads_23_951_t"    "ksads_23_952_t"    "ksads_23_953_t"   
# [937] "ksads_23_954_t"    "ksads_23_955_t"    "ksads_23_956_t"   
# [940] "ksads_23_957_t"    "ksads_23_958_t"    "ksads_23_959_t"   
# [943] "ksads_23_960_t"    "ksads_23_961_t"    "ksads_23_962_t"   
# [946] "ksads_23_963_t"    "ksads_23_964_t"    "ksads_23_965_t"   
# [949] "ksads_23_966_t"    "ksads_24_967_t"    "ksads_24_968_t"   
# [952] "ksads_22_969_t"    "ksads_22_970_t"    "ksads_8_31_t"     
# [955] "ksads_9_44_t"      "ksads_10_47_t"     "ksads_11_51_t"    
# [958] "ksads_12_65_t"     "ksads_13_75_t"     "ksads_14_90_t"    
# [961] "ksads_25_33_t"     "ksads_timestamp_t" "ksads_duration_t" 
# [964] "collection_title"  "study_cohort_name"

ksads_y = ksads_y[,-c(1:3, 5:8, 10:822, 829:830, 832:835, 839, 847:849, 
                      855:862, 864:871, 876:879, 887:899, 902:903, 906:927,
                      934:949, 954:965)]

colnames(ksads_y)
# [1] "subjectkey"     "eventname"      "ksads_1_840_t"  "ksads_1_841_t" 
# [5] "ksads_1_842_t"  "ksads_1_843_t"  "ksads_1_844_t"  "ksads_1_845_t" 
# [9] "ksads_3_848_t"  "ksads_14_853_t" "ksads_14_854_t" "ksads_14_855_t"
# [13] "ksads_5_857_t"  "ksads_5_858_t"  "ksads_6_859_t"  "ksads_6_860_t" 
# [17] "ksads_7_861_t"  "ksads_7_862_t"  "ksads_8_863_t"  "ksads_9_867_t" 
# [21] "ksads_9_868_t"  "ksads_10_869_t" "ksads_10_870_t" "ksads_20_871_t"
# [25] "ksads_20_880_t" "ksads_20_889_t" "ksads_20_890_t" "ksads_19_891_t"
# [29] "ksads_19_892_t" "ksads_16_897_t" "ksads_16_898_t" "ksads_16_899_t"
# [33] "ksads_16_900_t" "ksads_15_901_t" "ksads_15_902_t" "ksads_18_903_t"
# [37] "ksads_11_917_t" "ksads_11_918_t" "ksads_21_921_t" "ksads_21_922_t"
# [41] "ksads_23_945_t" "ksads_23_946_t" "ksads_23_947_t" "ksads_23_948_t"
# [45] "ksads_23_949_t" "ksads_23_950_t" "ksads_24_967_t" "ksads_24_968_t"
# [49] "ksads_22_969_t" "ksads_22_970_t"

#Rename variables
names(ksads_y)[names(ksads_y) == "subjectkey"] = "id"
names(ksads_y)[names(ksads_y) == "eventname"] = "timepoint"
names(ksads_y)[names(ksads_y) == "ksads_1_840_t"] = "y_mdd_present"
names(ksads_y)[names(ksads_y) == "ksads_1_841_t"] = "y_mdd_rem"
names(ksads_y)[names(ksads_y) == "ksads_1_842_t"] = "y_mdd_past"
names(ksads_y)[names(ksads_y) == "ksads_1_843_t"] = "y_pres_dep_present"
names(ksads_y)[names(ksads_y) == "ksads_1_844_t"] = "y_pres_dep_rem"
names(ksads_y)[names(ksads_y) == "ksads_1_845_t"] = "y_pres_dep_past"
names(ksads_y)[names(ksads_y) == "ksads_3_848_t"] = "y_dmdd"
names(ksads_y)[names(ksads_y) == "ksads_14_853_t"] = "y_adhd_present"
names(ksads_y)[names(ksads_y) == "ksads_14_854_t"] = "y_adhd_past"
names(ksads_y)[names(ksads_y) == "ksads_14_855_t"] = "y_adhd_rem"
names(ksads_y)[names(ksads_y) == "ksads_5_857_t"] = "y_panic_present"
names(ksads_y)[names(ksads_y) == "ksads_5_858_t"] = "y_panic_past"
names(ksads_y)[names(ksads_y) == "ksads_6_859_t"] = "y_agoraphobia_present"
names(ksads_y)[names(ksads_y) == "ksads_6_860_t"] = "y_agoraphobia_past"
names(ksads_y)[names(ksads_y) == "ksads_7_861_t"] = "y_sepanx_present"
names(ksads_y)[names(ksads_y) == "ksads_7_862_t"] = "y_sepanx_past"
names(ksads_y)[names(ksads_y) == "ksads_8_863_t"] = "y_socanx_present"
names(ksads_y)[names(ksads_y) == "ksads_9_867_t"] = "y_specphob_present"
names(ksads_y)[names(ksads_y) == "ksads_9_868_t"] = "y_specphob_past"
names(ksads_y)[names(ksads_y) == "ksads_10_869_t"] = "y_gad_present"
names(ksads_y)[names(ksads_y) == "ksads_10_870_t"] = "y_gad_past"
names(ksads_y)[names(ksads_y) == "ksads_20_871_t"] = "y_cud_present"
names(ksads_y)[names(ksads_y) == "ksads_20_880_t"] = "y_cud_past"
names(ksads_y)[names(ksads_y) == "ksads_20_889_t"] = "y_sud_present"
names(ksads_y)[names(ksads_y) == "ksads_20_890_t"] = "y_sud_past"
names(ksads_y)[names(ksads_y) == "ksads_19_891_t"] = "y_aud_present"
names(ksads_y)[names(ksads_y) == "ksads_19_892_t"] = "y_aud_past"
names(ksads_y)[names(ksads_y) == "ksads_16_897_t"] = "y_cd_child_present"
names(ksads_y)[names(ksads_y) == "ksads_16_898_t"] = "y_cd_adol_present"
names(ksads_y)[names(ksads_y) == "ksads_16_899_t"] = "y_cd_child_past"
names(ksads_y)[names(ksads_y) == "ksads_16_900_t"] = "y_cd_adol_past"
names(ksads_y)[names(ksads_y) == "ksads_15_901_t"] = "y_odd_present"
names(ksads_y)[names(ksads_y) == "ksads_15_902_t"] = "y_odd_past"
names(ksads_y)[names(ksads_y) == "ksads_18_903_t"] = "y_asd"
names(ksads_y)[names(ksads_y) == "ksads_11_917_t"] = "y_ocd_present"
names(ksads_y)[names(ksads_y) == "ksads_11_918_t"] = "y_ocd_past"
names(ksads_y)[names(ksads_y) == "ksads_21_921_t"] = "y_ptsd_present"
names(ksads_y)[names(ksads_y) == "ksads_21_922_t"] = "y_ptsd_past"
names(ksads_y)[names(ksads_y) == "ksads_23_945_t"] = "y_selfinj_present"
names(ksads_y)[names(ksads_y) == "ksads_23_946_t"] = "y_si_passive_pres"
names(ksads_y)[names(ksads_y) == "ksads_23_947_t"] = "y_si_active_pres"
names(ksads_y)[names(ksads_y) == "ksads_24_967_t"] = "y_hom_present"
names(ksads_y)[names(ksads_y) == "ksads_24_968_t"] = "y_hom_past"
names(ksads_y)[names(ksads_y) == "ksads_22_969_t"] = "y_sleep_present"
names(ksads_y)[names(ksads_y) == "ksads_22_970_t"] = "y_sleep_past"

colnames(ksads_y)
# [1] "id"                    "timepoint"             "y_mdd_present"        
# [4] "y_mdd_rem"             "y_mdd_past"            "y_pres_dep_present"   
# [7] "y_pres_dep_rem"        "y_pres_dep_past"       "y_dmdd"               
# [10] "y_adhd_present"        "y_adhd_past"           "y_adhd_rem"           
# [13] "y_panic_present"       "y_panic_past"          "y_agoraphobia_present"
# [16] "y_agoraphobia_past"    "y_sepanx_present"      "y_sepanx_past"        
# [19] "y_socanx_present"      "y_specphob_present"    "y_specphob_past"      
# [22] "y_gad_present"         "y_gad_past"            "y_cud_present"        
# [25] "y_cud_past"            "y_sud_present"         "y_sud_past"           
# [28] "y_aud_present"         "y_aud_past"            "y_cd_child_present"   
# [31] "y_cd_adol_present"     "y_cd_child_past"       "y_cd_adol_past"       
# [34] "y_odd_present"         "y_odd_past"            "y_asd"                
# [37] "y_ocd_present"         "y_ocd_past"            "y_ptsd_present"       
# [40] "y_ptsd_past"           "y_selfinj_present"     "y_si_passive_pres"    
# [43] "y_si_active_pres"      "ksads_23_948_t"        "ksads_23_949_t"       
# [46] "ksads_23_950_t"        "y_hom_present"         "y_hom_past"           
# [49] "y_sleep_present"       "y_sleep_past"    

#Remove 2 variables I do not need from dataframe 
ksads_y = ksads_y[,-c(45,46)]

colnames(ksads_y)
# [1] "id"                    "timepoint"             "y_mdd_present"        
# [4] "y_mdd_rem"             "y_mdd_past"            "y_pres_dep_present"   
# [7] "y_pres_dep_rem"        "y_pres_dep_past"       "y_dmdd"               
# [10] "y_adhd_present"        "y_adhd_past"           "y_adhd_rem"           
# [13] "y_panic_present"       "y_panic_past"          "y_agoraphobia_present"
# [16] "y_agoraphobia_past"    "y_sepanx_present"      "y_sepanx_past"        
# [19] "y_socanx_present"      "y_specphob_present"    "y_specphob_past"      
# [22] "y_gad_present"         "y_gad_past"            "y_cud_present"        
# [25] "y_cud_past"            "y_sud_present"         "y_sud_past"           
# [28] "y_aud_present"         "y_aud_past"            "y_cd_child_present"   
# [31] "y_cd_adol_present"     "y_cd_child_past"       "y_cd_adol_past"       
# [34] "y_odd_present"         "y_odd_past"            "y_asd"                
# [37] "y_ocd_present"         "y_ocd_past"            "y_ptsd_present"       
# [40] "y_ptsd_past"           "y_selfinj_present"     "y_si_passive_pres"    
# [43] "y_si_active_pres"      "ksads_23_948_t"        "y_hom_present"        
# [46] "y_hom_past"            "y_sleep_present"       "y_sleep_past" 

table(ksads_y$y_adhd_present, useNA = "ifany")
# 555 
# 33515 

table(ksads_y$y_socanx_present, useNA = "ifany")
#       0     1   555    888 
# 173 22015   101 11225     1 

#Rescale variables so "" is NA
colnames(ksads_y)
ksads_y[, c(3:48)][ksads_y[, c(3:48)] == ""] <- NA
ksads_y[, c(3:48)][ksads_y[, c(3:48)] == 555] <- NA
ksads_y[, c(3:48)][ksads_y[, c(3:48)] == 888] <- NA

table(ksads_y$y_adhd_present, useNA = "ifany")
#   <NA> 
#   33515 

table(ksads_y$y_socanx_present, useNA = "ifany")
#       0     1  <NA> 
#   22015   101 11399 

#Identify the number of timepoints in dataset
table(ksads_y$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1    baseline_year_1_arm_1 
# 11225                    10414                        11876       

#Label timepoints
ksads_y[which(ksads_y$timepoint == "baseline_year_1_arm_1"),  "timepoint"] = 0
ksads_y[which(ksads_y$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1
ksads_y[which(ksads_y$timepoint == "2_year_follow_up_y_arm_1"),  "timepoint"] = 2

table(ksads_y$timepoint, useNA = "ifany")
# 0     1     2 
# 11876 11225 10414 

#Reshape data to wide 
library(reshape)
ksads_y_wide = reshape(ksads_y, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(ksads_y_wide)
# [1] "id"                      "y_mdd_present.0"         "y_mdd_rem.0"            
# [4] "y_mdd_past.0"            "y_pres_dep_present.0"    "y_pres_dep_rem.0"       
# [7] "y_pres_dep_past.0"       "y_dmdd.0"                "y_adhd_present.0"       
# [10] "y_adhd_past.0"           "y_adhd_rem.0"            "y_panic_present.0"      
# [13] "y_panic_past.0"          "y_agoraphobia_present.0" "y_agoraphobia_past.0"   
# [16] "y_sepanx_present.0"      "y_sepanx_past.0"         "y_socanx_present.0"     
# [19] "y_specphob_present.0"    "y_specphob_past.0"       "y_gad_present.0"        
# [22] "y_gad_past.0"            "y_cud_present.0"         "y_cud_past.0"           
# [25] "y_sud_present.0"         "y_sud_past.0"            "y_aud_present.0"        
# [28] "y_aud_past.0"            "y_cd_child_present.0"    "y_cd_adol_present.0"    
# [31] "y_cd_child_past.0"       "y_cd_adol_past.0"        "y_odd_present.0"        
# [34] "y_odd_past.0"            "y_asd.0"                 "y_ocd_present.0"        
# [37] "y_ocd_past.0"            "y_ptsd_present.0"        "y_ptsd_past.0"          
# [40] "y_selfinj_present.0"     "y_si_passive_pres.0"     "y_si_active_pres.0"     
# [43] "ksads_23_948_t.0"        "y_hom_present.0"         "y_hom_past.0"           
# [46] "y_sleep_present.0"       "y_sleep_past.0"          "y_mdd_present.1"        
# [49] "y_mdd_rem.1"             "y_mdd_past.1"            "y_pres_dep_present.1"   
# [52] "y_pres_dep_rem.1"        "y_pres_dep_past.1"       "y_dmdd.1"               
# [55] "y_adhd_present.1"        "y_adhd_past.1"           "y_adhd_rem.1"           
# [58] "y_panic_present.1"       "y_panic_past.1"          "y_agoraphobia_present.1"
# [61] "y_agoraphobia_past.1"    "y_sepanx_present.1"      "y_sepanx_past.1"        
# [64] "y_socanx_present.1"      "y_specphob_present.1"    "y_specphob_past.1"      
# [67] "y_gad_present.1"         "y_gad_past.1"            "y_cud_present.1"        
# [70] "y_cud_past.1"            "y_sud_present.1"         "y_sud_past.1"           
# [73] "y_aud_present.1"         "y_aud_past.1"            "y_cd_child_present.1"   
# [76] "y_cd_adol_present.1"     "y_cd_child_past.1"       "y_cd_adol_past.1"       
# [79] "y_odd_present.1"         "y_odd_past.1"            "y_asd.1"                
# [82] "y_ocd_present.1"         "y_ocd_past.1"            "y_ptsd_present.1"       
# [85] "y_ptsd_past.1"           "y_selfinj_present.1"     "y_si_passive_pres.1"    
# [88] "y_si_active_pres.1"      "ksads_23_948_t.1"        "y_hom_present.1"        
# [91] "y_hom_past.1"            "y_sleep_present.1"       "y_sleep_past.1"         
# [94] "y_mdd_present.2"         "y_mdd_rem.2"             "y_mdd_past.2"           
# [97] "y_pres_dep_present.2"    "y_pres_dep_rem.2"        "y_pres_dep_past.2"      
# [100] "y_dmdd.2"                "y_adhd_present.2"        "y_adhd_past.2"          
# [103] "y_adhd_rem.2"            "y_panic_present.2"       "y_panic_past.2"         
# [106] "y_agoraphobia_present.2" "y_agoraphobia_past.2"    "y_sepanx_present.2"     
# [109] "y_sepanx_past.2"         "y_socanx_present.2"      "y_specphob_present.2"   
# [112] "y_specphob_past.2"       "y_gad_present.2"         "y_gad_past.2"           
# [115] "y_cud_present.2"         "y_cud_past.2"            "y_sud_present.2"        
# [118] "y_sud_past.2"            "y_aud_present.2"         "y_aud_past.2"           
# [121] "y_cd_child_present.2"    "y_cd_adol_present.2"     "y_cd_child_past.2"      
# [124] "y_cd_adol_past.2"        "y_odd_present.2"         "y_odd_past.2"           
# [127] "y_asd.2"                 "y_ocd_present.2"         "y_ocd_past.2"           
# [130] "y_ptsd_present.2"        "y_ptsd_past.2"           "y_selfinj_present.2"    
# [133] "y_si_passive_pres.2"     "y_si_active_pres.2"      "ksads_23_948_t.2"       
# [136] "y_hom_present.2"         "y_hom_past.2"            "y_sleep_present.2"      
# [139] "y_sleep_past.2"         

#ABCD Youth Wills Problem Solving Scale- ND (only 1 year follow up) ----

#Add path and file name
y_wills  = read.delim(file("abcd_ywpss01.txt"))
y_wills = y_wills[-c(1),]
dim(y_wills) 
# [1] 17476    18

colnames(y_wills)
# [1] "collection_id"     "abcd_ywpss01_id"   "dataset_id"        "subjectkey"        "src_subject_id"   
# [6] "interview_date"    "interview_age"     "sex"               "eventname"         "wps_q1_y"         
# [11] "wps_q2_y"          "wps_q3_y"          "wps_q4_y"          "wps_q5_y"          "wps_q6_y"         
# [16] "wps_admin"         "collection_title"  "study_cohort_name"

y_wills = y_wills[,-c(1:3, 5, 6, 7, 8, 16:18)]

colnames(y_wills)
#[1] "subjectkey" "eventname"  "wps_q1_y"   "wps_q2_y"   "wps_q3_y"   "wps_q4_y"   "wps_q5_y"   "wps_q6_y" 

#Rename variables
names(y_wills)[names(y_wills) == "subjectkey"] = "id"
names(y_wills)[names(y_wills) == "eventname"] = "timepoint"
names(y_wills)[names(y_wills) == "wps_q1_y"] = "wps_info"
names(y_wills)[names(y_wills) == "wps_q2_y"] = "wps_steps"
names(y_wills)[names(y_wills) == "wps_q3_y"] = "wps_choices"
names(y_wills)[names(y_wills) == "wps_q4_y"] = "wps_altways"
names(y_wills)[names(y_wills) == "wps_q5_y"] = "wps_altsolveprob"
names(y_wills)[names(y_wills) == "wps_q6_y"] = "wps_solveprob"

colnames(y_wills)
# [1] "id"               "timepoint"        "wps_info"         "wps_steps"        "wps_choices"     
# [6] "wps_altways"      "wps_altsolveprob" "wps_solveprob" 

table(y_wills$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                     6251 

table(y_wills$wps_info, useNA = "ifany")
#       0    1    2    3    4    5 
# 16   32 1007 2154 4197 5366 4704 

table(y_wills$wps_steps, useNA = "ifany")
#       0    1    2    3    4    5 
# 16   16  754 1951 4327 5505 4907 

#1 = Never
#2 = A little
#3 = Sometimes 
#4 = Pretty Often 
#5 = Usually 

#Rescale variables
colnames(y_wills)
y_wills[, c(3:8)][y_wills[, c(3:8)] == ""] <- NA
y_wills[, c(3:8)][y_wills[, c(3:8)] == 1] <- 0
y_wills[, c(3:8)][y_wills[, c(3:8)] == 2] <- 1
y_wills[, c(3:8)][y_wills[, c(3:8)] == 3] <- 2
y_wills[, c(3:8)][y_wills[, c(3:8)] == 4] <- 3
y_wills[, c(3:8)][y_wills[, c(3:8)] == 5] <- 4

table(y_wills$wps_steps, useNA = "ifany")
#     0    1    2    3    4 <NA> 
#   770 1951 4327 5505 4907   16 

table(y_wills$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                     6251 

#Label timepoint data 
y_wills[which(y_wills$timepoint == "3_year_follow_up_y_arm_1"),  "timepoint"] = 3
y_wills[which(y_wills$timepoint == "1_year_follow_up_y_arm_1"),  "timepoint"] = 1

table(y_wills$timepoint, useNA = "ifany")
#   1     3 
# 11225  6251 

#Reshape data to wide 
y_wills_wide = reshape(y_wills, idvar = "id", timevar = "timepoint", direction = "wide")

colnames(y_wills_wide)
# [1] "id"                 "wps_info.3"         "wps_steps.3"        "wps_choices.3"      "wps_altways.3"     
# [6] "wps_altsolveprob.3" "wps_solveprob.3"    "wps_info.1"         "wps_steps.1"        "wps_choices.1"     
# [11] "wps_altways.1"      "wps_altsolveprob.1" "wps_solveprob.1"  

#Remove 3 year follow-up
y_wills_wide = y_wills_wide[,-c(2:7)]
colnames(y_wills_wide)
# [1] "id"                 "wps_info.1"         "wps_steps.1"        "wps_choices.1"      "wps_altways.1"     
# [6] "wps_altsolveprob.1" "wps_solveprob.1"   

#Change character to numeric
y_wills_wide[,c(2:7)]<-as.data.frame(apply(y_wills_wide[,c(2:7)],2,as.numeric))


#Substance Use ---- 
#ABCD Youth Substance Use Interview- SU ----

#Add path and file name
y_subuse_base  = read.delim(file("abcd_ysu02.txt"))
y_subuse_base = y_subuse_base[-c(1),]
dim(y_subuse_base) 
# [1] 11876   777

colnames(y_subuse_base)
# [1] "collection_id"              "abcd_ysu02_id"              "dataset_id"                
# [4] "subjectkey"                 "src_subject_id"             "interview_date"            
# [7] "interview_age"              "sex"                        "su_today"                  
# [10] "tlfb_age"                   "tlfb_age_month"             "tlfb_age_calc_inmonths"    
# [13] "tlfb_alc"                   "tlfb_tob"                   "tlfb_mj"                   
# [16] "tlfb_mj_synth"              "tlfb_bitta"                 "tlfb_caff"                 
# [19] "tlfb_inhalant"              "tlfb_rx_misuse"             "tlfb_list_yes_no"          
# [22] "tlfb_list___1"              "tlfb_list___2"              "tlfb_list___3"             
# [25] "tlfb_list___4"              "tlfb_list___5"              "tlfb_list___6"             
# [28] "tlfb_list___7"              "tlfb_list___8"              "tlfb_list___9"             
# [31] "tlfb_list___10"             "tlfb_list___11"             "tlfb_list___12"            
# [34] "tlfb_list___18"             "tlfb_alc_sip"               "tlfb_alc_use"              
# [37] "tlfb_tob_puff"              "tlfb_cig_use"               "tlfb_ecig_use"             
# [40] "tlfb_chew_use"              "tlfb_cigar_use"             "tlfb_hookah_use"           
# [43] "tlfb_pipes_use"             "tlfb_nicotine_use"          "tlfb_mj_puff"              
# [46] "tlfb_mj_use"                "tlfb_blunt_use"             "tlfb_edible_use"           
# [49] "tlfb_mj_conc_use"           "tlfb_mj_drink_use"          "tlfb_tincture_use"         
# [52] "tlfb_mj_synth_use"          "tlfb_coc_use"               "tlfb_bsalts_use"           
# [55] "tlfb_meth_use"              "tlfb_mdma_use"              "tlfb_ket_use"              
# [58] "tlfb_ghb_use"               "tlfb_opi_use"               "tlfb_hall_use"             
# [61] "tlfb_shrooms_use"           "tlfb_salvia_use"            "tlfb_steroids_use"         
# [64] "tlfb_bitta_use"             "tlfb_sniff_use"             "tlfb_inhalant_use"         
# [67] "tlfb_amp_use"               "tlfb_tranq_use"             "tlfb_vicodin_use"          
# [70] "tlfb_cough_use"             "tlfb_other_use"             "tlfb_hall_use_type___1"    
# [73] "tlfb_hall_use_type___2"     "tlfb_hall_use_type___3"     "tlfb_hall_use_type___4"    
# [76] "tlfb_hall_use_type___6"     "tlfb_hall_use_type___7"     "tlfb_hall_use_type___8"    
# [79] "tlfb_hall_use_type___10"    "tlfb_inhalant_use_type___1" "tlfb_inhalant_use_type___2"
# [82] "tlfb_inhalant_use_type___3" "tlfb_inhalant_use_type___4" "tlfb_inhalant_use_type___5"
# [85] "tlfb_inhalant_use_type___6" "tlfb_inhalant_use_type___7" "tlfb_inhalant_use_type___8"
# [88] "isip_1"                     "su_isip_1_calc"             "isip_1b_yn"                
# [91] "isip_1b_2"                  "su_isip_1b_2_calc"          "isip_1d_2"                 
# [94] "isip_2_2"                   "isip_3_2"                   "isip_4_2"                  
# [97] "isip_5_2"                   "isip_6_2"                   "tlfb_alc_date1"            
# [100] "tlfb_alc_calc"              "tlfb_alc_reg"               "tlfb_alc_date2"            
# [103] "tlfb_alc_calc_reg"          "first_nicotine_1"           "first_nicotine_2"          
# [106] "first_nicotine_3"           "first_nicotine_4"           "first_nicotine_5"          
# [109] "first_nicotine_6"           "first_nicotine_7"           "first_nicotine_11"         
# [112] "first_nicotine_12"          "first_nicotine_13"          "tlfb_cig_date1"            
# [115] "tlfb_cig_calc"              "tlfb_cig_reg"               "tlfb_cig_date2"            
# [118] "tlfb_cig_calc_reg"          "tlfb_ecig_date1"            "tlfb_ecig_calc"            
# [121] "tlfb_ecig_reg"              "tlfb_ecig_date2"            "tlfb_ecig_calc_reg"        
# [124] "tlfb_chew_date1"            "tlfb_chew_calc"             "tlfb_chew_reg"             
# [127] "tlfb_chew_date2"            "tlfb_chew_calc_reg"         "tlfb_cigar_date1"          
# [130] "tlfb_cigar_calc"            "tlfb_cigar_reg"             "tlfb_cigar_date2"          
# [133] "tlfb_cigar_calc_reg"        "tlfb_hookah_date1"          "tlfb_hookah_calc"          
# [136] "tlfb_hookah_reg"            "tlfb_hookah_date2"          "tlfb_hookah_calc_reg"      
# [139] "tlfb_pipes_date1"           "tlfb_pipes_calc"            "tlfb_pipes_reg"            
# [142] "tlfb_pipes_date2"           "tlfb_pipes_calc_reg"        "tlfb_nicotine_date1"       
# [145] "tlfb_nicotine_calc"         "tlfb_nicotine_reg"          "tlfb_nicotine_date2"       
# [148] "tlfb_nicotine_calc_reg"     "first_mj_1b"                "first_mj_1a"               
# [151] "first_mj_3"                 "first_mj_4"                 "first_mj_5"                
# [154] "first_mj_6"                 "first_mj_7"                 "first_mj_8"                
# [157] "tlfb_mj_date1"              "tlfb_mj_calc"               "tlfb_mj_reg"               
# [160] "tlfb_mj_date2"              "tlfb_mj_calc_reg"           "tlfb_blunt_date1"          
# [163] "tlfb_blunt_calc"            "tlfb_blunt_reg"             "tlfb_blunt_date2"          
# [166] "tlfb_blunt_calc_reg"        "tlfb_edible_date1"          "tlfb_edible_calc"          
# [169] "tlfb_edible_reg"            "tlfb_edible_date2"          "tlfb_edible_calc_reg"      
# [172] "tlfb_mj_conc_date1"         "tlfb_mj_conc_calc"          "tlfb_mj_conc_reg"          
# [175] "tlfb_mj_conc_date2"         "tlfb_mj_conc_calc_reg"      "tlfb_mj_drink_date1"       
# [178] "xcalc_mj_drink"             "tlfb_mj_drink_reg"          "tlfb_mj_drink_date2"       
# [181] "tlfb_mj_drink_calc_reg"     "tlfb_tincture_date1"        "tlfb_tincture_calc"        
# [184] "tlfb_tincture_reg"          "tlfb_tincture_date2"        "tlfb_tincture_calc_reg"    
# [187] "tlfb_mj_synth_date1"        "tlfb_mj_synth_calc"         "tlfb_mj_synth_reg"         
# [190] "tlfb_mj_synth_date2"        "tlfb_mj_synth_calc_reg"     "tlfb_coc_date1"            
# [193] "tlfb_coc_calc"              "tlfb_coc_reg"               "tlfb_coc_date2"            
# [196] "tlfb_coc_calc_reg"          "tlfb_bsalts_date1"          "tlfb_bsalts_calc"          
# [199] "tlfb_bsalts_reg"            "tlfb_bsalts_date2"          "tlfb_bsalts_calc_reg"      
# [202] "tlfb_meth_date1"            "tlfb_meth_calc"             "tlfb_meth_reg"             
# [205] "tlfb_meth_date2"            "tlfb_meth_calc_reg"         "tlfb_mdma_date1"           
# [208] "tlfb_mdma_calc"             "tlfb_mdma_reg"              "tlfb_mdma_date2"           
# [211] "tlfb_mdma_calc_reg"         "tlfb_ket_date1"             "tlfb_ket_calc"             
# [214] "tlfb_ket_reg"               "tlfb_ket_date2"             "tlfb_ket_calc_reg"         
# [217] "tlfb_ghb_date1"             "tlfb_ghb_calc"              "tlfb_ghb_reg"              
# [220] "tlfb_ghb_date2"             "tlfb_ghb_calc_reg"          "tlfb_opi_date1"            
# [223] "tlfb_opi_calc"              "tlfb_opi_reg"               "tlfb_opi_date2"            
# [226] "tlfb_opi_calc_reg"          "tlfb_hall_date1"            "tlfb_hall_calc"            
# [229] "tlfb_hall_reg"              "tlfb_hall_date2"            "tlfb_hall_calc_reg"        
# [232] "tlfb_shrooms_date1"         "tlfb_shrooms_calc"          "tlfb_shrooms_reg"          
# [235] "tlfb_shrooms_date2"         "tlfb_shrooms_calc_reg"      "tlfb_salvia_date1"         
# [238] "tlfb_salvia_calc"           "tlfb_salvia_reg"            "tlfb_salvia_date2"         
# [241] "tlfb_salvia_calc_reg"       "tlfb_steroids_date1"        "tlfb_steroids_calc"        
# [244] "tlfb_steroids_reg"          "tlfb_steroids_date2"        "tlfb_steroids_calc_reg"    
# [247] "tlfb_bitta_date1"           "tlfb_bitta_calc"            "tlfb_bitta_reg"            
# [250] "tlfb_bitta_date2"           "tlfb_bitta_calc_reg"        "tlfb_inhalant_date1"       
# [253] "tlfb_inhalant_calc"         "tlfb_inhalant_reg"          "tlfb_inhalant_date2"       
# [256] "tlfb_inhalant_calc_reg"     "tlfb_amp_date1"             "tlfb_amp_calc"             
# [259] "tlfb_amp_reg"               "tlfb_amp_date2"             "tlfb_amp_calc_reg"         
# [262] "tlfb_tranq_date1"           "tlfb_tranq_calc"            "tlfb_tranq_reg"            
# [265] "tlfb_tranq_date2"           "tlfb_tranq_calc_reg"        "tlfb_vicodin_date1"        
# [268] "tlfb_vicodin_calc"          "tlfb_vicodin_reg"           "tlfb_vicodin_date2"        
# [271] "tlfb_vicodin_calc_reg"      "tlfb_cough_date1"           "tlfb_cough_calc"           
# [274] "tlfb_cough_reg"             "tlfb_cough_date2"           "tlfb_cough_calc_reg"       
# [277] "tlfb_alc_lt"                "tlfb_alc_lt_dk"             "tlfb_cig_lt"               
# [280] "tlfb_cig_lt_dk"             "tlfb_ecig_lt"               "tlfb_ecig_lt_dk"           
# [283] "tlfb_ecig_lt_size"          "tlfb_ecig_lt_strength_dk"   "tlfb_ecig_lt_strength"     
# [286] "tlfb_cigar_lt"              "tlfb_cigar_lt_dk"           "tlfb_hookah_lt"            
# [289] "tlfb_hookah_lt_dk"          "tlfb_chew_lt"               "tlfb_chew_lt_dk"           
# [292] "tlfb_pipes_lt"              "tlfb_pipes_lt_dk"           "tlfb_lt_nicotine"          
# [295] "tlfb_lt_nicotine_dk"        "tlfb_mj_lt"                 "tlfb_mj_lt_dk"             
# [298] "tlfb_blunt_lt"              "tlfb_blunt_lt_dk"           "tlfb_edible_lt"            
# [301] "tlfb_edible_lt_dk"          "tlfb_edible_lt_mg_dk"       "tlfb_edible_lt_mg"         
# [304] "tlfb_mj_conc_lt"            "tlfb_mj_conc_lt_dk"         "tlfb_mj_conc_lt_1b_dk"     
# [307] "tlfb_mj_conc_lt_1b"         "tlfb_mj_conc_lt_1c___1"     "tlfb_mj_conc_lt_1c___2"    
# [310] "tlfb_mj_conc_lt_1c___3"     "tlfb_mj_conc_lt_1c___4"     "tlfb_mj_conc_lt_1c___5"    
# [313] "tlfb_mj_conc_lt_1c___6"     "tlfb_mj_conc_lt_1d"         "tlfb_mj_conc_lt_1e"        
# [316] "tlfb_mj_drink_lt"           "tlfb_mj_drink_lt_dk"        "tlfb_tincture_lt"          
# [319] "tlfb_tincture_lt_dk"        "tlfb_mj_synth_lt"           "tlfb_mj_synth_lt_dk"       
# [322] "tlfb_coc_lt"                "tlfb_coc_lt_dk"             "tlfb_bsalts_lt"            
# [325] "tlfb_bsalts_lt_dk"          "tlfb_meth_lt"               "tlfb_meth_lt_dk"           
# [328] "tlfb_mdma_lt"               "tlfb_mdma_lt_dk"            "tlfb_ket_lt"               
# [331] "tlfb_ket_lt_dk"             "tlfb_ghb_lt"                "tlfb_ghb_lt_dk"            
# [334] "tlfb_opi_lt"                "tlfb_opi_lt_dk"             "tlfb_hall_lt"              
# [337] "tlfb_hall_lt_dk"            "tlfb_shrooms_lt"            "tlfb_shrooms_lt_dk"        
# [340] "tlfb_salvia_lt"             "tlfb_salvia_lt_dk"          "tlfb_steroids_lt"          
# [343] "tlfb_steroids_lt_dk"        "tlfb_bitta_lt"              "tlfb_bitta_lt_dk"          
# [346] "tlfb_inhalant_lt"           "tlfb_inhalant_lt_dk"        "tlfb_amp_lt"               
# [349] "tlfb_amp_lt_dk"             "tlfb_tranq_lt"              "tlfb_tranq_lt_dk"          
# [352] "tlfb_vicodin_lt"            "tlfb_vicodin_lt_dk"         "tlfb_cough_lt"             
# [355] "tlfb_cough_lt_dk"           "tlfb_other_lt"              "tlfb_other_lt_dk"          
# [358] "tlfb_alc_max"               "tlfb_alc_max_dk"            "tlfb_cig_max"              
# [361] "tlfb_cig_max_dk"            "tlfb_ecig_max_dk"           "tlfb_ecig_max"             
# [364] "tlfb_chew_max"              "tlfb_chew_max_dk"           "tlfb_cigar_max"            
# [367] "tlfb_cigar_max_dk"          "tlfb_hookah_max"            "tlfb_hookah_max_dk"        
# [370] "tlfb_pipes_max"             "tlfb_pipes_max_dk"          "tlfb_nicotine_max"         
# [373] "tlfb_nicotine_max_dk"       "tlfb_mj_max"                "tlfb_mj_max_dk"            
# [376] "tlfb_blunt_max"             "tlfb_blunt_max_dk"          "tlfb_edible_max_dk"        
# [379] "tlfb_edible_max"            "tlfb_mj_conc_max_dk"        "tlfb_mj_conc_max"          
# [382] "tlfb_mj_drink_max"          "tlfb_mj_drink_max_dk"       "tlfb_tincture_max"         
# [385] "tlfb_tincture_max_dk"       "tlfb_mj_synth_max"          "tlfb_mj_synth_max_dk"      
# [388] "tlfb_coc_max"               "tlfb_coc_max_dk"            "tlfb_bsalts_max"           
# [391] "tlfb_bsalts_max_dk"         "tlfb_meth_max"              "tlfb_meth_max_dk"          
# [394] "tlfb_mdma_max"              "tlfb_mdma_max_dk"           "tlfb_ket_max"              
# [397] "tlfb_ket_max_dk"            "tlfb_ghb_max"               "tlfb_ghb_max_dk"           
# [400] "tlfb_opi_max"               "tlfb_opi_max_dk"            "tlfb_hall_max"             
# [403] "tlfb_hall_max_dk"           "tlfb_shrooms_max"           "tlfb_shrooms_max_dk"       
# [406] "tlfb_salvia_max"            "tlfb_salvia_max_dk"         "tlfb_steroids_max"         
# [409] "tlfb_steroids_max_dk"       "tlfb_bitta_max"             "tlfb_bitta_max_dk"         
# [412] "tlfb_inhalant_max"          "tlfb_inhalant_max_dk"       "tlfb_amp_max"              
# [415] "tlfb_amp_max_dk"            "tlfb_tranq_max"             "tlfb_tranq_max_dk"         
# [418] "tlfb_vicodin_max"           "tlfb_vicodin_max_dk"        "tlfb_cough_max"            
# [421] "tlfb_cough_max_dk"          "tlfb_other_max"             "tlfb_other_max_dk"         
# [424] "tlfb_alc_last"              "tlfb_alc_last_calc"         "tlfb_cig_last"             
# [427] "tlfb_cig_last_calc"         "tlfb_ecig_last"             "tlfb_ecig_last_calc"       
# [430] "tlfb_chew_last"             "tlfb_chew_last_calc"        "tlfb_cigar_last"           
# [433] "tlfb_cigar_last_calc"       "tlfb_hookah_last"           "tlfb_hookah_last_calc"     
# [436] "tlfb_pipes_last"            "tlfb_pipes_last_calc"       "tlfb_nicotine_last"        
# [439] "tlfb_nicotine_last_calc"    "tlfb_mj_last"               "tlfb_mj_last_calc"         
# [442] "tlfb_blunt_last"            "tlfb_blunt_last_calc"       "tlfb_edible_last"          
# [445] "tlfb_edible_last_calc"      "tlfb_mj_conc_last"          "tlfb_mj_conc_last_calc"    
# [448] "tlfb_mj_drink_last"         "tlfb_mj_drink_last_calc"    "tlfb_tincture_last"        
# [451] "tlfb_tincture_last_calc"    "tlfb_mj_synth_last"         "tlfb_mj_synth_last_calc"   
# [454] "tlfb_coc_last"              "tlfb_coc_last_calc"         "tlfb_bsalts_last"          
# [457] "tlfb_bsalts_last_calc"      "tlfb_meth_last"             "tlfb_meth_last_calc"       
# [460] "tlfb_mdma_last"             "tlfb_mdma_last_calc"        "tlfb_ket_last"             
# [463] "tlfb_ket_last_calc"         "tlfb_ghb_last"              "tlfb_ghb_last_calc"        
# [466] "tlfb_opi_last"              "tlfb_hall_last"             "tlfb_opi_last_calc"        
# [469] "tlfb_hall_last_calc"        "tlfb_shrooms_last"          "tlfb_shrooms_last_calc"    
# [472] "tlfb_salvia_last"           "tlfb_salvia_last_calc"      "tlfb_steroids_last"        
# [475] "tlfb_steroids_last_calc"    "tlfb_bitta_last"            "tlfb_bitta_last_calc"      
# [478] "tlfb_inhalant_last"         "tlfb_inhalant_last_calc"    "tlfb_amp_last"             
# [481] "tlfb_amp_last_calc"         "tlfb_tranq_last"            "tlfb_tranq_last_calc"      
# [484] "tlfb_vicodin_last"          "tlfb_vicodin_last_calc"     "tlfb_cough_last"           
# [487] "tlfb_cough_last_calc"       "tlfb_other_last"            "tlfb_6mo_skip___1"         
# [490] "tlfb_6mo_skip___2"          "tlfb_6mo_skip___3"          "tlfb_6mo_skip___4"         
# [493] "tlfb_6mo_skip___5"          "tlfb_6mo_skip___6"          "tlfb_6mo_skip___7"         
# [496] "tlfb_6mo_skip___8"          "tlfb_6mo_skip___9"          "tlfb_6mo_skip___10"        
# [499] "tlfb_6mo_skip___11"         "tlfb_6mo_skip___12"         "tlfb_6mo_skip___13"        
# [502] "tlfb_6mo_skip___14"         "tlfb_6mo_skip___15"         "tlfb_6mo_skip___16"        
# [505] "tlfb_6mo_skip___17"         "tlfb_6mo_skip___18"         "tlfb_6mo_skip___19"        
# [508] "tlfb_6mo_skip___20"         "tlfb_6mo_skip___21"         "tlfb_6mo_skip___22"        
# [511] "tlfb_6mo_skip___23"         "tlfb_6mo_skip___24"         "tlfb_6mo_skip___25"        
# [514] "tlfb_6mo_skip___26"         "tlfb_6mo_skip___27"         "tlfb_6mo_skip___28"        
# [517] "tlfb_6mo_skip___29"         "tlfb_6mo_skip___30"         "tlfb_6mo_skip___31"        
# [520] "tlfb_6mo_skip___32"         "tlfb_6mo_hall_use_type___1" "tlfb_6mo_hall_use_type___2"
# [523] "tlfb_6mo_hall_use_type___3" "tlfb_6mo_hall_use_type___4" "tlfb_6mo_hall_use_type___6"
# [526] "tlfb_6mo_hall_use_type___7" "tlfb_6mo_hall_use_type___8" "tlfb_6mo_hall_use_type___9"
# [529] "tlfb_6mo_1_cig"             "tlfb_6mo_1_ecig"            "tlfb_6mo_1_ecig_dk"        
# [532] "tlfb_6mo_2_ecig"            "tlfb_6mo_2_ecig_dk"         "tlfb_6mo_3_ecig"           
# [535] "tlfb_6mo_4_ecig"            "tlfb_6mo_4_mj"              "tlfb_6mo_4_mj_dk"          
# [538] "tlfb_6mo_5_mj"              "tlfb_6mo_6_mj"              "tlfb_6mo_7_mj"             
# [541] "tlfb_6mo_8_mj"              "tlfb_6mo_9_concmj"          "tlfb_6mo_9b_concmj"        
# [544] "tlfb_6mo_10_concmj"         "tlfb_6mo_10b_concmj"        "tlfb_6mo_11_concmj"        
# [547] "tlfb_6mo_12_concmj"         "tlfb_6mo_13_mj___1"         "tlfb_6mo_13_mj___2"        
# [550] "tlfb_6mo_13_mj___3"         "tlfb_6mo_13_mj___4"         "tlfb_6mo_13_mj___5"        
# [553] "tlfb_6mo_13_mj___6"         "tlfb_6mo_13_mj___7"         "tlfb_6mo_13_mj___8"        
# [556] "tlfb_6mo_13_mj___9"         "tlfb_6mo_13_mj___10"        "tlfb_6mo_13_mj___11"       
# [559] "tlfb_6mo_13_mj___12"        "tlfb_6mo_13_mj___13"        "tlfb_6mo_13_mj___14"       
# [562] "tlfb_6mo_13_mj___15"        "tlfb_6mo_13_mj___16"        "tlfb_6mo_mj_drink_type"    
# [565] "tlfb_6mo_tincture_type"     "tlfb_6mo_14_coc"            "tlfb_6mo_15_coc"           
# [568] "tlfb_6mo_16_coc"            "tlfb_6mo_17_coc"            "tlfb_6mo_18_meth"          
# [571] "tlfb_6mo_19_meth"           "tlfb_6mo_20_meth"           "tlfb_6mo_21_heroin"        
# [574] "tlfb_6mo_22_heroin"         "tlfb_6mo_23_heroin"         "xskipout_alc"              
# [577] "xskipout_tob"               "xskipout_mj"                "xskipout_other"            
# [580] "caff_intake_1"              "caff_intake_3"              "caff_intake_4"             
# [583] "caff_intake_6"              "caff_intake_9"              "caff_max"                  
# [586] "caff_max_type"              "peer_deviance_1_4bbe5d"     "peer_deviance_2_dd1457"    
# [589] "peer_deviance_3_e1ec2e"     "peer_deviance_4_b6c588"     "peer_deviance_5_bffa44"    
# [592] "peer_deviance_6_69562e"     "peer_deviance_7_beb683"     "peer_deviance_8_35702e"    
# [595] "peer_deviance_9_6dd4ef"     "path_alc_youth1"            "path_alc_youth2"           
# [598] "path_alc_youth3"            "path_alc_youth4"            "path_alc_youth5"           
# [601] "path_alc_youth6"            "path_alc_youth7"            "path_alc_youth8"           
# [604] "path_alc_youth9"            "subj_resp_alc_1a"           "subj_resp_alc_2a"          
# [607] "subj_resp_alc_3a"           "subj_resp_alc_4a"           "subj_resp_alc_1b"          
# [610] "subj_resp_alc_2b"           "subj_resp_alc_3b"           "subj_resp_alc_4b"          
# [613] "subj_resp_alc_1c"           "subj_resp_alc_2c"           "subj_resp_alc_3c"          
# [616] "subj_resp_alc_4c"           "hangover1"                  "hangover2"                 
# [619] "hangover3"                  "hangover4"                  "hangover5"                 
# [622] "hangover6"                  "hangover7"                  "hangover8"                 
# [625] "hangover9"                  "hangover10"                 "hangover11"                
# [628] "hangover12"                 "hangover13"                 "hangover14"                
# [631] "rapi_section1_q01"          "rapi_section1_q02"          "rapi_section1_q03"         
# [634] "rapi_section1_q04"          "rapi_section1_q05"          "rapi_section1_q06"         
# [637] "rapi_section1_q07"          "rapi_section2_q08"          "rapi_section2_q09"         
# [640] "rapi_section2_q10"          "rapi_section2_q11"          "rapi_section2_q12"         
# [643] "rapi_section2_q13"          "rapi_section2_q14"          "rapi_section3_q15"         
# [646] "rapi_section3_q16"          "rapi_section3_q17"          "rapi_section3_q18"         
# [649] "subj_resp_nic_q01"          "subj_resp_nic_q02"          "subj_resp_nic_q03"         
# [652] "subj_resp_nic_q04"          "subj_resp_nic_q05"          "subj_resp_nic_q06"         
# [655] "subj_resp_nic_q07"          "subj_resp_nic_q08"          "subj_resp_nic_q09"         
# [658] "path_nic_dep_q01"           "path_nic_dep_q02"           "path_nic_dep_q03"          
# [661] "path_nic_dep_q04"           "path_nic_dep_q05"           "path_nic_dep_q06"          
# [664] "path_nic_dep_q07"           "path_nic_dep_q08"           "path_nic_dep_q09"          
# [667] "path_nic_dep_q10"           "sub_res_mj_q01"             "sub_res_mj_q02"            
# [670] "sub_res_mj_q03"             "sub_res_mj_q04"             "sub_res_mj_q05"            
# [673] "sub_res_mj_q06"             "sub_res_mj_q07"             "sub_res_mj_q08"            
# [676] "sub_res_mj_q09"             "sub_res_mj_q10"             "sub_res_mj_q11"            
# [679] "mapi_q01"                   "mapi_q02"                   "mapi_q03"                  
# [682] "mapi_q04"                   "mapi_q05"                   "mapi_q06"                  
# [685] "mapi_q07"                   "mapi_q08"                   "mapi_q09"                  
# [688] "mapi_q10"                   "mapi_q11"                   "mapi_q12"                  
# [691] "mapi_q13"                   "mapi_q14"                   "mapi_q15"                  
# [694] "mapi_q16"                   "mapi_q17"                   "mapi_q18"                  
# [697] "dapi_q01"                   "dapi_q02"                   "dapi_q03"                  
# [700] "dapi_q04"                   "dapi_q05"                   "dapi_q06"                  
# [703] "dapi_q07"                   "dapi_q08"                   "dapi_q09"                  
# [706] "dapi_q10"                   "dapi_q11"                   "dapi_q12"                  
# [709] "dapi_q13"                   "dapi_q14"                   "dapi_q15"                  
# [712] "dapi_q16"                   "dapi_q17"                   "dapi_q18"                  
# [715] "eventname"                  "su_tlfb_alc_lt_calc"        "su_tlfb_cig_lt_calc"       
# [718] "su_tlfb_ecig_lt_calc"       "su_tlfb_cigar_lt_calc"      "su_tlfb_hookah_lt_calc"    
# [721] "su_tlfb_chew_lt_calc"       "su_tlfb_pipes_lt_calc"      "su_tlfb_lt_nicotine_calc"  
# [724] "su_tlfb_alc_max_calc"       "su_tlfb_cig_max_calc"       "su_tlfb_ecig_max_calc"     
# [727] "su_tlfb_cigar_max_calc"     "su_tlfb_hookah_max_calc"    "su_tlfb_chew_max_calc"     
# [730] "su_tlfb_pipes_max_calc"     "su_tlfb_nicotine_max_calc"  "su_tlfb_6mo_1_ecig_calc"   
# [733] "su_tlfb_6mo_2_ecig_calc"    "su_caff_intake_1_calc"      "su_caff_intake_3_calc"     
# [736] "su_caff_intake_4_calc"      "su_caff_intake_6_calc"      "su_caff_intake_9_calc"     
# [739] "su_caff_max_calc"           "su_tlfb_hookah_use_calc"    "su_tlfb_pipes_use_calc"    
# [742] "su_tlfb_nicotine_use_calc"  "su_tlfb_mj_puff_calc"       "su_tlfb_mj_use_calc"       
# [745] "su_tlfb_blunt_use_calc"     "su_tlfb_edible_use_calc"    "su_tlfb_mj_conc_use_calc"  
# [748] "su_tlfb_mj_drink_use_calc"  "su_tlfb_tincture_use_calc"  "su_tlfb_mj_synth_use_calc" 
# [751] "su_tlfb_coc_use_calc"       "su_tlfb_bsalts_use_calc"    "su_tlfb_meth_use_calc"     
# [754] "su_tlfb_mdma_use_calc"      "su_tlfb_ket_use_calc"       "su_tlfb_ghb_use_calc"      
# [757] "su_tlfb_opi_use_calc"       "su_tlfb_hall_use_calc"      "su_tlfb_shrooms_use_calc"  
# [760] "su_tlfb_alc_sip_calc"       "su_tlfb_salvia_use_calc"    "su_tlfb_steroids_use_calc" 
# [763] "su_tlfb_bitta_use_calc"     "su_tlfb_inhalant_use_calc"  "su_tlfb_amp_use_calc"      
# [766] "su_tlfb_tranq_use_calc"     "su_tlfb_vicodin_use_calc"   "su_tlfb_cough_use_calc"    
# [769] "su_tlfb_other_use_calc"     "su_tlfb_alc_use_calc"       "su_tlfb_tob_puff_calc"     
# [772] "su_tlfb_cig_use_calc"       "su_tlfb_ecig_use_calc"      "su_tlfb_chew_use_calc"     
# [775] "su_tlfb_cigar_use_calc"     "collection_title"           "study_cohort_name"  
y_subuse_base = y_subuse_base[,-c(1:3, 5:34, 41:44, 53:87, 89, 90, 92:98, 102, 104:107, 110,
                                  113:114, 116:117, 119, 121:122, 124, 127, 129:148, 152:157, 
                                  160, 162, 165, 167, 170, 172, 175, 177, 180, 182, 185, 187, 
                                  190, 192:488, 492:496, 503:537, 543, 545, 548:575, 579:777)]

colnames(y_subuse_base)
# [1] "subjectkey"             "tlfb_alc_sip"           "tlfb_alc_use"           "tlfb_tob_puff"         
# [5] "tlfb_cig_use"           "tlfb_ecig_use"          "tlfb_chew_use"          "tlfb_mj_puff"          
# [9] "tlfb_mj_use"            "tlfb_blunt_use"         "tlfb_edible_use"        "tlfb_mj_conc_use"      
# [13] "tlfb_mj_drink_use"      "tlfb_tincture_use"      "tlfb_mj_synth_use"      "isip_1"                
# [17] "isip_1b_2"              "tlfb_alc_date1"         "tlfb_alc_calc"          "tlfb_alc_reg"          
# [21] "tlfb_alc_calc_reg"      "first_nicotine_5"       "first_nicotine_6"       "first_nicotine_11"     
# [25] "first_nicotine_12"      "tlfb_cig_calc"          "tlfb_cig_calc_reg"      "tlfb_ecig_calc"        
# [29] "tlfb_ecig_calc_reg"     "tlfb_chew_calc"         "tlfb_chew_reg"          "tlfb_chew_calc_reg"    
# [33] "first_mj_1b"            "first_mj_1a"            "first_mj_3"             "tlfb_mj_calc"          
# [37] "tlfb_mj_reg"            "tlfb_mj_calc_reg"       "tlfb_blunt_calc"        "tlfb_blunt_reg"        
# [41] "tlfb_blunt_calc_reg"    "tlfb_edible_calc"       "tlfb_edible_reg"        "tlfb_edible_calc_reg"  
# [45] "tlfb_mj_conc_calc"      "tlfb_mj_conc_reg"       "tlfb_mj_conc_calc_reg"  "xcalc_mj_drink"        
# [49] "tlfb_mj_drink_reg"      "tlfb_mj_drink_calc_reg" "tlfb_tincture_calc"     "tlfb_tincture_reg"     
# [53] "tlfb_tincture_calc_reg" "tlfb_mj_synth_calc"     "tlfb_mj_synth_reg"      "tlfb_mj_synth_calc_reg"
# [57] "tlfb_6mo_skip___1"      "tlfb_6mo_skip___2"      "tlfb_6mo_skip___3"      "tlfb_6mo_skip___9"     
# [61] "tlfb_6mo_skip___10"     "tlfb_6mo_skip___11"     "tlfb_6mo_skip___12"     "tlfb_6mo_skip___13"    
# [65] "tlfb_6mo_skip___14"     "tlfb_6mo_5_mj"          "tlfb_6mo_6_mj"          "tlfb_6mo_7_mj"         
# [69] "tlfb_6mo_8_mj"          "tlfb_6mo_9_concmj"      "tlfb_6mo_10_concmj"     "tlfb_6mo_11_concmj"    
# [73] "tlfb_6mo_12_concmj"     "xskipout_alc"           "xskipout_tob"           "xskipout_mj"           

#Rename variables
names(y_subuse_base)[names(y_subuse_base) == "subjectkey"] = "id"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_alc_sip"] = "alc_sip.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_alc_use"] = "alc_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_tob_puff"] = "tob_puff.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_cig_use"] = "cig_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_ecig_use"] = "ecig_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_chew_use"] = "chew_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_puff"] = "mj_puff.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_use"] = "mj_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_blunt_use"] = "blunt_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_edible_use"] = "edible_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_conc_use"] = "mj_conc_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_drink_use"] = "mj_drink_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_tincture_use"] = "tincture_use.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_synth_use"] = "mj_synth_use.0"
names(y_subuse_base)[names(y_subuse_base) == "isip_1"] = "total_sip.0"
names(y_subuse_base)[names(y_subuse_base) == "isip_1d_2"] = "age_sip.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_alc_calc"] = "alcohol_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_alc_reg"] = "reg_alcohol.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_alc_calc_reg"] = "regulalcohol_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "first_nicotine_5"] = "age_puff.0"
names(y_subuse_base)[names(y_subuse_base) == "first_nicotine_6"] = "cont_puff.0"
names(y_subuse_base)[names(y_subuse_base) == "first_nicotine_11"] = "age_chew.0"
names(y_subuse_base)[names(y_subuse_base) == "first_nicotine_12"] = "cont_chew.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_cig_calc"] = "cig_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_cig_calc_reg"] = "cigregul_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_ecig_calc"] = "ecig_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_ecig_calc_reg"] = "ecigreful_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_chew_calc"] = "chew_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_chew_reg"] = "regul_chew.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_chew_calc_reg"] = "regulchew_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "first_mj_1b"] = "total_mjpuff.0"
names(y_subuse_base)[names(y_subuse_base) == "first_mj_1a"] = "age_mjpuff.0"
names(y_subuse_base)[names(y_subuse_base) == "first_mj_3"] = "cont_mjpuff.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_calc"] = "mj_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_reg"] = "regul_mj.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_calc_reg"] = "regulmj_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_blunt_calc"] = "blunt_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_blunt_reg"] = "regul_blunt.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_blunt_calc_reg"] = "regulblunt_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_edible_calc"] = "edible_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_edible_reg"] = "regul_edible.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_edible_calc_reg"] = "reguledible_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_conc_calc"] = "mjconc_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_conc_reg"] = "regul_mjconc.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_conc_calc_reg"] = "regulmjconc_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_drink_reg"] = "regul_mjdrink.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_drink_calc_reg"] = "regulmjdrink_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_tincture_calc"] = "tincture_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_tincture_reg"] = "regul_tincture.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_tincture_calc_reg"] = "regultincture_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_synth_calc"] = "mjsynth_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_synth_reg"] = "regul_mjsynth"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_mj_synth_calc_reg"] = "regulmjsynth_onset.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___1"] = "6mo_alcohol.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___2"] = "6mo_tobacco.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___3"] = "6mo_ecig.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___9"] = "6mo_mj.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___10"] = "6mo_blunt.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___11"] = "6mo_edible.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___12"] = "6mo_mjconc.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___13"] = "6mo_mjdrink.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_skip___14"] = "6mo_tincture.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_5_mj"] = "6mo_mj_potent.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_6_mj"] = "6mo_mj_highpotent.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_7_mj"] = "6mo_mj_high.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_8_mj"] = "6mo_mjvhigh.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_9_concmj"] = "6mo_type_mjconc.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_10_concmj"] = "6mo_mj_route.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_11_concmj"] = "6mo_mjconc_potent.0"
names(y_subuse_base)[names(y_subuse_base) == "tlfb_6mo_12_concmj"] = "6mo_mjconc_hpotent.0"
names(y_subuse_base)[names(y_subuse_base) == "xskipout_alc"] = "6mo_totalalcohol.0"
names(y_subuse_base)[names(y_subuse_base) == "xskipout_tob"] = "6mo_totalcig.0"
names(y_subuse_base)[names(y_subuse_base) == "xskipout_mj"] = "6mo_totalmj.0"

colnames(y_subuse_base)
# [1] "id"                    "alc_sip.0"             "alc_use.0"             "tob_puff.0"           
# [5] "cig_use.0"             "ecig_use.0"            "chew_use.0"            "mj_puff.0"            
# [9] "mj_use.0"              "blunt_use.0"           "edible_use.0"          "mj_conc_use.0"        
# [13] "mj_drink_use.0"        "tincture_use.0"        "mj_synth_use.0"        "total_sip.0"          
# [17] "isip_1b_2"             "tlfb_alc_date1"        "alcohol_onset.0"       "reg_alcohol.0"        
# [21] "regulalcohol_onset.0"  "age_puff.0"            "cont_puff.0"           "age_chew.0"           
# [25] "cont_chew.0"           "cig_onset.0"           "cigregul_onset.0"      "ecig_onset.0"         
# [29] "ecigreful_onset.0"     "chew_onset.0"          "regul_chew.0"          "regulchew_onset.0"    
# [33] "total_mjpuff.0"        "age_mjpuff.0"          "cont_mjpuff.0"         "mj_onset.0"           
# [37] "regul_mj.0"            "regulmj_onset.0"       "blunt_onset.0"         "regul_blunt.0"        
# [41] "regulblunt_onset.0"    "edible_onset.0"        "regul_edible.0"        "reguledible_onset.0"  
# [45] "mjconc_onset.0"        "regul_mjconc.0"        "regulmjconc_onset.0"   "xcalc_mj_drink"       
# [49] "regul_mjdrink.0"       "regulmjdrink_onset.0"  "tincture_onset.0"      "regul_tincture.0"     
# [53] "regultincture_onset.0" "mjsynth_onset.0"       "regul_mjsynth"         "regulmjsynth_onset.0" 
# [57] "6mo_alcohol.0"         "6mo_tobacco.0"         "6mo_ecig.0"            "6mo_mj.0"             
# [61] "6mo_blunt.0"           "6mo_edible.0"          "6mo_mjconc.0"          "6mo_mjdrink.0"        
# [65] "6mo_tincture.0"        "6mo_mj_potent.0"       "6mo_mj_highpotent.0"   "6mo_mj_high.0"        
# [69] "6mo_mjvhigh.0"         "6mo_type_mjconc.0"     "6mo_mj_route.0"        "6mo_mjconc_potent.0"  
# [73] "6mo_mjconc_hpotent.0"  "6mo_totalalcohol.0"    "6mo_totalcig.0"        "6mo_totalmj.0"    

y_subuse_base = y_subuse_base[,-c(18)]

table(y_subuse_base$mj_use.0, useNA = "ifany")
#           0     1 
# 11864     7     5 

#Rescale variables so "" is NA
colnames(y_subuse_base)
y_subuse_base[, c(2:75)][y_subuse_base[, c(2:75)] == ""] <- NA
y_subuse_base[, c(2:75)][y_subuse_base[, c(2:75)] == 999] <- NA

table(y_subuse_base$mj_use.0, useNA = "ifany")
#   0     1  <NA> 
#   7     5 11864 

#Change character to numeric
y_subuse_base[,c(2:75)]<-as.data.frame(apply(y_subuse_base[,c(2:75)],2,as.numeric))

#check class
sapply(y_subuse_base,class)


#ABCD Parent Community Risk and Protective Factors- SU ---- 

Parent_CRPF=read.delim(file("abcd_crpf01.txt"))
Parent_CRPF = Parent_CRPF[-c(1),]
dim(Parent_CRPF)
#[1] 39766    25

colnames(Parent_CRPF)
# [1] "collection_id"          "abcd_crpf01_id"         "dataset_id"            
# [4] "subjectkey"             "src_subject_id"         "interview_date"        
# [7] "interview_age"          "sex"                    "eventname"             
# [10] "su_select_language___1" "su_risk_p_1"            "su_risk_p_2"           
# [13] "su_risk_p_3"            "su_risk_p_4"            "su_risk_p_5"           
# [16] "su_risk_p_6"            "su_risk_p_7"            "su_risk_p_8"           
# [19] "su_risk_p_9"            "su_risk_p_10"           "su_risk_p_11"          
# [22] "su_risk_p_12"           "su_risk_p_13"           "collection_title"      
# [25] "study_cohort_name"    

#Remove variables that will not be included for analysis
Parent_CRPF= Parent_CRPF[,-c(1:3,5,6:8,10,15:25)]

colnames(Parent_CRPF)
# [1] "subjectkey"  "eventname"   "su_risk_p_1" "su_risk_p_2" "su_risk_p_3" "su_risk_p_4"

#Rename variables
names(Parent_CRPF)[names(Parent_CRPF) == "subjectkey"] = "id"
names(Parent_CRPF)[names(Parent_CRPF) == "eventname"] = "timepoint"
names(Parent_CRPF)[names(Parent_CRPF) == "su_risk_p_1"] = "p_crpf_alcohol"
names(Parent_CRPF)[names(Parent_CRPF) == "su_risk_p_2"] = "p_crpf_cigarettes"
names(Parent_CRPF)[names(Parent_CRPF) == "su_risk_p_3"] = "p_crpf_vaping"
names(Parent_CRPF)[names(Parent_CRPF) == "su_risk_p_4"] = "p_crpf_marijuana"

colnames(Parent_CRPF)
# [1] "id"         "timepoint"  "alcohol"    "cigarettes" "vaping"     "marijuana" 

table(Parent_CRPF$alcohol, useNA = "ifany")
#       0     1     2     3     4 
# 227 18677  4295  5788  9286  1493

table(Parent_CRPF$vaping, useNA = "ifany")
#         0     1     2     3     4 
# 227 31704  3531  1292   603  2409 

#0 = Very hard
#1 = Sort of hard
#2 = Sort of easy 
#3 = Very easy 
#4 = Don't know

#Rescale variables make "" into NA
Parent_CRPF[,c(3:6)][Parent_CRPF[,c(3:6)] == ""]<- NA
Parent_CRPF[,c(3:6)][Parent_CRPF[,c(3:6)] == 999]<- NA
Parent_CRPF[,c(3:6)][Parent_CRPF[,c(3:6)] == 4]<- NA

#Check if NAs have been changed
table(Parent_CRPF$alcohol,useNA= "ifany")
#       0     1     2     3  <NA> 
#   18677  4295  5788  9286  1720 

summary(Parent_CRPF$alcohol)
#display classes of columns
sapply(Parent_CRPF,class)

#Change character to numeric
Parent_CRPF[,c(3:6)]<-as.data.frame(apply(Parent_CRPF[,c(3:6)],2,as.numeric))

#check class
sapply(Parent_CRPF,class)

table(Parent_CRPF$timepoint,useNA= "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                    10414                     6251 
# baseline_year_1_arm_1 
# 11876 

#Lable Timepoint data
Parent_CRPF[which(Parent_CRPF$timepoint == "1_year_follow_up_y_arm_1"),"timepoint"] = 1
Parent_CRPF[which(Parent_CRPF$timepoint == "2_year_follow_up_y_arm_1"),"timepoint"] = 2
Parent_CRPF[which(Parent_CRPF$timepoint == "3_year_follow_up_y_arm_1"),"timepoint"] = 3
Parent_CRPF[which(Parent_CRPF$timepoint == "baseline_year_1_arm_1"),"timepoint"] = 0

table(Parent_CRPF$timepoint,useNA= "ifany")
# 0     1     2     3 
# 11876 11225 10414  6251 

#Double check that no additional variable was made
colnames(Parent_CRPF)
#[1] "id"         "timepoint"  "alcohol"    "cigarettes" "vaping"     "marijuana" 

#Reshape data to wide
library(reshape)
Parent_CRPF_wide= reshape(Parent_CRPF, idvar="id",timevar = "timepoint", direction = "wide")

colnames(Parent_CRPF_wide)
# [1] "id"           "alcohol.0"    "cigarettes.0" "vaping.0"     "marijuana.0"  "alcohol.1"    "cigarettes.1"
# [8] "vaping.1"     "marijuana.1"  "alcohol.2"    "cigarettes.2" "vaping.2"     "marijuana.2"  "alcohol.3"   
# [15] "cigarettes.3" "vaping.3"     "marijuana.3" 

#check class
sapply(Parent_CRPF_wide,class)

#summary scores (na.rm=T would only calculate the scores for the participants you have)
Parent_CRPF_wide$total_pcrpf.0 = round(rowMeans(Parent_CRPF_wide[,c(2,3,4,5)], na.rm=T))
Parent_CRPF_wide$total_pcrpf.1 = round(rowMeans(Parent_CRPF_wide[,c(6,7,8,9)], na.rm=T))
Parent_CRPF_wide$total_pcrpf.2 = round(rowMeans(Parent_CRPF_wide[,c(10,11,12,13)], na.rm=T))
Parent_CRPF_wide$total_pcrpf.3 = round(rowMeans(Parent_CRPF_wide[,c(14,15,16,17)], na.rm=T))

colnames(Parent_CRPF_wide)

table(Parent_CRPF_wide$total_pcrpf.0, useNA = "ifany")
#    0    1    2    3  NaN 
# 8177 2524  543  178  454 

#ABCD Youth Community Risk and Protective Factors- SU ---- 

##Ad path and File name
Youth_CRPF=read.delim(file("abcd_ycrpf01.txt"))
Youth_CRPF = Youth_CRPF[-c(1),]
dim(Youth_CRPF)
#[1] 16665    26

colnames(Youth_CRPF)
# [1] "collection_id"     "abcd_ycrpf01_id"   "dataset_id"        "subjectkey"        "src_subject_id"   
# [6] "interview_date"    "interview_age"     "sex"               "eventname"         "su_crpf_avail_1"  
# [11] "su_crpf_avail_2"   "su_crpf_avail_3"   "su_crpf_avail_4"   "su_crpf_avail_6"   "su_crpf_avail_7"  
# [16] "su_crpf_avail_8"   "su_crpf_avail_9"   "su_crpf_avail_5"   "su_crpf_avail_10"  "su_crpf_avail_11" 
# [21] "su_crpf_avail_12"  "su_crpf_avail_13"  "crpf_admin"        "crpf_device"       "collection_title" 
# [26] "study_cohort_name"

#Remove variables that will not be included for analysis
Youth_CRPF= Youth_CRPF[,-c(1:3,5,6:8,14:26)]

colnames(Youth_CRPF)
#[1] "subjectkey"      "eventname"       "su_crpf_avail_1" "su_crpf_avail_2" "su_crpf_avail_3" "su_crpf_avail_4"

#Rename variables
names(Youth_CRPF)[names(Youth_CRPF) == "subjectkey"] = "id"
names(Youth_CRPF)[names(Youth_CRPF) == "eventname"] = "timepoint"
names(Youth_CRPF)[names(Youth_CRPF) == "su_crpf_avail_1"] = "y_crpf_alcohol"
names(Youth_CRPF)[names(Youth_CRPF) == "su_crpf_avail_2"] = "y_crpf_cigarettes"
names(Youth_CRPF)[names(Youth_CRPF) == "su_crpf_avail_3"] = "y_crpf_vaping"
names(Youth_CRPF)[names(Youth_CRPF) == "su_crpf_avail_4"] = "y_crpf_marijuana"

colnames(Youth_CRPF)
# [1] "id"         "timepoint"  "alcohol"    "cigarettes" "vaping"     "marijuana" 

table(Youth_CRPF$y_crpf_alcohol, useNA = "ifany")
#       1    2    3    4  999 
# 134 8207 2650 1677  807 3190 

#1 = Very hard
#2 = Sort of hard
#3 = Sort of easy 
#4 = Very easy 
#999 = Don't know

colnames(Youth_CRPF)

#Rescale variables so there is a true 0 
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == 1]<- 0
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == 2]<- 1
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == 3]<- 2
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == 4]<- 3

table(Youth_CRPF$alcohol, useNA = "ifany")
#       0    1    2    3  999 
# 134 8207 2650 1677  807 3190 

#0 = Very hard
#1 = Sort of hard
#2 = Sort of easy 
#3 = Very easy 
#999 = Don't know

#Rescale variables make "" into NA
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == ""]<- NA
Youth_CRPF[,c(3:6)][Youth_CRPF[,c(3:6)] == 999]<- NA

#Check if NAs have been changed
table(Youth_CRPF$alcohol,useNA= "ifany")
#     0    1    2    3 <NA> 
#   8207 2650 1677  807 3324 

summary(Youth_CRPF$alcohol)
#display classes of columns
sapply(Youth_CRPF,class) # All characters

#Change character to numeric
Youth_CRPF[,c(3:6)]<-as.data.frame(apply(Youth_CRPF[,c(3:6)],2,as.numeric))

#check class
sapply(Youth_CRPF,class)
# id          timepoint      alcohol   cigarettes     vaping   marijuana 
# "character" "character"   "numeric"   "numeric"   "numeric"   "numeric" 

table(Youth_CRPF$timepoint,useNA= "ifany")
# 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 10414                     6251 

#Lable Timepoint data
Youth_CRPF[which(Youth_CRPF$timepoint == "2_year_follow_up_y_arm_1"),"timepoint"] = 2
Youth_CRPF[which(Youth_CRPF$timepoint == "3_year_follow_up_y_arm_1"),"timepoint"] = 3

#Sample Sizes
table(Youth_CRPF$timepoint,useNA= "ifany")
# 2     3 
# 10414  6251 

#Double check that no additional variable was made
colnames(Youth_CRPF)

#Reshape data to wide
library(reshape)
Youth_CRPF_wide= reshape(Youth_CRPF, idvar="id",timevar = "timepoint", direction = "wide")

colnames(Youth_CRPF_wide)
# [1] "id"           "alcohol.3"    "cigarettes.3" "vaping.3"     "marijuana.3"  "alcohol.2"    "cigarettes.2"
# [8] "vaping.2"     "marijuana.2" 

#summary scores (na.rm=T would only calculate the scores for the participants you have)
Youth_CRPF_wide$total_ycrpf.2 = round(rowMeans(Youth_CRPF_wide[,c(6,7,8,9)], na.rm=T))
Youth_CRPF_wide$total_ycrpf.3 = round(rowMeans(Youth_CRPF_wide[,c(2,3,4,5)], na.rm=T))

colnames(Youth_CRPF_wide)

table(Youth_CRPF_wide$total_ycrpf.2, useNA = "ifany")
#   0    1    2    3  NaN 
# 6397 1675  923  166 1361 


#ABCD Multidimension Neglectful Behavior Scale- SU (cannot use measure, only 3 year available too much missing) ---- 

#Add path and file name
neg_behav  = read.delim(file("neglectful_behavior01.txt"))
neg_behav = neg_behav[-c(1),]
dim(neg_behav) 
# [1] 33515   964

colnames(neg_behav)




#ABCD Parent Survey of Substance Use Density, Storage, and Exposure- SU ---- 

#ABCD Parental Rules on Substance Use- SU ---- 

#ABCD Youth Substance Use Introduction and Patterns- SU ---- 

#Add path and file name
y_subuse  = read.delim(file("abcd_ysuip01.txt"))
y_subuse = y_subuse[-c(1),]
dim(y_subuse) 
# [1] 27890   377

colnames(y_subuse)
# [1] "collection_id"                  "abcd_ysuip01_id"                "dataset_id"                    
# [4] "subjectkey"                     "src_subject_id"                 "interview_age"                 
# [7] "interview_date"                 "sex"                            "eventname"                     
# [10] "tlfb_age_l"                     "tlfb_age_month_l"               "tlfb_age_calc_inmonths_l"      
# [13] "tlfb_alc_l"                     "tlfb_tob_l"                     "tlfb_mj_l"                     
# [16] "tlfb_mj_synth_l"                "tlfb_bitta_l"                   "tlfb_caff_l"                   
# [19] "tlfb_inhalant_l"                "tlfb_rx_misuse_l"               "tlfb_list_yes_no_l"            
# [22] "tlfb_list_l___1"                "tlfb_list_l___2"                "tlfb_list_l___3"               
# [25] "tlfb_list_l___4"                "tlfb_list_l___5"                "tlfb_list_l___6"               
# [28] "tlfb_list_l___7"                "tlfb_list_l___8"                "tlfb_list_l___9"               
# [31] "tlfb_list_l___10"               "tlfb_list_l___11"               "tlfb_list_l___12"              
# [34] "tlfb_list_l___18"               "tlfb_alc_sip_l"                 "tlfb_alc_use_l"                
# [37] "tlfb_tob_puff_l"                "tlfb_cig_use_l"                 "tlfb_ecig_use_l"               
# [40] "tlfb_chew_use_l"                "tlfb_cigar_use_l"               "tlfb_hookah_use_l"             
# [43] "tlfb_pipes_use_l"               "tlfb_nicotine_use_l"            "tlfb_mj_puff_l"                
# [46] "tlfb_mj_use_l"                  "tlfb_blunt_use_l"               "tlfb_edible_use_l"             
# [49] "tlfb_mj_conc_use_l"             "tlfb_mj_drink_use_l"            "tlfb_tincture_use_l"           
# [52] "tlfb_mj_synth_use_l"            "tlfb_coc_use_l"                 "tlfb_bsalts_use_l"             
# [55] "tlfb_meth_use_l"                "tlfb_mdma_use_l"                "tlfb_ket_use_l"                
# [58] "tlfb_ghb_use_l"                 "tlfb_opi_use_l"                 "tlfb_lsd_use_l"                
# [61] "tlfb_lsd_use_type_l___1"        "tlfb_lsd_use_type_l___2"        "tlfb_lsd_use_type_l___3"       
# [64] "tlfb_lsd_use_type_l___4"        "tlfb_lsd_use_type_l___6"        "tlfb_lsd_use_type_l___7"       
# [67] "tlfb_lsd_use_type_l___8"        "tlfb_lsd_use_type_l___10"       "tlfb_shrooms_use_l"            
# [70] "tlfb_salvia_use_l"              "tlfb_steroids_use_l"            "tlfb_bitta_use_l"              
# [73] "tlfb_inhalant_use_l"            "tlfb_inhalant_use_type_l___1"   "tlfb_inhalant_use_type_l___2"  
# [76] "tlfb_inhalant_use_type_l___3"   "tlfb_inhalant_use_type_l___4"   "tlfb_inhalant_use_type_l___5"  
# [79] "tlfb_inhalant_use_type_l___6"   "tlfb_inhalant_use_type_l___7"   "tlfb_inhalant_use_type_l___8"  
# [82] "tlfb_amp_use_l"                 "tlfb_tranq_use_l"               "tlfb_vicodin_use_l"            
# [85] "tlfb_cough_use_l"               "tlfb_other_use_l"               "isip_1_l"                      
# [88] "su_isip_1_calc_l"               "isip_1b_yn_l"                   "isip_1b_l"                     
# [91] "su_isip_1b_calc_l"              "isip_1d_l"                      "isip_2_l"                      
# [94] "isip_3_l"                       "isip_4_l"                       "isip_5_l"                      
# [97] "isip_6_l"                       "first_nicotine_1_l"             "first_nicotine_1b"             
# [100] "su_first_nicotine_1b_calc"      "first_nicotine_2_l"             "first_nicotine_5_l"            
# [103] "first_nicotine_6_l"             "first_nicotine_7_l"             "first_nicotine_3_l"            
# [106] "first_nicotine_4_l"             "first_nicotine_11_l"            "first_nicotine_12_l"           
# [109] "first_nicotine_13_l"            "first_mj_1b_l"                  "first_mj_1a_l"                 
# [112] "first_mj_3_l"                   "first_mj_4_l"                   "first_mj_5_l"                  
# [115] "first_mj_6_l"                   "first_mj_7_l"                   "first_mj_8_l"                  
# [118] "tlfb_alc_first_use"             "tlfb_alc_date1_l"               "tlfb_alc_calc_l"               
# [121] "tlfb_cig_first_use"             "tlfb_cig_date1_l"               "tlfb_cig_calc_l"               
# [124] "tlfb_ecig_first_use"            "tlfb_ecig_date1_l"              "tlfb_ecig_calc_l"              
# [127] "tlfb_chew_first_use"            "tlfb_chew_date1_l"              "tlfb_chew_calc_l"              
# [130] "tlfb_cigar_first_use"           "tlfb_cigar_date1_l"             "tlfb_cigar_calc_l"             
# [133] "tlfb_hookah_first_use"          "tlfb_hookah_date1_l"            "tlfb_hookah_calc_l"            
# [136] "tlfb_pipes_first_use"           "tlfb_pipes_date1_l"             "tlfb_pipes_calc_l"             
# [139] "tlfb_nicotine_first_use"        "tlfb_nicotine_date1_l"          "tlfb_nicotine_calc_l"          
# [142] "tlfb_mj_first_use"              "tlfb_mj_date1_l"                "tlfb_mj_calc_l"                
# [145] "tlfb_blunt_first_use"           "tlfb_blunt_date1_l"             "tlfb_blunt_calc_l"             
# [148] "tlfb_edible_first_use"          "tlfb_edible_date1_l"            "tlfb_edible_calc_l"            
# [151] "tlfb_mj_con_first_use"          "tlfb_mj_conc_date1_l"           "tlfb_mj_conc_calc_l"           
# [154] "tlfb_mj_drink_first_use"        "tlfb_mj_drink_date1_l"          "tlfb_mj_drink_calc_l"          
# [157] "tlfb_tincture_first_use"        "tlfb_tincture_date1_l"          "tlfb_tincture_calc_l"          
# [160] "tlfb_mj_synth_first_use"        "tlfb_mj_synth_date1_l"          "tlfb_mj_synth_calc_l"          
# [163] "tlfb_coc_first_use"             "tlfb_coc_date1_l"               "tlfb_coc_calc_l"               
# [166] "tlfb_bsalts_first_use"          "tlfb_bsalts_date1_l"            "tlfb_bsalts_calc_l"            
# [169] "tlfb_meth_first_use"            "tlfb_meth_date1_l"              "tlfb_meth_calc_l"              
# [172] "tlfb_mdma_first_use"            "tlfb_mdma_date1_l"              "tlfb_mdma_calc_l"              
# [175] "tlfb_ket_first_use"             "tlfb_ket_date1_l"               "tlfb_ket_calc_l"               
# [178] "tlfb_ghb_first_use"             "tlfb_ghb_date1_l"               "tlfb_ghb_calc_l"               
# [181] "tlfb_opi_first_use"             "tlfb_opi_date1_l"               "tlfb_opi_calc_l"               
# [184] "tlfb_hall_first_use"            "tlfb_hall_date1_l"              "tlfb_hall_calc_l"              
# [187] "tlfb_shrooms_first_use"         "tlfb_shrooms_date1_l"           "tlfb_shrooms_calc_l"           
# [190] "tlfb_salvia_first_use"          "tlfb_salvia_date1_l"            "tlfb_salvia_calc_l"            
# [193] "tlfb_steroids_first_use"        "tlfb_steroids_date1_l"          "tlfb_steroids_calc_l"          
# [196] "tlfb_bitta_first_use"           "tlfb_bitta_date1_l"             "tlfb_bitta_calc_l"             
# [199] "tlfb_inhalant_first_use"        "tlfb_inhalant_date1_l"          "tlfb_inhalant_calc_l"          
# [202] "tlfb_amp_first_use"             "tlfb_amp_date1_l"               "tlfb_amp_calc_l"               
# [205] "tlfb_tranq_first_use"           "tlfb_tranq_date1_l"             "tlfb_tranq_calc_l"             
# [208] "tlfb_vicodin_first_use"         "tlfb_vicodin_date1_l"           "tlfb_vicodin_calc_l"           
# [211] "tlfb_cough_first_use"           "tlfb_cough_date1_l"             "tlfb_cough_calc_l"             
# [214] "tlfb_other_first_use"           "tlfb_other_name_date1_l"        "tlfb_other_name_calc_l"        
# [217] "tlfb_6mo_skip_l___1"            "tlfb_6mo_skip_l___2"            "tlfb_6mo_skip_l___3"           
# [220] "tlfb_6mo_skip_l___4"            "tlfb_6mo_skip_l___5"            "tlfb_6mo_skip_l___6"           
# [223] "tlfb_6mo_skip_l___7"            "tlfb_6mo_skip_l___8"            "tlfb_6mo_skip_l___9"           
# [226] "tlfb_6mo_skip_l___10"           "tlfb_6mo_skip_l___11"           "tlfb_6mo_skip_l___12"          
# [229] "tlfb_6mo_skip_l___13"           "tlfb_6mo_skip_l___14"           "tlfb_6mo_skip_l___15"          
# [232] "tlfb_6mo_skip_l___16"           "tlfb_6mo_skip_l___17"           "tlfb_6mo_skip_l___18"          
# [235] "tlfb_6mo_skip_l___19"           "tlfb_6mo_skip_l___20"           "tlfb_6mo_skip_l___21"          
# [238] "tlfb_6mo_skip_l___22"           "tlfb_6mo_skip_l___23"           "tlfb_6mo_skip_l___24"          
# [241] "tlfb_6mo_skip_l___25"           "tlfb_6mo_skip_l___26"           "tlfb_6mo_skip_l___27"          
# [244] "tlfb_6mo_skip_l___28"           "tlfb_6mo_skip_l___29"           "tlfb_6mo_skip_l___30"          
# [247] "tlfb_6mo_skip_l___31"           "tlfb_6mo_skip_l___32"           "tlfb_6mo_lsd_use_type_l___1"   
# [250] "tlfb_6mo_lsd_use_type_l___2"    "tlfb_6mo_lsd_use_type_l___3"    "tlfb_6mo_lsd_use_type_l___4"   
# [253] "tlfb_6mo_lsd_use_type_l___6"    "tlfb_6mo_lsd_use_type_l___7"    "tlfb_6mo_lsd_use_type_l___8"   
# [256] "tlfb_6mo_lsd_use_type_l___9"    "xskipout_alc_l"                 "xskipout_tob_l"                
# [259] "xskipout_mj_l"                  "xskipout_other_l"               "tlfb_6mo_1_cig_l"              
# [262] "tlfb_6mo_1_ecig_l"              "tlfb_6mo_1_ecig_dk_l"           "su_tlfb_6mo_1_ecig_calc_l"     
# [265] "tlfb_6mo_2_ecig_l"              "tlfb_6mo_2_ecig_dk_l"           "su_tlfb_6mo_2_ecig_calc_l"     
# [268] "tlfb_6mo_3_ecig_l"              "tlfb_6mo_4_ecig_l"              "su_tlfb_past_yr_ecig_5_l"      
# [271] "su_tlfb_past_yr_ecig_6_l"       "su_tlfb_past_yr_prim_3_mj_l"    "tlfb_6mo_4_mj_l"               
# [274] "tlfb_6mo_4_mj_dk_l"             "tlfb_6mo_5_mj_l"                "tlfb_6mo_6_mj_l"               
# [277] "tlfb_6mo_7_mj_l"                "tlfb_6mo_8_mj_l"                "tlfb_6mo_9_concmj_l"           
# [280] "tlfb_6mo_10_concmj_l"           "tlfb_6mo_11_concmj_l"           "tlfb_6mo_12_concmj_l"          
# [283] "tlfb_6mo_13_mj_l___1"           "tlfb_6mo_13_mj_l___2"           "tlfb_6mo_13_mj_l___3"          
# [286] "tlfb_6mo_13_mj_l___4"           "tlfb_6mo_13_mj_l___5"           "tlfb_6mo_13_mj_l___6"          
# [289] "tlfb_6mo_13_mj_l___7"           "tlfb_6mo_13_mj_l___8"           "tlfb_6mo_13_mj_l___9"          
# [292] "tlfb_6mo_13_mj_l___10"          "tlfb_6mo_13_mj_l___11"          "tlfb_6mo_13_mj_l___12"         
# [295] "tlfb_6mo_13_mj_l___13"          "tlfb_6mo_13_mj_l___14"          "tlfb_6mo_13_mj_l___15"         
# [298] "tlfb_6mo_13_mj_l___16"          "su_tlfb_past_yr_mj_edible_l"    "tlfb_6mo_mj_drink_type_l"      
# [301] "tlfb_6mo_tincture_type_l"       "tlfb_6mo_14_coc_l"              "tlfb_6mo_15_coc_l"             
# [304] "tlfb_6mo_16_coc_l"              "tlfb_6mo_17_coc_l"              "tlfb_6mo_18_meth_l"            
# [307] "tlfb_6mo_19_meth_l"             "tlfb_6mo_20_meth_l"             "tlfb_6mo_21_heroin_l"          
# [310] "tlfb_6mo_22_heroin_l"           "tlfb_6mo_23_heroin_l"           "caff_intake_1_l"               
# [313] "su_caff_intake_1_calc_l"        "caff_intake_3_l"                "su_caff_intake_3_calc_l"       
# [316] "caff_intake_4_l"                "su_caff_intake_4_calc_l"        "caff_intake_6_l"               
# [319] "su_caff_intake_6_calc_l"        "caff_intake_9_l"                "su_caff_intake_9_calc_l"       
# [322] "caff_max_yn_l"                  "caff_max_l"                     "su_caff_max_calc_l"            
# [325] "caff_max_type_l"                "su_tlfb_alc_use_calc_l"         "su_tlfb_tob_puff_calc_l"       
# [328] "su_tlfb_cig_use_calc_l"         "su_tlfb_ecig_use_calc_l"        "su_tlfb_chew_use_calc_l"       
# [331] "su_tlfb_cigar_use_calc_l"       "su_tlfb_hookah_use_calc_l"      "su_tlfb_pipes_use_calc_l"      
# [334] "su_tlfb_nicotine_use_calc_l"    "su_tlfb_mj_puff_calc_l"         "su_tlfb_mj_use_calc_l"         
# [337] "su_tlfb_blunt_use_calc_l"       "su_tlfb_edible_use_calc_l"      "su_tlfb_mj_conc_use_calc_l"    
# [340] "su_tlfb_mj_drink_use_calc_l"    "su_tlfb_tincture_use_calc_l"    "su_tlfb_mj_synth_use_calc_l"   
# [343] "su_tlfb_coc_use_calc_l"         "su_tlfb_bsalts_use_calc_l"      "su_tlfb_meth_use_calc_l"       
# [346] "su_tlfb_cbd_use_l"              "su_tlfb_mdma_use_calc_l"        "su_tlfb_ket_use_calc_l"        
# [349] "su_tlfb_ghb_use_calc_l"         "su_tlfb_opi_use_calc_l"         "su_tlfb_hall_use_calc_l"       
# [352] "su_tlfb_shrooms_use_calc_l"     "su_tlfb_salvia_use_calc_l"      "su_tlfb_steroids_use_calc_l"   
# [355] "su_tlfb_bitta_use_calc_l"       "su_tlfb_inhalant_use_calc_l"    "su_tlfb_amp_use_calc_l"        
# [358] "su_tlfb_tranq_use_calc_l"       "su_tlfb_vicodin_use_calc_l"     "su_tlfb_cough_use_calc_l"      
# [361] "su_tlfb_other_use_calc_l"       "su_tlfb_cbd_first_use"          "su_tlfb_cbd_calc_l"            
# [364] "su_tlfb_cbd_date1_l"            "tlfb_other_use2_l"              "su_tlfb_alc_sip_calc_l"        
# [367] "su_tlfb_cbd_follow_up_l___1"    "su_tlfb_cbd_follow_up_l___2"    "su_tlfb_cbd_follow_up_l___3"   
# [370] "su_tlfb_cbd_follow_up_l___4"    "su_tlfb_cbd_follow_up_l___5"    "su_tlfb_cbd_follow_up_l___6"   
# [373] "xskipout_device"                "su_tlfb_vape_mj_fl_use_calc_l"  "su_tlfb_vape_mj_oil_use_calc_l"
# [376] "collection_title"               "study_cohort_name"  

y_subuse = y_subuse[,-c(1:3, 5:8, 10:12, 17:34, 53:86, 163:216, 232:256, 302:325,
                        343:345, 347:361, 365, 373, 376:377)]

colnames(y_subuse)
# [1] "subjectkey"                     "eventname"                      "tlfb_alc_l"                    
# [4] "tlfb_tob_l"                     "tlfb_mj_l"                      "tlfb_mj_synth_l"               
# [7] "tlfb_alc_sip_l"                 "tlfb_alc_use_l"                 "tlfb_tob_puff_l"               
# [10] "tlfb_cig_use_l"                 "tlfb_ecig_use_l"                "tlfb_chew_use_l"               
# [13] "tlfb_cigar_use_l"               "tlfb_hookah_use_l"              "tlfb_pipes_use_l"              
# [16] "tlfb_nicotine_use_l"            "tlfb_mj_puff_l"                 "tlfb_mj_use_l"                 
# [19] "tlfb_blunt_use_l"               "tlfb_edible_use_l"              "tlfb_mj_conc_use_l"            
# [22] "tlfb_mj_drink_use_l"            "tlfb_tincture_use_l"            "tlfb_mj_synth_use_l"           
# [25] "isip_1_l"                       "su_isip_1_calc_l"               "isip_1b_yn_l"                  
# [28] "isip_1b_l"                      "su_isip_1b_calc_l"              "isip_1d_l"                     
# [31] "isip_2_l"                       "isip_3_l"                       "isip_4_l"                      
# [34] "isip_5_l"                       "isip_6_l"                       "first_nicotine_1_l"            
# [37] "first_nicotine_1b"              "su_first_nicotine_1b_calc"      "first_nicotine_2_l"            
# [40] "first_nicotine_5_l"             "first_nicotine_6_l"             "first_nicotine_7_l"            
# [43] "first_nicotine_3_l"             "first_nicotine_4_l"             "first_nicotine_11_l"           
# [46] "first_nicotine_12_l"            "first_nicotine_13_l"            "first_mj_1b_l"                 
# [49] "first_mj_1a_l"                  "first_mj_3_l"                   "first_mj_4_l"                  
# [52] "first_mj_5_l"                   "first_mj_6_l"                   "first_mj_7_l"                  
# [55] "first_mj_8_l"                   "tlfb_alc_first_use"             "tlfb_alc_date1_l"              
# [58] "tlfb_alc_calc_l"                "tlfb_cig_first_use"             "tlfb_cig_date1_l"              
# [61] "tlfb_cig_calc_l"                "tlfb_ecig_first_use"            "tlfb_ecig_date1_l"             
# [64] "tlfb_ecig_calc_l"               "tlfb_chew_first_use"            "tlfb_chew_date1_l"             
# [67] "tlfb_chew_calc_l"               "tlfb_cigar_first_use"           "tlfb_cigar_date1_l"            
# [70] "tlfb_cigar_calc_l"              "tlfb_hookah_first_use"          "tlfb_hookah_date1_l"           
# [73] "tlfb_hookah_calc_l"             "tlfb_pipes_first_use"           "tlfb_pipes_date1_l"            
# [76] "tlfb_pipes_calc_l"              "tlfb_nicotine_first_use"        "tlfb_nicotine_date1_l"         
# [79] "tlfb_nicotine_calc_l"           "tlfb_mj_first_use"              "tlfb_mj_date1_l"               
# [82] "tlfb_mj_calc_l"                 "tlfb_blunt_first_use"           "tlfb_blunt_date1_l"            
# [85] "tlfb_blunt_calc_l"              "tlfb_edible_first_use"          "tlfb_edible_date1_l"           
# [88] "tlfb_edible_calc_l"             "tlfb_mj_con_first_use"          "tlfb_mj_conc_date1_l"          
# [91] "tlfb_mj_conc_calc_l"            "tlfb_mj_drink_first_use"        "tlfb_mj_drink_date1_l"         
# [94] "tlfb_mj_drink_calc_l"           "tlfb_tincture_first_use"        "tlfb_tincture_date1_l"         
# [97] "tlfb_tincture_calc_l"           "tlfb_mj_synth_first_use"        "tlfb_mj_synth_date1_l"         
# [100] "tlfb_mj_synth_calc_l"           "tlfb_6mo_skip_l___1"            "tlfb_6mo_skip_l___2"           
# [103] "tlfb_6mo_skip_l___3"            "tlfb_6mo_skip_l___4"            "tlfb_6mo_skip_l___5"           
# [106] "tlfb_6mo_skip_l___6"            "tlfb_6mo_skip_l___7"            "tlfb_6mo_skip_l___8"           
# [109] "tlfb_6mo_skip_l___9"            "tlfb_6mo_skip_l___10"           "tlfb_6mo_skip_l___11"          
# [112] "tlfb_6mo_skip_l___12"           "tlfb_6mo_skip_l___13"           "tlfb_6mo_skip_l___14"          
# [115] "tlfb_6mo_skip_l___15"           "xskipout_alc_l"                 "xskipout_tob_l"                
# [118] "xskipout_mj_l"                  "xskipout_other_l"               "tlfb_6mo_1_cig_l"              
# [121] "tlfb_6mo_1_ecig_l"              "tlfb_6mo_1_ecig_dk_l"           "su_tlfb_6mo_1_ecig_calc_l"     
# [124] "tlfb_6mo_2_ecig_l"              "tlfb_6mo_2_ecig_dk_l"           "su_tlfb_6mo_2_ecig_calc_l"     
# [127] "tlfb_6mo_3_ecig_l"              "tlfb_6mo_4_ecig_l"              "su_tlfb_past_yr_ecig_5_l"      
# [130] "su_tlfb_past_yr_ecig_6_l"       "su_tlfb_past_yr_prim_3_mj_l"    "tlfb_6mo_4_mj_l"               
# [133] "tlfb_6mo_4_mj_dk_l"             "tlfb_6mo_5_mj_l"                "tlfb_6mo_6_mj_l"               
# [136] "tlfb_6mo_7_mj_l"                "tlfb_6mo_8_mj_l"                "tlfb_6mo_9_concmj_l"           
# [139] "tlfb_6mo_10_concmj_l"           "tlfb_6mo_11_concmj_l"           "tlfb_6mo_12_concmj_l"          
# [142] "tlfb_6mo_13_mj_l___1"           "tlfb_6mo_13_mj_l___2"           "tlfb_6mo_13_mj_l___3"          
# [145] "tlfb_6mo_13_mj_l___4"           "tlfb_6mo_13_mj_l___5"           "tlfb_6mo_13_mj_l___6"          
# [148] "tlfb_6mo_13_mj_l___7"           "tlfb_6mo_13_mj_l___8"           "tlfb_6mo_13_mj_l___9"          
# [151] "tlfb_6mo_13_mj_l___10"          "tlfb_6mo_13_mj_l___11"          "tlfb_6mo_13_mj_l___12"         
# [154] "tlfb_6mo_13_mj_l___13"          "tlfb_6mo_13_mj_l___14"          "tlfb_6mo_13_mj_l___15"         
# [157] "tlfb_6mo_13_mj_l___16"          "su_tlfb_past_yr_mj_edible_l"    "tlfb_6mo_mj_drink_type_l"      
# [160] "tlfb_6mo_tincture_type_l"       "su_tlfb_alc_use_calc_l"         "su_tlfb_tob_puff_calc_l"       
# [163] "su_tlfb_cig_use_calc_l"         "su_tlfb_ecig_use_calc_l"        "su_tlfb_chew_use_calc_l"       
# [166] "su_tlfb_cigar_use_calc_l"       "su_tlfb_hookah_use_calc_l"      "su_tlfb_pipes_use_calc_l"      
# [169] "su_tlfb_nicotine_use_calc_l"    "su_tlfb_mj_puff_calc_l"         "su_tlfb_mj_use_calc_l"         
# [172] "su_tlfb_blunt_use_calc_l"       "su_tlfb_edible_use_calc_l"      "su_tlfb_mj_conc_use_calc_l"    
# [175] "su_tlfb_mj_drink_use_calc_l"    "su_tlfb_tincture_use_calc_l"    "su_tlfb_mj_synth_use_calc_l"   
# [178] "su_tlfb_cbd_use_l"              "su_tlfb_cbd_first_use"          "su_tlfb_cbd_calc_l"            
# [181] "su_tlfb_cbd_date1_l"            "su_tlfb_alc_sip_calc_l"         "su_tlfb_cbd_follow_up_l___1"   
# [184] "su_tlfb_cbd_follow_up_l___2"    "su_tlfb_cbd_follow_up_l___3"    "su_tlfb_cbd_follow_up_l___4"   
# [187] "su_tlfb_cbd_follow_up_l___5"    "su_tlfb_cbd_follow_up_l___6"    "su_tlfb_vape_mj_fl_use_calc_l" 
# [190] "su_tlfb_vape_mj_oil_use_calc_l"

#Rename variables
names(y_subuse)[names(y_subuse) == "subjectkey"] = "id"
names(y_subuse)[names(y_subuse) == "eventname"] = "timepoint"
names(y_subuse)[names(y_subuse) == "tlfb_alc_l"] = "tlfb_alcohol"
names(y_subuse)[names(y_subuse) == "tlfb_tob_l"] = "tlfb_tob"
names(y_subuse)[names(y_subuse) == "tlfb_mj_l"] = "tlfb_mj"
names(y_subuse)[names(y_subuse) == "tlfb_mj_synth_l"] = "tlfb_mjsynth"
names(y_subuse)[names(y_subuse) == "tlfb_alc_sip_l"] = "alc_sip"
names(y_subuse)[names(y_subuse) == "tlfb_alc_use_l"] = "full_alc"
names(y_subuse)[names(y_subuse) == "tlfb_tob_puff_l"] = "tob_puff"
names(y_subuse)[names(y_subuse) == "tlfb_cig_use_l"] = "cig_use"
names(y_subuse)[names(y_subuse) == "tlfb_ecig_use_l"] = "ecig_use"
names(y_subuse)[names(y_subuse) == "tlfb_chew_use_l"] = "chew_use"
names(y_subuse)[names(y_subuse) == "tlfb_cigar_use_l"] = "cigar_use"
names(y_subuse)[names(y_subuse) == "tlfb_hookah_use_l"] = "hookah_use"
names(y_subuse)[names(y_subuse) == "tlfb_pipes_use_l"] = "pipes_use"
names(y_subuse)[names(y_subuse) == "tlfb_nicotine_use_l"] = "nictoinereplace"
names(y_subuse)[names(y_subuse) == "tlfb_mj_puff_l"] = "mj_puff"
names(y_subuse)[names(y_subuse) == "tlfb_mj_use_l"] = "mj_use"
names(y_subuse)[names(y_subuse) == "tlfb_blunt_use_l"] = "blunt_use"
names(y_subuse)[names(y_subuse) == "tlfb_edible_use_l"] = "edible_use"
names(y_subuse)[names(y_subuse) == "tlfb_mj_conc_use_l"] = "mj_conc_use"
names(y_subuse)[names(y_subuse) == "tlfb_mj_drink_use_l"] = "mj_drink_use"
names(y_subuse)[names(y_subuse) == "tlfb_tincture_use_l"] = "tincture_use"
names(y_subuse)[names(y_subuse) == "tlfb_mj_synth_use_l"] = "mj_synth_use"
names(y_subuse)[names(y_subuse) == "isip_1_l"] = "totallast_alc_sip"
names(y_subuse)[names(y_subuse) == "isip_1b_yn_l"] = "alc_sip_relg"
names(y_subuse)[names(y_subuse) == "isip_1b_l"] = "total_alc_relg"
names(y_subuse)[names(y_subuse) == "isip_1d_l"] = "age_alc_sip"
names(y_subuse)[names(y_subuse) == "isip_2_l"] = "cont_alc_sip"
names(y_subuse)[names(y_subuse) == "isip_3_l"] = "type_alc_sip"
names(y_subuse)[names(y_subuse) == "isip_4_l"] = "belong_alc_sip"
names(y_subuse)[names(y_subuse) == "isip_5_l"] = "offer_alc_sip"
names(y_subuse)[names(y_subuse) == "first_nicotine_1_l"] = "last_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_1b"] = "totallast_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_2_l"] = "type_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_5_l"] = "age_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_6_l"] = "cont_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_7_l"] = "flavor_tob_puff"
names(y_subuse)[names(y_subuse) == "first_nicotine_4_l"] = "type_chew"
names(y_subuse)[names(y_subuse) == "first_nicotine_11_l"] = "age_chew"
names(y_subuse)[names(y_subuse) == "first_nicotine_12_l"] = "cont_chew"
names(y_subuse)[names(y_subuse) == "first_nicotine_13_l"] = "flavor_chew"
names(y_subuse)[names(y_subuse) == "first_mj_1b_l"] = "totallast_mj"
names(y_subuse)[names(y_subuse) == "first_mj_1a_l"] = "age_mj"
names(y_subuse)[names(y_subuse) == "first_mj_3_l"] = "cont_mj"
names(y_subuse)[names(y_subuse) == "first_mj_4_l"] = "type_mj"
names(y_subuse)[names(y_subuse) == "first_mj_5_l"] = "high_mj"
names(y_subuse)[names(y_subuse) == "first_mj_6_l"] = "belong_mj"
names(y_subuse)[names(y_subuse) == "first_mj_7_l"] = "offer_mj"
names(y_subuse)[names(y_subuse) == "tlfb_alc_calc_l"] = "alcohol_onset"
names(y_subuse)[names(y_subuse) == "tlfb_cig_calc_l"] = "cig_onset"
names(y_subuse)[names(y_subuse) == "tlfb_ecig_calc_l"] = "ecig_onset"
names(y_subuse)[names(y_subuse) == "tlfb_chew_calc_l"] = "chew_onset"
names(y_subuse)[names(y_subuse) == "tlfb_cigar_calc_l"] = "cigar_onset"
names(y_subuse)[names(y_subuse) == "tlfb_hookah_calc_l"] = "hookah_onset"
names(y_subuse)[names(y_subuse) == "tlfb_pipes_calc_l"] = "pipe_onset"
names(y_subuse)[names(y_subuse) == "tlfb_nicotine_calc_l"] = "nicreplace_onset"
names(y_subuse)[names(y_subuse) == "tlfb_mj_calc_l"] = "mj_onset"
names(y_subuse)[names(y_subuse) == "tlfb_blunt_calc_l"] = "blunt_onset"
names(y_subuse)[names(y_subuse) == "tlfb_edible_calc_l"] = "edible_onset"
names(y_subuse)[names(y_subuse) == "tlfb_mj_conc_calc_l"] = "mj_conc_onset"
names(y_subuse)[names(y_subuse) == "tlfb_mj_drink_calc_l"] = "mj_drink_onset"
names(y_subuse)[names(y_subuse) == "tlfb_tincture_calc_l"] = "tincture_onset"
names(y_subuse)[names(y_subuse) == "tlfb_mj_synth_calc_l"] = "mj_synth_onset"
names(y_subuse)[names(y_subuse) == "xskipout_alc_l"] = "12mo_alcohol"
names(y_subuse)[names(y_subuse) == "xskipout_tob_l"] = "12mo_tob"
names(y_subuse)[names(y_subuse) == "xskipout_mj_l"] = "12mo_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_1_cig_l"] = "1yr_flavorcig"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_1_ecig_l"] = "1yr_amt_ecig"
names(y_subuse)[names(y_subuse) == "su_tlfb_6mo_1_ecig_calc_l"] = "amt_ecig"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_2_ecig_l"] = "1yr_dose_ecig"
names(y_subuse)[names(y_subuse) == "su_tlfb_6mo_2_ecig_calc_l"] = "dose_ecig"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_3_ecig_l"] = "ecig_nicotine"
names(y_subuse)[names(y_subuse) == "su_tlfb_past_yr_prim_3_mj_l"] = "modeadmin_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_4_mj_l"] = "strain_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_5_mj_l"] = "potent_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_6_mj_l"] = "highpotent_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_7_mj_l"] = "1yr_high_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_8_mj_l"] = "1yr_vhigh_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_9_concmj_l"] = "type_mjconc"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_10_concmj_l"] = "modeadmin_mjconc"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_11_concmj_l"] = "potent_mjconc"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_12_concmj_l"] = "highpotent_mjconc"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___1"] = "doc_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___2"] = "mom_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___3"] = "dad_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___4"] = "guard_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___5"] = "unc_aunt_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___6"] = "sibling_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___7"] = "young_sib_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___8"] = "other_fam_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___9"] = "adult_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___10"] = "friendsell_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___11"] = "friend_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___12"] = "dealer_mj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___13"] = "fam_medmj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___14"] = "stranger_medmj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___15"] = "other_medmj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_13_mj_l___16"] = "other_mj"
names(y_subuse)[names(y_subuse) == "su_tlfb_past_yr_mj_edible_l"] = "type_edible"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_mj_drink_type_l"] = "type_drinkmj"
names(y_subuse)[names(y_subuse) == "tlfb_6mo_tincture_type_l"] = "type_tincture"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_use_l"] = "cbd_use"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_calc_l"] = "cbd_onset"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___1"] = "cbd_epidolex"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___2"] = "cbd_oil"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___3"] = "cbd_smoke"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___4"] = "cbd_edible"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___5"] = "cbd_topical"
names(y_subuse)[names(y_subuse) == "su_tlfb_cbd_follow_up_l___6"] = "cbd_vape"

colnames(y_subuse)
# [1] "id"                             "timepoint"                      "tlfb_alcohol"                  
# [4] "tlfb_tob"                       "tlfb_mj"                        "tlfb_mjsynth"                  
# [7] "alc_sip"                        "full_alc"                       "tob_puff"                      
# [10] "cig_use"                        "ecig_use"                       "chew_use"                      
# [13] "cigar_use"                      "hookah_use"                     "pipes_use"                     
# [16] "nictoinereplace"                "mj_puff"                        "mj_use"                        
# [19] "blunt_use"                      "edible_use"                     "mj_conc_use"                   
# [22] "mj_drink_use"                   "tincture_use"                   "mj_synth_use"                  
# [25] "totallast_alc_sip"              "su_isip_1_calc_l"               "alc_sip_relg"                  
# [28] "total_alc_relg"                 "su_isip_1b_calc_l"              "age_alc_sip"                   
# [31] "cont_alc_sip"                   "type_alc_sip"                   "belong_alc_sip"                
# [34] "offer_alc_sip"                  "isip_6_l"                       "last_tob_puff"                 
# [37] "totallast_tob_puff"             "su_first_nicotine_1b_calc"      "type_tob_puff"                 
# [40] "age_tob_puff"                   "cont_tob_puff"                  "flavor_tob_puff"               
# [43] "first_nicotine_3_l"             "type_chew"                      "age_chew"                      
# [46] "cont_chew"                      "flavor_chew"                    "totallast_mj"                  
# [49] "age_mj"                         "cont_mj"                        "type_mj"                       
# [52] "high_mj"                        "belong_mj"                      "offer_mj"                      
# [55] "first_mj_8_l"                   "tlfb_alc_first_use"             "tlfb_alc_date1_l"              
# [58] "alcohol_onset"                  "tlfb_cig_first_use"             "tlfb_cig_date1_l"              
# [61] "cig_onset"                      "tlfb_ecig_first_use"            "tlfb_ecig_date1_l"             
# [64] "ecig_onset"                     "tlfb_chew_first_use"            "tlfb_chew_date1_l"             
# [67] "chew_onset"                     "tlfb_cigar_first_use"           "tlfb_cigar_date1_l"            
# [70] "cigar_onset"                    "tlfb_hookah_first_use"          "tlfb_hookah_date1_l"           
# [73] "hookah_onset"                   "tlfb_pipes_first_use"           "tlfb_pipes_date1_l"            
# [76] "pipe_onset"                     "tlfb_nicotine_first_use"        "tlfb_nicotine_date1_l"         
# [79] "nicreplace_onset"               "tlfb_mj_first_use"              "tlfb_mj_date1_l"               
# [82] "mj_onset"                       "tlfb_blunt_first_use"           "tlfb_blunt_date1_l"            
# [85] "blunt_onset"                    "tlfb_edible_first_use"          "tlfb_edible_date1_l"           
# [88] "edible_onset"                   "tlfb_mj_con_first_use"          "tlfb_mj_conc_date1_l"          
# [91] "mj_conc_onset"                  "tlfb_mj_drink_first_use"        "tlfb_mj_drink_date1_l"         
# [94] "mj_drink_onset"                 "tlfb_tincture_first_use"        "tlfb_tincture_date1_l"         
# [97] "tincture_onset"                 "tlfb_mj_synth_first_use"        "tlfb_mj_synth_date1_l"         
# [100] "mj_synth_onset"                 "tlfb_6mo_skip_l___1"            "tlfb_6mo_skip_l___2"           
# [103] "tlfb_6mo_skip_l___3"            "tlfb_6mo_skip_l___4"            "tlfb_6mo_skip_l___5"           
# [106] "tlfb_6mo_skip_l___6"            "tlfb_6mo_skip_l___7"            "tlfb_6mo_skip_l___8"           
# [109] "tlfb_6mo_skip_l___9"            "tlfb_6mo_skip_l___10"           "tlfb_6mo_skip_l___11"          
# [112] "tlfb_6mo_skip_l___12"           "tlfb_6mo_skip_l___13"           "tlfb_6mo_skip_l___14"          
# [115] "tlfb_6mo_skip_l___15"           "12mo_alcohol"                   "12mo_tob"                      
# [118] "12mo_mj"                        "xskipout_other_l"               "1yr_flavorcig"                 
# [121] "1yr_amt_ecig"                   "tlfb_6mo_1_ecig_dk_l"           "amt_ecig"                      
# [124] "1yr_dose_ecig"                  "tlfb_6mo_2_ecig_dk_l"           "dose_ecig"                     
# [127] "ecig_nicotine"                  "tlfb_6mo_4_ecig_l"              "su_tlfb_past_yr_ecig_5_l"      
# [130] "su_tlfb_past_yr_ecig_6_l"       "modeadmin_mj"                   "strain_mj"                     
# [133] "tlfb_6mo_4_mj_dk_l"             "potent_mj"                      "highpotent_mj"                 
# [136] "1yr_high_mj"                    "1yr_vhigh_mj"                   "type_mjconc"                   
# [139] "modeadmin_mjconc"               "potent_mjconc"                  "highpotent_mjconc"             
# [142] "doc_mj"                         "mom_mj"                         "dad_mj"                        
# [145] "guard_mj"                       "unc_aunt_mj"                    "sibling_mj"                    
# [148] "young_sib_mj"                   "other_fam_mj"                   "adult_mj"                      
# [151] "friendsell_mj"                  "friend_mj"                      "dealer_mj"                     
# [154] "fam_medmj"                      "stranger_medmj"                 "other_medmj"                   
# [157] "other_mj"                       "type_edible"                    "type_drinkmj"                  
# [160] "type_tincture"                  "su_tlfb_alc_use_calc_l"         "su_tlfb_tob_puff_calc_l"       
# [163] "su_tlfb_cig_use_calc_l"         "su_tlfb_ecig_use_calc_l"        "su_tlfb_chew_use_calc_l"       
# [166] "su_tlfb_cigar_use_calc_l"       "su_tlfb_hookah_use_calc_l"      "su_tlfb_pipes_use_calc_l"      
# [169] "su_tlfb_nicotine_use_calc_l"    "su_tlfb_mj_puff_calc_l"         "su_tlfb_mj_use_calc_l"         
# [172] "su_tlfb_blunt_use_calc_l"       "su_tlfb_edible_use_calc_l"      "su_tlfb_mj_conc_use_calc_l"    
# [175] "su_tlfb_mj_drink_use_calc_l"    "su_tlfb_tincture_use_calc_l"    "su_tlfb_mj_synth_use_calc_l"   
# [178] "cbd_use"                        "su_tlfb_cbd_first_use"          "cbd_onset"                     
# [181] "su_tlfb_cbd_date1_l"            "su_tlfb_alc_sip_calc_l"         "cbd_epidolex"                  
# [184] "cbd_oil"                        "cbd_smoke"                      "cbd_edible"                    
# [187] "cbd_topical"                    "cbd_vape"                       "su_tlfb_vape_mj_fl_use_calc_l" 
# [190] "su_tlfb_vape_mj_oil_use_calc_l"

y_subuse = y_subuse[,-c(26, 29, 35, 38, 43, 55:57, 59, 60, 62, 63, 65, 66,
                        68, 69, 71, 72, 74, 75, 77, 78, 80, 81, 83, 84, 86, 87, 89, 90,
                        92, 93, 95, 96, 98, 99, 101:115, 119, 122, 125, 128, 129, 130, 133, 
                        161:177, 179, 181, 182, 189, 190)]

colnames(y_subuse)
# [1] "id"                 "timepoint"          "tlfb_alcohol"       "tlfb_tob"          
# [5] "tlfb_mj"            "tlfb_mjsynth"       "alc_sip"            "full_alc"          
# [9] "tob_puff"           "cig_use"            "ecig_use"           "chew_use"          
# [13] "cigar_use"          "hookah_use"         "pipes_use"          "nictoinereplace"   
# [17] "mj_puff"            "mj_use"             "blunt_use"          "edible_use"        
# [21] "mj_conc_use"        "mj_drink_use"       "tincture_use"       "mj_synth_use"      
# [25] "totallast_alc_sip"  "alc_sip_relg"       "total_alc_relg"     "age_alc_sip"       
# [29] "cont_alc_sip"       "type_alc_sip"       "belong_alc_sip"     "offer_alc_sip"     
# [33] "last_tob_puff"      "totallast_tob_puff" "type_tob_puff"      "age_tob_puff"      
# [37] "cont_tob_puff"      "flavor_tob_puff"    "type_chew"          "age_chew"          
# [41] "cont_chew"          "flavor_chew"        "totallast_mj"       "age_mj"            
# [45] "cont_mj"            "type_mj"            "high_mj"            "belong_mj"         
# [49] "offer_mj"           "alcohol_onset"      "cig_onset"          "ecig_onset"        
# [53] "chew_onset"         "cigar_onset"        "hookah_onset"       "pipe_onset"        
# [57] "nicreplace_onset"   "mj_onset"           "blunt_onset"        "edible_onset"      
# [61] "mj_conc_onset"      "mj_drink_onset"     "tincture_onset"     "mj_synth_onset"    
# [65] "12mo_alcohol"       "12mo_tob"           "12mo_mj"            "1yr_flavorcig"     
# [69] "1yr_amt_ecig"       "amt_ecig"           "1yr_dose_ecig"      "dose_ecig"         
# [73] "ecig_nicotine"      "modeadmin_mj"       "strain_mj"          "potent_mj"         
# [77] "highpotent_mj"      "1yr_high_mj"        "1yr_vhigh_mj"       "type_mjconc"       
# [81] "modeadmin_mjconc"   "potent_mjconc"      "highpotent_mjconc"  "doc_mj"            
# [85] "mom_mj"             "dad_mj"             "guard_mj"           "unc_aunt_mj"       
# [89] "sibling_mj"         "young_sib_mj"       "other_fam_mj"       "adult_mj"          
# [93] "friendsell_mj"      "friend_mj"          "dealer_mj"          "fam_medmj"         
# [97] "stranger_medmj"     "other_medmj"        "other_mj"           "type_edible"       
# [101] "type_drinkmj"       "type_tincture"      "cbd_use"            "cbd_onset"         
# [105] "cbd_epidolex"       "cbd_oil"            "cbd_smoke"          "cbd_edible"        
# [109] "cbd_topical"        "cbd_vape"  

table(y_subuse$alcohol_onset, useNA = "ifany")
#         11.01 11.11 11.24 11.58 11.65  11.8 12.12 12.36 12.57 12.62 12.75 12.83 12.96 13.12 13.16 13.24 13.33 
# 27868     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1 
# 13.41 13.48 13.82  4.44     5 
# 1     1     1     1     1 

#Rescale variables so "" is NA
colnames(y_subuse)
y_subuse[, c(3:110)][y_subuse[, c(3:110)] == ""] <- NA
y_subuse[, c(3:110)][y_subuse[, c(3:110)] == 999] <- NA

table(y_subuse$mj_onset, useNA = "ifany")
# 10.45  10.7 11.07 11.53 11.92 11.94 11.98 12.22 12.33 12.36 12.37 12.39 12.48 12.53 12.57 12.68 12.71 12.74 
# 1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1     1 
# 12.75 12.88  12.9 12.92 12.95 12.97 13.01 13.14 13.29 13.32 13.33 13.37 13.62 13.65  13.7  <NA> 
#   1     1     1     1     1     1     1     1     1     1     1     1     1     1     1 27857 

#Change character to numeric
y_subuse[,c(3:110)]<-as.data.frame(apply(y_subuse[,c(3:110)],2,as.numeric))

#check class
sapply(y_subuse,class)

table(y_subuse$timepoint, useNA = "ifany")
# 1_year_follow_up_y_arm_1 2_year_follow_up_y_arm_1 3_year_follow_up_y_arm_1 
# 11225                    10414                     6251 

#Lable Timepoint data
y_subuse[which(y_subuse$timepoint == "1_year_follow_up_y_arm_1"),"timepoint"] = 1
y_subuse[which(y_subuse$timepoint == "2_year_follow_up_y_arm_1"),"timepoint"] = 2
y_subuse[which(y_subuse$timepoint == "3_year_follow_up_y_arm_1"),"timepoint"] = 3

table(y_subuse$timepoint,useNA= "ifany")
#   1     2     3 
# 11225 10414  6251 

#Double check that no additional variable was made
colnames(y_subuse)
# [1] "id"                 "timepoint"          "tlfb_alcohol"       "tlfb_tob"          
# [5] "tlfb_mj"            "tlfb_mjsynth"       "alc_sip"            "full_alc"          
# [9] "tob_puff"           "cig_use"            "ecig_use"           "chew_use"          
# [13] "cigar_use"          "hookah_use"         "pipes_use"          "nictoinereplace"   
# [17] "mj_puff"            "mj_use"             "blunt_use"          "edible_use"        
# [21] "mj_conc_use"        "mj_drink_use"       "tincture_use"       "mj_synth_use"      
# [25] "totallast_alc_sip"  "alc_sip_relg"       "total_alc_relg"     "age_alc_sip"       
# [29] "cont_alc_sip"       "type_alc_sip"       "belong_alc_sip"     "offer_alc_sip"     
# [33] "last_tob_puff"      "totallast_tob_puff" "type_tob_puff"      "age_tob_puff"      
# [37] "cont_tob_puff"      "flavor_tob_puff"    "type_chew"          "age_chew"          
# [41] "cont_chew"          "flavor_chew"        "totallast_mj"       "age_mj"            
# [45] "cont_mj"            "type_mj"            "high_mj"            "belong_mj"         
# [49] "offer_mj"           "alcohol_onset"      "cig_onset"          "ecig_onset"        
# [53] "chew_onset"         "cigar_onset"        "hookah_onset"       "pipe_onset"        
# [57] "nicreplace_onset"   "mj_onset"           "blunt_onset"        "edible_onset"      
# [61] "mj_conc_onset"      "mj_drink_onset"     "tincture_onset"     "mj_synth_onset"    
# [65] "12mo_alcohol"       "12mo_tob"           "12mo_mj"            "1yr_flavorcig"     
# [69] "1yr_amt_ecig"       "amt_ecig"           "1yr_dose_ecig"      "dose_ecig"         
# [73] "ecig_nicotine"      "modeadmin_mj"       "strain_mj"          "potent_mj"         
# [77] "highpotent_mj"      "1yr_high_mj"        "1yr_vhigh_mj"       "type_mjconc"       
# [81] "modeadmin_mjconc"   "potent_mjconc"      "highpotent_mjconc"  "doc_mj"            
# [85] "mom_mj"             "dad_mj"             "guard_mj"           "unc_aunt_mj"       
# [89] "sibling_mj"         "young_sib_mj"       "other_fam_mj"       "adult_mj"          
# [93] "friendsell_mj"      "friend_mj"          "dealer_mj"          "fam_medmj"         
# [97] "stranger_medmj"     "other_medmj"        "other_mj"           "type_edible"       
# [101] "type_drinkmj"       "type_tincture"      "cbd_use"            "cbd_onset"         
# [105] "cbd_epidolex"       "cbd_oil"            "cbd_smoke"          "cbd_edible"        
# [109] "cbd_topical"        "cbd_vape"   

#Reshape data to wide
library(reshape)
y_subuse_wide= reshape(y_subuse, idvar="id",timevar = "timepoint", direction = "wide")

colnames(y_subuse_wide)
# [1] "id"                   "tlfb_alcohol.1"       "tlfb_tob.1"           "tlfb_mj.1"           
# [5] "tlfb_mjsynth.1"       "alc_sip.1"            "full_alc.1"           "tob_puff.1"          
# [9] "cig_use.1"            "ecig_use.1"           "chew_use.1"           "cigar_use.1"         
# [13] "hookah_use.1"         "pipes_use.1"          "nictoinereplace.1"    "mj_puff.1"           
# [17] "mj_use.1"             "blunt_use.1"          "edible_use.1"         "mj_conc_use.1"       
# [21] "mj_drink_use.1"       "tincture_use.1"       "mj_synth_use.1"       "totallast_alc_sip.1" 
# [25] "alc_sip_relg.1"       "total_alc_relg.1"     "age_alc_sip.1"        "cont_alc_sip.1"      
# [29] "type_alc_sip.1"       "belong_alc_sip.1"     "offer_alc_sip.1"      "last_tob_puff.1"     
# [33] "totallast_tob_puff.1" "type_tob_puff.1"      "age_tob_puff.1"       "cont_tob_puff.1"     
# [37] "flavor_tob_puff.1"    "type_chew.1"          "age_chew.1"           "cont_chew.1"         
# [41] "flavor_chew.1"        "totallast_mj.1"       "age_mj.1"             "cont_mj.1"           
# [45] "type_mj.1"            "high_mj.1"            "belong_mj.1"          "offer_mj.1"          
# [49] "alcohol_onset.1"      "cig_onset.1"          "ecig_onset.1"         "chew_onset.1"        
# [53] "cigar_onset.1"        "hookah_onset.1"       "pipe_onset.1"         "nicreplace_onset.1"  
# [57] "mj_onset.1"           "blunt_onset.1"        "edible_onset.1"       "mj_conc_onset.1"     
# [61] "mj_drink_onset.1"     "tincture_onset.1"     "mj_synth_onset.1"     "12mo_alcohol.1"      
# [65] "12mo_tob.1"           "12mo_mj.1"            "1yr_flavorcig.1"      "1yr_amt_ecig.1"      
# [69] "amt_ecig.1"           "1yr_dose_ecig.1"      "dose_ecig.1"          "ecig_nicotine.1"     
# [73] "modeadmin_mj.1"       "strain_mj.1"          "potent_mj.1"          "highpotent_mj.1"     
# [77] "1yr_high_mj.1"        "1yr_vhigh_mj.1"       "type_mjconc.1"        "modeadmin_mjconc.1"  
# [81] "potent_mjconc.1"      "highpotent_mjconc.1"  "doc_mj.1"             "mom_mj.1"            
# [85] "dad_mj.1"             "guard_mj.1"           "unc_aunt_mj.1"        "sibling_mj.1"        
# [89] "young_sib_mj.1"       "other_fam_mj.1"       "adult_mj.1"           "friendsell_mj.1"     
# [93] "friend_mj.1"          "dealer_mj.1"          "fam_medmj.1"          "stranger_medmj.1"    
# [97] "other_medmj.1"        "other_mj.1"           "type_edible.1"        "type_drinkmj.1"      
# [101] "type_tincture.1"      "cbd_use.1"            "cbd_onset.1"          "cbd_epidolex.1"      
# [105] "cbd_oil.1"            "cbd_smoke.1"          "cbd_edible.1"         "cbd_topical.1"       
# [109] "cbd_vape.1"           "tlfb_alcohol.2"       "tlfb_tob.2"           "tlfb_mj.2"           
# [113] "tlfb_mjsynth.2"       "alc_sip.2"            "full_alc.2"           "tob_puff.2"          
# [117] "cig_use.2"            "ecig_use.2"           "chew_use.2"           "cigar_use.2"         
# [121] "hookah_use.2"         "pipes_use.2"          "nictoinereplace.2"    "mj_puff.2"           
# [125] "mj_use.2"             "blunt_use.2"          "edible_use.2"         "mj_conc_use.2"       
# [129] "mj_drink_use.2"       "tincture_use.2"       "mj_synth_use.2"       "totallast_alc_sip.2" 
# [133] "alc_sip_relg.2"       "total_alc_relg.2"     "age_alc_sip.2"        "cont_alc_sip.2"      
# [137] "type_alc_sip.2"       "belong_alc_sip.2"     "offer_alc_sip.2"      "last_tob_puff.2"     
# [141] "totallast_tob_puff.2" "type_tob_puff.2"      "age_tob_puff.2"       "cont_tob_puff.2"     
# [145] "flavor_tob_puff.2"    "type_chew.2"          "age_chew.2"           "cont_chew.2"         
# [149] "flavor_chew.2"        "totallast_mj.2"       "age_mj.2"             "cont_mj.2"           
# [153] "type_mj.2"            "high_mj.2"            "belong_mj.2"          "offer_mj.2"          
# [157] "alcohol_onset.2"      "cig_onset.2"          "ecig_onset.2"         "chew_onset.2"        
# [161] "cigar_onset.2"        "hookah_onset.2"       "pipe_onset.2"         "nicreplace_onset.2"  
# [165] "mj_onset.2"           "blunt_onset.2"        "edible_onset.2"       "mj_conc_onset.2"     
# [169] "mj_drink_onset.2"     "tincture_onset.2"     "mj_synth_onset.2"     "12mo_alcohol.2"      
# [173] "12mo_tob.2"           "12mo_mj.2"            "1yr_flavorcig.2"      "1yr_amt_ecig.2"      
# [177] "amt_ecig.2"           "1yr_dose_ecig.2"      "dose_ecig.2"          "ecig_nicotine.2"     
# [181] "modeadmin_mj.2"       "strain_mj.2"          "potent_mj.2"          "highpotent_mj.2"     
# [185] "1yr_high_mj.2"        "1yr_vhigh_mj.2"       "type_mjconc.2"        "modeadmin_mjconc.2"  
# [189] "potent_mjconc.2"      "highpotent_mjconc.2"  "doc_mj.2"             "mom_mj.2"            
# [193] "dad_mj.2"             "guard_mj.2"           "unc_aunt_mj.2"        "sibling_mj.2"        
# [197] "young_sib_mj.2"       "other_fam_mj.2"       "adult_mj.2"           "friendsell_mj.2"     
# [201] "friend_mj.2"          "dealer_mj.2"          "fam_medmj.2"          "stranger_medmj.2"    
# [205] "other_medmj.2"        "other_mj.2"           "type_edible.2"        "type_drinkmj.2"      
# [209] "type_tincture.2"      "cbd_use.2"            "cbd_onset.2"          "cbd_epidolex.2"      
# [213] "cbd_oil.2"            "cbd_smoke.2"          "cbd_edible.2"         "cbd_topical.2"       
# [217] "cbd_vape.2"           "tlfb_alcohol.3"       "tlfb_tob.3"           "tlfb_mj.3"           
# [221] "tlfb_mjsynth.3"       "alc_sip.3"            "full_alc.3"           "tob_puff.3"          
# [225] "cig_use.3"            "ecig_use.3"           "chew_use.3"           "cigar_use.3"         
# [229] "hookah_use.3"         "pipes_use.3"          "nictoinereplace.3"    "mj_puff.3"           
# [233] "mj_use.3"             "blunt_use.3"          "edible_use.3"         "mj_conc_use.3"       
# [237] "mj_drink_use.3"       "tincture_use.3"       "mj_synth_use.3"       "totallast_alc_sip.3" 
# [241] "alc_sip_relg.3"       "total_alc_relg.3"     "age_alc_sip.3"        "cont_alc_sip.3"      
# [245] "type_alc_sip.3"       "belong_alc_sip.3"     "offer_alc_sip.3"      "last_tob_puff.3"     
# [249] "totallast_tob_puff.3" "type_tob_puff.3"      "age_tob_puff.3"       "cont_tob_puff.3"     
# [253] "flavor_tob_puff.3"    "type_chew.3"          "age_chew.3"           "cont_chew.3"         
# [257] "flavor_chew.3"        "totallast_mj.3"       "age_mj.3"             "cont_mj.3"           
# [261] "type_mj.3"            "high_mj.3"            "belong_mj.3"          "offer_mj.3"          
# [265] "alcohol_onset.3"      "cig_onset.3"          "ecig_onset.3"         "chew_onset.3"        
# [269] "cigar_onset.3"        "hookah_onset.3"       "pipe_onset.3"         "nicreplace_onset.3"  
# [273] "mj_onset.3"           "blunt_onset.3"        "edible_onset.3"       "mj_conc_onset.3"     
# [277] "mj_drink_onset.3"     "tincture_onset.3"     "mj_synth_onset.3"     "12mo_alcohol.3"      
# [281] "12mo_tob.3"           "12mo_mj.3"            "1yr_flavorcig.3"      "1yr_amt_ecig.3"      
# [285] "amt_ecig.3"           "1yr_dose_ecig.3"      "dose_ecig.3"          "ecig_nicotine.3"     
# [289] "modeadmin_mj.3"       "strain_mj.3"          "potent_mj.3"          "highpotent_mj.3"     
# [293] "1yr_high_mj.3"        "1yr_vhigh_mj.3"       "type_mjconc.3"        "modeadmin_mjconc.3"  
# [297] "potent_mjconc.3"      "highpotent_mjconc.3"  "doc_mj.3"             "mom_mj.3"            
# [301] "dad_mj.3"             "guard_mj.3"           "unc_aunt_mj.3"        "sibling_mj.3"        
# [305] "young_sib_mj.3"       "other_fam_mj.3"       "adult_mj.3"           "friendsell_mj.3"     
# [309] "friend_mj.3"          "dealer_mj.3"          "fam_medmj.3"          "stranger_medmj.3"    
# [313] "other_medmj.3"        "other_mj.3"           "type_edible.3"        "type_drinkmj.3"      
# [317] "type_tincture.3"      "cbd_use.3"            "cbd_onset.3"          "cbd_epidolex.3"      
# [321] "cbd_oil.3"            "cbd_smoke.3"          "cbd_edible.3"         "cbd_topical.3"       
# [325] "cbd_vape.3"    

#Remove .3 variables
y_subuse_wide = y_subuse_wide[,-c(218:325)]

#check class
sapply(y_subuse_wide,class)




#Data files that need to be combined into master data file ---- 
#site_wide
#sub_famhist
#dev_history
#weights_wide
#demograph 
#neigh_wide
#temperament (need to run correlations first, then create summary scores)
#mhealth_youth_wide
#nih_wide
#brief_teach_wide
#brief_youth_wide
#p_cbcl_wide
#ksads_p_wide (need to look at missingness)
#ksads_y_wide (need to look at missingness)
#y_wills_wide (need to run correlations first, then create summary scores)
#Parent_CRPF_wide
#Youth_CRPF_wide
#y_subuse_wide
#y_subuse_base


#Create master dataframe with all variables ----

nd_su = merge(demograph, dev_history, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, sub_famhist, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, neigh_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, temperament, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, mhealth_youth_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, nih_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, brief_teach_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, brief_youth_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, p_cbcl_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, ksads_p_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, ksads_y_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, y_wills_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, Parent_CRPF_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, Youth_CRPF_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, y_subuse_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, y_subuse_base, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, site_wide, by.x = "id",by.y = "id", all = TRUE)
nd_su = merge(nd_su, weights_wide, by.x = "id",by.y = "id", all = TRUE)

colnames(nd_su)
# [1] "id"                          "caretaker"                   "m_educ"                     
# [4] "p_educ"                      "biomom.x"                    "c_race"                     
# [7] "p_race"                      "age"                         "sex"                        
# [10] "biomom.y"                    "weight"                      "m_age"                      
# [13] "p_age"                       "plan_preg"                   "weeks_preg"                 
# [16] "b_tobacco"                   "b_tob_cigspday"              "b_alcohol"                  
# [19] "b_alc_max"                   "b_alc_avgpwk"                "b_alc_drinkseff"            
# [22] "b_THC"                       "b_THC_amtpday"               "a_tobacco"                  
# [25] "a_tob_cigspday"              "a_alcohol"                   "a_alc_max"                  
# [28] "a_alc_avgpwk"                "a_alc_drinkseff"             "a_THC"                      
# [31] "a_THC_amtpday"               "prenatal"                    "nausea"                     
# [34] "doctor_visit"                "premature"                   "wks_premature"              
# [37] "months_breastfed"            "rollover"                    "sit"                        
# [40] "walk"                        "firstword"                   "motordev"                   
# [43] "speechdev"                   "wetbed"                      "age_stopwetbed"             
# [46] "Pre_Tobacco"                 "Pre_Alcohol"                 "Pre_THC"                    
# [49] "Pre_AlcTob"                  "Pre_AlcTHC"                  "Pre_TobTHC"                 
# [52] "Pre_AlcTobTHC"               "m_imed_alcohol"              "p_imed_alcohol"             
# [55] "m_imed_drug"                 "p_imed_drug"                 "m_imed_depres"              
# [58] "p_imed_depres"               "age.0.x"                     "safe_walk.0"                
# [61] "violence.0"                  "safe_crime.0"                "age.2.x"                    
# [64] "safe_walk.2"                 "violence.2"                  "safe_crime.2"               
# [67] "age.1.x"                     "safe_walk.1"                 "violence.1"                 
# [70] "safe_crime.1"                "total_neigh.0"               "total_neigh.1"              
# [73] "total_neigh.2"               "trouble"                     "insult"                     
# [76] "finish"                      "africa"                      "deal"                       
# [79] "turn_taking"                 "enjoy"                       "open_present"               
# [82] "ski_slope"                   "cry"                         "angry_hit"                  
# [85] "care"                        "share"                       "before_hw"                  
# [88] "concentrate"                 "city_move"                   "right_away"                 
# [91] "spend_time"                  "rude"                        "annoyed"                    
# [94] "irritate_crit"               "distracted"                  "impulse"                    
# [97] "hugs"                        "blame"                       "sad"                        
# [100] "social"                      "sea_dive"                    "travel"                     
# [103] "worry"                       "irritated_place"             "doorslam"                   
# [106] "hardly_sad"                  "race_car"                    "try_focus"                  
# [109] "finish_hw"                   "school_excite"               "early_start"                
# [112] "peripheral"                  "energized"                   "makes_fun"                  
# [115] "no_criticize"                "close_rel"                   "is_shy"                     
# [118] "irritated_enjoy"             "puts_off"                    "laugh_control"              
# [121] "attachement"                 "sidetracked"                 "not_shy"                    
# [124] "friendly"                    "seems_sad"                   "ball_scared"                
# [127] "meet"                        "dark_scared"                 "rides_scared"               
# [130] "disagree"                    "frustrated"                  "stick_to_plan"              
# [133] "close_attention"             "alone"                       "shy_meet"                   
# [136] "upps_neg_urgency.2"          "upps_lack_of_planning.2"     "upps_sensation_seek.2"      
# [139] "upps_pos_urgency.2"          "upps_lack_of_perseverance.2" "bis.2"                      
# [142] "bas_reward_respon.2"         "bas_drive.2"                 "bas_fun_seek.2"             
# [145] "bis_mod.2"                   "bas_mod_reward_respon.2"     "bas_mod_drive.2"            
# [148] "delinq.2"                    "pexp_relational_victim.2"    "pexp_reputation.2"          
# [151] "pexp_reptuation_vict.2"      "pexp_overt_aggres.2"         "pexp_overt_vict.2"          
# [154] "pexp_relational_aggres.2"    "upps_neg_urgency.1"          "upps_lack_of_planning.1"    
# [157] "upps_sensation_seek.1"       "upps_pos_urgency.1"          "upps_lack_of_perseverance.1"
# [160] "bis.1"                       "bas_reward_respon.1"         "bas_drive.1"                
# [163] "bas_fun_seek.1"              "bis_mod.1"                   "bas_mod_reward_respon.1"    
# [166] "bas_mod_drive.1"             "delinq.1"                    "pexp_relational_victim.1"   
# [169] "pexp_reputation.1"           "pexp_reptuation_vict.1"      "pexp_overt_aggres.1"        
# [172] "pexp_overt_vict.1"           "pexp_relational_aggres.1"    "upps_neg_urgency.0"         
# [175] "upps_lack_of_planning.0"     "upps_sensation_seek.0"       "upps_pos_urgency.0"         
# [178] "upps_lack_of_perseverance.0" "bis.0"                       "bas_reward_respon.0"        
# [181] "bas_drive.0"                 "bas_fun_seek.0"              "bis_mod.0"                  
# [184] "bas_mod_reward_respon.0"     "bas_mod_drive.0"             "delinq.0"                   
# [187] "pexp_relational_victim.0"    "pexp_reputation.0"           "pexp_reptuation_vict.0"     
# [190] "pexp_overt_aggres.0"         "pexp_overt_vict.0"           "pexp_relational_aggres.0"   
# [193] "upps_neg_urgency.3"          "upps_lack_of_planning.3"     "upps_sensation_seek.3"      
# [196] "upps_pos_urgency.3"          "upps_lack_of_perseverance.3" "bis.3"                      
# [199] "bas_reward_respon.3"         "bas_drive.3"                 "bas_fun_seek.3"             
# [202] "bis_mod.3"                   "bas_mod_reward_respon.3"     "bas_mod_drive.3"            
# [205] "delinq.3"                    "pexp_relational_victim.3"    "pexp_reputation.3"          
# [208] "pexp_reptuation_vict.3"      "pexp_overt_aggres.3"         "pexp_overt_vict.3"          
# [211] "pexp_relational_aggres.3"    "flanker_uncor.0"             "flanker_agecor.0"           
# [214] "dccs_uncor.0"                "dccs_agecor.0"               "flanker_cortscore.0"        
# [217] "dccs_cortscore.0"            "flanker_uncor.2"             "flanker_agecor.2"           
# [220] "dccs_uncor.2"                "dccs_agecor.2"               "flanker_cortscore.2"        
# [223] "dccs_cortscore.2"            "bpm_attention_t.3"           "bpm_internal_t.3"           
# [226] "bpm_external_t.3"            "bpm_total_t.3"               "bpm_attention_t.0"          
# [229] "bpm_internal_t.0"            "bpm_external_t.0"            "bpm_total_t.0"              
# [232] "bpm_attention_t.1"           "bpm_internal_t.1"            "bpm_external_t.1"           
# [235] "bpm_total_t.1"               "bpm_attention_t.2"           "bpm_internal_t.2"           
# [238] "bpm_external_t.2"            "bpm_total_t.2"               "bpm_y_attention_t.1"        
# [241] "bpm_y_internal_t.1"          "bpm_y_external_t.1"          "bpm_y_total_t.1"            
# [244] "bpm_y_attention_t.2"         "bpm_y_internal_t.2"          "bpm_y_external_t.2"         
# [247] "bpm_y_total_t.2"             "bpm_y_attention_t.3"         "bpm_y_internal_t.3"         
# [250] "bpm_y_external_t.3"          "bpm_y_total_t.3"             "cbcl_anxdep_t.3"            
# [253] "cbcl_withdep_t.3"            "cbcl_somatic_t.3"            "cbcl_social_t.3"            
# [256] "cbcl_thought_t.3"            "cbcl_atten_t.3"              "cbcl_rulebreak_t.3"         
# [259] "cbcl_aggres_t.3"             "cbcl_internal_t.3"           "cbcl_ext_t.3"               
# [262] "cbcl_total_t.3"              "cbcl_depress_t.3"            "cbcl_anxdisord_t.3"         
# [265] "cbcl_somatic_t.3.1"          "cbcl_adhd_t.3"               "cbcl_oppositdef_t.3"        
# [268] "cbcl_conduct_t.3"            "cbcl_stress_t.3"             "cbcl_anxdep_t.2"            
# [271] "cbcl_withdep_t.2"            "cbcl_somatic_t.2"            "cbcl_social_t.2"            
# [274] "cbcl_thought_t.2"            "cbcl_atten_t.2"              "cbcl_rulebreak_t.2"         
# [277] "cbcl_aggres_t.2"             "cbcl_internal_t.2"           "cbcl_ext_t.2"               
# [280] "cbcl_total_t.2"              "cbcl_depress_t.2"            "cbcl_anxdisord_t.2"         
# [283] "cbcl_somatic_t.2.1"          "cbcl_adhd_t.2"               "cbcl_oppositdef_t.2"        
# [286] "cbcl_conduct_t.2"            "cbcl_stress_t.2"             "cbcl_anxdep_t.1"            
# [289] "cbcl_withdep_t.1"            "cbcl_somatic_t.1"            "cbcl_social_t.1"            
# [292] "cbcl_thought_t.1"            "cbcl_atten_t.1"              "cbcl_rulebreak_t.1"         
# [295] "cbcl_aggres_t.1"             "cbcl_internal_t.1"           "cbcl_ext_t.1"               
# [298] "cbcl_total_t.1"              "cbcl_depress_t.1"            "cbcl_anxdisord_t.1"         
# [301] "cbcl_somatic_t.1.1"          "cbcl_adhd_t.1"               "cbcl_oppositdef_t.1"        
# [304] "cbcl_conduct_t.1"            "cbcl_stress_t.1"             "cbcl_anxdep_t.0"            
# [307] "cbcl_withdep_t.0"            "cbcl_somatic_t.0"            "cbcl_social_t.0"            
# [310] "cbcl_thought_t.0"            "cbcl_atten_t.0"              "cbcl_rulebreak_t.0"         
# [313] "cbcl_aggres_t.0"             "cbcl_internal_t.0"           "cbcl_ext_t.0"               
# [316] "cbcl_total_t.0"              "cbcl_depress_t.0"            "cbcl_anxdisord_t.0"         
# [319] "cbcl_somatic_t.0.1"          "cbcl_adhd_t.0"               "cbcl_oppositdef_t.0"        
# [322] "cbcl_conduct_t.0"            "cbcl_stress_t.0"             "pers_dep_present.1"         
# [325] "pers_dep_past.1"             "pers_dep_remi.1"             "mdd_present.1"              
# [328] "mdd_remi.1"                  "mdd_past.1"                  "dmdd.1"                     
# [331] "panic_present.1"             "panic_past.1"                "agroaphobia_present.1"      
# [334] "agroaphobia_past.1"          "sep_anx_present.1"           "sep_anx_past.1"             
# [337] "soc_anx_past.1"              "soc_anx_present.1"           "spec_phobia_past.1"         
# [340] "spec_phobia_present.1"       "gad_present.1"               "gad_past.1"                 
# [343] "ocd_present.1"               "ocd_past.1"                  "adhd_rem.1"                 
# [346] "adhd_present.1"              "adhd_past.1"                 "odd_present.1"              
# [349] "odd_past.1"                  "conduct_adol_past.1"         "conduct_child_pres.1"       
# [352] "conduct_child_past.1"        "conduct_adol_pres.1"         "aud_present.1"              
# [355] "aud_past.1"                  "stimulant_coc_pres.1"        "stimulant_coc_past.1"       
# [358] "stimulant_amph_pres.1"       "stimulant_amph_past.1"       "sud_present.1"              
# [361] "sud_past.1"                  "cud_past.1"                  "cud_present.1"              
# [364] "ptsd_present.1"              "ptsd_past.1"                 "sleep_past.1"               
# [367] "sleep_present.1"             "si_passive_present.1"        "si_passsive_past.1"         
# [370] "si_present.1"                "si_past.1"                   "self_inj_past.1"            
# [373] "self_inj_present.1"          "pers_dep_present.2"          "pers_dep_past.2"            
# [376] "pers_dep_remi.2"             "mdd_present.2"               "mdd_remi.2"                 
# [379] "mdd_past.2"                  "dmdd.2"                      "panic_present.2"            
# [382] "panic_past.2"                "agroaphobia_present.2"       "agroaphobia_past.2"         
# [385] "sep_anx_present.2"           "sep_anx_past.2"              "soc_anx_past.2"             
# [388] "soc_anx_present.2"           "spec_phobia_past.2"          "spec_phobia_present.2"      
# [391] "gad_present.2"               "gad_past.2"                  "ocd_present.2"              
# [394] "ocd_past.2"                  "adhd_rem.2"                  "adhd_present.2"             
# [397] "adhd_past.2"                 "odd_present.2"               "odd_past.2"                 
# [400] "conduct_adol_past.2"         "conduct_child_pres.2"        "conduct_child_past.2"       
# [403] "conduct_adol_pres.2"         "aud_present.2"               "aud_past.2"                 
# [406] "stimulant_coc_pres.2"        "stimulant_coc_past.2"        "stimulant_amph_pres.2"      
# [409] "stimulant_amph_past.2"       "sud_present.2"               "sud_past.2"                 
# [412] "cud_past.2"                  "cud_present.2"               "ptsd_present.2"             
# [415] "ptsd_past.2"                 "sleep_past.2"                "sleep_present.2"            
# [418] "si_passive_present.2"        "si_passsive_past.2"          "si_present.2"               
# [421] "si_past.2"                   "self_inj_past.2"             "self_inj_present.2"         
# [424] "pers_dep_present.0"          "pers_dep_past.0"             "pers_dep_remi.0"            
# [427] "mdd_present.0"               "mdd_remi.0"                  "mdd_past.0"                 
# [430] "dmdd.0"                      "panic_present.0"             "panic_past.0"               
# [433] "agroaphobia_present.0"       "agroaphobia_past.0"          "sep_anx_present.0"          
# [436] "sep_anx_past.0"              "soc_anx_past.0"              "soc_anx_present.0"          
# [439] "spec_phobia_past.0"          "spec_phobia_present.0"       "gad_present.0"              
# [442] "gad_past.0"                  "ocd_present.0"               "ocd_past.0"                 
# [445] "adhd_rem.0"                  "adhd_present.0"              "adhd_past.0"                
# [448] "odd_present.0"               "odd_past.0"                  "conduct_adol_past.0"        
# [451] "conduct_child_pres.0"        "conduct_child_past.0"        "conduct_adol_pres.0"        
# [454] "aud_present.0"               "aud_past.0"                  "stimulant_coc_pres.0"       
# [457] "stimulant_coc_past.0"        "stimulant_amph_pres.0"       "stimulant_amph_past.0"      
# [460] "sud_present.0"               "sud_past.0"                  "cud_past.0"                 
# [463] "cud_present.0"               "ptsd_present.0"              "ptsd_past.0"                
# [466] "sleep_past.0"                "sleep_present.0"             "si_passive_present.0"       
# [469] "si_passsive_past.0"          "si_present.0"                "si_past.0"                  
# [472] "self_inj_past.0"             "self_inj_present.0"          "y_mdd_present.0"            
# [475] "y_mdd_rem.0"                 "y_mdd_past.0"                "y_pres_dep_present.0"       
# [478] "y_pres_dep_rem.0"            "y_pres_dep_past.0"           "y_dmdd.0"                   
# [481] "y_adhd_present.0"            "y_adhd_past.0"               "y_adhd_rem.0"               
# [484] "y_panic_present.0"           "y_panic_past.0"              "y_agoraphobia_present.0"    
# [487] "y_agoraphobia_past.0"        "y_sepanx_present.0"          "y_sepanx_past.0"            
# [490] "y_socanx_present.0"          "y_specphob_present.0"        "y_specphob_past.0"          
# [493] "y_gad_present.0"             "y_gad_past.0"                "y_cud_present.0"            
# [496] "y_cud_past.0"                "y_sud_present.0"             "y_sud_past.0"               
# [499] "y_aud_present.0"             "y_aud_past.0"                "y_cd_child_present.0"       
# [502] "y_cd_adol_present.0"         "y_cd_child_past.0"           "y_cd_adol_past.0"           
# [505] "y_odd_present.0"             "y_odd_past.0"                "y_asd.0"                    
# [508] "y_ocd_present.0"             "y_ocd_past.0"                "y_ptsd_present.0"           
# [511] "y_ptsd_past.0"               "y_selfinj_present.0"         "y_si_passive_pres.0"        
# [514] "y_si_active_pres.0"          "ksads_23_948_t.0"            "y_hom_present.0"            
# [517] "y_hom_past.0"                "y_sleep_present.0"           "y_sleep_past.0"             
# [520] "y_mdd_present.1"             "y_mdd_rem.1"                 "y_mdd_past.1"               
# [523] "y_pres_dep_present.1"        "y_pres_dep_rem.1"            "y_pres_dep_past.1"          
# [526] "y_dmdd.1"                    "y_adhd_present.1"            "y_adhd_past.1"              
# [529] "y_adhd_rem.1"                "y_panic_present.1"           "y_panic_past.1"             
# [532] "y_agoraphobia_present.1"     "y_agoraphobia_past.1"        "y_sepanx_present.1"         
# [535] "y_sepanx_past.1"             "y_socanx_present.1"          "y_specphob_present.1"       
# [538] "y_specphob_past.1"           "y_gad_present.1"             "y_gad_past.1"               
# [541] "y_cud_present.1"             "y_cud_past.1"                "y_sud_present.1"            
# [544] "y_sud_past.1"                "y_aud_present.1"             "y_aud_past.1"               
# [547] "y_cd_child_present.1"        "y_cd_adol_present.1"         "y_cd_child_past.1"          
# [550] "y_cd_adol_past.1"            "y_odd_present.1"             "y_odd_past.1"               
# [553] "y_asd.1"                     "y_ocd_present.1"             "y_ocd_past.1"               
# [556] "y_ptsd_present.1"            "y_ptsd_past.1"               "y_selfinj_present.1"        
# [559] "y_si_passive_pres.1"         "y_si_active_pres.1"          "ksads_23_948_t.1"           
# [562] "y_hom_present.1"             "y_hom_past.1"                "y_sleep_present.1"          
# [565] "y_sleep_past.1"              "y_mdd_present.2"             "y_mdd_rem.2"                
# [568] "y_mdd_past.2"                "y_pres_dep_present.2"        "y_pres_dep_rem.2"           
# [571] "y_pres_dep_past.2"           "y_dmdd.2"                    "y_adhd_present.2"           
# [574] "y_adhd_past.2"               "y_adhd_rem.2"                "y_panic_present.2"          
# [577] "y_panic_past.2"              "y_agoraphobia_present.2"     "y_agoraphobia_past.2"       
# [580] "y_sepanx_present.2"          "y_sepanx_past.2"             "y_socanx_present.2"         
# [583] "y_specphob_present.2"        "y_specphob_past.2"           "y_gad_present.2"            
# [586] "y_gad_past.2"                "y_cud_present.2"             "y_cud_past.2"               
# [589] "y_sud_present.2"             "y_sud_past.2"                "y_aud_present.2"            
# [592] "y_aud_past.2"                "y_cd_child_present.2"        "y_cd_adol_present.2"        
# [595] "y_cd_child_past.2"           "y_cd_adol_past.2"            "y_odd_present.2"            
# [598] "y_odd_past.2"                "y_asd.2"                     "y_ocd_present.2"            
# [601] "y_ocd_past.2"                "y_ptsd_present.2"            "y_ptsd_past.2"              
# [604] "y_selfinj_present.2"         "y_si_passive_pres.2"         "y_si_active_pres.2"         
# [607] "ksads_23_948_t.2"            "y_hom_present.2"             "y_hom_past.2"               
# [610] "y_sleep_present.2"           "y_sleep_past.2"              "wps_info.1"                 
# [613] "wps_steps.1"                 "wps_choices.1"               "wps_altways.1"              
# [616] "wps_altsolveprob.1"          "wps_solveprob.1"             "p_crpf_alcohol.0"           
# [619] "p_crpf_cigarettes.0"         "p_crpf_vaping.0"             "p_crpf_marijuana.0"         
# [622] "p_crpf_alcohol.1"            "p_crpf_cigarettes.1"         "p_crpf_vaping.1"            
# [625] "p_crpf_marijuana.1"          "p_crpf_alcohol.2"            "p_crpf_cigarettes.2"        
# [628] "p_crpf_vaping.2"             "p_crpf_marijuana.2"          "p_crpf_alcohol.3"           
# [631] "p_crpf_cigarettes.3"         "p_crpf_vaping.3"             "p_crpf_marijuana.3"         
# [634] "total_pcrpf.0"               "total_pcrpf.1"               "total_pcrpf.2"              
# [637] "total_pcrpf.3"               "y_crpf_alcohol.3"            "y_crpf_cigarettes.3"        
# [640] "y_crpf_vaping.3"             "y_crpf_marijuana.3"          "y_crpf_alcohol.2"           
# [643] "y_crpf_cigarettes.2"         "y_crpf_vaping.2"             "y_crpf_marijuana.2"         
# [646] "total_ycrpf.2"               "total_ycrpf.3"               "tlfb_alcohol.1"             
# [649] "tlfb_tob.1"                  "tlfb_mj.1"                   "tlfb_mjsynth.1"             
# [652] "alc_sip.1"                   "full_alc.1"                  "tob_puff.1"                 
# [655] "cig_use.1"                   "ecig_use.1"                  "chew_use.1"                 
# [658] "cigar_use.1"                 "hookah_use.1"                "pipes_use.1"                
# [661] "nictoinereplace.1"           "mj_puff.1"                   "mj_use.1"                   
# [664] "blunt_use.1"                 "edible_use.1"                "mj_conc_use.1"              
# [667] "mj_drink_use.1"              "tincture_use.1"              "mj_synth_use.1"             
# [670] "totallast_alc_sip.1"         "alc_sip_relg.1"              "total_alc_relg.1"           
# [673] "age_alc_sip.1"               "cont_alc_sip.1"              "type_alc_sip.1"             
# [676] "belong_alc_sip.1"            "offer_alc_sip.1"             "last_tob_puff.1"            
# [679] "totallast_tob_puff.1"        "type_tob_puff.1"             "age_tob_puff.1"             
# [682] "cont_tob_puff.1"             "flavor_tob_puff.1"           "type_chew.1"                
# [685] "age_chew.1"                  "cont_chew.1"                 "flavor_chew.1"              
# [688] "totallast_mj.1"              "age_mj.1"                    "cont_mj.1"                  
# [691] "type_mj.1"                   "high_mj.1"                   "belong_mj.1"                
# [694] "offer_mj.1"                  "alcohol_onset.1"             "cig_onset.1"                
# [697] "ecig_onset.1"                "chew_onset.1"                "cigar_onset.1"              
# [700] "hookah_onset.1"              "pipe_onset.1"                "nicreplace_onset.1"         
# [703] "mj_onset.1"                  "blunt_onset.1"               "edible_onset.1"             
# [706] "mj_conc_onset.1"             "mj_drink_onset.1"            "tincture_onset.1"           
# [709] "mj_synth_onset.1"            "12mo_alcohol.1"              "12mo_tob.1"                 
# [712] "12mo_mj.1"                   "1yr_flavorcig.1"             "1yr_amt_ecig.1"             
# [715] "amt_ecig.1"                  "1yr_dose_ecig.1"             "dose_ecig.1"                
# [718] "ecig_nicotine.1"             "modeadmin_mj.1"              "strain_mj.1"                
# [721] "potent_mj.1"                 "highpotent_mj.1"             "1yr_high_mj.1"              
# [724] "1yr_vhigh_mj.1"              "type_mjconc.1"               "modeadmin_mjconc.1"         
# [727] "potent_mjconc.1"             "highpotent_mjconc.1"         "doc_mj.1"                   
# [730] "mom_mj.1"                    "dad_mj.1"                    "guard_mj.1"                 
# [733] "unc_aunt_mj.1"               "sibling_mj.1"                "young_sib_mj.1"             
# [736] "other_fam_mj.1"              "adult_mj.1"                  "friendsell_mj.1"            
# [739] "friend_mj.1"                 "dealer_mj.1"                 "fam_medmj.1"                
# [742] "stranger_medmj.1"            "other_medmj.1"               "other_mj.1"                 
# [745] "type_edible.1"               "type_drinkmj.1"              "type_tincture.1"            
# [748] "cbd_use.1"                   "cbd_onset.1"                 "cbd_epidolex.1"             
# [751] "cbd_oil.1"                   "cbd_smoke.1"                 "cbd_edible.1"               
# [754] "cbd_topical.1"               "cbd_vape.1"                  "tlfb_alcohol.2"             
# [757] "tlfb_tob.2"                  "tlfb_mj.2"                   "tlfb_mjsynth.2"             
# [760] "alc_sip.2"                   "full_alc.2"                  "tob_puff.2"                 
# [763] "cig_use.2"                   "ecig_use.2"                  "chew_use.2"                 
# [766] "cigar_use.2"                 "hookah_use.2"                "pipes_use.2"                
# [769] "nictoinereplace.2"           "mj_puff.2"                   "mj_use.2"                   
# [772] "blunt_use.2"                 "edible_use.2"                "mj_conc_use.2"              
# [775] "mj_drink_use.2"              "tincture_use.2"              "mj_synth_use.2"             
# [778] "totallast_alc_sip.2"         "alc_sip_relg.2"              "total_alc_relg.2"           
# [781] "age_alc_sip.2"               "cont_alc_sip.2"              "type_alc_sip.2"             
# [784] "belong_alc_sip.2"            "offer_alc_sip.2"             "last_tob_puff.2"            
# [787] "totallast_tob_puff.2"        "type_tob_puff.2"             "age_tob_puff.2"             
# [790] "cont_tob_puff.2"             "flavor_tob_puff.2"           "type_chew.2"                
# [793] "age_chew.2"                  "cont_chew.2"                 "flavor_chew.2"              
# [796] "totallast_mj.2"              "age_mj.2"                    "cont_mj.2"                  
# [799] "type_mj.2"                   "high_mj.2"                   "belong_mj.2"                
# [802] "offer_mj.2"                  "alcohol_onset.2"             "cig_onset.2"                
# [805] "ecig_onset.2"                "chew_onset.2"                "cigar_onset.2"              
# [808] "hookah_onset.2"              "pipe_onset.2"                "nicreplace_onset.2"         
# [811] "mj_onset.2"                  "blunt_onset.2"               "edible_onset.2"             
# [814] "mj_conc_onset.2"             "mj_drink_onset.2"            "tincture_onset.2"           
# [817] "mj_synth_onset.2"            "12mo_alcohol.2"              "12mo_tob.2"                 
# [820] "12mo_mj.2"                   "1yr_flavorcig.2"             "1yr_amt_ecig.2"             
# [823] "amt_ecig.2"                  "1yr_dose_ecig.2"             "dose_ecig.2"                
# [826] "ecig_nicotine.2"             "modeadmin_mj.2"              "strain_mj.2"                
# [829] "potent_mj.2"                 "highpotent_mj.2"             "1yr_high_mj.2"              
# [832] "1yr_vhigh_mj.2"              "type_mjconc.2"               "modeadmin_mjconc.2"         
# [835] "potent_mjconc.2"             "highpotent_mjconc.2"         "doc_mj.2"                   
# [838] "mom_mj.2"                    "dad_mj.2"                    "guard_mj.2"                 
# [841] "unc_aunt_mj.2"               "sibling_mj.2"                "young_sib_mj.2"             
# [844] "other_fam_mj.2"              "adult_mj.2"                  "friendsell_mj.2"            
# [847] "friend_mj.2"                 "dealer_mj.2"                 "fam_medmj.2"                
# [850] "stranger_medmj.2"            "other_medmj.2"               "other_mj.2"                 
# [853] "type_edible.2"               "type_drinkmj.2"              "type_tincture.2"            
# [856] "cbd_use.2"                   "cbd_onset.2"                 "cbd_epidolex.2"             
# [859] "cbd_oil.2"                   "cbd_smoke.2"                 "cbd_edible.2"               
# [862] "cbd_topical.2"               "cbd_vape.2"                  "alc_sip.0"                  
# [865] "alc_use.0"                   "tob_puff.0"                  "cig_use.0"                  
# [868] "ecig_use.0"                  "chew_use.0"                  "mj_puff.0"                  
# [871] "mj_use.0"                    "blunt_use.0"                 "edible_use.0"               
# [874] "mj_conc_use.0"               "mj_drink_use.0"              "tincture_use.0"             
# [877] "mj_synth_use.0"              "total_sip.0"                 "isip_1b_2"                  
# [880] "alcohol_onset.0"             "reg_alcohol.0"               "regulalcohol_onset.0"       
# [883] "age_puff.0"                  "cont_puff.0"                 "age_chew.0"                 
# [886] "cont_chew.0"                 "cig_onset.0"                 "cigregul_onset.0"           
# [889] "ecig_onset.0"                "ecigreful_onset.0"           "chew_onset.0"               
# [892] "regul_chew.0"                "regulchew_onset.0"           "total_mjpuff.0"             
# [895] "age_mjpuff.0"                "cont_mjpuff.0"               "mj_onset.0"                 
# [898] "regul_mj.0"                  "regulmj_onset.0"             "blunt_onset.0"              
# [901] "regul_blunt.0"               "regulblunt_onset.0"          "edible_onset.0"             
# [904] "regul_edible.0"              "reguledible_onset.0"         "mjconc_onset.0"             
# [907] "regul_mjconc.0"              "regulmjconc_onset.0"         "xcalc_mj_drink"             
# [910] "regul_mjdrink.0"             "regulmjdrink_onset.0"        "tincture_onset.0"           
# [913] "regul_tincture.0"            "regultincture_onset.0"       "mjsynth_onset.0"            
# [916] "regul_mjsynth"               "regulmjsynth_onset.0"        "6mo_alcohol.0"              
# [919] "6mo_tobacco.0"               "6mo_ecig.0"                  "6mo_mj.0"                   
# [922] "6mo_blunt.0"                 "6mo_edible.0"                "6mo_mjconc.0"               
# [925] "6mo_mjdrink.0"               "6mo_tincture.0"              "6mo_mj_potent.0"            
# [928] "6mo_mj_highpotent.0"         "6mo_mj_high.0"               "6mo_mjvhigh.0"              
# [931] "6mo_type_mjconc.0"           "6mo_mj_route.0"              "6mo_mjconc_potent.0"        
# [934] "6mo_mjconc_hpotent.0"        "6mo_totalalcohol.0"          "6mo_totalcig.0"             
# [937] "6mo_totalmj.0"               "age.0.y"                     "site_id.0"                  
# [940] "age.2.y"                     "site_id.2"                   "age.1.y"                    
# [943] "site_id.1"                   "age.1"                       "weight_ps.1"                
# [946] "age.0"                       "fam_id.0"                    "fam_rel.0"                  
# [949] "weight_ps.0"                

sub_nd_su = nd_su[,-c(8, 10, 16, 17, 22, 24, 26, 30, 212:215, 218:221, 938, 940, 942, 944, 946)]

colnames(sub_nd_su)
# [1] "id"                          "caretaker"                   "m_educ"                     
# [4] "p_educ"                      "biomom.x"                    "c_race"                     
# [7] "p_race"                      "sex"                         "weight"                     
# [10] "m_age"                       "p_age"                       "plan_preg"                  
# [13] "weeks_preg"                  "b_alcohol"                   "b_alc_max"                  
# [16] "b_alc_avgpwk"                "b_alc_drinkseff"             "b_THC_amtpday"              
# [19] "a_tob_cigspday"              "a_alc_max"                   "a_alc_avgpwk"               
# [22] "a_alc_drinkseff"             "a_THC_amtpday"               "prenatal"                   
# [25] "nausea"                      "doctor_visit"                "premature"                  
# [28] "wks_premature"               "months_breastfed"            "rollover"                   
# [31] "sit"                         "walk"                        "firstword"                  
# [34] "motordev"                    "speechdev"                   "wetbed"                     
# [37] "age_stopwetbed"              "Pre_Tobacco"                 "Pre_Alcohol"                
# [40] "Pre_THC"                     "Pre_AlcTob"                  "Pre_AlcTHC"                 
# [43] "Pre_TobTHC"                  "Pre_AlcTobTHC"               "m_imed_alcohol"             
# [46] "p_imed_alcohol"              "m_imed_drug"                 "p_imed_drug"                
# [49] "m_imed_depres"               "p_imed_depres"               "age.0.x"                    
# [52] "safe_walk.0"                 "violence.0"                  "safe_crime.0"               
# [55] "age.2.x"                     "safe_walk.2"                 "violence.2"                 
# [58] "safe_crime.2"                "age.1.x"                     "safe_walk.1"                
# [61] "violence.1"                  "safe_crime.1"                "total_neigh.0"              
# [64] "total_neigh.1"               "total_neigh.2"               "trouble"                    
# [67] "insult"                      "finish"                      "africa"                     
# [70] "deal"                        "turn_taking"                 "enjoy"                      
# [73] "open_present"                "ski_slope"                   "cry"                        
# [76] "angry_hit"                   "care"                        "share"                      
# [79] "before_hw"                   "concentrate"                 "city_move"                  
# [82] "right_away"                  "spend_time"                  "rude"                       
# [85] "annoyed"                     "irritate_crit"               "distracted"                 
# [88] "impulse"                     "hugs"                        "blame"                      
# [91] "sad"                         "social"                      "sea_dive"                   
# [94] "travel"                      "worry"                       "irritated_place"            
# [97] "doorslam"                    "hardly_sad"                  "race_car"                   
# [100] "try_focus"                   "finish_hw"                   "school_excite"              
# [103] "early_start"                 "peripheral"                  "energized"                  
# [106] "makes_fun"                   "no_criticize"                "close_rel"                  
# [109] "is_shy"                      "irritated_enjoy"             "puts_off"                   
# [112] "laugh_control"               "attachement"                 "sidetracked"                
# [115] "not_shy"                     "friendly"                    "seems_sad"                  
# [118] "ball_scared"                 "meet"                        "dark_scared"                
# [121] "rides_scared"                "disagree"                    "frustrated"                 
# [124] "stick_to_plan"               "close_attention"             "alone"                      
# [127] "shy_meet"                    "upps_neg_urgency.2"          "upps_lack_of_planning.2"    
# [130] "upps_sensation_seek.2"       "upps_pos_urgency.2"          "upps_lack_of_perseverance.2"
# [133] "bis.2"                       "bas_reward_respon.2"         "bas_drive.2"                
# [136] "bas_fun_seek.2"              "bis_mod.2"                   "bas_mod_reward_respon.2"    
# [139] "bas_mod_drive.2"             "delinq.2"                    "pexp_relational_victim.2"   
# [142] "pexp_reputation.2"           "pexp_reptuation_vict.2"      "pexp_overt_aggres.2"        
# [145] "pexp_overt_vict.2"           "pexp_relational_aggres.2"    "upps_neg_urgency.1"         
# [148] "upps_lack_of_planning.1"     "upps_sensation_seek.1"       "upps_pos_urgency.1"         
# [151] "upps_lack_of_perseverance.1" "bis.1"                       "bas_reward_respon.1"        
# [154] "bas_drive.1"                 "bas_fun_seek.1"              "bis_mod.1"                  
# [157] "bas_mod_reward_respon.1"     "bas_mod_drive.1"             "delinq.1"                   
# [160] "pexp_relational_victim.1"    "pexp_reputation.1"           "pexp_reptuation_vict.1"     
# [163] "pexp_overt_aggres.1"         "pexp_overt_vict.1"           "pexp_relational_aggres.1"   
# [166] "upps_neg_urgency.0"          "upps_lack_of_planning.0"     "upps_sensation_seek.0"      
# [169] "upps_pos_urgency.0"          "upps_lack_of_perseverance.0" "bis.0"                      
# [172] "bas_reward_respon.0"         "bas_drive.0"                 "bas_fun_seek.0"             
# [175] "bis_mod.0"                   "bas_mod_reward_respon.0"     "bas_mod_drive.0"            
# [178] "delinq.0"                    "pexp_relational_victim.0"    "pexp_reputation.0"          
# [181] "pexp_reptuation_vict.0"      "pexp_overt_aggres.0"         "pexp_overt_vict.0"          
# [184] "pexp_relational_aggres.0"    "upps_neg_urgency.3"          "upps_lack_of_planning.3"    
# [187] "upps_sensation_seek.3"       "upps_pos_urgency.3"          "upps_lack_of_perseverance.3"
# [190] "bis.3"                       "bas_reward_respon.3"         "bas_drive.3"                
# [193] "bas_fun_seek.3"              "bis_mod.3"                   "bas_mod_reward_respon.3"    
# [196] "bas_mod_drive.3"             "delinq.3"                    "pexp_relational_victim.3"   
# [199] "pexp_reputation.3"           "pexp_reptuation_vict.3"      "pexp_overt_aggres.3"        
# [202] "pexp_overt_vict.3"           "pexp_relational_aggres.3"    "flanker_cortscore.0"        
# [205] "dccs_cortscore.0"            "flanker_cortscore.2"         "dccs_cortscore.2"           
# [208] "bpm_attention_t.3"           "bpm_internal_t.3"            "bpm_external_t.3"           
# [211] "bpm_total_t.3"               "bpm_attention_t.0"           "bpm_internal_t.0"           
# [214] "bpm_external_t.0"            "bpm_total_t.0"               "bpm_attention_t.1"          
# [217] "bpm_internal_t.1"            "bpm_external_t.1"            "bpm_total_t.1"              
# [220] "bpm_attention_t.2"           "bpm_internal_t.2"            "bpm_external_t.2"           
# [223] "bpm_total_t.2"               "bpm_y_attention_t.1"         "bpm_y_internal_t.1"         
# [226] "bpm_y_external_t.1"          "bpm_y_total_t.1"             "bpm_y_attention_t.2"        
# [229] "bpm_y_internal_t.2"          "bpm_y_external_t.2"          "bpm_y_total_t.2"            
# [232] "bpm_y_attention_t.3"         "bpm_y_internal_t.3"          "bpm_y_external_t.3"         
# [235] "bpm_y_total_t.3"             "cbcl_anxdep_t.3"             "cbcl_withdep_t.3"           
# [238] "cbcl_somatic_t.3"            "cbcl_social_t.3"             "cbcl_thought_t.3"           
# [241] "cbcl_atten_t.3"              "cbcl_rulebreak_t.3"          "cbcl_aggres_t.3"            
# [244] "cbcl_internal_t.3"           "cbcl_ext_t.3"                "cbcl_total_t.3"             
# [247] "cbcl_depress_t.3"            "cbcl_anxdisord_t.3"          "cbcl_somatic_t.3.1"         
# [250] "cbcl_adhd_t.3"               "cbcl_oppositdef_t.3"         "cbcl_conduct_t.3"           
# [253] "cbcl_stress_t.3"             "cbcl_anxdep_t.2"             "cbcl_withdep_t.2"           
# [256] "cbcl_somatic_t.2"            "cbcl_social_t.2"             "cbcl_thought_t.2"           
# [259] "cbcl_atten_t.2"              "cbcl_rulebreak_t.2"          "cbcl_aggres_t.2"            
# [262] "cbcl_internal_t.2"           "cbcl_ext_t.2"                "cbcl_total_t.2"             
# [265] "cbcl_depress_t.2"            "cbcl_anxdisord_t.2"          "cbcl_somatic_t.2.1"         
# [268] "cbcl_adhd_t.2"               "cbcl_oppositdef_t.2"         "cbcl_conduct_t.2"           
# [271] "cbcl_stress_t.2"             "cbcl_anxdep_t.1"             "cbcl_withdep_t.1"           
# [274] "cbcl_somatic_t.1"            "cbcl_social_t.1"             "cbcl_thought_t.1"           
# [277] "cbcl_atten_t.1"              "cbcl_rulebreak_t.1"          "cbcl_aggres_t.1"            
# [280] "cbcl_internal_t.1"           "cbcl_ext_t.1"                "cbcl_total_t.1"             
# [283] "cbcl_depress_t.1"            "cbcl_anxdisord_t.1"          "cbcl_somatic_t.1.1"         
# [286] "cbcl_adhd_t.1"               "cbcl_oppositdef_t.1"         "cbcl_conduct_t.1"           
# [289] "cbcl_stress_t.1"             "cbcl_anxdep_t.0"             "cbcl_withdep_t.0"           
# [292] "cbcl_somatic_t.0"            "cbcl_social_t.0"             "cbcl_thought_t.0"           
# [295] "cbcl_atten_t.0"              "cbcl_rulebreak_t.0"          "cbcl_aggres_t.0"            
# [298] "cbcl_internal_t.0"           "cbcl_ext_t.0"                "cbcl_total_t.0"             
# [301] "cbcl_depress_t.0"            "cbcl_anxdisord_t.0"          "cbcl_somatic_t.0.1"         
# [304] "cbcl_adhd_t.0"               "cbcl_oppositdef_t.0"         "cbcl_conduct_t.0"           
# [307] "cbcl_stress_t.0"             "pers_dep_present.1"          "pers_dep_past.1"            
# [310] "pers_dep_remi.1"             "mdd_present.1"               "mdd_remi.1"                 
# [313] "mdd_past.1"                  "dmdd.1"                      "panic_present.1"            
# [316] "panic_past.1"                "agroaphobia_present.1"       "agroaphobia_past.1"         
# [319] "sep_anx_present.1"           "sep_anx_past.1"              "soc_anx_past.1"             
# [322] "soc_anx_present.1"           "spec_phobia_past.1"          "spec_phobia_present.1"      
# [325] "gad_present.1"               "gad_past.1"                  "ocd_present.1"              
# [328] "ocd_past.1"                  "adhd_rem.1"                  "adhd_present.1"             
# [331] "adhd_past.1"                 "odd_present.1"               "odd_past.1"                 
# [334] "conduct_adol_past.1"         "conduct_child_pres.1"        "conduct_child_past.1"       
# [337] "conduct_adol_pres.1"         "aud_present.1"               "aud_past.1"                 
# [340] "stimulant_coc_pres.1"        "stimulant_coc_past.1"        "stimulant_amph_pres.1"      
# [343] "stimulant_amph_past.1"       "sud_present.1"               "sud_past.1"                 
# [346] "cud_past.1"                  "cud_present.1"               "ptsd_present.1"             
# [349] "ptsd_past.1"                 "sleep_past.1"                "sleep_present.1"            
# [352] "si_passive_present.1"        "si_passsive_past.1"          "si_present.1"               
# [355] "si_past.1"                   "self_inj_past.1"             "self_inj_present.1"         
# [358] "pers_dep_present.2"          "pers_dep_past.2"             "pers_dep_remi.2"            
# [361] "mdd_present.2"               "mdd_remi.2"                  "mdd_past.2"                 
# [364] "dmdd.2"                      "panic_present.2"             "panic_past.2"               
# [367] "agroaphobia_present.2"       "agroaphobia_past.2"          "sep_anx_present.2"          
# [370] "sep_anx_past.2"              "soc_anx_past.2"              "soc_anx_present.2"          
# [373] "spec_phobia_past.2"          "spec_phobia_present.2"       "gad_present.2"              
# [376] "gad_past.2"                  "ocd_present.2"               "ocd_past.2"                 
# [379] "adhd_rem.2"                  "adhd_present.2"              "adhd_past.2"                
# [382] "odd_present.2"               "odd_past.2"                  "conduct_adol_past.2"        
# [385] "conduct_child_pres.2"        "conduct_child_past.2"        "conduct_adol_pres.2"        
# [388] "aud_present.2"               "aud_past.2"                  "stimulant_coc_pres.2"       
# [391] "stimulant_coc_past.2"        "stimulant_amph_pres.2"       "stimulant_amph_past.2"      
# [394] "sud_present.2"               "sud_past.2"                  "cud_past.2"                 
# [397] "cud_present.2"               "ptsd_present.2"              "ptsd_past.2"                
# [400] "sleep_past.2"                "sleep_present.2"             "si_passive_present.2"       
# [403] "si_passsive_past.2"          "si_present.2"                "si_past.2"                  
# [406] "self_inj_past.2"             "self_inj_present.2"          "pers_dep_present.0"         
# [409] "pers_dep_past.0"             "pers_dep_remi.0"             "mdd_present.0"              
# [412] "mdd_remi.0"                  "mdd_past.0"                  "dmdd.0"                     
# [415] "panic_present.0"             "panic_past.0"                "agroaphobia_present.0"      
# [418] "agroaphobia_past.0"          "sep_anx_present.0"           "sep_anx_past.0"             
# [421] "soc_anx_past.0"              "soc_anx_present.0"           "spec_phobia_past.0"         
# [424] "spec_phobia_present.0"       "gad_present.0"               "gad_past.0"                 
# [427] "ocd_present.0"               "ocd_past.0"                  "adhd_rem.0"                 
# [430] "adhd_present.0"              "adhd_past.0"                 "odd_present.0"              
# [433] "odd_past.0"                  "conduct_adol_past.0"         "conduct_child_pres.0"       
# [436] "conduct_child_past.0"        "conduct_adol_pres.0"         "aud_present.0"              
# [439] "aud_past.0"                  "stimulant_coc_pres.0"        "stimulant_coc_past.0"       
# [442] "stimulant_amph_pres.0"       "stimulant_amph_past.0"       "sud_present.0"              
# [445] "sud_past.0"                  "cud_past.0"                  "cud_present.0"              
# [448] "ptsd_present.0"              "ptsd_past.0"                 "sleep_past.0"               
# [451] "sleep_present.0"             "si_passive_present.0"        "si_passsive_past.0"         
# [454] "si_present.0"                "si_past.0"                   "self_inj_past.0"            
# [457] "self_inj_present.0"          "y_mdd_present.0"             "y_mdd_rem.0"                
# [460] "y_mdd_past.0"                "y_pres_dep_present.0"        "y_pres_dep_rem.0"           
# [463] "y_pres_dep_past.0"           "y_dmdd.0"                    "y_adhd_present.0"           
# [466] "y_adhd_past.0"               "y_adhd_rem.0"                "y_panic_present.0"          
# [469] "y_panic_past.0"              "y_agoraphobia_present.0"     "y_agoraphobia_past.0"       
# [472] "y_sepanx_present.0"          "y_sepanx_past.0"             "y_socanx_present.0"         
# [475] "y_specphob_present.0"        "y_specphob_past.0"           "y_gad_present.0"            
# [478] "y_gad_past.0"                "y_cud_present.0"             "y_cud_past.0"               
# [481] "y_sud_present.0"             "y_sud_past.0"                "y_aud_present.0"            
# [484] "y_aud_past.0"                "y_cd_child_present.0"        "y_cd_adol_present.0"        
# [487] "y_cd_child_past.0"           "y_cd_adol_past.0"            "y_odd_present.0"            
# [490] "y_odd_past.0"                "y_asd.0"                     "y_ocd_present.0"            
# [493] "y_ocd_past.0"                "y_ptsd_present.0"            "y_ptsd_past.0"              
# [496] "y_selfinj_present.0"         "y_si_passive_pres.0"         "y_si_active_pres.0"         
# [499] "ksads_23_948_t.0"            "y_hom_present.0"             "y_hom_past.0"               
# [502] "y_sleep_present.0"           "y_sleep_past.0"              "y_mdd_present.1"            
# [505] "y_mdd_rem.1"                 "y_mdd_past.1"                "y_pres_dep_present.1"       
# [508] "y_pres_dep_rem.1"            "y_pres_dep_past.1"           "y_dmdd.1"                   
# [511] "y_adhd_present.1"            "y_adhd_past.1"               "y_adhd_rem.1"               
# [514] "y_panic_present.1"           "y_panic_past.1"              "y_agoraphobia_present.1"    
# [517] "y_agoraphobia_past.1"        "y_sepanx_present.1"          "y_sepanx_past.1"            
# [520] "y_socanx_present.1"          "y_specphob_present.1"        "y_specphob_past.1"          
# [523] "y_gad_present.1"             "y_gad_past.1"                "y_cud_present.1"            
# [526] "y_cud_past.1"                "y_sud_present.1"             "y_sud_past.1"               
# [529] "y_aud_present.1"             "y_aud_past.1"                "y_cd_child_present.1"       
# [532] "y_cd_adol_present.1"         "y_cd_child_past.1"           "y_cd_adol_past.1"           
# [535] "y_odd_present.1"             "y_odd_past.1"                "y_asd.1"                    
# [538] "y_ocd_present.1"             "y_ocd_past.1"                "y_ptsd_present.1"           
# [541] "y_ptsd_past.1"               "y_selfinj_present.1"         "y_si_passive_pres.1"        
# [544] "y_si_active_pres.1"          "ksads_23_948_t.1"            "y_hom_present.1"            
# [547] "y_hom_past.1"                "y_sleep_present.1"           "y_sleep_past.1"             
# [550] "y_mdd_present.2"             "y_mdd_rem.2"                 "y_mdd_past.2"               
# [553] "y_pres_dep_present.2"        "y_pres_dep_rem.2"            "y_pres_dep_past.2"          
# [556] "y_dmdd.2"                    "y_adhd_present.2"            "y_adhd_past.2"              
# [559] "y_adhd_rem.2"                "y_panic_present.2"           "y_panic_past.2"             
# [562] "y_agoraphobia_present.2"     "y_agoraphobia_past.2"        "y_sepanx_present.2"         
# [565] "y_sepanx_past.2"             "y_socanx_present.2"          "y_specphob_present.2"       
# [568] "y_specphob_past.2"           "y_gad_present.2"             "y_gad_past.2"               
# [571] "y_cud_present.2"             "y_cud_past.2"                "y_sud_present.2"            
# [574] "y_sud_past.2"                "y_aud_present.2"             "y_aud_past.2"               
# [577] "y_cd_child_present.2"        "y_cd_adol_present.2"         "y_cd_child_past.2"          
# [580] "y_cd_adol_past.2"            "y_odd_present.2"             "y_odd_past.2"               
# [583] "y_asd.2"                     "y_ocd_present.2"             "y_ocd_past.2"               
# [586] "y_ptsd_present.2"            "y_ptsd_past.2"               "y_selfinj_present.2"        
# [589] "y_si_passive_pres.2"         "y_si_active_pres.2"          "ksads_23_948_t.2"           
# [592] "y_hom_present.2"             "y_hom_past.2"                "y_sleep_present.2"          
# [595] "y_sleep_past.2"              "wps_info.1"                  "wps_steps.1"                
# [598] "wps_choices.1"               "wps_altways.1"               "wps_altsolveprob.1"         
# [601] "wps_solveprob.1"             "p_crpf_alcohol.0"            "p_crpf_cigarettes.0"        
# [604] "p_crpf_vaping.0"             "p_crpf_marijuana.0"          "p_crpf_alcohol.1"           
# [607] "p_crpf_cigarettes.1"         "p_crpf_vaping.1"             "p_crpf_marijuana.1"         
# [610] "p_crpf_alcohol.2"            "p_crpf_cigarettes.2"         "p_crpf_vaping.2"            
# [613] "p_crpf_marijuana.2"          "p_crpf_alcohol.3"            "p_crpf_cigarettes.3"        
# [616] "p_crpf_vaping.3"             "p_crpf_marijuana.3"          "total_pcrpf.0"              
# [619] "total_pcrpf.1"               "total_pcrpf.2"               "total_pcrpf.3"              
# [622] "y_crpf_alcohol.3"            "y_crpf_cigarettes.3"         "y_crpf_vaping.3"            
# [625] "y_crpf_marijuana.3"          "y_crpf_alcohol.2"            "y_crpf_cigarettes.2"        
# [628] "y_crpf_vaping.2"             "y_crpf_marijuana.2"          "total_ycrpf.2"              
# [631] "total_ycrpf.3"               "tlfb_alcohol.1"              "tlfb_tob.1"                 
# [634] "tlfb_mj.1"                   "tlfb_mjsynth.1"              "alc_sip.1"                  
# [637] "full_alc.1"                  "tob_puff.1"                  "cig_use.1"                  
# [640] "ecig_use.1"                  "chew_use.1"                  "cigar_use.1"                
# [643] "hookah_use.1"                "pipes_use.1"                 "nictoinereplace.1"          
# [646] "mj_puff.1"                   "mj_use.1"                    "blunt_use.1"                
# [649] "edible_use.1"                "mj_conc_use.1"               "mj_drink_use.1"             
# [652] "tincture_use.1"              "mj_synth_use.1"              "totallast_alc_sip.1"        
# [655] "alc_sip_relg.1"              "total_alc_relg.1"            "age_alc_sip.1"              
# [658] "cont_alc_sip.1"              "type_alc_sip.1"              "belong_alc_sip.1"           
# [661] "offer_alc_sip.1"             "last_tob_puff.1"             "totallast_tob_puff.1"       
# [664] "type_tob_puff.1"             "age_tob_puff.1"              "cont_tob_puff.1"            
# [667] "flavor_tob_puff.1"           "type_chew.1"                 "age_chew.1"                 
# [670] "cont_chew.1"                 "flavor_chew.1"               "totallast_mj.1"             
# [673] "age_mj.1"                    "cont_mj.1"                   "type_mj.1"                  
# [676] "high_mj.1"                   "belong_mj.1"                 "offer_mj.1"                 
# [679] "alcohol_onset.1"             "cig_onset.1"                 "ecig_onset.1"               
# [682] "chew_onset.1"                "cigar_onset.1"               "hookah_onset.1"             
# [685] "pipe_onset.1"                "nicreplace_onset.1"          "mj_onset.1"                 
# [688] "blunt_onset.1"               "edible_onset.1"              "mj_conc_onset.1"            
# [691] "mj_drink_onset.1"            "tincture_onset.1"            "mj_synth_onset.1"           
# [694] "12mo_alcohol.1"              "12mo_tob.1"                  "12mo_mj.1"                  
# [697] "1yr_flavorcig.1"             "1yr_amt_ecig.1"              "amt_ecig.1"                 
# [700] "1yr_dose_ecig.1"             "dose_ecig.1"                 "ecig_nicotine.1"            
# [703] "modeadmin_mj.1"              "strain_mj.1"                 "potent_mj.1"                
# [706] "highpotent_mj.1"             "1yr_high_mj.1"               "1yr_vhigh_mj.1"             
# [709] "type_mjconc.1"               "modeadmin_mjconc.1"          "potent_mjconc.1"            
# [712] "highpotent_mjconc.1"         "doc_mj.1"                    "mom_mj.1"                   
# [715] "dad_mj.1"                    "guard_mj.1"                  "unc_aunt_mj.1"              
# [718] "sibling_mj.1"                "young_sib_mj.1"              "other_fam_mj.1"             
# [721] "adult_mj.1"                  "friendsell_mj.1"             "friend_mj.1"                
# [724] "dealer_mj.1"                 "fam_medmj.1"                 "stranger_medmj.1"           
# [727] "other_medmj.1"               "other_mj.1"                  "type_edible.1"              
# [730] "type_drinkmj.1"              "type_tincture.1"             "cbd_use.1"                  
# [733] "cbd_onset.1"                 "cbd_epidolex.1"              "cbd_oil.1"                  
# [736] "cbd_smoke.1"                 "cbd_edible.1"                "cbd_topical.1"              
# [739] "cbd_vape.1"                  "tlfb_alcohol.2"              "tlfb_tob.2"                 
# [742] "tlfb_mj.2"                   "tlfb_mjsynth.2"              "alc_sip.2"                  
# [745] "full_alc.2"                  "tob_puff.2"                  "cig_use.2"                  
# [748] "ecig_use.2"                  "chew_use.2"                  "cigar_use.2"                
# [751] "hookah_use.2"                "pipes_use.2"                 "nictoinereplace.2"          
# [754] "mj_puff.2"                   "mj_use.2"                    "blunt_use.2"                
# [757] "edible_use.2"                "mj_conc_use.2"               "mj_drink_use.2"             
# [760] "tincture_use.2"              "mj_synth_use.2"              "totallast_alc_sip.2"        
# [763] "alc_sip_relg.2"              "total_alc_relg.2"            "age_alc_sip.2"              
# [766] "cont_alc_sip.2"              "type_alc_sip.2"              "belong_alc_sip.2"           
# [769] "offer_alc_sip.2"             "last_tob_puff.2"             "totallast_tob_puff.2"       
# [772] "type_tob_puff.2"             "age_tob_puff.2"              "cont_tob_puff.2"            
# [775] "flavor_tob_puff.2"           "type_chew.2"                 "age_chew.2"                 
# [778] "cont_chew.2"                 "flavor_chew.2"               "totallast_mj.2"             
# [781] "age_mj.2"                    "cont_mj.2"                   "type_mj.2"                  
# [784] "high_mj.2"                   "belong_mj.2"                 "offer_mj.2"                 
# [787] "alcohol_onset.2"             "cig_onset.2"                 "ecig_onset.2"               
# [790] "chew_onset.2"                "cigar_onset.2"               "hookah_onset.2"             
# [793] "pipe_onset.2"                "nicreplace_onset.2"          "mj_onset.2"                 
# [796] "blunt_onset.2"               "edible_onset.2"              "mj_conc_onset.2"            
# [799] "mj_drink_onset.2"            "tincture_onset.2"            "mj_synth_onset.2"           
# [802] "12mo_alcohol.2"              "12mo_tob.2"                  "12mo_mj.2"                  
# [805] "1yr_flavorcig.2"             "1yr_amt_ecig.2"              "amt_ecig.2"                 
# [808] "1yr_dose_ecig.2"             "dose_ecig.2"                 "ecig_nicotine.2"            
# [811] "modeadmin_mj.2"              "strain_mj.2"                 "potent_mj.2"                
# [814] "highpotent_mj.2"             "1yr_high_mj.2"               "1yr_vhigh_mj.2"             
# [817] "type_mjconc.2"               "modeadmin_mjconc.2"          "potent_mjconc.2"            
# [820] "highpotent_mjconc.2"         "doc_mj.2"                    "mom_mj.2"                   
# [823] "dad_mj.2"                    "guard_mj.2"                  "unc_aunt_mj.2"              
# [826] "sibling_mj.2"                "young_sib_mj.2"              "other_fam_mj.2"             
# [829] "adult_mj.2"                  "friendsell_mj.2"             "friend_mj.2"                
# [832] "dealer_mj.2"                 "fam_medmj.2"                 "stranger_medmj.2"           
# [835] "other_medmj.2"               "other_mj.2"                  "type_edible.2"              
# [838] "type_drinkmj.2"              "type_tincture.2"             "cbd_use.2"                  
# [841] "cbd_onset.2"                 "cbd_epidolex.2"              "cbd_oil.2"                  
# [844] "cbd_smoke.2"                 "cbd_edible.2"                "cbd_topical.2"              
# [847] "cbd_vape.2"                  "alc_sip.0"                   "alc_use.0"                  
# [850] "tob_puff.0"                  "cig_use.0"                   "ecig_use.0"                 
# [853] "chew_use.0"                  "mj_puff.0"                   "mj_use.0"                   
# [856] "blunt_use.0"                 "edible_use.0"                "mj_conc_use.0"              
# [859] "mj_drink_use.0"              "tincture_use.0"              "mj_synth_use.0"             
# [862] "total_sip.0"                 "isip_1b_2"                   "alcohol_onset.0"            
# [865] "reg_alcohol.0"               "regulalcohol_onset.0"        "age_puff.0"                 
# [868] "cont_puff.0"                 "age_chew.0"                  "cont_chew.0"                
# [871] "cig_onset.0"                 "cigregul_onset.0"            "ecig_onset.0"               
# [874] "ecigreful_onset.0"           "chew_onset.0"                "regul_chew.0"               
# [877] "regulchew_onset.0"           "total_mjpuff.0"              "age_mjpuff.0"               
# [880] "cont_mjpuff.0"               "mj_onset.0"                  "regul_mj.0"                 
# [883] "regulmj_onset.0"             "blunt_onset.0"               "regul_blunt.0"              
# [886] "regulblunt_onset.0"          "edible_onset.0"              "regul_edible.0"             
# [889] "reguledible_onset.0"         "mjconc_onset.0"              "regul_mjconc.0"             
# [892] "regulmjconc_onset.0"         "xcalc_mj_drink"              "regul_mjdrink.0"            
# [895] "regulmjdrink_onset.0"        "tincture_onset.0"            "regul_tincture.0"           
# [898] "regultincture_onset.0"       "mjsynth_onset.0"             "regul_mjsynth"              
# [901] "regulmjsynth_onset.0"        "6mo_alcohol.0"               "6mo_tobacco.0"              
# [904] "6mo_ecig.0"                  "6mo_mj.0"                    "6mo_blunt.0"                
# [907] "6mo_edible.0"                "6mo_mjconc.0"                "6mo_mjdrink.0"              
# [910] "6mo_tincture.0"              "6mo_mj_potent.0"             "6mo_mj_highpotent.0"        
# [913] "6mo_mj_high.0"               "6mo_mjvhigh.0"               "6mo_type_mjconc.0"          
# [916] "6mo_mj_route.0"              "6mo_mjconc_potent.0"         "6mo_mjconc_hpotent.0"       
# [919] "6mo_totalalcohol.0"          "6mo_totalcig.0"              "6mo_totalmj.0"              
# [922] "site_id.0"                   "site_id.2"                   "site_id.1"                  
# [925] "weight_ps.1"                 "fam_id.0"                    "fam_rel.0"                  
# [928] "weight_ps.0"       

sub_nd_su[, c(8)][sub_nd_su[, c(8)] == "M"] <- 0
sub_nd_su[, c(8)][sub_nd_su[, c(8)] == "F"] <- 1

sub_nd_su[, c(11)][sub_nd_su[, c(11)] == 389] <- NA
sub_nd_su[, c(11)][sub_nd_su[, c(11)] == 332] <- NA

table(sub_nd_su$p_age, useNA = "ifany")

table(sub_nd_su$sex, useNA = "ifany")
# 0    1 
# 6196 5680

#0 = Male
#1 = Female

sub_nd_su[,c(2:928)]<-as.data.frame(apply(sub_nd_su[,c(2:928)],2,as.numeric))

write.csv(sub_nd_su, "sub_nd_su.csv", row.names=FALSE, quote = FALSE, na="NA" )

#Cross Tables
install.packages("gmodels")
library(gmodels)

CrossTable(sub_nd_su$Pre_THC, sub_nd_su$alc_sip.0)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$alc_sip.1)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$alc_sip.2)

CrossTable(sub_nd_su$Pre_THC, sub_nd_su$mj_puff.0)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$mj_puff.1)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$mj_puff.2)

CrossTable(sub_nd_su$Pre_THC, sub_nd_su$tob_puff.0)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$tob_puff.1)
CrossTable(sub_nd_su$Pre_THC, sub_nd_su$tob_puff.2)

#mean, min, max sd for maternal age
round(mean(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)
min(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==0)], na.rm=T)
max(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==0)], na.rm=T)
round(sd(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)
min(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==1)], na.rm=T)
max(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==1)], na.rm=T)
round(sd(sub_nd_su$m_age[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max, sd for paternal age
round(mean(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)
min(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==0)], na.rm=T)
max(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==0)], na.rm=T)
round(sd(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)
min(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==1)], na.rm=T)
max(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==1)], na.rm=T)
round(sd(sub_nd_su$p_age[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max sd for child age @ baseline
round(mean(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)
min(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
max(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
round(sd(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)
min(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
max(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
round(sd(sub_nd_su$age.0.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max sd for child age @ 1 year
round(mean(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)
min(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
max(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
round(sd(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)
min(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
max(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
round(sd(sub_nd_su$age.1.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)

#mean, min, max sd for child age @ 2 year
round(mean(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)
min(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
max(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==0)], na.rm=T)
round(sd(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==0)], na.rm=T), digits = 2)

round(mean(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)
min(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
max(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==1)], na.rm=T)
round(sd(sub_nd_su$age.2.x[which(sub_nd_su$Pre_THC==1)], na.rm=T), digits = 2)


