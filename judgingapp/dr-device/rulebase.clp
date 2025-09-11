(import-rdf "facts.rdf")
		(export-rdf export.rdf  
                basic_punishment
                increase_punishment
                aggravating_factor
                weapon_factor
                family_offense_factor
                child_victim_factor
                recidivist_factor
                multiple_victims_factor
                light_offense_factor
                threat_offense_factor
            )
		(export-proof proof.ruleml)
		
(defeasiblerule rule1
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:injuryTypes "SEVERE")
	) 
  => 
	 
	(basic_punishment 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule2
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:protectionMeasureViolation true)
	) 
  => 
	 
	(increase_punishment 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule3
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:childrenPresent true)
	) 
  => 
	 
	(aggravating_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule4
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:useOfWeapon true)
	) 
  => 
	 
	(weapon_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule5
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:victimRelationship "SPOUSE")
	) 
  => 
	 
	(family_offense_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule6
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:victimRelationship "CHILD")
	) 
  => 
	 
	(child_victim_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule7
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:previouslyConvicted true)
	) 
  => 
	 
	(recidivist_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule8
		 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:numvictims ?NumVictims)
	) 
  => 
	 
	(multiple_victims_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule9
		(declare (superior rule1 rule6 rule8 )) 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:violenceNature "RECKLESS_BEHAVIOUR")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:injuryTypes "NONE")
	) 
  => 
	 
	(light_offense_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule rule10
		(declare (superior rule1 rule6 rule8 )) 
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:violenceNature "THREAT")
	)  
	(lc:case 
		(
		 lc:defendant ?Defendant)
	
		(
		 lc:injuryTypes "NONE")
	) 
  => 
	 
	(threat_offense_factor 
		(
		 defendant ?Defendant)
	) 
) 
	
(defeasiblerule pen1
		 
	(basic_punishment 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(imprisonment 
		(
		 value 6)
	) 
) 
	
(defeasiblerule pen2
		 
	(increase_punishment 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 5000)
	) 
) 
	
(defeasiblerule pen3
		 
	(aggravating_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 10000)
	) 
) 
	
(defeasiblerule pen3
		 
	(weapon_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 10000)
	) 
) 
	
(defeasiblerule pen3
		 
	(family_offense_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 10000)
	) 
) 
	
(defeasiblerule pen4
		 
	(child_victim_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(imprisonment 
		(
		 value 12)
	) 
) 
	
(defeasiblerule pen3
		 
	(recidivist_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 10000)
	) 
) 
	
(defeasiblerule pen5
		 
	(multiple_victims_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(imprisonment 
		(
		 value 24)
	) 
) 
	
(defeasiblerule pen6
		 
	(light_offense_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 2000)
	) 
) 
	
(defeasiblerule pen7
		 
	(threat_offense_factor 
		(
		 defendant ?Defendant)
	) 
  => 
	 
	(fine 
		(
		 value 3000)
	) 
) 
	