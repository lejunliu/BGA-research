setwd("/Volumes/bga_lab/DATA_REPOSITORIES/ABCD/ABCD_5.0")


library(dplyr)

# Cleaninig for ABCD parent life events
#Add path and file name
parent_life_events <- read.csv("mh_p_le.csv", header = TRUE)
dim(parent_life_events) 
# [1] 49151   143

#Look at column names to determine which variables to remove
colnames(parent_life_events)
# [1] "src_subject_id"              "eventname"                   "ple_p_select_language___1"   "ple_died_p"                  "ple_died_past_yr_p"          "ple_died_fu_p"               "ple_died_fu2_p"              "ple_injured_p"              
# [9] "ple_injur_p_p"               "ple_injured_fu_p"            "ple_injured_fu2_p"           "ple_crime_p"                 "ple_crime_past_yr_p"         "ple_crime_fu_p"              "ple_crime_fu2_p"             "ple_friend_p"               
# [17] "ple_friend_past_yr_p"        "ple_friend_fu_p"             "ple_friend_fu2_p"            "ple_friend_injur_p"          "ple_friend_injur_past_yr_p"  "ple_friend_injur_fu_p"       "ple_friend_injur_fu2_p"      "ple_financial_p"            
# [25] "ple_financial_past_yr_p"     "ple_financial_fu_p"          "ple_financial_fu2_p"         "ple_sud_p"                   "ple_sud_past_yr_p"           "ple_sud_fu_p"                "ple_sud_fu2_p"               "ple_ill_p"                  
# [33] "ple_ill_past_yr_p"           "ple_ill_fu_p"                "ple_ill_fu2_p"               "ple_injur_p"                 "ple_injur_p_past"            "ple_injur_fu_p"              "ple_injur_fu2_p"             "ple_argue_p"                
# [41] "ple_argue_past_yr_p"         "ple_argue_fu_p"              "ple_argue_fu2_p"             "ple_job_p"                   "ple_job_past_yr_p"           "ple_job_fu_p"                "ple_job_fu2_p"               "ple_away_p"                 
# [49] "ple_away_past_yr_p"          "ple_away_fu_p"               "ple_away_fu2_p"              "ple_arrest_p"                "ple_arrest_past_yr_p"        "ple_arrest_fu_p"             "ple_arrest_fu2_p"            "ple_friend_died_p"          
# [57] "ple_friend_died_past_yr_p"   "ple_friend_died_fu_p"        "ple_friend_died_fu2_p"       "ple_mh_p"                    "ple_mh_past_yr_p"            "ple_mh_fu_p"                 "ple_mh_fu2_p"                "ple_sib_p"                  
# [65] "ple_sib_past_yr_p"           "ple_sib_fu_p"                "ple_sib_fu2_p"               "ple_victim_p"                "ple_victim_past_yr_p"        "ple_victim_fu_p"             "ple_victim_fu2_p"            "ple_separ_p"                
# [73] "ple_separ_past_yr_p"         "ple_separ_fu_p"              "ple_separ_fu2_p"             "ple_law_p"                   "ple_law_past_yr_p"           "ple_law_fu_p"                "ple_law_fu2_p"               "ple_school_p"               
# [81] "ple_school_past_yr_p"        "ple_school_fu_p"             "ple_school_fu2_p"            "ple_move_p"                  "ple_move_past_yr_p"          "ple_move_fu_p"               "ple_move_fu2_p"              "ple_jail_p"                 
# [89] "ple_jail_past_yr_p"          "ple_jail_fu_p"               "ple_jail_fu2_p"              "ple_step_p"                  "ple_step_past_yr_p"          "ple_step_fu_p"               "ple_step_fu2_p"              "ple_new_job_p"              
# [97] "ple_new_job_past_yr_p"       "ple_new_job_fu_p"            "ple_new_job_fu2_p"           "ple_new_sib_p"               "ple_new_sib_past_yr_p"       "ple_new_sib_fu_p"            "ple_new_sib_fu2_p"           "ple_hospitalized_fu2_p"     
# [105] "ple_foster_care_p"           "ple_foster_care_time_p"      "ple_foster_care_past_yr_p"   "ple_foster_care_fu_p"        "ple_foster_care_fu2_p"       "ple_hit_p"                   "ple_hit_past_yr_p"           "ple_hit_fu_p"               
# [113] "ple_hit_fu2_p"               "ple_shot_p"                  "ple_shot_past_yr_p"          "ple_shot_fu_p"               "ple_shot_fu2_p"              "ple_lockdown_p"              "ple_lockdown_past_yr_p"      "ple_lockdown_fu_p"          
# [121] "ple_lockdown_fu2_p"          "ple_homeless_p"              "ple_homeless_past_yr_p"      "ple_deported_p"              "ple_homeless_fu_p"           "ple_homeless_fu2_p"          "ple_deported_past_yr_p"      "ple_deported_fu_p"          
# [129] "ple_deported_fu2_p"          "ple_hospitalized_p"          "ple_hospitalized_past_yr_p"  "ple_hospitalized_fu_p"       "ple_p_ss_total_number"       "ple_p_ss_total_number_nm"    "ple_p_ss_total_number_nt"    "ple_p_ss_total_good"        
# [137] "ple_p_ss_total_bad"          "ple_p_ss_affected_good_sum"  "ple_p_ss_affected_good_mean" "ple_p_ss_affected_bad_sum"   "ple_p_ss_affected_bad_mean"  "ple_p_ss_affected_mean"      "ple_p_ss_affect_sum"      

#Rename variables
names(parent_life_events)[names(parent_life_events) == "src_subject_id"] = "id"
names(parent_life_events)[names(parent_life_events) == "eventname"] = "eventname"
names(parent_life_events)[names(parent_life_events) == "ple_p_select_language___1"] = "language"

names(parent_life_events)[names(parent_life_events) == "ple_died_p"] = "family_death"
names(parent_life_events)[names(parent_life_events) == "ple_died_past_yr_p"] = "past_year_family_death"
names(parent_life_events)[names(parent_life_events) == "ple_died_fu_p"] = "family_death_experience"
names(parent_life_events)[names(parent_life_events) == "ple_died_fu2_p"] = "family_death_effects"

names(parent_life_events)[names(parent_life_events) == "ple_injured_p"] = "family_injury"
names(parent_life_events)[names(parent_life_events) == "ple_injur_p_p"] = "past_year_family_injury"
names(parent_life_events)[names(parent_life_events) == "ple_injured_fu_p"] = "family_injury_experience"
names(parent_life_events)[names(parent_life_events) == "ple_injured_fu2_p"] = "family_injury_effects"

names(parent_life_events)[names(parent_life_events) == "ple_crime_p"] = "crime"
names(parent_life_events)[names(parent_life_events) == "ple_crime_past_yr_p"] = "past_year_crime"
names(parent_life_events)[names(parent_life_events) == "ple_crime_fu_p"] = "crime_experience"
names(parent_life_events)[names(parent_life_events) == "ple_crime_fu2_p"] = "crime_effects"

names(parent_life_events)[names(parent_life_events) == "ple_friend_p"] = "friend_loss"
names(parent_life_events)[names(parent_life_events) == "ple_friend_past_yr_p"] = "past_year_friend_lost"
names(parent_life_events)[names(parent_life_events) == "ple_friend_fu_p"] = "friend_lost_experience"
names(parent_life_events)[names(parent_life_events) == "ple_friend_fu2_p"] = "friend_lost_effects"

names(parent_life_events)[names(parent_life_events) == "ple_friend_injur_p"] = "friend_injury"
names(parent_life_events)[names(parent_life_events) == "ple_friend_injur_past_yr_p"] = "past_year_friend_injury"
names(parent_life_events)[names(parent_life_events) == "ple_friend_injur_fu_p"] = "friend_injury_experience"
names(parent_life_events)[names(parent_life_events) == "ple_friend_injur_fu2_p"] = "friend_injury_effects"

names(parent_life_events)[names(parent_life_events) == "ple_financial_p"] = "financial_crisis"
names(parent_life_events)[names(parent_life_events) == "ple_financial_past_yr_p"] = "past_year_financial_crisis"
names(parent_life_events)[names(parent_life_events) == "ple_financial_fu_p"] = "financial_crisis_experience"
names(parent_life_events)[names(parent_life_events) == "ple_financial_fu2_p"] = "financial_crisis_effects"

names(parent_life_events)[names(parent_life_events) == "ple_sud_p"] = "family_drug"
names(parent_life_events)[names(parent_life_events) == "ple_sud_past_yr_p"] = "past_year_family_drug"
names(parent_life_events)[names(parent_life_events) == "ple_sud_fu_p"] = "family_drug_experience"
names(parent_life_events)[names(parent_life_events) == "ple_sud_fu2_p"] = "family_drug_effects"

names(parent_life_events)[names(parent_life_events) == "ple_ill_p"] = "illness"
names(parent_life_events)[names(parent_life_events) == "ple_ill_past_yr_p"] = "past_year_illness"
names(parent_life_events)[names(parent_life_events) == "ple_ill_fu_p"] = "illness_experience"
names(parent_life_events)[names(parent_life_events) == "ple_ill_fu2_p"] = "illness_effects"

names(parent_life_events)[names(parent_life_events) == "ple_injur_p"] = "child_injury"
names(parent_life_events)[names(parent_life_events) == "ple_injur_p_past"] = "past_year_child_injury"
names(parent_life_events)[names(parent_life_events) == "ple_injur_fu_p"] = "child_injury_experience"
names(parent_life_events)[names(parent_life_events) == "ple_injur_fu2_p"] = "child_injury_effects"

names(parent_life_events)[names(parent_life_events) == "ple_argue_p"] = "arguments"
names(parent_life_events)[names(parent_life_events) == "ple_argue_past_yr_p"] = "past_year_arguments"
names(parent_life_events)[names(parent_life_events) == "ple_argue_fu_p"] = "arguments_experience"
names(parent_life_events)[names(parent_life_events) == "ple_argue_fu2_p"] = "arguments_effects"

names(parent_life_events)[names(parent_life_events) == "ple_job_p"] = "job_loss"
names(parent_life_events)[names(parent_life_events) == "ple_job_past_yr_p"] = "past_year_job_loss"
names(parent_life_events)[names(parent_life_events) == "ple_job_fu_p"] = "job_loss_experience"
names(parent_life_events)[names(parent_life_events) == "ple_job_fu2_p"] = "job_loss_effects"

names(parent_life_events)[names(parent_life_events) == "ple_away_p"] = "parents_away"
names(parent_life_events)[names(parent_life_events) == "ple_away_past_yr_p"] = "past_year_parents_away"
names(parent_life_events)[names(parent_life_events) == "ple_away_fu_p"] = "parents_away_experience"
names(parent_life_events)[names(parent_life_events) == "ple_away_fu2_p"] = "parents_away_effects"

names(parent_life_events)[names(parent_life_events) == "ple_arrest_p"] = "family_arrested"
names(parent_life_events)[names(parent_life_events) == "ple_arrest_past_yr_p"] = "past_year_family_arrested"
names(parent_life_events)[names(parent_life_events) == "ple_arrest_fu_p"] = "family_arrested_experience"
names(parent_life_events)[names(parent_life_events) == "ple_arrest_fu2_p"] = "family_arrestedy_effects"

names(parent_life_events)[names(parent_life_events) == "ple_friend_died_p"] = "friend_death"
names(parent_life_events)[names(parent_life_events) == "ple_friend_died_past_yr_p"] = "past_year_friend_death"
names(parent_life_events)[names(parent_life_events) == "ple_friend_died_fu_p"] = "friend_death_experience"
names(parent_life_events)[names(parent_life_events) == "ple_friend_died_fu2_p"] = "friend_death_effects"

names(parent_life_events)[names(parent_life_events) == "ple_mh_p"] = "family_mental_ill"
names(parent_life_events)[names(parent_life_events) == "ple_mh_past_yr_p"] = "past_year_family_mental_ill"
names(parent_life_events)[names(parent_life_events) == "ple_mh_fu_p"] = "family_mental_ill_experience"
names(parent_life_events)[names(parent_life_events) == "ple_mh_fu2_p"] = "family_mental_ill_effects"

names(parent_life_events)[names(parent_life_events) == "ple_sib_p"] = "sibling_left"
names(parent_life_events)[names(parent_life_events) == "ple_sib_past_yr_p"] = "past_year_sibling_left"
names(parent_life_events)[names(parent_life_events) == "ple_sib_fu_p"] = "sibling_left_experience"
names(parent_life_events)[names(parent_life_events) == "ple_sib_fu2_p"] = "sibling_left_effects"

names(parent_life_events)[names(parent_life_events) == "ple_victim_p"] = "victim"
names(parent_life_events)[names(parent_life_events) == "ple_victim_past_yr_p"] = "past_year_victim"
names(parent_life_events)[names(parent_life_events) == "ple_victim_fu_p"] = "victim_experience"
names(parent_life_events)[names(parent_life_events) == "ple_victim_fu2_p"] = "victim_effects"

names(parent_life_events)[names(parent_life_events) == "ple_victim_p"] = "victim"
names(parent_life_events)[names(parent_life_events) == "ple_victim_past_yr_p"] = "past_year_victim"
names(parent_life_events)[names(parent_life_events) == "ple_victim_fu_p"] = "victim_experience"
names(parent_life_events)[names(parent_life_events) == "ple_victim_fu2_p"] = "victim_effects"

names(parent_life_events)[names(parent_life_events) == "ple_separ_p"] = "parents_divorce"
names(parent_life_events)[names(parent_life_events) == "ple_separ_past_yr_p"] = "past_year_parents_divorce"
names(parent_life_events)[names(parent_life_events) == "ple_separ_fu_p"] = "parents_divorce_experience"
names(parent_life_events)[names(parent_life_events) == "ple_separ_fu2_p"] = "parents_divorce_effects"

names(parent_life_events)[names(parent_life_events) == "ple_law_p"] = "parents_unlawful"
names(parent_life_events)[names(parent_life_events) == "ple_law_past_yr_p"] = "past_year_parents_unlawful"
names(parent_life_events)[names(parent_life_events) == "ple_law_fu_p"] = "parents_unlawful_experience"
names(parent_life_events)[names(parent_life_events) == "ple_law_fu2_p"] = "parents_unlawful_effects"

names(parent_life_events)[names(parent_life_events) == "ple_school_p"] = "new_school"
names(parent_life_events)[names(parent_life_events) == "ple_school_past_yr_p"] = "past_year_new_school"
names(parent_life_events)[names(parent_life_events) == "ple_school_fu_p"] = "new_school_experience"
names(parent_life_events)[names(parent_life_events) == "ple_school_fu2_p"] = "new_school_effects"

names(parent_life_events)[names(parent_life_events) == "ple_move_p"] = "family_moved"
names(parent_life_events)[names(parent_life_events) == "ple_move_past_yr_p"] = "past_year_family_moved"
names(parent_life_events)[names(parent_life_events) == "ple_move_fu_p"] = "family_moved_experience"
names(parent_life_events)[names(parent_life_events) == "ple_move_fu2_p"] = "family_moved_effects"

names(parent_life_events)[names(parent_life_events) == "ple_jail_p"] = "parents_jail"
names(parent_life_events)[names(parent_life_events) == "ple_jail_past_yr_p"] = "past_year_parents_jail"
names(parent_life_events)[names(parent_life_events) == "ple_jail_fu_p"] = "parents_jail_experience"
names(parent_life_events)[names(parent_life_events) == "ple_jail_fu2_p"] = "parents_jail_effects"

names(parent_life_events)[names(parent_life_events) == "ple_step_p"] = "step_parent"
names(parent_life_events)[names(parent_life_events) == "ple_step_past_yr_p"] = "past_year_step_parent"
names(parent_life_events)[names(parent_life_events) == "ple_step_fu_p"] = "step_parent_experience"
names(parent_life_events)[names(parent_life_events) == "ple_step_fu2_p"] = "step_parent_effects"

names(parent_life_events)[names(parent_life_events) == "ple_new_job_p"] = "parent_newjob"
names(parent_life_events)[names(parent_life_events) == "ple_new_job_past_yr_p"] = "past_year_parent_newjob"
names(parent_life_events)[names(parent_life_events) == "ple_new_job_fu_p"] = "parent_newjob_experience"
names(parent_life_events)[names(parent_life_events) == "ple_new_job_fu2_p"] = "parent_newjob_effects"

names(parent_life_events)[names(parent_life_events) == "ple_new_sib_p"] = "new_sibling"
names(parent_life_events)[names(parent_life_events) == "ple_new_sib_past_yr_p"] = "past_year_new_sibling"
names(parent_life_events)[names(parent_life_events) == "ple_new_sib_fu_p"] = "new_sibling_experience"
names(parent_life_events)[names(parent_life_events) == "ple_new_sib_fu2_p"] = "new_sibling_effects"

names(parent_life_events)[names(parent_life_events) == "ple_hospitalized_p"] = "parents_hospitalized"
names(parent_life_events)[names(parent_life_events) == "ple_hospitalized_past_yr_p"] = "past_year_parents_hospitalized"
names(parent_life_events)[names(parent_life_events) == "ple_hospitalized_fu_p"] = "parents_hospitalized_experience"
names(parent_life_events)[names(parent_life_events) == "ple_hospitalized_fu2_p"] = "parents_hospitalized_effects"

names(parent_life_events)[names(parent_life_events) == "ple_foster_care_p"] = "folster_care"
names(parent_life_events)[names(parent_life_events) == "ple_foster_care_time_p"] = "folster_care_months"
names(parent_life_events)[names(parent_life_events) == "ple_foster_care_past_yr_p"] = "past_year_parents_folster_care"
names(parent_life_events)[names(parent_life_events) == "ple_foster_care_fu_p"] = "folster_care_experience"
names(parent_life_events)[names(parent_life_events) == "ple_foster_care_fu2_p"] = "folster_care_effects"

names(parent_life_events)[names(parent_life_events) == "ple_hit_p"] = "observed_violence"
names(parent_life_events)[names(parent_life_events) == "ple_hit_past_yr_p"] = "past_year_observed_violence"
names(parent_life_events)[names(parent_life_events) == "ple_hit_fu_p"] = "observed_violence_experience"
names(parent_life_events)[names(parent_life_events) == "ple_hit_fu2_p"] = "observed_violence_effects"

names(parent_life_events)[names(parent_life_events) == "ple_shot_p"] = "observed_shooting"
names(parent_life_events)[names(parent_life_events) == "ple_shot_past_yr_p"] = "past_year_observed_shooting"
names(parent_life_events)[names(parent_life_events) == "ple_shot_fu_p"] = "observed_shooting_experience"
names(parent_life_events)[names(parent_life_events) == "ple_shot_fu2_p"] = "observed_shooting_effects"

names(parent_life_events)[names(parent_life_events) == "ple_lockdown_p"] = "lockdown"
names(parent_life_events)[names(parent_life_events) == "ple_lockdown_past_yr_p"] = "past_year_lockdown"
names(parent_life_events)[names(parent_life_events) == "ple_lockdown_fu_p"] = "lockdown_experience"
names(parent_life_events)[names(parent_life_events) == "ple_lockdown_fu2_p"] = "lockdown_effects"

names(parent_life_events)[names(parent_life_events) == "ple_homeless_p"] = "family_homeless"
names(parent_life_events)[names(parent_life_events) == "ple_homeless_past_yr_p"] = "past_year_family_homeless"
names(parent_life_events)[names(parent_life_events) == "ple_homeless_fu_p"] = "family_homeless_experience"
names(parent_life_events)[names(parent_life_events) == "ple_homeless_fu2_p"] = "family_homeless_effects"

names(parent_life_events)[names(parent_life_events) == "ple_deported_p"] = "family_deported"
names(parent_life_events)[names(parent_life_events) == "ple_deported_past_yr_p"] = "past_year_family_deported"
names(parent_life_events)[names(parent_life_events) == "ple_deported_fu_p"] = "family_deported_experience"
names(parent_life_events)[names(parent_life_events) == "ple_deported_fu2_p"] = "family_deported_effects"

names(parent_life_events)[names(parent_life_events) == "ple_p_ss_total_number"] = "tot_events"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_total_number_nm"] = "tot_missing"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_total_number_nt"] = "tot_questions"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_total_good"] = "tot_good_events"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_total_bad"] = "tot_bad_events"

names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affected_good_sum"] = "positive_effects"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affected_good_mean"] = "mean_positive_effects"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affected_bad_sum"] = "negative_effects"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affected_bad_mean"] = "mean_negative_effects"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affected_mean"] = "tot_effects_mean"
names(parent_life_events)[names(parent_life_events) == "ple_p_ss_affect_sum"] = "tot_effects_sum"

apply_table_to_columns <- function(df, df_name, file_name = "table_results.txt") {
  # Open a connection to the file
  file_conn <- file(file_name, "w")
  
  # Loop over each column in the dataframe
  for (col_name in names(df)) {
    # Apply the table function with useNA = "ifany"
    tab <- table(df[[col_name]], useNA = "ifany")
    print(col_name)
    print(tab)

  }
}

apply_table_to_columns(parent_life_events, "parent_life_events")

