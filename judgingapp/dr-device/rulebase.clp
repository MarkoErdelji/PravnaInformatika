(import-rdf "facts.rdf")
		(export-rdf export.rdf  is_theft_lv1 is_theft_lv2 is_theft_lv3 is_theft_lv4 is_theft_lv5 is_theft_lv6 min_imprisonment max_imprisonment monetary_penalty)
		(export-proof proof.ruleml)
		
(defeasiblerule rule1
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	) 
  => 
	 
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule2
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:value_of_stolen_items ?value_of_stolen_items)
	) 
		(test 
		(<=  ?value_of_stolen_items 150
		)
	)
	
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule3
		(declare (superior rule2 rule1 )) 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:breaking_and_entering "true")
	) 
  => 
	 
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule4
		(declare (superior rule1 )) 
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule5
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:value_of_stolen_items ?value_of_stolen_items)
	) 
		(test 
		(>  ?value_of_stolen_items 30000
		)
	)
	
  => 
	 
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule6
		(declare (superior rule3 )) 
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule7
		(declare (superior rule1 )) 
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule8
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:caught_in_the_act "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:use_of_force_or_threat "true")
	) 
  => 
	 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule9
		(declare (superior rule5 )) 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule10
		(declare (superior rule3 )) 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule11
		(declare (superior rule1 )) 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule12
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:caught_in_the_act "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:use_of_force_or_threat "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:caused_severe_injury "true")
	) 
  => 
	 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule13
		(declare (superior rule8 )) 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule14
		(declare (superior rule5 )) 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule15
		(declare (superior rule3 )) 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule16
		(declare (superior rule1 )) 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule17
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_movable_property "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:is_taken "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:intent_to_appropriate "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:caught_in_the_act "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:use_of_force_or_threat "true")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:death_caused "true")
	) 
  => 
	 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule18
		(declare (superior rule12 )) 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule19
		(declare (superior rule8 )) 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule20
		(declare (superior rule5 )) 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule21
		(declare (superior rule3 )) 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule rule22
		(declare (superior rule1 )) 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	
		(not  
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) )
	
) 
	
(defeasiblerule pen_lv1_monetary
		 
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(monetary_penalty 
		(
		 value True)
	) 
) 
	
(defeasiblerule pen_lv1_min
		 
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 0)
	) 
) 
	
(defeasiblerule pen_lv1_max
		 
	(is_theft_lv1 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 3)
	) 
) 
	
(defeasiblerule pen_lv2_min
		 
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_lv2_max
		 
	(is_theft_lv2 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 8)
	) 
) 
	
(defeasiblerule pen_lv3_min
		 
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 2)
	) 
) 
	
(defeasiblerule pen_lv3_max
		 
	(is_theft_lv3 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 10)
	) 
) 
	
(defeasiblerule pen_lv4_min
		 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 1)
	) 
) 
	
(defeasiblerule pen_lv4_max
		 
	(is_theft_lv4 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 8)
	) 
) 
	
(defeasiblerule pen_lv5_min
		 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 3)
	) 
) 
	
(defeasiblerule pen_lv5_max
		 
	(is_theft_lv5 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(max_imprisonment 
		(
		 value 15)
	) 
) 
	
(defeasiblerule pen_lv6_min
		 
	(is_theft_lv6 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(min_imprisonment 
		(
		 value 10)
	) 
) 
	