([pen7-defeasibly-dot] of derived-attribute-rule
   (pos-name pen7-defeasibly-dot-gen219)
   (depends-on declare fine threat_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen7] ) ) ) ?gen194 <- ( fine ( value 3000 ) ( positive 1 ) ( positive-derivator pen7 $? ) ) ( test ( eq ( class ?gen194 ) fine ) ) ( not ( and ?gen201 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive ?gen200 & : ( >= ?gen200 1 ) ) ) ?gen194 <- ( fine ( negative ~ 2 ) ( positive-overruled $?gen196 & : ( not ( member$ pen7 $?gen196 ) ) ) ) ) ) => ?gen194 <- ( fine ( positive 0 ) )"))

([pen7-defeasibly] of derived-attribute-rule
   (pos-name pen7-defeasibly-gen221)
   (depends-on declare threat_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen7] ) ) ) ?gen201 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive ?gen200 & : ( >= ?gen200 1 ) ) ) ?gen194 <- ( fine ( value 3000 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen196 & : ( not ( member$ pen7 $?gen196 ) ) ) ) ( test ( eq ( class ?gen194 ) fine ) ) => ?gen194 <- ( fine ( positive 1 ) ( positive-derivator pen7 ?gen201 ) )"))

([pen7-overruled-dot] of derived-attribute-rule
   (pos-name pen7-overruled-dot-gen223)
   (depends-on declare fine threat_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen7] ) ) ) ?gen194 <- ( fine ( value 3000 ) ( negative-support $?gen197 ) ( negative-overruled $?gen198 & : ( subseq-pos ( create$ pen7-overruled $?gen197 $$$ $?gen198 ) ) ) ) ( test ( eq ( class ?gen194 ) fine ) ) ( not ( and ?gen201 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive ?gen200 & : ( >= ?gen200 1 ) ) ) ?gen194 <- ( fine ( positive-defeated $?gen196 & : ( not ( member$ pen7 $?gen196 ) ) ) ) ) ) => ( calc ( bind $?gen199 ( delete-member$ $?gen198 ( create$ pen7-overruled $?gen197 ) ) ) ) ?gen194 <- ( fine ( negative-overruled $?gen199 ) )"))

([pen7-overruled] of derived-attribute-rule
   (pos-name pen7-overruled-gen225)
   (depends-on declare threat_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen7] ) ) ) ?gen201 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive ?gen200 & : ( >= ?gen200 1 ) ) ) ?gen194 <- ( fine ( value 3000 ) ( negative-support $?gen197 ) ( negative-overruled $?gen198 & : ( not ( subseq-pos ( create$ pen7-overruled $?gen197 $$$ $?gen198 ) ) ) ) ( positive-defeated $?gen196 & : ( not ( member$ pen7 $?gen196 ) ) ) ) ( test ( eq ( class ?gen194 ) fine ) ) => ( calc ( bind $?gen199 ( create$ pen7-overruled $?gen197 $?gen198 ) ) ) ?gen194 <- ( fine ( negative-overruled $?gen199 ) )"))

([pen7-support] of derived-attribute-rule
   (pos-name pen7-support-gen227)
   (depends-on declare threat_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen7] ) ) ) ?gen193 <- ( threat_offense_factor ( defendant ?Defendant ) ) ?gen194 <- ( fine ( value 3000 ) ( positive-support $?gen196 & : ( not ( subseq-pos ( create$ pen7 ?gen193 $$$ $?gen196 ) ) ) ) ) ( test ( eq ( class ?gen194 ) fine ) ) => ( calc ( bind $?gen199 ( create$ pen7 ?gen193 $?gen196 ) ) ) ?gen194 <- ( fine ( positive-support $?gen199 ) )"))

([pen6-defeasibly-dot] of derived-attribute-rule
   (pos-name pen6-defeasibly-dot-gen229)
   (depends-on declare fine light_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen6] ) ) ) ?gen185 <- ( fine ( value 2000 ) ( positive 1 ) ( positive-derivator pen6 $? ) ) ( test ( eq ( class ?gen185 ) fine ) ) ( not ( and ?gen192 <- ( light_offense_factor ( defendant ?Defendant ) ( positive ?gen191 & : ( >= ?gen191 1 ) ) ) ?gen185 <- ( fine ( negative ~ 2 ) ( positive-overruled $?gen187 & : ( not ( member$ pen6 $?gen187 ) ) ) ) ) ) => ?gen185 <- ( fine ( positive 0 ) )"))

([pen6-defeasibly] of derived-attribute-rule
   (pos-name pen6-defeasibly-gen231)
   (depends-on declare light_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen6] ) ) ) ?gen192 <- ( light_offense_factor ( defendant ?Defendant ) ( positive ?gen191 & : ( >= ?gen191 1 ) ) ) ?gen185 <- ( fine ( value 2000 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen187 & : ( not ( member$ pen6 $?gen187 ) ) ) ) ( test ( eq ( class ?gen185 ) fine ) ) => ?gen185 <- ( fine ( positive 1 ) ( positive-derivator pen6 ?gen192 ) )"))

([pen6-overruled-dot] of derived-attribute-rule
   (pos-name pen6-overruled-dot-gen233)
   (depends-on declare fine light_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen6] ) ) ) ?gen185 <- ( fine ( value 2000 ) ( negative-support $?gen188 ) ( negative-overruled $?gen189 & : ( subseq-pos ( create$ pen6-overruled $?gen188 $$$ $?gen189 ) ) ) ) ( test ( eq ( class ?gen185 ) fine ) ) ( not ( and ?gen192 <- ( light_offense_factor ( defendant ?Defendant ) ( positive ?gen191 & : ( >= ?gen191 1 ) ) ) ?gen185 <- ( fine ( positive-defeated $?gen187 & : ( not ( member$ pen6 $?gen187 ) ) ) ) ) ) => ( calc ( bind $?gen190 ( delete-member$ $?gen189 ( create$ pen6-overruled $?gen188 ) ) ) ) ?gen185 <- ( fine ( negative-overruled $?gen190 ) )"))

([pen6-overruled] of derived-attribute-rule
   (pos-name pen6-overruled-gen235)
   (depends-on declare light_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen6] ) ) ) ?gen192 <- ( light_offense_factor ( defendant ?Defendant ) ( positive ?gen191 & : ( >= ?gen191 1 ) ) ) ?gen185 <- ( fine ( value 2000 ) ( negative-support $?gen188 ) ( negative-overruled $?gen189 & : ( not ( subseq-pos ( create$ pen6-overruled $?gen188 $$$ $?gen189 ) ) ) ) ( positive-defeated $?gen187 & : ( not ( member$ pen6 $?gen187 ) ) ) ) ( test ( eq ( class ?gen185 ) fine ) ) => ( calc ( bind $?gen190 ( create$ pen6-overruled $?gen188 $?gen189 ) ) ) ?gen185 <- ( fine ( negative-overruled $?gen190 ) )"))

([pen6-support] of derived-attribute-rule
   (pos-name pen6-support-gen237)
   (depends-on declare light_offense_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen6] ) ) ) ?gen184 <- ( light_offense_factor ( defendant ?Defendant ) ) ?gen185 <- ( fine ( value 2000 ) ( positive-support $?gen187 & : ( not ( subseq-pos ( create$ pen6 ?gen184 $$$ $?gen187 ) ) ) ) ) ( test ( eq ( class ?gen185 ) fine ) ) => ( calc ( bind $?gen190 ( create$ pen6 ?gen184 $?gen187 ) ) ) ?gen185 <- ( fine ( positive-support $?gen190 ) )"))

([pen5-defeasibly-dot] of derived-attribute-rule
   (pos-name pen5-defeasibly-dot-gen239)
   (depends-on declare imprisonment multiple_victims_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen5] ) ) ) ?gen176 <- ( imprisonment ( value 24 ) ( positive 1 ) ( positive-derivator pen5 $? ) ) ( test ( eq ( class ?gen176 ) imprisonment ) ) ( not ( and ?gen183 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen176 <- ( imprisonment ( negative ~ 2 ) ( positive-overruled $?gen178 & : ( not ( member$ pen5 $?gen178 ) ) ) ) ) ) => ?gen176 <- ( imprisonment ( positive 0 ) )"))

([pen5-defeasibly] of derived-attribute-rule
   (pos-name pen5-defeasibly-gen241)
   (depends-on declare multiple_victims_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen5] ) ) ) ?gen183 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen176 <- ( imprisonment ( value 24 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen178 & : ( not ( member$ pen5 $?gen178 ) ) ) ) ( test ( eq ( class ?gen176 ) imprisonment ) ) => ?gen176 <- ( imprisonment ( positive 1 ) ( positive-derivator pen5 ?gen183 ) )"))

([pen5-overruled-dot] of derived-attribute-rule
   (pos-name pen5-overruled-dot-gen243)
   (depends-on declare imprisonment multiple_victims_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen5] ) ) ) ?gen176 <- ( imprisonment ( value 24 ) ( negative-support $?gen179 ) ( negative-overruled $?gen180 & : ( subseq-pos ( create$ pen5-overruled $?gen179 $$$ $?gen180 ) ) ) ) ( test ( eq ( class ?gen176 ) imprisonment ) ) ( not ( and ?gen183 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen176 <- ( imprisonment ( positive-defeated $?gen178 & : ( not ( member$ pen5 $?gen178 ) ) ) ) ) ) => ( calc ( bind $?gen181 ( delete-member$ $?gen180 ( create$ pen5-overruled $?gen179 ) ) ) ) ?gen176 <- ( imprisonment ( negative-overruled $?gen181 ) )"))

([pen5-overruled] of derived-attribute-rule
   (pos-name pen5-overruled-gen245)
   (depends-on declare multiple_victims_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen5] ) ) ) ?gen183 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive ?gen182 & : ( >= ?gen182 1 ) ) ) ?gen176 <- ( imprisonment ( value 24 ) ( negative-support $?gen179 ) ( negative-overruled $?gen180 & : ( not ( subseq-pos ( create$ pen5-overruled $?gen179 $$$ $?gen180 ) ) ) ) ( positive-defeated $?gen178 & : ( not ( member$ pen5 $?gen178 ) ) ) ) ( test ( eq ( class ?gen176 ) imprisonment ) ) => ( calc ( bind $?gen181 ( create$ pen5-overruled $?gen179 $?gen180 ) ) ) ?gen176 <- ( imprisonment ( negative-overruled $?gen181 ) )"))

([pen5-support] of derived-attribute-rule
   (pos-name pen5-support-gen247)
   (depends-on declare multiple_victims_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen5] ) ) ) ?gen175 <- ( multiple_victims_factor ( defendant ?Defendant ) ) ?gen176 <- ( imprisonment ( value 24 ) ( positive-support $?gen178 & : ( not ( subseq-pos ( create$ pen5 ?gen175 $$$ $?gen178 ) ) ) ) ) ( test ( eq ( class ?gen176 ) imprisonment ) ) => ( calc ( bind $?gen181 ( create$ pen5 ?gen175 $?gen178 ) ) ) ?gen176 <- ( imprisonment ( positive-support $?gen181 ) )"))

([pen4-defeasibly-dot] of derived-attribute-rule
   (pos-name pen4-defeasibly-dot-gen259)
   (depends-on declare imprisonment child_victim_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen4] ) ) ) ?gen158 <- ( imprisonment ( value 12 ) ( positive 1 ) ( positive-derivator pen4 $? ) ) ( test ( eq ( class ?gen158 ) imprisonment ) ) ( not ( and ?gen165 <- ( child_victim_factor ( defendant ?Defendant ) ( positive ?gen164 & : ( >= ?gen164 1 ) ) ) ?gen158 <- ( imprisonment ( negative ~ 2 ) ( positive-overruled $?gen160 & : ( not ( member$ pen4 $?gen160 ) ) ) ) ) ) => ?gen158 <- ( imprisonment ( positive 0 ) )"))

([pen4-defeasibly] of derived-attribute-rule
   (pos-name pen4-defeasibly-gen261)
   (depends-on declare child_victim_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen4] ) ) ) ?gen165 <- ( child_victim_factor ( defendant ?Defendant ) ( positive ?gen164 & : ( >= ?gen164 1 ) ) ) ?gen158 <- ( imprisonment ( value 12 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen160 & : ( not ( member$ pen4 $?gen160 ) ) ) ) ( test ( eq ( class ?gen158 ) imprisonment ) ) => ?gen158 <- ( imprisonment ( positive 1 ) ( positive-derivator pen4 ?gen165 ) )"))

([pen4-overruled-dot] of derived-attribute-rule
   (pos-name pen4-overruled-dot-gen263)
   (depends-on declare imprisonment child_victim_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen4] ) ) ) ?gen158 <- ( imprisonment ( value 12 ) ( negative-support $?gen161 ) ( negative-overruled $?gen162 & : ( subseq-pos ( create$ pen4-overruled $?gen161 $$$ $?gen162 ) ) ) ) ( test ( eq ( class ?gen158 ) imprisonment ) ) ( not ( and ?gen165 <- ( child_victim_factor ( defendant ?Defendant ) ( positive ?gen164 & : ( >= ?gen164 1 ) ) ) ?gen158 <- ( imprisonment ( positive-defeated $?gen160 & : ( not ( member$ pen4 $?gen160 ) ) ) ) ) ) => ( calc ( bind $?gen163 ( delete-member$ $?gen162 ( create$ pen4-overruled $?gen161 ) ) ) ) ?gen158 <- ( imprisonment ( negative-overruled $?gen163 ) )"))

([pen4-overruled] of derived-attribute-rule
   (pos-name pen4-overruled-gen265)
   (depends-on declare child_victim_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen4] ) ) ) ?gen165 <- ( child_victim_factor ( defendant ?Defendant ) ( positive ?gen164 & : ( >= ?gen164 1 ) ) ) ?gen158 <- ( imprisonment ( value 12 ) ( negative-support $?gen161 ) ( negative-overruled $?gen162 & : ( not ( subseq-pos ( create$ pen4-overruled $?gen161 $$$ $?gen162 ) ) ) ) ( positive-defeated $?gen160 & : ( not ( member$ pen4 $?gen160 ) ) ) ) ( test ( eq ( class ?gen158 ) imprisonment ) ) => ( calc ( bind $?gen163 ( create$ pen4-overruled $?gen161 $?gen162 ) ) ) ?gen158 <- ( imprisonment ( negative-overruled $?gen163 ) )"))

([pen4-support] of derived-attribute-rule
   (pos-name pen4-support-gen267)
   (depends-on declare child_victim_factor imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen4] ) ) ) ?gen157 <- ( child_victim_factor ( defendant ?Defendant ) ) ?gen158 <- ( imprisonment ( value 12 ) ( positive-support $?gen160 & : ( not ( subseq-pos ( create$ pen4 ?gen157 $$$ $?gen160 ) ) ) ) ) ( test ( eq ( class ?gen158 ) imprisonment ) ) => ( calc ( bind $?gen163 ( create$ pen4 ?gen157 $?gen160 ) ) ) ?gen158 <- ( imprisonment ( positive-support $?gen163 ) )"))

([pen3-defeasibly-dot] of derived-attribute-rule
   (pos-name pen3-defeasibly-dot-gen289)
   (depends-on declare fine aggravating_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen3] ) ) ) ?gen131 <- ( fine ( value 10000 ) ( positive 1 ) ( positive-derivator pen3 $? ) ) ( test ( eq ( class ?gen131 ) fine ) ) ( not ( and ?gen138 <- ( aggravating_factor ( defendant ?Defendant ) ( positive ?gen137 & : ( >= ?gen137 1 ) ) ) ?gen131 <- ( fine ( negative ~ 2 ) ( positive-overruled $?gen133 & : ( not ( member$ pen3 $?gen133 ) ) ) ) ) ) => ?gen131 <- ( fine ( positive 0 ) )"))

([pen3-defeasibly] of derived-attribute-rule
   (pos-name pen3-defeasibly-gen291)
   (depends-on declare aggravating_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen3] ) ) ) ?gen138 <- ( aggravating_factor ( defendant ?Defendant ) ( positive ?gen137 & : ( >= ?gen137 1 ) ) ) ?gen131 <- ( fine ( value 10000 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen133 & : ( not ( member$ pen3 $?gen133 ) ) ) ) ( test ( eq ( class ?gen131 ) fine ) ) => ?gen131 <- ( fine ( positive 1 ) ( positive-derivator pen3 ?gen138 ) )"))

([pen3-overruled-dot] of derived-attribute-rule
   (pos-name pen3-overruled-dot-gen293)
   (depends-on declare fine aggravating_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen3] ) ) ) ?gen131 <- ( fine ( value 10000 ) ( negative-support $?gen134 ) ( negative-overruled $?gen135 & : ( subseq-pos ( create$ pen3-overruled $?gen134 $$$ $?gen135 ) ) ) ) ( test ( eq ( class ?gen131 ) fine ) ) ( not ( and ?gen138 <- ( aggravating_factor ( defendant ?Defendant ) ( positive ?gen137 & : ( >= ?gen137 1 ) ) ) ?gen131 <- ( fine ( positive-defeated $?gen133 & : ( not ( member$ pen3 $?gen133 ) ) ) ) ) ) => ( calc ( bind $?gen136 ( delete-member$ $?gen135 ( create$ pen3-overruled $?gen134 ) ) ) ) ?gen131 <- ( fine ( negative-overruled $?gen136 ) )"))

([pen3-overruled] of derived-attribute-rule
   (pos-name pen3-overruled-gen295)
   (depends-on declare aggravating_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen3] ) ) ) ?gen138 <- ( aggravating_factor ( defendant ?Defendant ) ( positive ?gen137 & : ( >= ?gen137 1 ) ) ) ?gen131 <- ( fine ( value 10000 ) ( negative-support $?gen134 ) ( negative-overruled $?gen135 & : ( not ( subseq-pos ( create$ pen3-overruled $?gen134 $$$ $?gen135 ) ) ) ) ( positive-defeated $?gen133 & : ( not ( member$ pen3 $?gen133 ) ) ) ) ( test ( eq ( class ?gen131 ) fine ) ) => ( calc ( bind $?gen136 ( create$ pen3-overruled $?gen134 $?gen135 ) ) ) ?gen131 <- ( fine ( negative-overruled $?gen136 ) )"))

([pen3-support] of derived-attribute-rule
   (pos-name pen3-support-gen297)
   (depends-on declare aggravating_factor fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen3] ) ) ) ?gen130 <- ( aggravating_factor ( defendant ?Defendant ) ) ?gen131 <- ( fine ( value 10000 ) ( positive-support $?gen133 & : ( not ( subseq-pos ( create$ pen3 ?gen130 $$$ $?gen133 ) ) ) ) ) ( test ( eq ( class ?gen131 ) fine ) ) => ( calc ( bind $?gen136 ( create$ pen3 ?gen130 $?gen133 ) ) ) ?gen131 <- ( fine ( positive-support $?gen136 ) )"))

([pen2-defeasibly-dot] of derived-attribute-rule
   (pos-name pen2-defeasibly-dot-gen299)
   (depends-on declare fine increase_punishment fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen2] ) ) ) ?gen122 <- ( fine ( value 5000 ) ( positive 1 ) ( positive-derivator pen2 $? ) ) ( test ( eq ( class ?gen122 ) fine ) ) ( not ( and ?gen129 <- ( increase_punishment ( defendant ?Defendant ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen122 <- ( fine ( negative ~ 2 ) ( positive-overruled $?gen124 & : ( not ( member$ pen2 $?gen124 ) ) ) ) ) ) => ?gen122 <- ( fine ( positive 0 ) )"))

([pen2-defeasibly] of derived-attribute-rule
   (pos-name pen2-defeasibly-gen301)
   (depends-on declare increase_punishment fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen2] ) ) ) ?gen129 <- ( increase_punishment ( defendant ?Defendant ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen122 <- ( fine ( value 5000 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen124 & : ( not ( member$ pen2 $?gen124 ) ) ) ) ( test ( eq ( class ?gen122 ) fine ) ) => ?gen122 <- ( fine ( positive 1 ) ( positive-derivator pen2 ?gen129 ) )"))

([pen2-overruled-dot] of derived-attribute-rule
   (pos-name pen2-overruled-dot-gen303)
   (depends-on declare fine increase_punishment fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen2] ) ) ) ?gen122 <- ( fine ( value 5000 ) ( negative-support $?gen125 ) ( negative-overruled $?gen126 & : ( subseq-pos ( create$ pen2-overruled $?gen125 $$$ $?gen126 ) ) ) ) ( test ( eq ( class ?gen122 ) fine ) ) ( not ( and ?gen129 <- ( increase_punishment ( defendant ?Defendant ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen122 <- ( fine ( positive-defeated $?gen124 & : ( not ( member$ pen2 $?gen124 ) ) ) ) ) ) => ( calc ( bind $?gen127 ( delete-member$ $?gen126 ( create$ pen2-overruled $?gen125 ) ) ) ) ?gen122 <- ( fine ( negative-overruled $?gen127 ) )"))

([pen2-overruled] of derived-attribute-rule
   (pos-name pen2-overruled-gen305)
   (depends-on declare increase_punishment fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen2] ) ) ) ?gen129 <- ( increase_punishment ( defendant ?Defendant ) ( positive ?gen128 & : ( >= ?gen128 1 ) ) ) ?gen122 <- ( fine ( value 5000 ) ( negative-support $?gen125 ) ( negative-overruled $?gen126 & : ( not ( subseq-pos ( create$ pen2-overruled $?gen125 $$$ $?gen126 ) ) ) ) ( positive-defeated $?gen124 & : ( not ( member$ pen2 $?gen124 ) ) ) ) ( test ( eq ( class ?gen122 ) fine ) ) => ( calc ( bind $?gen127 ( create$ pen2-overruled $?gen125 $?gen126 ) ) ) ?gen122 <- ( fine ( negative-overruled $?gen127 ) )"))

([pen2-support] of derived-attribute-rule
   (pos-name pen2-support-gen307)
   (depends-on declare increase_punishment fine)
   (implies fine)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen2] ) ) ) ?gen121 <- ( increase_punishment ( defendant ?Defendant ) ) ?gen122 <- ( fine ( value 5000 ) ( positive-support $?gen124 & : ( not ( subseq-pos ( create$ pen2 ?gen121 $$$ $?gen124 ) ) ) ) ) ( test ( eq ( class ?gen122 ) fine ) ) => ( calc ( bind $?gen127 ( create$ pen2 ?gen121 $?gen124 ) ) ) ?gen122 <- ( fine ( positive-support $?gen127 ) )"))

([pen1-defeasibly-dot] of derived-attribute-rule
   (pos-name pen1-defeasibly-dot-gen309)
   (depends-on declare imprisonment basic_punishment imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen1] ) ) ) ?gen113 <- ( imprisonment ( value 6 ) ( positive 1 ) ( positive-derivator pen1 $? ) ) ( test ( eq ( class ?gen113 ) imprisonment ) ) ( not ( and ?gen120 <- ( basic_punishment ( defendant ?Defendant ) ( positive ?gen119 & : ( >= ?gen119 1 ) ) ) ?gen113 <- ( imprisonment ( negative ~ 2 ) ( positive-overruled $?gen115 & : ( not ( member$ pen1 $?gen115 ) ) ) ) ) ) => ?gen113 <- ( imprisonment ( positive 0 ) )"))

([pen1-defeasibly] of derived-attribute-rule
   (pos-name pen1-defeasibly-gen311)
   (depends-on declare basic_punishment imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen1] ) ) ) ?gen120 <- ( basic_punishment ( defendant ?Defendant ) ( positive ?gen119 & : ( >= ?gen119 1 ) ) ) ?gen113 <- ( imprisonment ( value 6 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen115 & : ( not ( member$ pen1 $?gen115 ) ) ) ) ( test ( eq ( class ?gen113 ) imprisonment ) ) => ?gen113 <- ( imprisonment ( positive 1 ) ( positive-derivator pen1 ?gen120 ) )"))

([pen1-overruled-dot] of derived-attribute-rule
   (pos-name pen1-overruled-dot-gen313)
   (depends-on declare imprisonment basic_punishment imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen1] ) ) ) ?gen113 <- ( imprisonment ( value 6 ) ( negative-support $?gen116 ) ( negative-overruled $?gen117 & : ( subseq-pos ( create$ pen1-overruled $?gen116 $$$ $?gen117 ) ) ) ) ( test ( eq ( class ?gen113 ) imprisonment ) ) ( not ( and ?gen120 <- ( basic_punishment ( defendant ?Defendant ) ( positive ?gen119 & : ( >= ?gen119 1 ) ) ) ?gen113 <- ( imprisonment ( positive-defeated $?gen115 & : ( not ( member$ pen1 $?gen115 ) ) ) ) ) ) => ( calc ( bind $?gen118 ( delete-member$ $?gen117 ( create$ pen1-overruled $?gen116 ) ) ) ) ?gen113 <- ( imprisonment ( negative-overruled $?gen118 ) )"))

([pen1-overruled] of derived-attribute-rule
   (pos-name pen1-overruled-gen315)
   (depends-on declare basic_punishment imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen1] ) ) ) ?gen120 <- ( basic_punishment ( defendant ?Defendant ) ( positive ?gen119 & : ( >= ?gen119 1 ) ) ) ?gen113 <- ( imprisonment ( value 6 ) ( negative-support $?gen116 ) ( negative-overruled $?gen117 & : ( not ( subseq-pos ( create$ pen1-overruled $?gen116 $$$ $?gen117 ) ) ) ) ( positive-defeated $?gen115 & : ( not ( member$ pen1 $?gen115 ) ) ) ) ( test ( eq ( class ?gen113 ) imprisonment ) ) => ( calc ( bind $?gen118 ( create$ pen1-overruled $?gen116 $?gen117 ) ) ) ?gen113 <- ( imprisonment ( negative-overruled $?gen118 ) )"))

([pen1-support] of derived-attribute-rule
   (pos-name pen1-support-gen317)
   (depends-on declare basic_punishment imprisonment)
   (implies imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen1] ) ) ) ?gen112 <- ( basic_punishment ( defendant ?Defendant ) ) ?gen113 <- ( imprisonment ( value 6 ) ( positive-support $?gen115 & : ( not ( subseq-pos ( create$ pen1 ?gen112 $$$ $?gen115 ) ) ) ) ) ( test ( eq ( class ?gen113 ) imprisonment ) ) => ( calc ( bind $?gen118 ( create$ pen1 ?gen112 $?gen115 ) ) ) ?gen113 <- ( imprisonment ( positive-support $?gen118 ) )"))

([rule10-defeated-dot] of derived-attribute-rule
   (pos-name rule10-defeated-dot-gen319)
   (depends-on declare threat_offense_factor lc:case lc:case)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule10] ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( negative-defeated $?gen105 & : ( subseq-pos ( create$ rule10-defeated rule1 rule6 rule8 $$$ $?gen105 ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) ( not ( and ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ) ) => ( calc ( bind $?gen104 ( delete-member$ $?gen105 ( create$ rule10-defeated rule1 rule6 rule8 ) ) ) ) ?gen102 <- ( threat_offense_factor ( negative-defeated $?gen104 ) )"))

([rule10-defeated] of derived-attribute-rule
   (pos-name rule10-defeated-gen321)
   (depends-on declare lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule10] ) ) ) ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( negative-defeated $?gen105 & : ( not ( subseq-pos ( create$ rule10-defeated rule1 rule6 rule8 $$$ $?gen105 ) ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) => ( calc ( bind $?gen104 ( create$ rule10-defeated rule1 rule6 rule8 $?gen105 ) ) ) ?gen102 <- ( threat_offense_factor ( negative-defeated $?gen104 ) )"))

([rule10-defeasibly-dot] of derived-attribute-rule
   (pos-name rule10-defeasibly-dot-gen323)
   (depends-on declare threat_offense_factor lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule10] ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule10 $? ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) ( not ( and ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ?gen102 <- ( threat_offense_factor ( negative ~ 2 ) ( positive-overruled $?gen104 & : ( not ( member$ rule10 $?gen104 ) ) ) ) ) ) => ?gen102 <- ( threat_offense_factor ( positive 0 ) )"))

([rule10-defeasibly] of derived-attribute-rule
   (pos-name rule10-defeasibly-gen325)
   (depends-on declare lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule10] ) ) ) ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen104 & : ( not ( member$ rule10 $?gen104 ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) => ?gen102 <- ( threat_offense_factor ( positive 1 ) ( positive-derivator rule10 ?gen109 ?gen111 ) )"))

([rule10-overruled-dot] of derived-attribute-rule
   (pos-name rule10-overruled-dot-gen327)
   (depends-on declare threat_offense_factor lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule10] ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( negative-support $?gen105 ) ( negative-overruled $?gen106 & : ( subseq-pos ( create$ rule10-overruled $?gen105 $$$ $?gen106 ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) ( not ( and ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ?gen102 <- ( threat_offense_factor ( positive-defeated $?gen104 & : ( not ( member$ rule10 $?gen104 ) ) ) ) ) ) => ( calc ( bind $?gen107 ( delete-member$ $?gen106 ( create$ rule10-overruled $?gen105 ) ) ) ) ?gen102 <- ( threat_offense_factor ( negative-overruled $?gen107 ) )"))

([rule10-overruled] of derived-attribute-rule
   (pos-name rule10-overruled-gen329)
   (depends-on declare lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule10] ) ) ) ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ( positive ?gen108 & : ( >= ?gen108 1 ) ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen110 & : ( >= ?gen110 1 ) ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( negative-support $?gen105 ) ( negative-overruled $?gen106 & : ( not ( subseq-pos ( create$ rule10-overruled $?gen105 $$$ $?gen106 ) ) ) ) ( positive-defeated $?gen104 & : ( not ( member$ rule10 $?gen104 ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) => ( calc ( bind $?gen107 ( create$ rule10-overruled $?gen105 $?gen106 ) ) ) ?gen102 <- ( threat_offense_factor ( negative-overruled $?gen107 ) )"))

([rule10-support] of derived-attribute-rule
   (pos-name rule10-support-gen331)
   (depends-on declare lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule10] ) ) ) ?gen100 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ?gen102 <- ( threat_offense_factor ( defendant ?Defendant ) ( positive-support $?gen104 & : ( not ( subseq-pos ( create$ rule10 ?gen100 ?gen101 $$$ $?gen104 ) ) ) ) ) ( test ( eq ( class ?gen102 ) threat_offense_factor ) ) => ( calc ( bind $?gen107 ( create$ rule10 ?gen100 ?gen101 $?gen104 ) ) ) ?gen102 <- ( threat_offense_factor ( positive-support $?gen107 ) )"))

([rule9-defeated-dot] of derived-attribute-rule
   (pos-name rule9-defeated-dot-gen333)
   (depends-on declare light_offense_factor lc:case lc:case)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule9] ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( negative-defeated $?gen93 & : ( subseq-pos ( create$ rule9-defeated rule1 rule6 rule8 $$$ $?gen93 ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) ( not ( and ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ) ) => ( calc ( bind $?gen92 ( delete-member$ $?gen93 ( create$ rule9-defeated rule1 rule6 rule8 ) ) ) ) ?gen90 <- ( light_offense_factor ( negative-defeated $?gen92 ) )"))

([rule9-defeated] of derived-attribute-rule
   (pos-name rule9-defeated-gen335)
   (depends-on declare lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule9] ) ) ) ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( negative-defeated $?gen93 & : ( not ( subseq-pos ( create$ rule9-defeated rule1 rule6 rule8 $$$ $?gen93 ) ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) => ( calc ( bind $?gen92 ( create$ rule9-defeated rule1 rule6 rule8 $?gen93 ) ) ) ?gen90 <- ( light_offense_factor ( negative-defeated $?gen92 ) )"))

([rule9-defeasibly-dot] of derived-attribute-rule
   (pos-name rule9-defeasibly-dot-gen337)
   (depends-on declare light_offense_factor lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule9] ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule9 $? ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) ( not ( and ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen90 <- ( light_offense_factor ( negative ~ 2 ) ( positive-overruled $?gen92 & : ( not ( member$ rule9 $?gen92 ) ) ) ) ) ) => ?gen90 <- ( light_offense_factor ( positive 0 ) )"))

([rule9-defeasibly] of derived-attribute-rule
   (pos-name rule9-defeasibly-gen339)
   (depends-on declare lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule9] ) ) ) ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen92 & : ( not ( member$ rule9 $?gen92 ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) => ?gen90 <- ( light_offense_factor ( positive 1 ) ( positive-derivator rule9 ?gen97 ?gen99 ) )"))

([rule9-overruled-dot] of derived-attribute-rule
   (pos-name rule9-overruled-dot-gen341)
   (depends-on declare light_offense_factor lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule9] ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( negative-support $?gen93 ) ( negative-overruled $?gen94 & : ( subseq-pos ( create$ rule9-overruled $?gen93 $$$ $?gen94 ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) ( not ( and ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen90 <- ( light_offense_factor ( positive-defeated $?gen92 & : ( not ( member$ rule9 $?gen92 ) ) ) ) ) ) => ( calc ( bind $?gen95 ( delete-member$ $?gen94 ( create$ rule9-overruled $?gen93 ) ) ) ) ?gen90 <- ( light_offense_factor ( negative-overruled $?gen95 ) )"))

([rule9-overruled] of derived-attribute-rule
   (pos-name rule9-overruled-gen343)
   (depends-on declare lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule9] ) ) ) ?gen97 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen99 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ( positive ?gen98 & : ( >= ?gen98 1 ) ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( negative-support $?gen93 ) ( negative-overruled $?gen94 & : ( not ( subseq-pos ( create$ rule9-overruled $?gen93 $$$ $?gen94 ) ) ) ) ( positive-defeated $?gen92 & : ( not ( member$ rule9 $?gen92 ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) => ( calc ( bind $?gen95 ( create$ rule9-overruled $?gen93 $?gen94 ) ) ) ?gen90 <- ( light_offense_factor ( negative-overruled $?gen95 ) )"))

([rule9-support] of derived-attribute-rule
   (pos-name rule9-support-gen345)
   (depends-on declare lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule9] ) ) ) ?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ?gen90 <- ( light_offense_factor ( defendant ?Defendant ) ( positive-support $?gen92 & : ( not ( subseq-pos ( create$ rule9 ?gen88 ?gen89 $$$ $?gen92 ) ) ) ) ) ( test ( eq ( class ?gen90 ) light_offense_factor ) ) => ( calc ( bind $?gen95 ( create$ rule9 ?gen88 ?gen89 $?gen92 ) ) ) ?gen90 <- ( light_offense_factor ( positive-support $?gen95 ) )"))

([rule8-defeasibly-dot] of derived-attribute-rule
   (pos-name rule8-defeasibly-dot-gen347)
   (depends-on declare multiple_victims_factor lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule8] ) ) ) ?gen80 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule8 $? ) ) ( test ( eq ( class ?gen80 ) multiple_victims_factor ) ) ( not ( and ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen80 <- ( multiple_victims_factor ( negative ~ 2 ) ( positive-overruled $?gen82 & : ( not ( member$ rule8 $?gen82 ) ) ) ) ) ) => ?gen80 <- ( multiple_victims_factor ( positive 0 ) )"))

([rule8-defeasibly] of derived-attribute-rule
   (pos-name rule8-defeasibly-gen349)
   (depends-on declare lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule8] ) ) ) ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen80 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen82 & : ( not ( member$ rule8 $?gen82 ) ) ) ) ( test ( eq ( class ?gen80 ) multiple_victims_factor ) ) => ?gen80 <- ( multiple_victims_factor ( positive 1 ) ( positive-derivator rule8 ?gen87 ) )"))

([rule8-overruled-dot] of derived-attribute-rule
   (pos-name rule8-overruled-dot-gen351)
   (depends-on declare multiple_victims_factor lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule8] ) ) ) ?gen80 <- ( multiple_victims_factor ( defendant ?Defendant ) ( negative-support $?gen83 ) ( negative-overruled $?gen84 & : ( subseq-pos ( create$ rule8-overruled $?gen83 $$$ $?gen84 ) ) ) ) ( test ( eq ( class ?gen80 ) multiple_victims_factor ) ) ( not ( and ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen80 <- ( multiple_victims_factor ( positive-defeated $?gen82 & : ( not ( member$ rule8 $?gen82 ) ) ) ) ) ) => ( calc ( bind $?gen85 ( delete-member$ $?gen84 ( create$ rule8-overruled $?gen83 ) ) ) ) ?gen80 <- ( multiple_victims_factor ( negative-overruled $?gen85 ) )"))

([rule8-overruled] of derived-attribute-rule
   (pos-name rule8-overruled-gen353)
   (depends-on declare lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule8] ) ) ) ?gen87 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ( positive ?gen86 & : ( >= ?gen86 1 ) ) ) ?gen80 <- ( multiple_victims_factor ( defendant ?Defendant ) ( negative-support $?gen83 ) ( negative-overruled $?gen84 & : ( not ( subseq-pos ( create$ rule8-overruled $?gen83 $$$ $?gen84 ) ) ) ) ( positive-defeated $?gen82 & : ( not ( member$ rule8 $?gen82 ) ) ) ) ( test ( eq ( class ?gen80 ) multiple_victims_factor ) ) => ( calc ( bind $?gen85 ( create$ rule8-overruled $?gen83 $?gen84 ) ) ) ?gen80 <- ( multiple_victims_factor ( negative-overruled $?gen85 ) )"))

([rule8-support] of derived-attribute-rule
   (pos-name rule8-support-gen355)
   (depends-on declare lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule8] ) ) ) ?gen79 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ) ?gen80 <- ( multiple_victims_factor ( defendant ?Defendant ) ( positive-support $?gen82 & : ( not ( subseq-pos ( create$ rule8 ?gen79 $$$ $?gen82 ) ) ) ) ) ( test ( eq ( class ?gen80 ) multiple_victims_factor ) ) => ( calc ( bind $?gen85 ( create$ rule8 ?gen79 $?gen82 ) ) ) ?gen80 <- ( multiple_victims_factor ( positive-support $?gen85 ) )"))

([rule7-defeasibly-dot] of derived-attribute-rule
   (pos-name rule7-defeasibly-dot-gen357)
   (depends-on declare recidivist_factor lc:case recidivist_factor)
   (implies recidivist_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule7] ) ) ) ?gen71 <- ( recidivist_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule7 $? ) ) ( test ( eq ( class ?gen71 ) recidivist_factor ) ) ( not ( and ?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ( positive ?gen77 & : ( >= ?gen77 1 ) ) ) ?gen71 <- ( recidivist_factor ( negative ~ 2 ) ( positive-overruled $?gen73 & : ( not ( member$ rule7 $?gen73 ) ) ) ) ) ) => ?gen71 <- ( recidivist_factor ( positive 0 ) )"))

([rule7-defeasibly] of derived-attribute-rule
   (pos-name rule7-defeasibly-gen359)
   (depends-on declare lc:case recidivist_factor)
   (implies recidivist_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule7] ) ) ) ?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ( positive ?gen77 & : ( >= ?gen77 1 ) ) ) ?gen71 <- ( recidivist_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen73 & : ( not ( member$ rule7 $?gen73 ) ) ) ) ( test ( eq ( class ?gen71 ) recidivist_factor ) ) => ?gen71 <- ( recidivist_factor ( positive 1 ) ( positive-derivator rule7 ?gen78 ) )"))

([rule7-overruled-dot] of derived-attribute-rule
   (pos-name rule7-overruled-dot-gen361)
   (depends-on declare recidivist_factor lc:case recidivist_factor)
   (implies recidivist_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule7] ) ) ) ?gen71 <- ( recidivist_factor ( defendant ?Defendant ) ( negative-support $?gen74 ) ( negative-overruled $?gen75 & : ( subseq-pos ( create$ rule7-overruled $?gen74 $$$ $?gen75 ) ) ) ) ( test ( eq ( class ?gen71 ) recidivist_factor ) ) ( not ( and ?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ( positive ?gen77 & : ( >= ?gen77 1 ) ) ) ?gen71 <- ( recidivist_factor ( positive-defeated $?gen73 & : ( not ( member$ rule7 $?gen73 ) ) ) ) ) ) => ( calc ( bind $?gen76 ( delete-member$ $?gen75 ( create$ rule7-overruled $?gen74 ) ) ) ) ?gen71 <- ( recidivist_factor ( negative-overruled $?gen76 ) )"))

([rule7-overruled] of derived-attribute-rule
   (pos-name rule7-overruled-gen363)
   (depends-on declare lc:case recidivist_factor)
   (implies recidivist_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule7] ) ) ) ?gen78 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ( positive ?gen77 & : ( >= ?gen77 1 ) ) ) ?gen71 <- ( recidivist_factor ( defendant ?Defendant ) ( negative-support $?gen74 ) ( negative-overruled $?gen75 & : ( not ( subseq-pos ( create$ rule7-overruled $?gen74 $$$ $?gen75 ) ) ) ) ( positive-defeated $?gen73 & : ( not ( member$ rule7 $?gen73 ) ) ) ) ( test ( eq ( class ?gen71 ) recidivist_factor ) ) => ( calc ( bind $?gen76 ( create$ rule7-overruled $?gen74 $?gen75 ) ) ) ?gen71 <- ( recidivist_factor ( negative-overruled $?gen76 ) )"))

([rule7-support] of derived-attribute-rule
   (pos-name rule7-support-gen365)
   (depends-on declare lc:case recidivist_factor)
   (implies recidivist_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule7] ) ) ) ?gen70 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ) ?gen71 <- ( recidivist_factor ( defendant ?Defendant ) ( positive-support $?gen73 & : ( not ( subseq-pos ( create$ rule7 ?gen70 $$$ $?gen73 ) ) ) ) ) ( test ( eq ( class ?gen71 ) recidivist_factor ) ) => ( calc ( bind $?gen76 ( create$ rule7 ?gen70 $?gen73 ) ) ) ?gen71 <- ( recidivist_factor ( positive-support $?gen76 ) )"))

([rule6-defeasibly-dot] of derived-attribute-rule
   (pos-name rule6-defeasibly-dot-gen367)
   (depends-on declare child_victim_factor lc:case child_victim_factor)
   (implies child_victim_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule6] ) ) ) ?gen62 <- ( child_victim_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule6 $? ) ) ( test ( eq ( class ?gen62 ) child_victim_factor ) ) ( not ( and ?gen69 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( child_victim_factor ( negative ~ 2 ) ( positive-overruled $?gen64 & : ( not ( member$ rule6 $?gen64 ) ) ) ) ) ) => ?gen62 <- ( child_victim_factor ( positive 0 ) )"))

([rule6-defeasibly] of derived-attribute-rule
   (pos-name rule6-defeasibly-gen369)
   (depends-on declare lc:case child_victim_factor)
   (implies child_victim_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule6] ) ) ) ?gen69 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( child_victim_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen64 & : ( not ( member$ rule6 $?gen64 ) ) ) ) ( test ( eq ( class ?gen62 ) child_victim_factor ) ) => ?gen62 <- ( child_victim_factor ( positive 1 ) ( positive-derivator rule6 ?gen69 ) )"))

([rule6-overruled-dot] of derived-attribute-rule
   (pos-name rule6-overruled-dot-gen371)
   (depends-on declare child_victim_factor lc:case child_victim_factor)
   (implies child_victim_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule6] ) ) ) ?gen62 <- ( child_victim_factor ( defendant ?Defendant ) ( negative-support $?gen65 ) ( negative-overruled $?gen66 & : ( subseq-pos ( create$ rule6-overruled $?gen65 $$$ $?gen66 ) ) ) ) ( test ( eq ( class ?gen62 ) child_victim_factor ) ) ( not ( and ?gen69 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( child_victim_factor ( positive-defeated $?gen64 & : ( not ( member$ rule6 $?gen64 ) ) ) ) ) ) => ( calc ( bind $?gen67 ( delete-member$ $?gen66 ( create$ rule6-overruled $?gen65 ) ) ) ) ?gen62 <- ( child_victim_factor ( negative-overruled $?gen67 ) )"))

([rule6-overruled] of derived-attribute-rule
   (pos-name rule6-overruled-gen373)
   (depends-on declare lc:case child_victim_factor)
   (implies child_victim_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule6] ) ) ) ?gen69 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( child_victim_factor ( defendant ?Defendant ) ( negative-support $?gen65 ) ( negative-overruled $?gen66 & : ( not ( subseq-pos ( create$ rule6-overruled $?gen65 $$$ $?gen66 ) ) ) ) ( positive-defeated $?gen64 & : ( not ( member$ rule6 $?gen64 ) ) ) ) ( test ( eq ( class ?gen62 ) child_victim_factor ) ) => ( calc ( bind $?gen67 ( create$ rule6-overruled $?gen65 $?gen66 ) ) ) ?gen62 <- ( child_victim_factor ( negative-overruled $?gen67 ) )"))

([rule6-support] of derived-attribute-rule
   (pos-name rule6-support-gen375)
   (depends-on declare lc:case child_victim_factor)
   (implies child_victim_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule6] ) ) ) ?gen61 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ) ?gen62 <- ( child_victim_factor ( defendant ?Defendant ) ( positive-support $?gen64 & : ( not ( subseq-pos ( create$ rule6 ?gen61 $$$ $?gen64 ) ) ) ) ) ( test ( eq ( class ?gen62 ) child_victim_factor ) ) => ( calc ( bind $?gen67 ( create$ rule6 ?gen61 $?gen64 ) ) ) ?gen62 <- ( child_victim_factor ( positive-support $?gen67 ) )"))

([rule5-defeasibly-dot] of derived-attribute-rule
   (pos-name rule5-defeasibly-dot-gen377)
   (depends-on declare family_offense_factor lc:case family_offense_factor)
   (implies family_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule5] ) ) ) ?gen53 <- ( family_offense_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule5 $? ) ) ( test ( eq ( class ?gen53 ) family_offense_factor ) ) ( not ( and ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen53 <- ( family_offense_factor ( negative ~ 2 ) ( positive-overruled $?gen55 & : ( not ( member$ rule5 $?gen55 ) ) ) ) ) ) => ?gen53 <- ( family_offense_factor ( positive 0 ) )"))

([rule5-defeasibly] of derived-attribute-rule
   (pos-name rule5-defeasibly-gen379)
   (depends-on declare lc:case family_offense_factor)
   (implies family_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule5] ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen53 <- ( family_offense_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen55 & : ( not ( member$ rule5 $?gen55 ) ) ) ) ( test ( eq ( class ?gen53 ) family_offense_factor ) ) => ?gen53 <- ( family_offense_factor ( positive 1 ) ( positive-derivator rule5 ?gen60 ) )"))

([rule5-overruled-dot] of derived-attribute-rule
   (pos-name rule5-overruled-dot-gen381)
   (depends-on declare family_offense_factor lc:case family_offense_factor)
   (implies family_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule5] ) ) ) ?gen53 <- ( family_offense_factor ( defendant ?Defendant ) ( negative-support $?gen56 ) ( negative-overruled $?gen57 & : ( subseq-pos ( create$ rule5-overruled $?gen56 $$$ $?gen57 ) ) ) ) ( test ( eq ( class ?gen53 ) family_offense_factor ) ) ( not ( and ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen53 <- ( family_offense_factor ( positive-defeated $?gen55 & : ( not ( member$ rule5 $?gen55 ) ) ) ) ) ) => ( calc ( bind $?gen58 ( delete-member$ $?gen57 ( create$ rule5-overruled $?gen56 ) ) ) ) ?gen53 <- ( family_offense_factor ( negative-overruled $?gen58 ) )"))

([rule5-overruled] of derived-attribute-rule
   (pos-name rule5-overruled-gen383)
   (depends-on declare lc:case family_offense_factor)
   (implies family_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule5] ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen53 <- ( family_offense_factor ( defendant ?Defendant ) ( negative-support $?gen56 ) ( negative-overruled $?gen57 & : ( not ( subseq-pos ( create$ rule5-overruled $?gen56 $$$ $?gen57 ) ) ) ) ( positive-defeated $?gen55 & : ( not ( member$ rule5 $?gen55 ) ) ) ) ( test ( eq ( class ?gen53 ) family_offense_factor ) ) => ( calc ( bind $?gen58 ( create$ rule5-overruled $?gen56 $?gen57 ) ) ) ?gen53 <- ( family_offense_factor ( negative-overruled $?gen58 ) )"))

([rule5-support] of derived-attribute-rule
   (pos-name rule5-support-gen385)
   (depends-on declare lc:case family_offense_factor)
   (implies family_offense_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule5] ) ) ) ?gen52 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ) ?gen53 <- ( family_offense_factor ( defendant ?Defendant ) ( positive-support $?gen55 & : ( not ( subseq-pos ( create$ rule5 ?gen52 $$$ $?gen55 ) ) ) ) ) ( test ( eq ( class ?gen53 ) family_offense_factor ) ) => ( calc ( bind $?gen58 ( create$ rule5 ?gen52 $?gen55 ) ) ) ?gen53 <- ( family_offense_factor ( positive-support $?gen58 ) )"))

([rule4-defeasibly-dot] of derived-attribute-rule
   (pos-name rule4-defeasibly-dot-gen387)
   (depends-on declare weapon_factor lc:case weapon_factor)
   (implies weapon_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule4] ) ) ) ?gen44 <- ( weapon_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule4 $? ) ) ( test ( eq ( class ?gen44 ) weapon_factor ) ) ( not ( and ?gen51 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ( positive ?gen50 & : ( >= ?gen50 1 ) ) ) ?gen44 <- ( weapon_factor ( negative ~ 2 ) ( positive-overruled $?gen46 & : ( not ( member$ rule4 $?gen46 ) ) ) ) ) ) => ?gen44 <- ( weapon_factor ( positive 0 ) )"))

([rule4-defeasibly] of derived-attribute-rule
   (pos-name rule4-defeasibly-gen389)
   (depends-on declare lc:case weapon_factor)
   (implies weapon_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule4] ) ) ) ?gen51 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ( positive ?gen50 & : ( >= ?gen50 1 ) ) ) ?gen44 <- ( weapon_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen46 & : ( not ( member$ rule4 $?gen46 ) ) ) ) ( test ( eq ( class ?gen44 ) weapon_factor ) ) => ?gen44 <- ( weapon_factor ( positive 1 ) ( positive-derivator rule4 ?gen51 ) )"))

([rule4-overruled-dot] of derived-attribute-rule
   (pos-name rule4-overruled-dot-gen391)
   (depends-on declare weapon_factor lc:case weapon_factor)
   (implies weapon_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule4] ) ) ) ?gen44 <- ( weapon_factor ( defendant ?Defendant ) ( negative-support $?gen47 ) ( negative-overruled $?gen48 & : ( subseq-pos ( create$ rule4-overruled $?gen47 $$$ $?gen48 ) ) ) ) ( test ( eq ( class ?gen44 ) weapon_factor ) ) ( not ( and ?gen51 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ( positive ?gen50 & : ( >= ?gen50 1 ) ) ) ?gen44 <- ( weapon_factor ( positive-defeated $?gen46 & : ( not ( member$ rule4 $?gen46 ) ) ) ) ) ) => ( calc ( bind $?gen49 ( delete-member$ $?gen48 ( create$ rule4-overruled $?gen47 ) ) ) ) ?gen44 <- ( weapon_factor ( negative-overruled $?gen49 ) )"))

([rule4-overruled] of derived-attribute-rule
   (pos-name rule4-overruled-gen393)
   (depends-on declare lc:case weapon_factor)
   (implies weapon_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule4] ) ) ) ?gen51 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ( positive ?gen50 & : ( >= ?gen50 1 ) ) ) ?gen44 <- ( weapon_factor ( defendant ?Defendant ) ( negative-support $?gen47 ) ( negative-overruled $?gen48 & : ( not ( subseq-pos ( create$ rule4-overruled $?gen47 $$$ $?gen48 ) ) ) ) ( positive-defeated $?gen46 & : ( not ( member$ rule4 $?gen46 ) ) ) ) ( test ( eq ( class ?gen44 ) weapon_factor ) ) => ( calc ( bind $?gen49 ( create$ rule4-overruled $?gen47 $?gen48 ) ) ) ?gen44 <- ( weapon_factor ( negative-overruled $?gen49 ) )"))

([rule4-support] of derived-attribute-rule
   (pos-name rule4-support-gen395)
   (depends-on declare lc:case weapon_factor)
   (implies weapon_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule4] ) ) ) ?gen43 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ) ?gen44 <- ( weapon_factor ( defendant ?Defendant ) ( positive-support $?gen46 & : ( not ( subseq-pos ( create$ rule4 ?gen43 $$$ $?gen46 ) ) ) ) ) ( test ( eq ( class ?gen44 ) weapon_factor ) ) => ( calc ( bind $?gen49 ( create$ rule4 ?gen43 $?gen46 ) ) ) ?gen44 <- ( weapon_factor ( positive-support $?gen49 ) )"))

([rule3-defeasibly-dot] of derived-attribute-rule
   (pos-name rule3-defeasibly-dot-gen397)
   (depends-on declare aggravating_factor lc:case aggravating_factor)
   (implies aggravating_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule3] ) ) ) ?gen35 <- ( aggravating_factor ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule3 $? ) ) ( test ( eq ( class ?gen35 ) aggravating_factor ) ) ( not ( and ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ?gen35 <- ( aggravating_factor ( negative ~ 2 ) ( positive-overruled $?gen37 & : ( not ( member$ rule3 $?gen37 ) ) ) ) ) ) => ?gen35 <- ( aggravating_factor ( positive 0 ) )"))

([rule3-defeasibly] of derived-attribute-rule
   (pos-name rule3-defeasibly-gen399)
   (depends-on declare lc:case aggravating_factor)
   (implies aggravating_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule3] ) ) ) ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ?gen35 <- ( aggravating_factor ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen37 & : ( not ( member$ rule3 $?gen37 ) ) ) ) ( test ( eq ( class ?gen35 ) aggravating_factor ) ) => ?gen35 <- ( aggravating_factor ( positive 1 ) ( positive-derivator rule3 ?gen42 ) )"))

([rule3-overruled-dot] of derived-attribute-rule
   (pos-name rule3-overruled-dot-gen401)
   (depends-on declare aggravating_factor lc:case aggravating_factor)
   (implies aggravating_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule3] ) ) ) ?gen35 <- ( aggravating_factor ( defendant ?Defendant ) ( negative-support $?gen38 ) ( negative-overruled $?gen39 & : ( subseq-pos ( create$ rule3-overruled $?gen38 $$$ $?gen39 ) ) ) ) ( test ( eq ( class ?gen35 ) aggravating_factor ) ) ( not ( and ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ?gen35 <- ( aggravating_factor ( positive-defeated $?gen37 & : ( not ( member$ rule3 $?gen37 ) ) ) ) ) ) => ( calc ( bind $?gen40 ( delete-member$ $?gen39 ( create$ rule3-overruled $?gen38 ) ) ) ) ?gen35 <- ( aggravating_factor ( negative-overruled $?gen40 ) )"))

([rule3-overruled] of derived-attribute-rule
   (pos-name rule3-overruled-gen403)
   (depends-on declare lc:case aggravating_factor)
   (implies aggravating_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule3] ) ) ) ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ?gen35 <- ( aggravating_factor ( defendant ?Defendant ) ( negative-support $?gen38 ) ( negative-overruled $?gen39 & : ( not ( subseq-pos ( create$ rule3-overruled $?gen38 $$$ $?gen39 ) ) ) ) ( positive-defeated $?gen37 & : ( not ( member$ rule3 $?gen37 ) ) ) ) ( test ( eq ( class ?gen35 ) aggravating_factor ) ) => ( calc ( bind $?gen40 ( create$ rule3-overruled $?gen38 $?gen39 ) ) ) ?gen35 <- ( aggravating_factor ( negative-overruled $?gen40 ) )"))

([rule3-support] of derived-attribute-rule
   (pos-name rule3-support-gen405)
   (depends-on declare lc:case aggravating_factor)
   (implies aggravating_factor)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule3] ) ) ) ?gen34 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ) ?gen35 <- ( aggravating_factor ( defendant ?Defendant ) ( positive-support $?gen37 & : ( not ( subseq-pos ( create$ rule3 ?gen34 $$$ $?gen37 ) ) ) ) ) ( test ( eq ( class ?gen35 ) aggravating_factor ) ) => ( calc ( bind $?gen40 ( create$ rule3 ?gen34 $?gen37 ) ) ) ?gen35 <- ( aggravating_factor ( positive-support $?gen40 ) )"))

([rule2-defeasibly-dot] of derived-attribute-rule
   (pos-name rule2-defeasibly-dot-gen407)
   (depends-on declare increase_punishment lc:case increase_punishment)
   (implies increase_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule2] ) ) ) ?gen26 <- ( increase_punishment ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule2 $? ) ) ( test ( eq ( class ?gen26 ) increase_punishment ) ) ( not ( and ?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ( positive ?gen32 & : ( >= ?gen32 1 ) ) ) ?gen26 <- ( increase_punishment ( negative ~ 2 ) ( positive-overruled $?gen28 & : ( not ( member$ rule2 $?gen28 ) ) ) ) ) ) => ?gen26 <- ( increase_punishment ( positive 0 ) )"))

([rule2-defeasibly] of derived-attribute-rule
   (pos-name rule2-defeasibly-gen409)
   (depends-on declare lc:case increase_punishment)
   (implies increase_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule2] ) ) ) ?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ( positive ?gen32 & : ( >= ?gen32 1 ) ) ) ?gen26 <- ( increase_punishment ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen28 & : ( not ( member$ rule2 $?gen28 ) ) ) ) ( test ( eq ( class ?gen26 ) increase_punishment ) ) => ?gen26 <- ( increase_punishment ( positive 1 ) ( positive-derivator rule2 ?gen33 ) )"))

([rule2-overruled-dot] of derived-attribute-rule
   (pos-name rule2-overruled-dot-gen411)
   (depends-on declare increase_punishment lc:case increase_punishment)
   (implies increase_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule2] ) ) ) ?gen26 <- ( increase_punishment ( defendant ?Defendant ) ( negative-support $?gen29 ) ( negative-overruled $?gen30 & : ( subseq-pos ( create$ rule2-overruled $?gen29 $$$ $?gen30 ) ) ) ) ( test ( eq ( class ?gen26 ) increase_punishment ) ) ( not ( and ?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ( positive ?gen32 & : ( >= ?gen32 1 ) ) ) ?gen26 <- ( increase_punishment ( positive-defeated $?gen28 & : ( not ( member$ rule2 $?gen28 ) ) ) ) ) ) => ( calc ( bind $?gen31 ( delete-member$ $?gen30 ( create$ rule2-overruled $?gen29 ) ) ) ) ?gen26 <- ( increase_punishment ( negative-overruled $?gen31 ) )"))

([rule2-overruled] of derived-attribute-rule
   (pos-name rule2-overruled-gen413)
   (depends-on declare lc:case increase_punishment)
   (implies increase_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule2] ) ) ) ?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ( positive ?gen32 & : ( >= ?gen32 1 ) ) ) ?gen26 <- ( increase_punishment ( defendant ?Defendant ) ( negative-support $?gen29 ) ( negative-overruled $?gen30 & : ( not ( subseq-pos ( create$ rule2-overruled $?gen29 $$$ $?gen30 ) ) ) ) ( positive-defeated $?gen28 & : ( not ( member$ rule2 $?gen28 ) ) ) ) ( test ( eq ( class ?gen26 ) increase_punishment ) ) => ( calc ( bind $?gen31 ( create$ rule2-overruled $?gen29 $?gen30 ) ) ) ?gen26 <- ( increase_punishment ( negative-overruled $?gen31 ) )"))

([rule2-support] of derived-attribute-rule
   (pos-name rule2-support-gen415)
   (depends-on declare lc:case increase_punishment)
   (implies increase_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule2] ) ) ) ?gen25 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ) ?gen26 <- ( increase_punishment ( defendant ?Defendant ) ( positive-support $?gen28 & : ( not ( subseq-pos ( create$ rule2 ?gen25 $$$ $?gen28 ) ) ) ) ) ( test ( eq ( class ?gen26 ) increase_punishment ) ) => ( calc ( bind $?gen31 ( create$ rule2 ?gen25 $?gen28 ) ) ) ?gen26 <- ( increase_punishment ( positive-support $?gen31 ) )"))

([rule1-defeasibly-dot] of derived-attribute-rule
   (pos-name rule1-defeasibly-dot-gen417)
   (depends-on declare basic_punishment lc:case basic_punishment)
   (implies basic_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule1] ) ) ) ?gen17 <- ( basic_punishment ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule1 $? ) ) ( test ( eq ( class ?gen17 ) basic_punishment ) ) ( not ( and ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen17 <- ( basic_punishment ( negative ~ 2 ) ( positive-overruled $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ) ) => ?gen17 <- ( basic_punishment ( positive 0 ) )"))

([rule1-defeasibly] of derived-attribute-rule
   (pos-name rule1-defeasibly-gen419)
   (depends-on declare lc:case basic_punishment)
   (implies basic_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule1] ) ) ) ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen17 <- ( basic_punishment ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ( test ( eq ( class ?gen17 ) basic_punishment ) ) => ?gen17 <- ( basic_punishment ( positive 1 ) ( positive-derivator rule1 ?gen24 ) )"))

([rule1-overruled-dot] of derived-attribute-rule
   (pos-name rule1-overruled-dot-gen421)
   (depends-on declare basic_punishment lc:case basic_punishment)
   (implies basic_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule1] ) ) ) ?gen17 <- ( basic_punishment ( defendant ?Defendant ) ( negative-support $?gen20 ) ( negative-overruled $?gen21 & : ( subseq-pos ( create$ rule1-overruled $?gen20 $$$ $?gen21 ) ) ) ) ( test ( eq ( class ?gen17 ) basic_punishment ) ) ( not ( and ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen17 <- ( basic_punishment ( positive-defeated $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ) ) => ( calc ( bind $?gen22 ( delete-member$ $?gen21 ( create$ rule1-overruled $?gen20 ) ) ) ) ?gen17 <- ( basic_punishment ( negative-overruled $?gen22 ) )"))

([rule1-overruled] of derived-attribute-rule
   (pos-name rule1-overruled-gen423)
   (depends-on declare lc:case basic_punishment)
   (implies basic_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule1] ) ) ) ?gen24 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ( positive ?gen23 & : ( >= ?gen23 1 ) ) ) ?gen17 <- ( basic_punishment ( defendant ?Defendant ) ( negative-support $?gen20 ) ( negative-overruled $?gen21 & : ( not ( subseq-pos ( create$ rule1-overruled $?gen20 $$$ $?gen21 ) ) ) ) ( positive-defeated $?gen19 & : ( not ( member$ rule1 $?gen19 ) ) ) ) ( test ( eq ( class ?gen17 ) basic_punishment ) ) => ( calc ( bind $?gen22 ( create$ rule1-overruled $?gen20 $?gen21 ) ) ) ?gen17 <- ( basic_punishment ( negative-overruled $?gen22 ) )"))

([rule1-support] of derived-attribute-rule
   (pos-name rule1-support-gen425)
   (depends-on declare lc:case basic_punishment)
   (implies basic_punishment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule1] ) ) ) ?gen16 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ) ?gen17 <- ( basic_punishment ( defendant ?Defendant ) ( positive-support $?gen19 & : ( not ( subseq-pos ( create$ rule1 ?gen16 $$$ $?gen19 ) ) ) ) ) ( test ( eq ( class ?gen17 ) basic_punishment ) ) => ( calc ( bind $?gen22 ( create$ rule1 ?gen16 $?gen19 ) ) ) ?gen17 <- ( basic_punishment ( positive-support $?gen22 ) )"))

([pen7-deductive] of ntm-deductive-rule
   (pos-name pen7-deductive-gen218)
   (depends-on threat_offense_factor fine)
   (implies fine)
   (deductive-rule "?gen193 <- ( threat_offense_factor ( defendant ?Defendant ) ) ( not ( fine ( value 3000 ) ) ) => ( fine ( value 3000 ) )")
   (production-rule "( defrule pen7-deductive-gen218 ( declare ( salience ( calc-salience fine ) ) ) ( run-deductive-rules ) ( object ( name ?gen193 ) ( is-a threat_offense_factor ) ( defendant ?Defendant ) ) ( not ( object ( is-a fine ) ( value 3000 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat fine 3000 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat fine 3000 ) ) ) ( make-instance ?oid of fine ( value 3000 ) ) )")
   (derived-class fine))

([pen6-deductive] of ntm-deductive-rule
   (pos-name pen6-deductive-gen217)
   (depends-on light_offense_factor fine)
   (implies fine)
   (deductive-rule "?gen184 <- ( light_offense_factor ( defendant ?Defendant ) ) ( not ( fine ( value 2000 ) ) ) => ( fine ( value 2000 ) )")
   (production-rule "( defrule pen6-deductive-gen217 ( declare ( salience ( calc-salience fine ) ) ) ( run-deductive-rules ) ( object ( name ?gen184 ) ( is-a light_offense_factor ) ( defendant ?Defendant ) ) ( not ( object ( is-a fine ) ( value 2000 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat fine 2000 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat fine 2000 ) ) ) ( make-instance ?oid of fine ( value 2000 ) ) )")
   (derived-class fine))

([pen5-deductive] of ntm-deductive-rule
   (pos-name pen5-deductive-gen216)
   (depends-on multiple_victims_factor imprisonment)
   (implies imprisonment)
   (deductive-rule "?gen175 <- ( multiple_victims_factor ( defendant ?Defendant ) ) ( not ( imprisonment ( value 24 ) ) ) => ( imprisonment ( value 24 ) )")
   (production-rule "( defrule pen5-deductive-gen216 ( declare ( salience ( calc-salience imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen175 ) ( is-a multiple_victims_factor ) ( defendant ?Defendant ) ) ( not ( object ( is-a imprisonment ) ( value 24 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat imprisonment 24 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat imprisonment 24 ) ) ) ( make-instance ?oid of imprisonment ( value 24 ) ) )")
   (derived-class imprisonment))

([pen4-deductive] of ntm-deductive-rule
   (pos-name pen4-deductive-gen215)
   (depends-on child_victim_factor imprisonment)
   (implies imprisonment)
   (deductive-rule "?gen157 <- ( child_victim_factor ( defendant ?Defendant ) ) ( not ( imprisonment ( value 12 ) ) ) => ( imprisonment ( value 12 ) )")
   (production-rule "( defrule pen4-deductive-gen215 ( declare ( salience ( calc-salience imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen157 ) ( is-a child_victim_factor ) ( defendant ?Defendant ) ) ( not ( object ( is-a imprisonment ) ( value 12 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat imprisonment 12 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat imprisonment 12 ) ) ) ( make-instance ?oid of imprisonment ( value 12 ) ) )")
   (derived-class imprisonment))

([pen3-deductive] of ntm-deductive-rule
   (pos-name pen3-deductive-gen214)
   (depends-on aggravating_factor fine)
   (implies fine)
   (deductive-rule "?gen130 <- ( aggravating_factor ( defendant ?Defendant ) ) ( not ( fine ( value 10000 ) ) ) => ( fine ( value 10000 ) )")
   (production-rule "( defrule pen3-deductive-gen214 ( declare ( salience ( calc-salience fine ) ) ) ( run-deductive-rules ) ( object ( name ?gen130 ) ( is-a aggravating_factor ) ( defendant ?Defendant ) ) ( not ( object ( is-a fine ) ( value 10000 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat fine 10000 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat fine 10000 ) ) ) ( make-instance ?oid of fine ( value 10000 ) ) )")
   (derived-class fine))

([pen2-deductive] of ntm-deductive-rule
   (pos-name pen2-deductive-gen213)
   (depends-on increase_punishment fine)
   (implies fine)
   (deductive-rule "?gen121 <- ( increase_punishment ( defendant ?Defendant ) ) ( not ( fine ( value 5000 ) ) ) => ( fine ( value 5000 ) )")
   (production-rule "( defrule pen2-deductive-gen213 ( declare ( salience ( calc-salience fine ) ) ) ( run-deductive-rules ) ( object ( name ?gen121 ) ( is-a increase_punishment ) ( defendant ?Defendant ) ) ( not ( object ( is-a fine ) ( value 5000 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat fine 5000 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat fine 5000 ) ) ) ( make-instance ?oid of fine ( value 5000 ) ) )")
   (derived-class fine))

([pen1-deductive] of ntm-deductive-rule
   (pos-name pen1-deductive-gen212)
   (depends-on basic_punishment imprisonment)
   (implies imprisonment)
   (deductive-rule "?gen112 <- ( basic_punishment ( defendant ?Defendant ) ) ( not ( imprisonment ( value 6 ) ) ) => ( imprisonment ( value 6 ) )")
   (production-rule "( defrule pen1-deductive-gen212 ( declare ( salience ( calc-salience imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen112 ) ( is-a basic_punishment ) ( defendant ?Defendant ) ) ( not ( object ( is-a imprisonment ) ( value 6 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat imprisonment 6 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat imprisonment 6 ) ) ) ( make-instance ?oid of imprisonment ( value 6 ) ) )")
   (derived-class imprisonment))

([rule10-deductive] of ntm-deductive-rule
   (pos-name rule10-deductive-gen211)
   (depends-on lc:case lc:case threat_offense_factor)
   (implies threat_offense_factor)
   (deductive-rule "?gen100 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ) ?gen101 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ( not ( threat_offense_factor ( defendant ?Defendant ) ) ) => ( threat_offense_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule10-deductive-gen211 ( declare ( salience ( calc-salience threat_offense_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen100 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:violenceNature \"THREAT\" ) ) ( object ( name ?gen101 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ( not ( object ( is-a threat_offense_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat threat_offense_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat threat_offense_factor ?Defendant ) ) ) ( make-instance ?oid of threat_offense_factor ( defendant ?Defendant ) ) )")
   (derived-class threat_offense_factor))

([rule9-deductive] of ntm-deductive-rule
   (pos-name rule9-deductive-gen210)
   (depends-on lc:case lc:case light_offense_factor)
   (implies light_offense_factor)
   (deductive-rule "?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ) ?gen89 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ( not ( light_offense_factor ( defendant ?Defendant ) ) ) => ( light_offense_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule9-deductive-gen210 ( declare ( salience ( calc-salience light_offense_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen88 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:violenceNature \"RECKLESS_BEHAVIOUR\" ) ) ( object ( name ?gen89 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:injuryTypes \"NONE\" ) ) ( not ( object ( is-a light_offense_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat light_offense_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat light_offense_factor ?Defendant ) ) ) ( make-instance ?oid of light_offense_factor ( defendant ?Defendant ) ) )")
   (derived-class light_offense_factor))

([rule8-deductive] of ntm-deductive-rule
   (pos-name rule8-deductive-gen209)
   (depends-on lc:case multiple_victims_factor)
   (implies multiple_victims_factor)
   (deductive-rule "?gen79 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ) ( not ( multiple_victims_factor ( defendant ?Defendant ) ) ) => ( multiple_victims_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule8-deductive-gen209 ( declare ( salience ( calc-salience multiple_victims_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen79 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:numvictims ?NumVictims ) ) ( not ( object ( is-a multiple_victims_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat multiple_victims_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat multiple_victims_factor ?Defendant ) ) ) ( make-instance ?oid of multiple_victims_factor ( defendant ?Defendant ) ) )")
   (derived-class multiple_victims_factor))

([rule7-deductive] of ntm-deductive-rule
   (pos-name rule7-deductive-gen208)
   (depends-on lc:case recidivist_factor)
   (implies recidivist_factor)
   (deductive-rule "?gen70 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ) ( not ( recidivist_factor ( defendant ?Defendant ) ) ) => ( recidivist_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule7-deductive-gen208 ( declare ( salience ( calc-salience recidivist_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen70 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:previouslyConvicted true ) ) ( not ( object ( is-a recidivist_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat recidivist_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat recidivist_factor ?Defendant ) ) ) ( make-instance ?oid of recidivist_factor ( defendant ?Defendant ) ) )")
   (derived-class recidivist_factor))

([rule6-deductive] of ntm-deductive-rule
   (pos-name rule6-deductive-gen207)
   (depends-on lc:case child_victim_factor)
   (implies child_victim_factor)
   (deductive-rule "?gen61 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ) ( not ( child_victim_factor ( defendant ?Defendant ) ) ) => ( child_victim_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule6-deductive-gen207 ( declare ( salience ( calc-salience child_victim_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen61 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:victimRelationship \"CHILD\" ) ) ( not ( object ( is-a child_victim_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat child_victim_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat child_victim_factor ?Defendant ) ) ) ( make-instance ?oid of child_victim_factor ( defendant ?Defendant ) ) )")
   (derived-class child_victim_factor))

([rule5-deductive] of ntm-deductive-rule
   (pos-name rule5-deductive-gen206)
   (depends-on lc:case family_offense_factor)
   (implies family_offense_factor)
   (deductive-rule "?gen52 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ) ( not ( family_offense_factor ( defendant ?Defendant ) ) ) => ( family_offense_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule5-deductive-gen206 ( declare ( salience ( calc-salience family_offense_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen52 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:victimRelationship \"SPOUSE\" ) ) ( not ( object ( is-a family_offense_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat family_offense_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat family_offense_factor ?Defendant ) ) ) ( make-instance ?oid of family_offense_factor ( defendant ?Defendant ) ) )")
   (derived-class family_offense_factor))

([rule4-deductive] of ntm-deductive-rule
   (pos-name rule4-deductive-gen205)
   (depends-on lc:case weapon_factor)
   (implies weapon_factor)
   (deductive-rule "?gen43 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ) ( not ( weapon_factor ( defendant ?Defendant ) ) ) => ( weapon_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule4-deductive-gen205 ( declare ( salience ( calc-salience weapon_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen43 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:useOfWeapon true ) ) ( not ( object ( is-a weapon_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat weapon_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat weapon_factor ?Defendant ) ) ) ( make-instance ?oid of weapon_factor ( defendant ?Defendant ) ) )")
   (derived-class weapon_factor))

([rule3-deductive] of ntm-deductive-rule
   (pos-name rule3-deductive-gen204)
   (depends-on lc:case aggravating_factor)
   (implies aggravating_factor)
   (deductive-rule "?gen34 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ) ( not ( aggravating_factor ( defendant ?Defendant ) ) ) => ( aggravating_factor ( defendant ?Defendant ) )")
   (production-rule "( defrule rule3-deductive-gen204 ( declare ( salience ( calc-salience aggravating_factor ) ) ) ( run-deductive-rules ) ( object ( name ?gen34 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:childrenPresent true ) ) ( not ( object ( is-a aggravating_factor ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat aggravating_factor ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat aggravating_factor ?Defendant ) ) ) ( make-instance ?oid of aggravating_factor ( defendant ?Defendant ) ) )")
   (derived-class aggravating_factor))

([rule2-deductive] of ntm-deductive-rule
   (pos-name rule2-deductive-gen203)
   (depends-on lc:case increase_punishment)
   (implies increase_punishment)
   (deductive-rule "?gen25 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ) ( not ( increase_punishment ( defendant ?Defendant ) ) ) => ( increase_punishment ( defendant ?Defendant ) )")
   (production-rule "( defrule rule2-deductive-gen203 ( declare ( salience ( calc-salience increase_punishment ) ) ) ( run-deductive-rules ) ( object ( name ?gen25 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:protectionMeasureViolation true ) ) ( not ( object ( is-a increase_punishment ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat increase_punishment ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat increase_punishment ?Defendant ) ) ) ( make-instance ?oid of increase_punishment ( defendant ?Defendant ) ) )")
   (derived-class increase_punishment))

([rule1-deductive] of ntm-deductive-rule
   (pos-name rule1-deductive-gen202)
   (depends-on lc:case basic_punishment)
   (implies basic_punishment)
   (deductive-rule "?gen16 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ) ( not ( basic_punishment ( defendant ?Defendant ) ) ) => ( basic_punishment ( defendant ?Defendant ) )")
   (production-rule "( defrule rule1-deductive-gen202 ( declare ( salience ( calc-salience basic_punishment ) ) ) ( run-deductive-rules ) ( object ( name ?gen16 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:injuryTypes \"SEVERE\" ) ) ( not ( object ( is-a basic_punishment ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat basic_punishment ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat basic_punishment ?Defendant ) ) ) ( make-instance ?oid of basic_punishment ( defendant ?Defendant ) ) )")
   (derived-class basic_punishment))

