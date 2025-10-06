([pen_lv6_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv6_min-defeasibly-dot-gen426)
   (depends-on declare min_imprisonment is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv6_min] ) ) ) ?gen384 <- ( min_imprisonment ( value 10 ) ( positive 1 ) ( positive-derivator pen_lv6_min $? ) ) ( test ( eq ( class ?gen384 ) min_imprisonment ) ) ( not ( and ?gen391 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen390 & : ( >= ?gen390 1 ) ) ) ?gen384 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen386 & : ( not ( member$ pen_lv6_min $?gen386 ) ) ) ) ) ) => ?gen384 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv6_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv6_min-defeasibly-gen428)
   (depends-on declare is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv6_min] ) ) ) ?gen391 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen390 & : ( >= ?gen390 1 ) ) ) ?gen384 <- ( min_imprisonment ( value 10 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen386 & : ( not ( member$ pen_lv6_min $?gen386 ) ) ) ) ( test ( eq ( class ?gen384 ) min_imprisonment ) ) => ?gen384 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv6_min ?gen391 ) )"))

([pen_lv6_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv6_min-overruled-dot-gen430)
   (depends-on declare min_imprisonment is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv6_min] ) ) ) ?gen384 <- ( min_imprisonment ( value 10 ) ( negative-support $?gen387 ) ( negative-overruled $?gen388 & : ( subseq-pos ( create$ pen_lv6_min-overruled $?gen387 $$$ $?gen388 ) ) ) ) ( test ( eq ( class ?gen384 ) min_imprisonment ) ) ( not ( and ?gen391 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen390 & : ( >= ?gen390 1 ) ) ) ?gen384 <- ( min_imprisonment ( positive-defeated $?gen386 & : ( not ( member$ pen_lv6_min $?gen386 ) ) ) ) ) ) => ( calc ( bind $?gen389 ( delete-member$ $?gen388 ( create$ pen_lv6_min-overruled $?gen387 ) ) ) ) ?gen384 <- ( min_imprisonment ( negative-overruled $?gen389 ) )"))

([pen_lv6_min-overruled] of derived-attribute-rule
   (pos-name pen_lv6_min-overruled-gen432)
   (depends-on declare is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv6_min] ) ) ) ?gen391 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen390 & : ( >= ?gen390 1 ) ) ) ?gen384 <- ( min_imprisonment ( value 10 ) ( negative-support $?gen387 ) ( negative-overruled $?gen388 & : ( not ( subseq-pos ( create$ pen_lv6_min-overruled $?gen387 $$$ $?gen388 ) ) ) ) ( positive-defeated $?gen386 & : ( not ( member$ pen_lv6_min $?gen386 ) ) ) ) ( test ( eq ( class ?gen384 ) min_imprisonment ) ) => ( calc ( bind $?gen389 ( create$ pen_lv6_min-overruled $?gen387 $?gen388 ) ) ) ?gen384 <- ( min_imprisonment ( negative-overruled $?gen389 ) )"))

([pen_lv6_min-support] of derived-attribute-rule
   (pos-name pen_lv6_min-support-gen434)
   (depends-on declare is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv6_min] ) ) ) ?gen383 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen384 <- ( min_imprisonment ( value 10 ) ( positive-support $?gen386 & : ( not ( subseq-pos ( create$ pen_lv6_min ?gen383 $$$ $?gen386 ) ) ) ) ) ( test ( eq ( class ?gen384 ) min_imprisonment ) ) => ( calc ( bind $?gen389 ( create$ pen_lv6_min ?gen383 $?gen386 ) ) ) ?gen384 <- ( min_imprisonment ( positive-support $?gen389 ) )"))

([pen_lv5_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv5_max-defeasibly-dot-gen436)
   (depends-on declare max_imprisonment is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv5_max] ) ) ) ?gen375 <- ( max_imprisonment ( value 15 ) ( positive 1 ) ( positive-derivator pen_lv5_max $? ) ) ( test ( eq ( class ?gen375 ) max_imprisonment ) ) ( not ( and ?gen382 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen381 & : ( >= ?gen381 1 ) ) ) ?gen375 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen377 & : ( not ( member$ pen_lv5_max $?gen377 ) ) ) ) ) ) => ?gen375 <- ( max_imprisonment ( positive 0 ) )"))

([pen_lv5_max-defeasibly] of derived-attribute-rule
   (pos-name pen_lv5_max-defeasibly-gen438)
   (depends-on declare is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv5_max] ) ) ) ?gen382 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen381 & : ( >= ?gen381 1 ) ) ) ?gen375 <- ( max_imprisonment ( value 15 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen377 & : ( not ( member$ pen_lv5_max $?gen377 ) ) ) ) ( test ( eq ( class ?gen375 ) max_imprisonment ) ) => ?gen375 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_lv5_max ?gen382 ) )"))

([pen_lv5_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv5_max-overruled-dot-gen440)
   (depends-on declare max_imprisonment is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv5_max] ) ) ) ?gen375 <- ( max_imprisonment ( value 15 ) ( negative-support $?gen378 ) ( negative-overruled $?gen379 & : ( subseq-pos ( create$ pen_lv5_max-overruled $?gen378 $$$ $?gen379 ) ) ) ) ( test ( eq ( class ?gen375 ) max_imprisonment ) ) ( not ( and ?gen382 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen381 & : ( >= ?gen381 1 ) ) ) ?gen375 <- ( max_imprisonment ( positive-defeated $?gen377 & : ( not ( member$ pen_lv5_max $?gen377 ) ) ) ) ) ) => ( calc ( bind $?gen380 ( delete-member$ $?gen379 ( create$ pen_lv5_max-overruled $?gen378 ) ) ) ) ?gen375 <- ( max_imprisonment ( negative-overruled $?gen380 ) )"))

([pen_lv5_max-overruled] of derived-attribute-rule
   (pos-name pen_lv5_max-overruled-gen442)
   (depends-on declare is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv5_max] ) ) ) ?gen382 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen381 & : ( >= ?gen381 1 ) ) ) ?gen375 <- ( max_imprisonment ( value 15 ) ( negative-support $?gen378 ) ( negative-overruled $?gen379 & : ( not ( subseq-pos ( create$ pen_lv5_max-overruled $?gen378 $$$ $?gen379 ) ) ) ) ( positive-defeated $?gen377 & : ( not ( member$ pen_lv5_max $?gen377 ) ) ) ) ( test ( eq ( class ?gen375 ) max_imprisonment ) ) => ( calc ( bind $?gen380 ( create$ pen_lv5_max-overruled $?gen378 $?gen379 ) ) ) ?gen375 <- ( max_imprisonment ( negative-overruled $?gen380 ) )"))

([pen_lv5_max-support] of derived-attribute-rule
   (pos-name pen_lv5_max-support-gen444)
   (depends-on declare is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv5_max] ) ) ) ?gen374 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen375 <- ( max_imprisonment ( value 15 ) ( positive-support $?gen377 & : ( not ( subseq-pos ( create$ pen_lv5_max ?gen374 $$$ $?gen377 ) ) ) ) ) ( test ( eq ( class ?gen375 ) max_imprisonment ) ) => ( calc ( bind $?gen380 ( create$ pen_lv5_max ?gen374 $?gen377 ) ) ) ?gen375 <- ( max_imprisonment ( positive-support $?gen380 ) )"))

([pen_lv5_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv5_min-defeasibly-dot-gen446)
   (depends-on declare min_imprisonment is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv5_min] ) ) ) ?gen366 <- ( min_imprisonment ( value 3 ) ( positive 1 ) ( positive-derivator pen_lv5_min $? ) ) ( test ( eq ( class ?gen366 ) min_imprisonment ) ) ( not ( and ?gen373 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen372 & : ( >= ?gen372 1 ) ) ) ?gen366 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen368 & : ( not ( member$ pen_lv5_min $?gen368 ) ) ) ) ) ) => ?gen366 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv5_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv5_min-defeasibly-gen448)
   (depends-on declare is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv5_min] ) ) ) ?gen373 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen372 & : ( >= ?gen372 1 ) ) ) ?gen366 <- ( min_imprisonment ( value 3 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen368 & : ( not ( member$ pen_lv5_min $?gen368 ) ) ) ) ( test ( eq ( class ?gen366 ) min_imprisonment ) ) => ?gen366 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv5_min ?gen373 ) )"))

([pen_lv5_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv5_min-overruled-dot-gen450)
   (depends-on declare min_imprisonment is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv5_min] ) ) ) ?gen366 <- ( min_imprisonment ( value 3 ) ( negative-support $?gen369 ) ( negative-overruled $?gen370 & : ( subseq-pos ( create$ pen_lv5_min-overruled $?gen369 $$$ $?gen370 ) ) ) ) ( test ( eq ( class ?gen366 ) min_imprisonment ) ) ( not ( and ?gen373 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen372 & : ( >= ?gen372 1 ) ) ) ?gen366 <- ( min_imprisonment ( positive-defeated $?gen368 & : ( not ( member$ pen_lv5_min $?gen368 ) ) ) ) ) ) => ( calc ( bind $?gen371 ( delete-member$ $?gen370 ( create$ pen_lv5_min-overruled $?gen369 ) ) ) ) ?gen366 <- ( min_imprisonment ( negative-overruled $?gen371 ) )"))

([pen_lv5_min-overruled] of derived-attribute-rule
   (pos-name pen_lv5_min-overruled-gen452)
   (depends-on declare is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv5_min] ) ) ) ?gen373 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen372 & : ( >= ?gen372 1 ) ) ) ?gen366 <- ( min_imprisonment ( value 3 ) ( negative-support $?gen369 ) ( negative-overruled $?gen370 & : ( not ( subseq-pos ( create$ pen_lv5_min-overruled $?gen369 $$$ $?gen370 ) ) ) ) ( positive-defeated $?gen368 & : ( not ( member$ pen_lv5_min $?gen368 ) ) ) ) ( test ( eq ( class ?gen366 ) min_imprisonment ) ) => ( calc ( bind $?gen371 ( create$ pen_lv5_min-overruled $?gen369 $?gen370 ) ) ) ?gen366 <- ( min_imprisonment ( negative-overruled $?gen371 ) )"))

([pen_lv5_min-support] of derived-attribute-rule
   (pos-name pen_lv5_min-support-gen454)
   (depends-on declare is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv5_min] ) ) ) ?gen365 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen366 <- ( min_imprisonment ( value 3 ) ( positive-support $?gen368 & : ( not ( subseq-pos ( create$ pen_lv5_min ?gen365 $$$ $?gen368 ) ) ) ) ) ( test ( eq ( class ?gen366 ) min_imprisonment ) ) => ( calc ( bind $?gen371 ( create$ pen_lv5_min ?gen365 $?gen368 ) ) ) ?gen366 <- ( min_imprisonment ( positive-support $?gen371 ) )"))

([pen_lv4_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv4_max-defeasibly-dot-gen456)
   (depends-on declare max_imprisonment is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv4_max] ) ) ) ?gen357 <- ( max_imprisonment ( value 8 ) ( positive 1 ) ( positive-derivator pen_lv4_max $? ) ) ( test ( eq ( class ?gen357 ) max_imprisonment ) ) ( not ( and ?gen364 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen363 & : ( >= ?gen363 1 ) ) ) ?gen357 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen359 & : ( not ( member$ pen_lv4_max $?gen359 ) ) ) ) ) ) => ?gen357 <- ( max_imprisonment ( positive 0 ) )"))

([pen_lv4_max-defeasibly] of derived-attribute-rule
   (pos-name pen_lv4_max-defeasibly-gen458)
   (depends-on declare is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv4_max] ) ) ) ?gen364 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen363 & : ( >= ?gen363 1 ) ) ) ?gen357 <- ( max_imprisonment ( value 8 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen359 & : ( not ( member$ pen_lv4_max $?gen359 ) ) ) ) ( test ( eq ( class ?gen357 ) max_imprisonment ) ) => ?gen357 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_lv4_max ?gen364 ) )"))

([pen_lv4_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv4_max-overruled-dot-gen460)
   (depends-on declare max_imprisonment is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv4_max] ) ) ) ?gen357 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen360 ) ( negative-overruled $?gen361 & : ( subseq-pos ( create$ pen_lv4_max-overruled $?gen360 $$$ $?gen361 ) ) ) ) ( test ( eq ( class ?gen357 ) max_imprisonment ) ) ( not ( and ?gen364 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen363 & : ( >= ?gen363 1 ) ) ) ?gen357 <- ( max_imprisonment ( positive-defeated $?gen359 & : ( not ( member$ pen_lv4_max $?gen359 ) ) ) ) ) ) => ( calc ( bind $?gen362 ( delete-member$ $?gen361 ( create$ pen_lv4_max-overruled $?gen360 ) ) ) ) ?gen357 <- ( max_imprisonment ( negative-overruled $?gen362 ) )"))

([pen_lv4_max-overruled] of derived-attribute-rule
   (pos-name pen_lv4_max-overruled-gen462)
   (depends-on declare is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv4_max] ) ) ) ?gen364 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen363 & : ( >= ?gen363 1 ) ) ) ?gen357 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen360 ) ( negative-overruled $?gen361 & : ( not ( subseq-pos ( create$ pen_lv4_max-overruled $?gen360 $$$ $?gen361 ) ) ) ) ( positive-defeated $?gen359 & : ( not ( member$ pen_lv4_max $?gen359 ) ) ) ) ( test ( eq ( class ?gen357 ) max_imprisonment ) ) => ( calc ( bind $?gen362 ( create$ pen_lv4_max-overruled $?gen360 $?gen361 ) ) ) ?gen357 <- ( max_imprisonment ( negative-overruled $?gen362 ) )"))

([pen_lv4_max-support] of derived-attribute-rule
   (pos-name pen_lv4_max-support-gen464)
   (depends-on declare is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv4_max] ) ) ) ?gen356 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ?gen357 <- ( max_imprisonment ( value 8 ) ( positive-support $?gen359 & : ( not ( subseq-pos ( create$ pen_lv4_max ?gen356 $$$ $?gen359 ) ) ) ) ) ( test ( eq ( class ?gen357 ) max_imprisonment ) ) => ( calc ( bind $?gen362 ( create$ pen_lv4_max ?gen356 $?gen359 ) ) ) ?gen357 <- ( max_imprisonment ( positive-support $?gen362 ) )"))

([pen_lv4_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv4_min-defeasibly-dot-gen466)
   (depends-on declare min_imprisonment is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv4_min] ) ) ) ?gen348 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_lv4_min $? ) ) ( test ( eq ( class ?gen348 ) min_imprisonment ) ) ( not ( and ?gen355 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen354 & : ( >= ?gen354 1 ) ) ) ?gen348 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen350 & : ( not ( member$ pen_lv4_min $?gen350 ) ) ) ) ) ) => ?gen348 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv4_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv4_min-defeasibly-gen468)
   (depends-on declare is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv4_min] ) ) ) ?gen355 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen354 & : ( >= ?gen354 1 ) ) ) ?gen348 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen350 & : ( not ( member$ pen_lv4_min $?gen350 ) ) ) ) ( test ( eq ( class ?gen348 ) min_imprisonment ) ) => ?gen348 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv4_min ?gen355 ) )"))

([pen_lv4_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv4_min-overruled-dot-gen470)
   (depends-on declare min_imprisonment is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv4_min] ) ) ) ?gen348 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen351 ) ( negative-overruled $?gen352 & : ( subseq-pos ( create$ pen_lv4_min-overruled $?gen351 $$$ $?gen352 ) ) ) ) ( test ( eq ( class ?gen348 ) min_imprisonment ) ) ( not ( and ?gen355 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen354 & : ( >= ?gen354 1 ) ) ) ?gen348 <- ( min_imprisonment ( positive-defeated $?gen350 & : ( not ( member$ pen_lv4_min $?gen350 ) ) ) ) ) ) => ( calc ( bind $?gen353 ( delete-member$ $?gen352 ( create$ pen_lv4_min-overruled $?gen351 ) ) ) ) ?gen348 <- ( min_imprisonment ( negative-overruled $?gen353 ) )"))

([pen_lv4_min-overruled] of derived-attribute-rule
   (pos-name pen_lv4_min-overruled-gen472)
   (depends-on declare is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv4_min] ) ) ) ?gen355 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen354 & : ( >= ?gen354 1 ) ) ) ?gen348 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen351 ) ( negative-overruled $?gen352 & : ( not ( subseq-pos ( create$ pen_lv4_min-overruled $?gen351 $$$ $?gen352 ) ) ) ) ( positive-defeated $?gen350 & : ( not ( member$ pen_lv4_min $?gen350 ) ) ) ) ( test ( eq ( class ?gen348 ) min_imprisonment ) ) => ( calc ( bind $?gen353 ( create$ pen_lv4_min-overruled $?gen351 $?gen352 ) ) ) ?gen348 <- ( min_imprisonment ( negative-overruled $?gen353 ) )"))

([pen_lv4_min-support] of derived-attribute-rule
   (pos-name pen_lv4_min-support-gen474)
   (depends-on declare is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv4_min] ) ) ) ?gen347 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ?gen348 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen350 & : ( not ( subseq-pos ( create$ pen_lv4_min ?gen347 $$$ $?gen350 ) ) ) ) ) ( test ( eq ( class ?gen348 ) min_imprisonment ) ) => ( calc ( bind $?gen353 ( create$ pen_lv4_min ?gen347 $?gen350 ) ) ) ?gen348 <- ( min_imprisonment ( positive-support $?gen353 ) )"))

([pen_lv3_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv3_max-defeasibly-dot-gen476)
   (depends-on declare max_imprisonment is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv3_max] ) ) ) ?gen339 <- ( max_imprisonment ( value 10 ) ( positive 1 ) ( positive-derivator pen_lv3_max $? ) ) ( test ( eq ( class ?gen339 ) max_imprisonment ) ) ( not ( and ?gen346 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen345 & : ( >= ?gen345 1 ) ) ) ?gen339 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen341 & : ( not ( member$ pen_lv3_max $?gen341 ) ) ) ) ) ) => ?gen339 <- ( max_imprisonment ( positive 0 ) )"))

([pen_lv3_max-defeasibly] of derived-attribute-rule
   (pos-name pen_lv3_max-defeasibly-gen478)
   (depends-on declare is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv3_max] ) ) ) ?gen346 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen345 & : ( >= ?gen345 1 ) ) ) ?gen339 <- ( max_imprisonment ( value 10 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen341 & : ( not ( member$ pen_lv3_max $?gen341 ) ) ) ) ( test ( eq ( class ?gen339 ) max_imprisonment ) ) => ?gen339 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_lv3_max ?gen346 ) )"))

([pen_lv3_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv3_max-overruled-dot-gen480)
   (depends-on declare max_imprisonment is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv3_max] ) ) ) ?gen339 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen342 ) ( negative-overruled $?gen343 & : ( subseq-pos ( create$ pen_lv3_max-overruled $?gen342 $$$ $?gen343 ) ) ) ) ( test ( eq ( class ?gen339 ) max_imprisonment ) ) ( not ( and ?gen346 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen345 & : ( >= ?gen345 1 ) ) ) ?gen339 <- ( max_imprisonment ( positive-defeated $?gen341 & : ( not ( member$ pen_lv3_max $?gen341 ) ) ) ) ) ) => ( calc ( bind $?gen344 ( delete-member$ $?gen343 ( create$ pen_lv3_max-overruled $?gen342 ) ) ) ) ?gen339 <- ( max_imprisonment ( negative-overruled $?gen344 ) )"))

([pen_lv3_max-overruled] of derived-attribute-rule
   (pos-name pen_lv3_max-overruled-gen482)
   (depends-on declare is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv3_max] ) ) ) ?gen346 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen345 & : ( >= ?gen345 1 ) ) ) ?gen339 <- ( max_imprisonment ( value 10 ) ( negative-support $?gen342 ) ( negative-overruled $?gen343 & : ( not ( subseq-pos ( create$ pen_lv3_max-overruled $?gen342 $$$ $?gen343 ) ) ) ) ( positive-defeated $?gen341 & : ( not ( member$ pen_lv3_max $?gen341 ) ) ) ) ( test ( eq ( class ?gen339 ) max_imprisonment ) ) => ( calc ( bind $?gen344 ( create$ pen_lv3_max-overruled $?gen342 $?gen343 ) ) ) ?gen339 <- ( max_imprisonment ( negative-overruled $?gen344 ) )"))

([pen_lv3_max-support] of derived-attribute-rule
   (pos-name pen_lv3_max-support-gen484)
   (depends-on declare is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv3_max] ) ) ) ?gen338 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ?gen339 <- ( max_imprisonment ( value 10 ) ( positive-support $?gen341 & : ( not ( subseq-pos ( create$ pen_lv3_max ?gen338 $$$ $?gen341 ) ) ) ) ) ( test ( eq ( class ?gen339 ) max_imprisonment ) ) => ( calc ( bind $?gen344 ( create$ pen_lv3_max ?gen338 $?gen341 ) ) ) ?gen339 <- ( max_imprisonment ( positive-support $?gen344 ) )"))

([pen_lv3_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv3_min-defeasibly-dot-gen486)
   (depends-on declare min_imprisonment is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv3_min] ) ) ) ?gen330 <- ( min_imprisonment ( value 2 ) ( positive 1 ) ( positive-derivator pen_lv3_min $? ) ) ( test ( eq ( class ?gen330 ) min_imprisonment ) ) ( not ( and ?gen337 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen336 & : ( >= ?gen336 1 ) ) ) ?gen330 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen332 & : ( not ( member$ pen_lv3_min $?gen332 ) ) ) ) ) ) => ?gen330 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv3_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv3_min-defeasibly-gen488)
   (depends-on declare is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv3_min] ) ) ) ?gen337 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen336 & : ( >= ?gen336 1 ) ) ) ?gen330 <- ( min_imprisonment ( value 2 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen332 & : ( not ( member$ pen_lv3_min $?gen332 ) ) ) ) ( test ( eq ( class ?gen330 ) min_imprisonment ) ) => ?gen330 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv3_min ?gen337 ) )"))

([pen_lv3_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv3_min-overruled-dot-gen490)
   (depends-on declare min_imprisonment is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv3_min] ) ) ) ?gen330 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen333 ) ( negative-overruled $?gen334 & : ( subseq-pos ( create$ pen_lv3_min-overruled $?gen333 $$$ $?gen334 ) ) ) ) ( test ( eq ( class ?gen330 ) min_imprisonment ) ) ( not ( and ?gen337 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen336 & : ( >= ?gen336 1 ) ) ) ?gen330 <- ( min_imprisonment ( positive-defeated $?gen332 & : ( not ( member$ pen_lv3_min $?gen332 ) ) ) ) ) ) => ( calc ( bind $?gen335 ( delete-member$ $?gen334 ( create$ pen_lv3_min-overruled $?gen333 ) ) ) ) ?gen330 <- ( min_imprisonment ( negative-overruled $?gen335 ) )"))

([pen_lv3_min-overruled] of derived-attribute-rule
   (pos-name pen_lv3_min-overruled-gen492)
   (depends-on declare is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv3_min] ) ) ) ?gen337 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen336 & : ( >= ?gen336 1 ) ) ) ?gen330 <- ( min_imprisonment ( value 2 ) ( negative-support $?gen333 ) ( negative-overruled $?gen334 & : ( not ( subseq-pos ( create$ pen_lv3_min-overruled $?gen333 $$$ $?gen334 ) ) ) ) ( positive-defeated $?gen332 & : ( not ( member$ pen_lv3_min $?gen332 ) ) ) ) ( test ( eq ( class ?gen330 ) min_imprisonment ) ) => ( calc ( bind $?gen335 ( create$ pen_lv3_min-overruled $?gen333 $?gen334 ) ) ) ?gen330 <- ( min_imprisonment ( negative-overruled $?gen335 ) )"))

([pen_lv3_min-support] of derived-attribute-rule
   (pos-name pen_lv3_min-support-gen494)
   (depends-on declare is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv3_min] ) ) ) ?gen329 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ?gen330 <- ( min_imprisonment ( value 2 ) ( positive-support $?gen332 & : ( not ( subseq-pos ( create$ pen_lv3_min ?gen329 $$$ $?gen332 ) ) ) ) ) ( test ( eq ( class ?gen330 ) min_imprisonment ) ) => ( calc ( bind $?gen335 ( create$ pen_lv3_min ?gen329 $?gen332 ) ) ) ?gen330 <- ( min_imprisonment ( positive-support $?gen335 ) )"))

([pen_lv2_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv2_max-defeasibly-dot-gen496)
   (depends-on declare max_imprisonment is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv2_max] ) ) ) ?gen321 <- ( max_imprisonment ( value 8 ) ( positive 1 ) ( positive-derivator pen_lv2_max $? ) ) ( test ( eq ( class ?gen321 ) max_imprisonment ) ) ( not ( and ?gen328 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen327 & : ( >= ?gen327 1 ) ) ) ?gen321 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen323 & : ( not ( member$ pen_lv2_max $?gen323 ) ) ) ) ) ) => ?gen321 <- ( max_imprisonment ( positive 0 ) )"))

([pen_lv2_max-defeasibly] of derived-attribute-rule
   (pos-name pen_lv2_max-defeasibly-gen498)
   (depends-on declare is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv2_max] ) ) ) ?gen328 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen327 & : ( >= ?gen327 1 ) ) ) ?gen321 <- ( max_imprisonment ( value 8 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen323 & : ( not ( member$ pen_lv2_max $?gen323 ) ) ) ) ( test ( eq ( class ?gen321 ) max_imprisonment ) ) => ?gen321 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_lv2_max ?gen328 ) )"))

([pen_lv2_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv2_max-overruled-dot-gen500)
   (depends-on declare max_imprisonment is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv2_max] ) ) ) ?gen321 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen324 ) ( negative-overruled $?gen325 & : ( subseq-pos ( create$ pen_lv2_max-overruled $?gen324 $$$ $?gen325 ) ) ) ) ( test ( eq ( class ?gen321 ) max_imprisonment ) ) ( not ( and ?gen328 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen327 & : ( >= ?gen327 1 ) ) ) ?gen321 <- ( max_imprisonment ( positive-defeated $?gen323 & : ( not ( member$ pen_lv2_max $?gen323 ) ) ) ) ) ) => ( calc ( bind $?gen326 ( delete-member$ $?gen325 ( create$ pen_lv2_max-overruled $?gen324 ) ) ) ) ?gen321 <- ( max_imprisonment ( negative-overruled $?gen326 ) )"))

([pen_lv2_max-overruled] of derived-attribute-rule
   (pos-name pen_lv2_max-overruled-gen502)
   (depends-on declare is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv2_max] ) ) ) ?gen328 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen327 & : ( >= ?gen327 1 ) ) ) ?gen321 <- ( max_imprisonment ( value 8 ) ( negative-support $?gen324 ) ( negative-overruled $?gen325 & : ( not ( subseq-pos ( create$ pen_lv2_max-overruled $?gen324 $$$ $?gen325 ) ) ) ) ( positive-defeated $?gen323 & : ( not ( member$ pen_lv2_max $?gen323 ) ) ) ) ( test ( eq ( class ?gen321 ) max_imprisonment ) ) => ( calc ( bind $?gen326 ( create$ pen_lv2_max-overruled $?gen324 $?gen325 ) ) ) ?gen321 <- ( max_imprisonment ( negative-overruled $?gen326 ) )"))

([pen_lv2_max-support] of derived-attribute-rule
   (pos-name pen_lv2_max-support-gen504)
   (depends-on declare is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv2_max] ) ) ) ?gen320 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ?gen321 <- ( max_imprisonment ( value 8 ) ( positive-support $?gen323 & : ( not ( subseq-pos ( create$ pen_lv2_max ?gen320 $$$ $?gen323 ) ) ) ) ) ( test ( eq ( class ?gen321 ) max_imprisonment ) ) => ( calc ( bind $?gen326 ( create$ pen_lv2_max ?gen320 $?gen323 ) ) ) ?gen321 <- ( max_imprisonment ( positive-support $?gen326 ) )"))

([pen_lv2_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv2_min-defeasibly-dot-gen506)
   (depends-on declare min_imprisonment is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv2_min] ) ) ) ?gen312 <- ( min_imprisonment ( value 1 ) ( positive 1 ) ( positive-derivator pen_lv2_min $? ) ) ( test ( eq ( class ?gen312 ) min_imprisonment ) ) ( not ( and ?gen319 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen318 & : ( >= ?gen318 1 ) ) ) ?gen312 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen314 & : ( not ( member$ pen_lv2_min $?gen314 ) ) ) ) ) ) => ?gen312 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv2_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv2_min-defeasibly-gen508)
   (depends-on declare is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv2_min] ) ) ) ?gen319 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen318 & : ( >= ?gen318 1 ) ) ) ?gen312 <- ( min_imprisonment ( value 1 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen314 & : ( not ( member$ pen_lv2_min $?gen314 ) ) ) ) ( test ( eq ( class ?gen312 ) min_imprisonment ) ) => ?gen312 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv2_min ?gen319 ) )"))

([pen_lv2_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv2_min-overruled-dot-gen510)
   (depends-on declare min_imprisonment is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv2_min] ) ) ) ?gen312 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen315 ) ( negative-overruled $?gen316 & : ( subseq-pos ( create$ pen_lv2_min-overruled $?gen315 $$$ $?gen316 ) ) ) ) ( test ( eq ( class ?gen312 ) min_imprisonment ) ) ( not ( and ?gen319 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen318 & : ( >= ?gen318 1 ) ) ) ?gen312 <- ( min_imprisonment ( positive-defeated $?gen314 & : ( not ( member$ pen_lv2_min $?gen314 ) ) ) ) ) ) => ( calc ( bind $?gen317 ( delete-member$ $?gen316 ( create$ pen_lv2_min-overruled $?gen315 ) ) ) ) ?gen312 <- ( min_imprisonment ( negative-overruled $?gen317 ) )"))

([pen_lv2_min-overruled] of derived-attribute-rule
   (pos-name pen_lv2_min-overruled-gen512)
   (depends-on declare is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv2_min] ) ) ) ?gen319 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen318 & : ( >= ?gen318 1 ) ) ) ?gen312 <- ( min_imprisonment ( value 1 ) ( negative-support $?gen315 ) ( negative-overruled $?gen316 & : ( not ( subseq-pos ( create$ pen_lv2_min-overruled $?gen315 $$$ $?gen316 ) ) ) ) ( positive-defeated $?gen314 & : ( not ( member$ pen_lv2_min $?gen314 ) ) ) ) ( test ( eq ( class ?gen312 ) min_imprisonment ) ) => ( calc ( bind $?gen317 ( create$ pen_lv2_min-overruled $?gen315 $?gen316 ) ) ) ?gen312 <- ( min_imprisonment ( negative-overruled $?gen317 ) )"))

([pen_lv2_min-support] of derived-attribute-rule
   (pos-name pen_lv2_min-support-gen514)
   (depends-on declare is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv2_min] ) ) ) ?gen311 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ?gen312 <- ( min_imprisonment ( value 1 ) ( positive-support $?gen314 & : ( not ( subseq-pos ( create$ pen_lv2_min ?gen311 $$$ $?gen314 ) ) ) ) ) ( test ( eq ( class ?gen312 ) min_imprisonment ) ) => ( calc ( bind $?gen317 ( create$ pen_lv2_min ?gen311 $?gen314 ) ) ) ?gen312 <- ( min_imprisonment ( positive-support $?gen317 ) )"))

([pen_lv1_max-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv1_max-defeasibly-dot-gen516)
   (depends-on declare max_imprisonment is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv1_max] ) ) ) ?gen303 <- ( max_imprisonment ( value 3 ) ( positive 1 ) ( positive-derivator pen_lv1_max $? ) ) ( test ( eq ( class ?gen303 ) max_imprisonment ) ) ( not ( and ?gen310 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen309 & : ( >= ?gen309 1 ) ) ) ?gen303 <- ( max_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen305 & : ( not ( member$ pen_lv1_max $?gen305 ) ) ) ) ) ) => ?gen303 <- ( max_imprisonment ( positive 0 ) )"))

([pen_lv1_max-defeasibly] of derived-attribute-rule
   (pos-name pen_lv1_max-defeasibly-gen518)
   (depends-on declare is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv1_max] ) ) ) ?gen310 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen309 & : ( >= ?gen309 1 ) ) ) ?gen303 <- ( max_imprisonment ( value 3 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen305 & : ( not ( member$ pen_lv1_max $?gen305 ) ) ) ) ( test ( eq ( class ?gen303 ) max_imprisonment ) ) => ?gen303 <- ( max_imprisonment ( positive 1 ) ( positive-derivator pen_lv1_max ?gen310 ) )"))

([pen_lv1_max-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv1_max-overruled-dot-gen520)
   (depends-on declare max_imprisonment is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv1_max] ) ) ) ?gen303 <- ( max_imprisonment ( value 3 ) ( negative-support $?gen306 ) ( negative-overruled $?gen307 & : ( subseq-pos ( create$ pen_lv1_max-overruled $?gen306 $$$ $?gen307 ) ) ) ) ( test ( eq ( class ?gen303 ) max_imprisonment ) ) ( not ( and ?gen310 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen309 & : ( >= ?gen309 1 ) ) ) ?gen303 <- ( max_imprisonment ( positive-defeated $?gen305 & : ( not ( member$ pen_lv1_max $?gen305 ) ) ) ) ) ) => ( calc ( bind $?gen308 ( delete-member$ $?gen307 ( create$ pen_lv1_max-overruled $?gen306 ) ) ) ) ?gen303 <- ( max_imprisonment ( negative-overruled $?gen308 ) )"))

([pen_lv1_max-overruled] of derived-attribute-rule
   (pos-name pen_lv1_max-overruled-gen522)
   (depends-on declare is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv1_max] ) ) ) ?gen310 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen309 & : ( >= ?gen309 1 ) ) ) ?gen303 <- ( max_imprisonment ( value 3 ) ( negative-support $?gen306 ) ( negative-overruled $?gen307 & : ( not ( subseq-pos ( create$ pen_lv1_max-overruled $?gen306 $$$ $?gen307 ) ) ) ) ( positive-defeated $?gen305 & : ( not ( member$ pen_lv1_max $?gen305 ) ) ) ) ( test ( eq ( class ?gen303 ) max_imprisonment ) ) => ( calc ( bind $?gen308 ( create$ pen_lv1_max-overruled $?gen306 $?gen307 ) ) ) ?gen303 <- ( max_imprisonment ( negative-overruled $?gen308 ) )"))

([pen_lv1_max-support] of derived-attribute-rule
   (pos-name pen_lv1_max-support-gen524)
   (depends-on declare is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv1_max] ) ) ) ?gen302 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ?gen303 <- ( max_imprisonment ( value 3 ) ( positive-support $?gen305 & : ( not ( subseq-pos ( create$ pen_lv1_max ?gen302 $$$ $?gen305 ) ) ) ) ) ( test ( eq ( class ?gen303 ) max_imprisonment ) ) => ( calc ( bind $?gen308 ( create$ pen_lv1_max ?gen302 $?gen305 ) ) ) ?gen303 <- ( max_imprisonment ( positive-support $?gen308 ) )"))

([pen_lv1_min-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv1_min-defeasibly-dot-gen526)
   (depends-on declare min_imprisonment is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv1_min] ) ) ) ?gen294 <- ( min_imprisonment ( value 0 ) ( positive 1 ) ( positive-derivator pen_lv1_min $? ) ) ( test ( eq ( class ?gen294 ) min_imprisonment ) ) ( not ( and ?gen301 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen300 & : ( >= ?gen300 1 ) ) ) ?gen294 <- ( min_imprisonment ( negative ~ 2 ) ( positive-overruled $?gen296 & : ( not ( member$ pen_lv1_min $?gen296 ) ) ) ) ) ) => ?gen294 <- ( min_imprisonment ( positive 0 ) )"))

([pen_lv1_min-defeasibly] of derived-attribute-rule
   (pos-name pen_lv1_min-defeasibly-gen528)
   (depends-on declare is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv1_min] ) ) ) ?gen301 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen300 & : ( >= ?gen300 1 ) ) ) ?gen294 <- ( min_imprisonment ( value 0 ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen296 & : ( not ( member$ pen_lv1_min $?gen296 ) ) ) ) ( test ( eq ( class ?gen294 ) min_imprisonment ) ) => ?gen294 <- ( min_imprisonment ( positive 1 ) ( positive-derivator pen_lv1_min ?gen301 ) )"))

([pen_lv1_min-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv1_min-overruled-dot-gen530)
   (depends-on declare min_imprisonment is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv1_min] ) ) ) ?gen294 <- ( min_imprisonment ( value 0 ) ( negative-support $?gen297 ) ( negative-overruled $?gen298 & : ( subseq-pos ( create$ pen_lv1_min-overruled $?gen297 $$$ $?gen298 ) ) ) ) ( test ( eq ( class ?gen294 ) min_imprisonment ) ) ( not ( and ?gen301 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen300 & : ( >= ?gen300 1 ) ) ) ?gen294 <- ( min_imprisonment ( positive-defeated $?gen296 & : ( not ( member$ pen_lv1_min $?gen296 ) ) ) ) ) ) => ( calc ( bind $?gen299 ( delete-member$ $?gen298 ( create$ pen_lv1_min-overruled $?gen297 ) ) ) ) ?gen294 <- ( min_imprisonment ( negative-overruled $?gen299 ) )"))

([pen_lv1_min-overruled] of derived-attribute-rule
   (pos-name pen_lv1_min-overruled-gen532)
   (depends-on declare is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv1_min] ) ) ) ?gen301 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen300 & : ( >= ?gen300 1 ) ) ) ?gen294 <- ( min_imprisonment ( value 0 ) ( negative-support $?gen297 ) ( negative-overruled $?gen298 & : ( not ( subseq-pos ( create$ pen_lv1_min-overruled $?gen297 $$$ $?gen298 ) ) ) ) ( positive-defeated $?gen296 & : ( not ( member$ pen_lv1_min $?gen296 ) ) ) ) ( test ( eq ( class ?gen294 ) min_imprisonment ) ) => ( calc ( bind $?gen299 ( create$ pen_lv1_min-overruled $?gen297 $?gen298 ) ) ) ?gen294 <- ( min_imprisonment ( negative-overruled $?gen299 ) )"))

([pen_lv1_min-support] of derived-attribute-rule
   (pos-name pen_lv1_min-support-gen534)
   (depends-on declare is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv1_min] ) ) ) ?gen293 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ?gen294 <- ( min_imprisonment ( value 0 ) ( positive-support $?gen296 & : ( not ( subseq-pos ( create$ pen_lv1_min ?gen293 $$$ $?gen296 ) ) ) ) ) ( test ( eq ( class ?gen294 ) min_imprisonment ) ) => ( calc ( bind $?gen299 ( create$ pen_lv1_min ?gen293 $?gen296 ) ) ) ?gen294 <- ( min_imprisonment ( positive-support $?gen299 ) )"))

([pen_lv1_monetary-defeasibly-dot] of derived-attribute-rule
   (pos-name pen_lv1_monetary-defeasibly-dot-gen536)
   (depends-on declare monetary_penalty is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [pen_lv1_monetary] ) ) ) ?gen285 <- ( monetary_penalty ( value True ) ( positive 1 ) ( positive-derivator pen_lv1_monetary $? ) ) ( test ( eq ( class ?gen285 ) monetary_penalty ) ) ( not ( and ?gen292 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen291 & : ( >= ?gen291 1 ) ) ) ?gen285 <- ( monetary_penalty ( negative ~ 2 ) ( positive-overruled $?gen287 & : ( not ( member$ pen_lv1_monetary $?gen287 ) ) ) ) ) ) => ?gen285 <- ( monetary_penalty ( positive 0 ) )"))

([pen_lv1_monetary-defeasibly] of derived-attribute-rule
   (pos-name pen_lv1_monetary-defeasibly-gen538)
   (depends-on declare is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [pen_lv1_monetary] ) ) ) ?gen292 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen291 & : ( >= ?gen291 1 ) ) ) ?gen285 <- ( monetary_penalty ( value True ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen287 & : ( not ( member$ pen_lv1_monetary $?gen287 ) ) ) ) ( test ( eq ( class ?gen285 ) monetary_penalty ) ) => ?gen285 <- ( monetary_penalty ( positive 1 ) ( positive-derivator pen_lv1_monetary ?gen292 ) )"))

([pen_lv1_monetary-overruled-dot] of derived-attribute-rule
   (pos-name pen_lv1_monetary-overruled-dot-gen540)
   (depends-on declare monetary_penalty is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [pen_lv1_monetary] ) ) ) ?gen285 <- ( monetary_penalty ( value True ) ( negative-support $?gen288 ) ( negative-overruled $?gen289 & : ( subseq-pos ( create$ pen_lv1_monetary-overruled $?gen288 $$$ $?gen289 ) ) ) ) ( test ( eq ( class ?gen285 ) monetary_penalty ) ) ( not ( and ?gen292 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen291 & : ( >= ?gen291 1 ) ) ) ?gen285 <- ( monetary_penalty ( positive-defeated $?gen287 & : ( not ( member$ pen_lv1_monetary $?gen287 ) ) ) ) ) ) => ( calc ( bind $?gen290 ( delete-member$ $?gen289 ( create$ pen_lv1_monetary-overruled $?gen288 ) ) ) ) ?gen285 <- ( monetary_penalty ( negative-overruled $?gen290 ) )"))

([pen_lv1_monetary-overruled] of derived-attribute-rule
   (pos-name pen_lv1_monetary-overruled-gen542)
   (depends-on declare is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [pen_lv1_monetary] ) ) ) ?gen292 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive ?gen291 & : ( >= ?gen291 1 ) ) ) ?gen285 <- ( monetary_penalty ( value True ) ( negative-support $?gen288 ) ( negative-overruled $?gen289 & : ( not ( subseq-pos ( create$ pen_lv1_monetary-overruled $?gen288 $$$ $?gen289 ) ) ) ) ( positive-defeated $?gen287 & : ( not ( member$ pen_lv1_monetary $?gen287 ) ) ) ) ( test ( eq ( class ?gen285 ) monetary_penalty ) ) => ( calc ( bind $?gen290 ( create$ pen_lv1_monetary-overruled $?gen288 $?gen289 ) ) ) ?gen285 <- ( monetary_penalty ( negative-overruled $?gen290 ) )"))

([pen_lv1_monetary-support] of derived-attribute-rule
   (pos-name pen_lv1_monetary-support-gen544)
   (depends-on declare is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [pen_lv1_monetary] ) ) ) ?gen284 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ?gen285 <- ( monetary_penalty ( value True ) ( positive-support $?gen287 & : ( not ( subseq-pos ( create$ pen_lv1_monetary ?gen284 $$$ $?gen287 ) ) ) ) ) ( test ( eq ( class ?gen285 ) monetary_penalty ) ) => ( calc ( bind $?gen290 ( create$ pen_lv1_monetary ?gen284 $?gen287 ) ) ) ?gen285 <- ( monetary_penalty ( positive-support $?gen290 ) )"))

([rule22-defeated-dot] of derived-attribute-rule
   (pos-name rule22-defeated-dot-gen546)
   (depends-on declare is_theft_lv1 is_theft_lv6)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule22] ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen279 & : ( subseq-pos ( create$ rule22-defeated rule1 $$$ $?gen279 ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) ( not ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ) => ( calc ( bind $?gen278 ( delete-member$ $?gen279 ( create$ rule22-defeated rule1 ) ) ) ) ?gen276 <- ( is_theft_lv1 ( positive-defeated $?gen278 ) )"))

([rule22-defeated] of derived-attribute-rule
   (pos-name rule22-defeated-gen548)
   (depends-on declare is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule22] ) ) ) ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen279 & : ( not ( subseq-pos ( create$ rule22-defeated rule1 $$$ $?gen279 ) ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) => ( calc ( bind $?gen278 ( create$ rule22-defeated rule1 $?gen279 ) ) ) ?gen276 <- ( is_theft_lv1 ( positive-defeated $?gen278 ) )"))

([rule22-defeasibly-dot] of derived-attribute-rule
   (pos-name rule22-defeasibly-dot-gen550)
   (depends-on declare is_theft_lv1 is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule22] ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule22 $? ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) ( not ( and ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ?gen276 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen278 & : ( not ( member$ rule22 $?gen278 ) ) ) ) ) ) => ?gen276 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule22-defeasibly] of derived-attribute-rule
   (pos-name rule22-defeasibly-gen552)
   (depends-on declare is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule22] ) ) ) ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen278 & : ( not ( member$ rule22 $?gen278 ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) => ?gen276 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule22 ?gen283 ) )"))

([rule22-overruled-dot] of derived-attribute-rule
   (pos-name rule22-overruled-dot-gen554)
   (depends-on declare is_theft_lv1 is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule22] ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen279 ) ( positive-overruled $?gen280 & : ( subseq-pos ( create$ rule22-overruled $?gen279 $$$ $?gen280 ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) ( not ( and ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ?gen276 <- ( is_theft_lv1 ( negative-defeated $?gen278 & : ( not ( member$ rule22 $?gen278 ) ) ) ) ) ) => ( calc ( bind $?gen281 ( delete-member$ $?gen280 ( create$ rule22-overruled $?gen279 ) ) ) ) ?gen276 <- ( is_theft_lv1 ( positive-overruled $?gen281 ) )"))

([rule22-overruled] of derived-attribute-rule
   (pos-name rule22-overruled-gen556)
   (depends-on declare is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule22] ) ) ) ?gen283 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen282 & : ( >= ?gen282 1 ) ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen279 ) ( positive-overruled $?gen280 & : ( not ( subseq-pos ( create$ rule22-overruled $?gen279 $$$ $?gen280 ) ) ) ) ( negative-defeated $?gen278 & : ( not ( member$ rule22 $?gen278 ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) => ( calc ( bind $?gen281 ( create$ rule22-overruled $?gen279 $?gen280 ) ) ) ?gen276 <- ( is_theft_lv1 ( positive-overruled $?gen281 ) )"))

([rule22-support] of derived-attribute-rule
   (pos-name rule22-support-gen558)
   (depends-on declare is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule22] ) ) ) ?gen275 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen276 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen278 & : ( not ( subseq-pos ( create$ rule22 ?gen275 $$$ $?gen278 ) ) ) ) ) ( test ( eq ( class ?gen276 ) is_theft_lv1 ) ) => ( calc ( bind $?gen281 ( create$ rule22 ?gen275 $?gen278 ) ) ) ?gen276 <- ( is_theft_lv1 ( negative-support $?gen281 ) )"))

([rule21-defeated-dot] of derived-attribute-rule
   (pos-name rule21-defeated-dot-gen560)
   (depends-on declare is_theft_lv2 is_theft_lv6)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule21] ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen270 & : ( subseq-pos ( create$ rule21-defeated rule3 $$$ $?gen270 ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) ( not ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ) => ( calc ( bind $?gen269 ( delete-member$ $?gen270 ( create$ rule21-defeated rule3 ) ) ) ) ?gen267 <- ( is_theft_lv2 ( positive-defeated $?gen269 ) )"))

([rule21-defeated] of derived-attribute-rule
   (pos-name rule21-defeated-gen562)
   (depends-on declare is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule21] ) ) ) ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen270 & : ( not ( subseq-pos ( create$ rule21-defeated rule3 $$$ $?gen270 ) ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) => ( calc ( bind $?gen269 ( create$ rule21-defeated rule3 $?gen270 ) ) ) ?gen267 <- ( is_theft_lv2 ( positive-defeated $?gen269 ) )"))

([rule21-defeasibly-dot] of derived-attribute-rule
   (pos-name rule21-defeasibly-dot-gen564)
   (depends-on declare is_theft_lv2 is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule21] ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule21 $? ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) ( not ( and ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ?gen267 <- ( is_theft_lv2 ( positive ~ 2 ) ( negative-overruled $?gen269 & : ( not ( member$ rule21 $?gen269 ) ) ) ) ) ) => ?gen267 <- ( is_theft_lv2 ( negative 0 ) )"))

([rule21-defeasibly] of derived-attribute-rule
   (pos-name rule21-defeasibly-gen566)
   (depends-on declare is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule21] ) ) ) ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen269 & : ( not ( member$ rule21 $?gen269 ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) => ?gen267 <- ( is_theft_lv2 ( negative 1 ) ( negative-derivator rule21 ?gen274 ) )"))

([rule21-overruled-dot] of derived-attribute-rule
   (pos-name rule21-overruled-dot-gen568)
   (depends-on declare is_theft_lv2 is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule21] ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen270 ) ( positive-overruled $?gen271 & : ( subseq-pos ( create$ rule21-overruled $?gen270 $$$ $?gen271 ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) ( not ( and ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ?gen267 <- ( is_theft_lv2 ( negative-defeated $?gen269 & : ( not ( member$ rule21 $?gen269 ) ) ) ) ) ) => ( calc ( bind $?gen272 ( delete-member$ $?gen271 ( create$ rule21-overruled $?gen270 ) ) ) ) ?gen267 <- ( is_theft_lv2 ( positive-overruled $?gen272 ) )"))

([rule21-overruled] of derived-attribute-rule
   (pos-name rule21-overruled-gen570)
   (depends-on declare is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule21] ) ) ) ?gen274 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen273 & : ( >= ?gen273 1 ) ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen270 ) ( positive-overruled $?gen271 & : ( not ( subseq-pos ( create$ rule21-overruled $?gen270 $$$ $?gen271 ) ) ) ) ( negative-defeated $?gen269 & : ( not ( member$ rule21 $?gen269 ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) => ( calc ( bind $?gen272 ( create$ rule21-overruled $?gen270 $?gen271 ) ) ) ?gen267 <- ( is_theft_lv2 ( positive-overruled $?gen272 ) )"))

([rule21-support] of derived-attribute-rule
   (pos-name rule21-support-gen572)
   (depends-on declare is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule21] ) ) ) ?gen266 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen267 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen269 & : ( not ( subseq-pos ( create$ rule21 ?gen266 $$$ $?gen269 ) ) ) ) ) ( test ( eq ( class ?gen267 ) is_theft_lv2 ) ) => ( calc ( bind $?gen272 ( create$ rule21 ?gen266 $?gen269 ) ) ) ?gen267 <- ( is_theft_lv2 ( negative-support $?gen272 ) )"))

([rule20-defeated-dot] of derived-attribute-rule
   (pos-name rule20-defeated-dot-gen574)
   (depends-on declare is_theft_lv3 is_theft_lv6)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule20] ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen261 & : ( subseq-pos ( create$ rule20-defeated rule5 $$$ $?gen261 ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) ( not ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ) => ( calc ( bind $?gen260 ( delete-member$ $?gen261 ( create$ rule20-defeated rule5 ) ) ) ) ?gen258 <- ( is_theft_lv3 ( positive-defeated $?gen260 ) )"))

([rule20-defeated] of derived-attribute-rule
   (pos-name rule20-defeated-gen576)
   (depends-on declare is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule20] ) ) ) ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen261 & : ( not ( subseq-pos ( create$ rule20-defeated rule5 $$$ $?gen261 ) ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) => ( calc ( bind $?gen260 ( create$ rule20-defeated rule5 $?gen261 ) ) ) ?gen258 <- ( is_theft_lv3 ( positive-defeated $?gen260 ) )"))

([rule20-defeasibly-dot] of derived-attribute-rule
   (pos-name rule20-defeasibly-dot-gen578)
   (depends-on declare is_theft_lv3 is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule20] ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule20 $? ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) ( not ( and ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ?gen258 <- ( is_theft_lv3 ( positive ~ 2 ) ( negative-overruled $?gen260 & : ( not ( member$ rule20 $?gen260 ) ) ) ) ) ) => ?gen258 <- ( is_theft_lv3 ( negative 0 ) )"))

([rule20-defeasibly] of derived-attribute-rule
   (pos-name rule20-defeasibly-gen580)
   (depends-on declare is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule20] ) ) ) ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen260 & : ( not ( member$ rule20 $?gen260 ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) => ?gen258 <- ( is_theft_lv3 ( negative 1 ) ( negative-derivator rule20 ?gen265 ) )"))

([rule20-overruled-dot] of derived-attribute-rule
   (pos-name rule20-overruled-dot-gen582)
   (depends-on declare is_theft_lv3 is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule20] ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen261 ) ( positive-overruled $?gen262 & : ( subseq-pos ( create$ rule20-overruled $?gen261 $$$ $?gen262 ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) ( not ( and ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ?gen258 <- ( is_theft_lv3 ( negative-defeated $?gen260 & : ( not ( member$ rule20 $?gen260 ) ) ) ) ) ) => ( calc ( bind $?gen263 ( delete-member$ $?gen262 ( create$ rule20-overruled $?gen261 ) ) ) ) ?gen258 <- ( is_theft_lv3 ( positive-overruled $?gen263 ) )"))

([rule20-overruled] of derived-attribute-rule
   (pos-name rule20-overruled-gen584)
   (depends-on declare is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule20] ) ) ) ?gen265 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen264 & : ( >= ?gen264 1 ) ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen261 ) ( positive-overruled $?gen262 & : ( not ( subseq-pos ( create$ rule20-overruled $?gen261 $$$ $?gen262 ) ) ) ) ( negative-defeated $?gen260 & : ( not ( member$ rule20 $?gen260 ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) => ( calc ( bind $?gen263 ( create$ rule20-overruled $?gen261 $?gen262 ) ) ) ?gen258 <- ( is_theft_lv3 ( positive-overruled $?gen263 ) )"))

([rule20-support] of derived-attribute-rule
   (pos-name rule20-support-gen586)
   (depends-on declare is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule20] ) ) ) ?gen257 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen258 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative-support $?gen260 & : ( not ( subseq-pos ( create$ rule20 ?gen257 $$$ $?gen260 ) ) ) ) ) ( test ( eq ( class ?gen258 ) is_theft_lv3 ) ) => ( calc ( bind $?gen263 ( create$ rule20 ?gen257 $?gen260 ) ) ) ?gen258 <- ( is_theft_lv3 ( negative-support $?gen263 ) )"))

([rule19-defeated-dot] of derived-attribute-rule
   (pos-name rule19-defeated-dot-gen588)
   (depends-on declare is_theft_lv4 is_theft_lv6)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule19] ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-defeated $?gen252 & : ( subseq-pos ( create$ rule19-defeated rule8 $$$ $?gen252 ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) ( not ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ) => ( calc ( bind $?gen251 ( delete-member$ $?gen252 ( create$ rule19-defeated rule8 ) ) ) ) ?gen249 <- ( is_theft_lv4 ( positive-defeated $?gen251 ) )"))

([rule19-defeated] of derived-attribute-rule
   (pos-name rule19-defeated-gen590)
   (depends-on declare is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule19] ) ) ) ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-defeated $?gen252 & : ( not ( subseq-pos ( create$ rule19-defeated rule8 $$$ $?gen252 ) ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) => ( calc ( bind $?gen251 ( create$ rule19-defeated rule8 $?gen252 ) ) ) ?gen249 <- ( is_theft_lv4 ( positive-defeated $?gen251 ) )"))

([rule19-defeasibly-dot] of derived-attribute-rule
   (pos-name rule19-defeasibly-dot-gen592)
   (depends-on declare is_theft_lv4 is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule19] ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule19 $? ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) ( not ( and ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ?gen249 <- ( is_theft_lv4 ( positive ~ 2 ) ( negative-overruled $?gen251 & : ( not ( member$ rule19 $?gen251 ) ) ) ) ) ) => ?gen249 <- ( is_theft_lv4 ( negative 0 ) )"))

([rule19-defeasibly] of derived-attribute-rule
   (pos-name rule19-defeasibly-gen594)
   (depends-on declare is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule19] ) ) ) ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen251 & : ( not ( member$ rule19 $?gen251 ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) => ?gen249 <- ( is_theft_lv4 ( negative 1 ) ( negative-derivator rule19 ?gen256 ) )"))

([rule19-overruled-dot] of derived-attribute-rule
   (pos-name rule19-overruled-dot-gen596)
   (depends-on declare is_theft_lv4 is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule19] ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-support $?gen252 ) ( positive-overruled $?gen253 & : ( subseq-pos ( create$ rule19-overruled $?gen252 $$$ $?gen253 ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) ( not ( and ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ?gen249 <- ( is_theft_lv4 ( negative-defeated $?gen251 & : ( not ( member$ rule19 $?gen251 ) ) ) ) ) ) => ( calc ( bind $?gen254 ( delete-member$ $?gen253 ( create$ rule19-overruled $?gen252 ) ) ) ) ?gen249 <- ( is_theft_lv4 ( positive-overruled $?gen254 ) )"))

([rule19-overruled] of derived-attribute-rule
   (pos-name rule19-overruled-gen598)
   (depends-on declare is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule19] ) ) ) ?gen256 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen255 & : ( >= ?gen255 1 ) ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-support $?gen252 ) ( positive-overruled $?gen253 & : ( not ( subseq-pos ( create$ rule19-overruled $?gen252 $$$ $?gen253 ) ) ) ) ( negative-defeated $?gen251 & : ( not ( member$ rule19 $?gen251 ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) => ( calc ( bind $?gen254 ( create$ rule19-overruled $?gen252 $?gen253 ) ) ) ?gen249 <- ( is_theft_lv4 ( positive-overruled $?gen254 ) )"))

([rule19-support] of derived-attribute-rule
   (pos-name rule19-support-gen600)
   (depends-on declare is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule19] ) ) ) ?gen248 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen249 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative-support $?gen251 & : ( not ( subseq-pos ( create$ rule19 ?gen248 $$$ $?gen251 ) ) ) ) ) ( test ( eq ( class ?gen249 ) is_theft_lv4 ) ) => ( calc ( bind $?gen254 ( create$ rule19 ?gen248 $?gen251 ) ) ) ?gen249 <- ( is_theft_lv4 ( negative-support $?gen254 ) )"))

([rule18-defeated-dot] of derived-attribute-rule
   (pos-name rule18-defeated-dot-gen602)
   (depends-on declare is_theft_lv5 is_theft_lv6)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule18] ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive-defeated $?gen243 & : ( subseq-pos ( create$ rule18-defeated rule12 $$$ $?gen243 ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) ( not ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ) => ( calc ( bind $?gen242 ( delete-member$ $?gen243 ( create$ rule18-defeated rule12 ) ) ) ) ?gen240 <- ( is_theft_lv5 ( positive-defeated $?gen242 ) )"))

([rule18-defeated] of derived-attribute-rule
   (pos-name rule18-defeated-gen604)
   (depends-on declare is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule18] ) ) ) ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive-defeated $?gen243 & : ( not ( subseq-pos ( create$ rule18-defeated rule12 $$$ $?gen243 ) ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) => ( calc ( bind $?gen242 ( create$ rule18-defeated rule12 $?gen243 ) ) ) ?gen240 <- ( is_theft_lv5 ( positive-defeated $?gen242 ) )"))

([rule18-defeasibly-dot] of derived-attribute-rule
   (pos-name rule18-defeasibly-dot-gen606)
   (depends-on declare is_theft_lv5 is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule18] ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule18 $? ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) ( not ( and ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ?gen240 <- ( is_theft_lv5 ( positive ~ 2 ) ( negative-overruled $?gen242 & : ( not ( member$ rule18 $?gen242 ) ) ) ) ) ) => ?gen240 <- ( is_theft_lv5 ( negative 0 ) )"))

([rule18-defeasibly] of derived-attribute-rule
   (pos-name rule18-defeasibly-gen608)
   (depends-on declare is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule18] ) ) ) ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen242 & : ( not ( member$ rule18 $?gen242 ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) => ?gen240 <- ( is_theft_lv5 ( negative 1 ) ( negative-derivator rule18 ?gen247 ) )"))

([rule18-overruled-dot] of derived-attribute-rule
   (pos-name rule18-overruled-dot-gen610)
   (depends-on declare is_theft_lv5 is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule18] ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive-support $?gen243 ) ( positive-overruled $?gen244 & : ( subseq-pos ( create$ rule18-overruled $?gen243 $$$ $?gen244 ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) ( not ( and ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ?gen240 <- ( is_theft_lv5 ( negative-defeated $?gen242 & : ( not ( member$ rule18 $?gen242 ) ) ) ) ) ) => ( calc ( bind $?gen245 ( delete-member$ $?gen244 ( create$ rule18-overruled $?gen243 ) ) ) ) ?gen240 <- ( is_theft_lv5 ( positive-overruled $?gen245 ) )"))

([rule18-overruled] of derived-attribute-rule
   (pos-name rule18-overruled-gen612)
   (depends-on declare is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule18] ) ) ) ?gen247 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive ?gen246 & : ( >= ?gen246 1 ) ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive-support $?gen243 ) ( positive-overruled $?gen244 & : ( not ( subseq-pos ( create$ rule18-overruled $?gen243 $$$ $?gen244 ) ) ) ) ( negative-defeated $?gen242 & : ( not ( member$ rule18 $?gen242 ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) => ( calc ( bind $?gen245 ( create$ rule18-overruled $?gen243 $?gen244 ) ) ) ?gen240 <- ( is_theft_lv5 ( positive-overruled $?gen245 ) )"))

([rule18-support] of derived-attribute-rule
   (pos-name rule18-support-gen614)
   (depends-on declare is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule18] ) ) ) ?gen239 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ?gen240 <- ( is_theft_lv5 ( defendant ?Defendant ) ( negative-support $?gen242 & : ( not ( subseq-pos ( create$ rule18 ?gen239 $$$ $?gen242 ) ) ) ) ) ( test ( eq ( class ?gen240 ) is_theft_lv5 ) ) => ( calc ( bind $?gen245 ( create$ rule18 ?gen239 $?gen242 ) ) ) ?gen240 <- ( is_theft_lv5 ( negative-support $?gen245 ) )"))

([rule17-defeasibly-dot] of derived-attribute-rule
   (pos-name rule17-defeasibly-dot-gen616)
   (depends-on declare is_theft_lv6 lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule17] ) ) ) ?gen221 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule17 $? ) ) ( test ( eq ( class ?gen221 ) is_theft_lv6 ) ) ( not ( and ?gen228 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen227 & : ( >= ?gen227 1 ) ) ) ?gen230 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen232 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen231 & : ( >= ?gen231 1 ) ) ) ?gen234 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen233 & : ( >= ?gen233 1 ) ) ) ?gen236 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen235 & : ( >= ?gen235 1 ) ) ) ?gen238 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ( positive ?gen237 & : ( >= ?gen237 1 ) ) ) ?gen221 <- ( is_theft_lv6 ( negative ~ 2 ) ( positive-overruled $?gen223 & : ( not ( member$ rule17 $?gen223 ) ) ) ) ) ) => ?gen221 <- ( is_theft_lv6 ( positive 0 ) )"))

([rule17-defeasibly] of derived-attribute-rule
   (pos-name rule17-defeasibly-gen618)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule17] ) ) ) ?gen228 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen227 & : ( >= ?gen227 1 ) ) ) ?gen230 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen232 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen231 & : ( >= ?gen231 1 ) ) ) ?gen234 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen233 & : ( >= ?gen233 1 ) ) ) ?gen236 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen235 & : ( >= ?gen235 1 ) ) ) ?gen238 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ( positive ?gen237 & : ( >= ?gen237 1 ) ) ) ?gen221 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen223 & : ( not ( member$ rule17 $?gen223 ) ) ) ) ( test ( eq ( class ?gen221 ) is_theft_lv6 ) ) => ?gen221 <- ( is_theft_lv6 ( positive 1 ) ( positive-derivator rule17 ?gen228 ?gen230 ?gen232 ?gen234 ?gen236 ?gen238 ) )"))

([rule17-overruled-dot] of derived-attribute-rule
   (pos-name rule17-overruled-dot-gen620)
   (depends-on declare is_theft_lv6 lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule17] ) ) ) ?gen221 <- ( is_theft_lv6 ( defendant ?Defendant ) ( negative-support $?gen224 ) ( negative-overruled $?gen225 & : ( subseq-pos ( create$ rule17-overruled $?gen224 $$$ $?gen225 ) ) ) ) ( test ( eq ( class ?gen221 ) is_theft_lv6 ) ) ( not ( and ?gen228 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen227 & : ( >= ?gen227 1 ) ) ) ?gen230 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen232 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen231 & : ( >= ?gen231 1 ) ) ) ?gen234 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen233 & : ( >= ?gen233 1 ) ) ) ?gen236 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen235 & : ( >= ?gen235 1 ) ) ) ?gen238 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ( positive ?gen237 & : ( >= ?gen237 1 ) ) ) ?gen221 <- ( is_theft_lv6 ( positive-defeated $?gen223 & : ( not ( member$ rule17 $?gen223 ) ) ) ) ) ) => ( calc ( bind $?gen226 ( delete-member$ $?gen225 ( create$ rule17-overruled $?gen224 ) ) ) ) ?gen221 <- ( is_theft_lv6 ( negative-overruled $?gen226 ) )"))

([rule17-overruled] of derived-attribute-rule
   (pos-name rule17-overruled-gen622)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule17] ) ) ) ?gen228 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen227 & : ( >= ?gen227 1 ) ) ) ?gen230 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen229 & : ( >= ?gen229 1 ) ) ) ?gen232 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen231 & : ( >= ?gen231 1 ) ) ) ?gen234 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen233 & : ( >= ?gen233 1 ) ) ) ?gen236 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen235 & : ( >= ?gen235 1 ) ) ) ?gen238 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ( positive ?gen237 & : ( >= ?gen237 1 ) ) ) ?gen221 <- ( is_theft_lv6 ( defendant ?Defendant ) ( negative-support $?gen224 ) ( negative-overruled $?gen225 & : ( not ( subseq-pos ( create$ rule17-overruled $?gen224 $$$ $?gen225 ) ) ) ) ( positive-defeated $?gen223 & : ( not ( member$ rule17 $?gen223 ) ) ) ) ( test ( eq ( class ?gen221 ) is_theft_lv6 ) ) => ( calc ( bind $?gen226 ( create$ rule17-overruled $?gen224 $?gen225 ) ) ) ?gen221 <- ( is_theft_lv6 ( negative-overruled $?gen226 ) )"))

([rule17-support] of derived-attribute-rule
   (pos-name rule17-support-gen624)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule17] ) ) ) ?gen215 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen216 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen217 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen218 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen219 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ?gen220 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ) ?gen221 <- ( is_theft_lv6 ( defendant ?Defendant ) ( positive-support $?gen223 & : ( not ( subseq-pos ( create$ rule17 ?gen215 ?gen216 ?gen217 ?gen218 ?gen219 ?gen220 $$$ $?gen223 ) ) ) ) ) ( test ( eq ( class ?gen221 ) is_theft_lv6 ) ) => ( calc ( bind $?gen226 ( create$ rule17 ?gen215 ?gen216 ?gen217 ?gen218 ?gen219 ?gen220 $?gen223 ) ) ) ?gen221 <- ( is_theft_lv6 ( positive-support $?gen226 ) )"))

([rule16-defeated-dot] of derived-attribute-rule
   (pos-name rule16-defeated-dot-gen626)
   (depends-on declare is_theft_lv1 is_theft_lv5)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule16] ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen210 & : ( subseq-pos ( create$ rule16-defeated rule1 $$$ $?gen210 ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) ( not ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ) => ( calc ( bind $?gen209 ( delete-member$ $?gen210 ( create$ rule16-defeated rule1 ) ) ) ) ?gen207 <- ( is_theft_lv1 ( positive-defeated $?gen209 ) )"))

([rule16-defeated] of derived-attribute-rule
   (pos-name rule16-defeated-gen628)
   (depends-on declare is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule16] ) ) ) ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen210 & : ( not ( subseq-pos ( create$ rule16-defeated rule1 $$$ $?gen210 ) ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) => ( calc ( bind $?gen209 ( create$ rule16-defeated rule1 $?gen210 ) ) ) ?gen207 <- ( is_theft_lv1 ( positive-defeated $?gen209 ) )"))

([rule16-defeasibly-dot] of derived-attribute-rule
   (pos-name rule16-defeasibly-dot-gen630)
   (depends-on declare is_theft_lv1 is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule16] ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule16 $? ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) ( not ( and ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ?gen207 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen209 & : ( not ( member$ rule16 $?gen209 ) ) ) ) ) ) => ?gen207 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule16-defeasibly] of derived-attribute-rule
   (pos-name rule16-defeasibly-gen632)
   (depends-on declare is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule16] ) ) ) ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen209 & : ( not ( member$ rule16 $?gen209 ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) => ?gen207 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule16 ?gen214 ) )"))

([rule16-overruled-dot] of derived-attribute-rule
   (pos-name rule16-overruled-dot-gen634)
   (depends-on declare is_theft_lv1 is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule16] ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen210 ) ( positive-overruled $?gen211 & : ( subseq-pos ( create$ rule16-overruled $?gen210 $$$ $?gen211 ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) ( not ( and ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ?gen207 <- ( is_theft_lv1 ( negative-defeated $?gen209 & : ( not ( member$ rule16 $?gen209 ) ) ) ) ) ) => ( calc ( bind $?gen212 ( delete-member$ $?gen211 ( create$ rule16-overruled $?gen210 ) ) ) ) ?gen207 <- ( is_theft_lv1 ( positive-overruled $?gen212 ) )"))

([rule16-overruled] of derived-attribute-rule
   (pos-name rule16-overruled-gen636)
   (depends-on declare is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule16] ) ) ) ?gen214 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen213 & : ( >= ?gen213 1 ) ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen210 ) ( positive-overruled $?gen211 & : ( not ( subseq-pos ( create$ rule16-overruled $?gen210 $$$ $?gen211 ) ) ) ) ( negative-defeated $?gen209 & : ( not ( member$ rule16 $?gen209 ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) => ( calc ( bind $?gen212 ( create$ rule16-overruled $?gen210 $?gen211 ) ) ) ?gen207 <- ( is_theft_lv1 ( positive-overruled $?gen212 ) )"))

([rule16-support] of derived-attribute-rule
   (pos-name rule16-support-gen638)
   (depends-on declare is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule16] ) ) ) ?gen206 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen207 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen209 & : ( not ( subseq-pos ( create$ rule16 ?gen206 $$$ $?gen209 ) ) ) ) ) ( test ( eq ( class ?gen207 ) is_theft_lv1 ) ) => ( calc ( bind $?gen212 ( create$ rule16 ?gen206 $?gen209 ) ) ) ?gen207 <- ( is_theft_lv1 ( negative-support $?gen212 ) )"))

([rule15-defeated-dot] of derived-attribute-rule
   (pos-name rule15-defeated-dot-gen640)
   (depends-on declare is_theft_lv2 is_theft_lv5)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule15] ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen201 & : ( subseq-pos ( create$ rule15-defeated rule3 $$$ $?gen201 ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) ( not ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ) => ( calc ( bind $?gen200 ( delete-member$ $?gen201 ( create$ rule15-defeated rule3 ) ) ) ) ?gen198 <- ( is_theft_lv2 ( positive-defeated $?gen200 ) )"))

([rule15-defeated] of derived-attribute-rule
   (pos-name rule15-defeated-gen642)
   (depends-on declare is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule15] ) ) ) ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen201 & : ( not ( subseq-pos ( create$ rule15-defeated rule3 $$$ $?gen201 ) ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) => ( calc ( bind $?gen200 ( create$ rule15-defeated rule3 $?gen201 ) ) ) ?gen198 <- ( is_theft_lv2 ( positive-defeated $?gen200 ) )"))

([rule15-defeasibly-dot] of derived-attribute-rule
   (pos-name rule15-defeasibly-dot-gen644)
   (depends-on declare is_theft_lv2 is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule15] ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule15 $? ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) ( not ( and ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ?gen198 <- ( is_theft_lv2 ( positive ~ 2 ) ( negative-overruled $?gen200 & : ( not ( member$ rule15 $?gen200 ) ) ) ) ) ) => ?gen198 <- ( is_theft_lv2 ( negative 0 ) )"))

([rule15-defeasibly] of derived-attribute-rule
   (pos-name rule15-defeasibly-gen646)
   (depends-on declare is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule15] ) ) ) ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen200 & : ( not ( member$ rule15 $?gen200 ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) => ?gen198 <- ( is_theft_lv2 ( negative 1 ) ( negative-derivator rule15 ?gen205 ) )"))

([rule15-overruled-dot] of derived-attribute-rule
   (pos-name rule15-overruled-dot-gen648)
   (depends-on declare is_theft_lv2 is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule15] ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen201 ) ( positive-overruled $?gen202 & : ( subseq-pos ( create$ rule15-overruled $?gen201 $$$ $?gen202 ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) ( not ( and ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ?gen198 <- ( is_theft_lv2 ( negative-defeated $?gen200 & : ( not ( member$ rule15 $?gen200 ) ) ) ) ) ) => ( calc ( bind $?gen203 ( delete-member$ $?gen202 ( create$ rule15-overruled $?gen201 ) ) ) ) ?gen198 <- ( is_theft_lv2 ( positive-overruled $?gen203 ) )"))

([rule15-overruled] of derived-attribute-rule
   (pos-name rule15-overruled-gen650)
   (depends-on declare is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule15] ) ) ) ?gen205 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen204 & : ( >= ?gen204 1 ) ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen201 ) ( positive-overruled $?gen202 & : ( not ( subseq-pos ( create$ rule15-overruled $?gen201 $$$ $?gen202 ) ) ) ) ( negative-defeated $?gen200 & : ( not ( member$ rule15 $?gen200 ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) => ( calc ( bind $?gen203 ( create$ rule15-overruled $?gen201 $?gen202 ) ) ) ?gen198 <- ( is_theft_lv2 ( positive-overruled $?gen203 ) )"))

([rule15-support] of derived-attribute-rule
   (pos-name rule15-support-gen652)
   (depends-on declare is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule15] ) ) ) ?gen197 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen198 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen200 & : ( not ( subseq-pos ( create$ rule15 ?gen197 $$$ $?gen200 ) ) ) ) ) ( test ( eq ( class ?gen198 ) is_theft_lv2 ) ) => ( calc ( bind $?gen203 ( create$ rule15 ?gen197 $?gen200 ) ) ) ?gen198 <- ( is_theft_lv2 ( negative-support $?gen203 ) )"))

([rule14-defeated-dot] of derived-attribute-rule
   (pos-name rule14-defeated-dot-gen654)
   (depends-on declare is_theft_lv3 is_theft_lv5)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule14] ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen192 & : ( subseq-pos ( create$ rule14-defeated rule5 $$$ $?gen192 ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) ( not ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ) => ( calc ( bind $?gen191 ( delete-member$ $?gen192 ( create$ rule14-defeated rule5 ) ) ) ) ?gen189 <- ( is_theft_lv3 ( positive-defeated $?gen191 ) )"))

([rule14-defeated] of derived-attribute-rule
   (pos-name rule14-defeated-gen656)
   (depends-on declare is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule14] ) ) ) ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen192 & : ( not ( subseq-pos ( create$ rule14-defeated rule5 $$$ $?gen192 ) ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) => ( calc ( bind $?gen191 ( create$ rule14-defeated rule5 $?gen192 ) ) ) ?gen189 <- ( is_theft_lv3 ( positive-defeated $?gen191 ) )"))

([rule14-defeasibly-dot] of derived-attribute-rule
   (pos-name rule14-defeasibly-dot-gen658)
   (depends-on declare is_theft_lv3 is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule14] ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule14 $? ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) ( not ( and ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ?gen189 <- ( is_theft_lv3 ( positive ~ 2 ) ( negative-overruled $?gen191 & : ( not ( member$ rule14 $?gen191 ) ) ) ) ) ) => ?gen189 <- ( is_theft_lv3 ( negative 0 ) )"))

([rule14-defeasibly] of derived-attribute-rule
   (pos-name rule14-defeasibly-gen660)
   (depends-on declare is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule14] ) ) ) ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen191 & : ( not ( member$ rule14 $?gen191 ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) => ?gen189 <- ( is_theft_lv3 ( negative 1 ) ( negative-derivator rule14 ?gen196 ) )"))

([rule14-overruled-dot] of derived-attribute-rule
   (pos-name rule14-overruled-dot-gen662)
   (depends-on declare is_theft_lv3 is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule14] ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen192 ) ( positive-overruled $?gen193 & : ( subseq-pos ( create$ rule14-overruled $?gen192 $$$ $?gen193 ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) ( not ( and ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ?gen189 <- ( is_theft_lv3 ( negative-defeated $?gen191 & : ( not ( member$ rule14 $?gen191 ) ) ) ) ) ) => ( calc ( bind $?gen194 ( delete-member$ $?gen193 ( create$ rule14-overruled $?gen192 ) ) ) ) ?gen189 <- ( is_theft_lv3 ( positive-overruled $?gen194 ) )"))

([rule14-overruled] of derived-attribute-rule
   (pos-name rule14-overruled-gen664)
   (depends-on declare is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule14] ) ) ) ?gen196 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen195 & : ( >= ?gen195 1 ) ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen192 ) ( positive-overruled $?gen193 & : ( not ( subseq-pos ( create$ rule14-overruled $?gen192 $$$ $?gen193 ) ) ) ) ( negative-defeated $?gen191 & : ( not ( member$ rule14 $?gen191 ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) => ( calc ( bind $?gen194 ( create$ rule14-overruled $?gen192 $?gen193 ) ) ) ?gen189 <- ( is_theft_lv3 ( positive-overruled $?gen194 ) )"))

([rule14-support] of derived-attribute-rule
   (pos-name rule14-support-gen666)
   (depends-on declare is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule14] ) ) ) ?gen188 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen189 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative-support $?gen191 & : ( not ( subseq-pos ( create$ rule14 ?gen188 $$$ $?gen191 ) ) ) ) ) ( test ( eq ( class ?gen189 ) is_theft_lv3 ) ) => ( calc ( bind $?gen194 ( create$ rule14 ?gen188 $?gen191 ) ) ) ?gen189 <- ( is_theft_lv3 ( negative-support $?gen194 ) )"))

([rule13-defeated-dot] of derived-attribute-rule
   (pos-name rule13-defeated-dot-gen668)
   (depends-on declare is_theft_lv4 is_theft_lv5)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule13] ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-defeated $?gen183 & : ( subseq-pos ( create$ rule13-defeated rule8 $$$ $?gen183 ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) ( not ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ) => ( calc ( bind $?gen182 ( delete-member$ $?gen183 ( create$ rule13-defeated rule8 ) ) ) ) ?gen180 <- ( is_theft_lv4 ( positive-defeated $?gen182 ) )"))

([rule13-defeated] of derived-attribute-rule
   (pos-name rule13-defeated-gen670)
   (depends-on declare is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule13] ) ) ) ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-defeated $?gen183 & : ( not ( subseq-pos ( create$ rule13-defeated rule8 $$$ $?gen183 ) ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) => ( calc ( bind $?gen182 ( create$ rule13-defeated rule8 $?gen183 ) ) ) ?gen180 <- ( is_theft_lv4 ( positive-defeated $?gen182 ) )"))

([rule13-defeasibly-dot] of derived-attribute-rule
   (pos-name rule13-defeasibly-dot-gen672)
   (depends-on declare is_theft_lv4 is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule13] ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule13 $? ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) ( not ( and ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ?gen180 <- ( is_theft_lv4 ( positive ~ 2 ) ( negative-overruled $?gen182 & : ( not ( member$ rule13 $?gen182 ) ) ) ) ) ) => ?gen180 <- ( is_theft_lv4 ( negative 0 ) )"))

([rule13-defeasibly] of derived-attribute-rule
   (pos-name rule13-defeasibly-gen674)
   (depends-on declare is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule13] ) ) ) ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen182 & : ( not ( member$ rule13 $?gen182 ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) => ?gen180 <- ( is_theft_lv4 ( negative 1 ) ( negative-derivator rule13 ?gen187 ) )"))

([rule13-overruled-dot] of derived-attribute-rule
   (pos-name rule13-overruled-dot-gen676)
   (depends-on declare is_theft_lv4 is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule13] ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-support $?gen183 ) ( positive-overruled $?gen184 & : ( subseq-pos ( create$ rule13-overruled $?gen183 $$$ $?gen184 ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) ( not ( and ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ?gen180 <- ( is_theft_lv4 ( negative-defeated $?gen182 & : ( not ( member$ rule13 $?gen182 ) ) ) ) ) ) => ( calc ( bind $?gen185 ( delete-member$ $?gen184 ( create$ rule13-overruled $?gen183 ) ) ) ) ?gen180 <- ( is_theft_lv4 ( positive-overruled $?gen185 ) )"))

([rule13-overruled] of derived-attribute-rule
   (pos-name rule13-overruled-gen678)
   (depends-on declare is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule13] ) ) ) ?gen187 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive ?gen186 & : ( >= ?gen186 1 ) ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-support $?gen183 ) ( positive-overruled $?gen184 & : ( not ( subseq-pos ( create$ rule13-overruled $?gen183 $$$ $?gen184 ) ) ) ) ( negative-defeated $?gen182 & : ( not ( member$ rule13 $?gen182 ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) => ( calc ( bind $?gen185 ( create$ rule13-overruled $?gen183 $?gen184 ) ) ) ?gen180 <- ( is_theft_lv4 ( positive-overruled $?gen185 ) )"))

([rule13-support] of derived-attribute-rule
   (pos-name rule13-support-gen680)
   (depends-on declare is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule13] ) ) ) ?gen179 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ?gen180 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative-support $?gen182 & : ( not ( subseq-pos ( create$ rule13 ?gen179 $$$ $?gen182 ) ) ) ) ) ( test ( eq ( class ?gen180 ) is_theft_lv4 ) ) => ( calc ( bind $?gen185 ( create$ rule13 ?gen179 $?gen182 ) ) ) ?gen180 <- ( is_theft_lv4 ( negative-support $?gen185 ) )"))

([rule12-defeasibly-dot] of derived-attribute-rule
   (pos-name rule12-defeasibly-dot-gen682)
   (depends-on declare is_theft_lv5 lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule12] ) ) ) ?gen161 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule12 $? ) ) ( test ( eq ( class ?gen161 ) is_theft_lv5 ) ) ( not ( and ?gen168 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen167 & : ( >= ?gen167 1 ) ) ) ?gen170 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen169 & : ( >= ?gen169 1 ) ) ) ?gen172 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen171 & : ( >= ?gen171 1 ) ) ) ?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen173 & : ( >= ?gen173 1 ) ) ) ?gen176 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen175 & : ( >= ?gen175 1 ) ) ) ?gen178 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ( positive ?gen177 & : ( >= ?gen177 1 ) ) ) ?gen161 <- ( is_theft_lv5 ( negative ~ 2 ) ( positive-overruled $?gen163 & : ( not ( member$ rule12 $?gen163 ) ) ) ) ) ) => ?gen161 <- ( is_theft_lv5 ( positive 0 ) )"))

([rule12-defeasibly] of derived-attribute-rule
   (pos-name rule12-defeasibly-gen684)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule12] ) ) ) ?gen168 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen167 & : ( >= ?gen167 1 ) ) ) ?gen170 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen169 & : ( >= ?gen169 1 ) ) ) ?gen172 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen171 & : ( >= ?gen171 1 ) ) ) ?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen173 & : ( >= ?gen173 1 ) ) ) ?gen176 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen175 & : ( >= ?gen175 1 ) ) ) ?gen178 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ( positive ?gen177 & : ( >= ?gen177 1 ) ) ) ?gen161 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen163 & : ( not ( member$ rule12 $?gen163 ) ) ) ) ( test ( eq ( class ?gen161 ) is_theft_lv5 ) ) => ?gen161 <- ( is_theft_lv5 ( positive 1 ) ( positive-derivator rule12 ?gen168 ?gen170 ?gen172 ?gen174 ?gen176 ?gen178 ) )"))

([rule12-overruled-dot] of derived-attribute-rule
   (pos-name rule12-overruled-dot-gen686)
   (depends-on declare is_theft_lv5 lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule12] ) ) ) ?gen161 <- ( is_theft_lv5 ( defendant ?Defendant ) ( negative-support $?gen164 ) ( negative-overruled $?gen165 & : ( subseq-pos ( create$ rule12-overruled $?gen164 $$$ $?gen165 ) ) ) ) ( test ( eq ( class ?gen161 ) is_theft_lv5 ) ) ( not ( and ?gen168 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen167 & : ( >= ?gen167 1 ) ) ) ?gen170 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen169 & : ( >= ?gen169 1 ) ) ) ?gen172 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen171 & : ( >= ?gen171 1 ) ) ) ?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen173 & : ( >= ?gen173 1 ) ) ) ?gen176 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen175 & : ( >= ?gen175 1 ) ) ) ?gen178 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ( positive ?gen177 & : ( >= ?gen177 1 ) ) ) ?gen161 <- ( is_theft_lv5 ( positive-defeated $?gen163 & : ( not ( member$ rule12 $?gen163 ) ) ) ) ) ) => ( calc ( bind $?gen166 ( delete-member$ $?gen165 ( create$ rule12-overruled $?gen164 ) ) ) ) ?gen161 <- ( is_theft_lv5 ( negative-overruled $?gen166 ) )"))

([rule12-overruled] of derived-attribute-rule
   (pos-name rule12-overruled-gen688)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule12] ) ) ) ?gen168 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen167 & : ( >= ?gen167 1 ) ) ) ?gen170 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen169 & : ( >= ?gen169 1 ) ) ) ?gen172 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen171 & : ( >= ?gen171 1 ) ) ) ?gen174 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen173 & : ( >= ?gen173 1 ) ) ) ?gen176 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen175 & : ( >= ?gen175 1 ) ) ) ?gen178 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ( positive ?gen177 & : ( >= ?gen177 1 ) ) ) ?gen161 <- ( is_theft_lv5 ( defendant ?Defendant ) ( negative-support $?gen164 ) ( negative-overruled $?gen165 & : ( not ( subseq-pos ( create$ rule12-overruled $?gen164 $$$ $?gen165 ) ) ) ) ( positive-defeated $?gen163 & : ( not ( member$ rule12 $?gen163 ) ) ) ) ( test ( eq ( class ?gen161 ) is_theft_lv5 ) ) => ( calc ( bind $?gen166 ( create$ rule12-overruled $?gen164 $?gen165 ) ) ) ?gen161 <- ( is_theft_lv5 ( negative-overruled $?gen166 ) )"))

([rule12-support] of derived-attribute-rule
   (pos-name rule12-support-gen690)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule12] ) ) ) ?gen155 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen156 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen157 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen158 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen159 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ?gen160 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ) ?gen161 <- ( is_theft_lv5 ( defendant ?Defendant ) ( positive-support $?gen163 & : ( not ( subseq-pos ( create$ rule12 ?gen155 ?gen156 ?gen157 ?gen158 ?gen159 ?gen160 $$$ $?gen163 ) ) ) ) ) ( test ( eq ( class ?gen161 ) is_theft_lv5 ) ) => ( calc ( bind $?gen166 ( create$ rule12 ?gen155 ?gen156 ?gen157 ?gen158 ?gen159 ?gen160 $?gen163 ) ) ) ?gen161 <- ( is_theft_lv5 ( positive-support $?gen166 ) )"))

([rule11-defeated-dot] of derived-attribute-rule
   (pos-name rule11-defeated-dot-gen692)
   (depends-on declare is_theft_lv1 is_theft_lv4)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule11] ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen150 & : ( subseq-pos ( create$ rule11-defeated rule1 $$$ $?gen150 ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) ( not ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ) => ( calc ( bind $?gen149 ( delete-member$ $?gen150 ( create$ rule11-defeated rule1 ) ) ) ) ?gen147 <- ( is_theft_lv1 ( positive-defeated $?gen149 ) )"))

([rule11-defeated] of derived-attribute-rule
   (pos-name rule11-defeated-gen694)
   (depends-on declare is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule11] ) ) ) ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen150 & : ( not ( subseq-pos ( create$ rule11-defeated rule1 $$$ $?gen150 ) ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) => ( calc ( bind $?gen149 ( create$ rule11-defeated rule1 $?gen150 ) ) ) ?gen147 <- ( is_theft_lv1 ( positive-defeated $?gen149 ) )"))

([rule11-defeasibly-dot] of derived-attribute-rule
   (pos-name rule11-defeasibly-dot-gen696)
   (depends-on declare is_theft_lv1 is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule11] ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule11 $? ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) ( not ( and ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ?gen147 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen149 & : ( not ( member$ rule11 $?gen149 ) ) ) ) ) ) => ?gen147 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule11-defeasibly] of derived-attribute-rule
   (pos-name rule11-defeasibly-gen698)
   (depends-on declare is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule11] ) ) ) ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen149 & : ( not ( member$ rule11 $?gen149 ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) => ?gen147 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule11 ?gen154 ) )"))

([rule11-overruled-dot] of derived-attribute-rule
   (pos-name rule11-overruled-dot-gen700)
   (depends-on declare is_theft_lv1 is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule11] ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen150 ) ( positive-overruled $?gen151 & : ( subseq-pos ( create$ rule11-overruled $?gen150 $$$ $?gen151 ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) ( not ( and ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ?gen147 <- ( is_theft_lv1 ( negative-defeated $?gen149 & : ( not ( member$ rule11 $?gen149 ) ) ) ) ) ) => ( calc ( bind $?gen152 ( delete-member$ $?gen151 ( create$ rule11-overruled $?gen150 ) ) ) ) ?gen147 <- ( is_theft_lv1 ( positive-overruled $?gen152 ) )"))

([rule11-overruled] of derived-attribute-rule
   (pos-name rule11-overruled-gen702)
   (depends-on declare is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule11] ) ) ) ?gen154 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen153 & : ( >= ?gen153 1 ) ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen150 ) ( positive-overruled $?gen151 & : ( not ( subseq-pos ( create$ rule11-overruled $?gen150 $$$ $?gen151 ) ) ) ) ( negative-defeated $?gen149 & : ( not ( member$ rule11 $?gen149 ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) => ( calc ( bind $?gen152 ( create$ rule11-overruled $?gen150 $?gen151 ) ) ) ?gen147 <- ( is_theft_lv1 ( positive-overruled $?gen152 ) )"))

([rule11-support] of derived-attribute-rule
   (pos-name rule11-support-gen704)
   (depends-on declare is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule11] ) ) ) ?gen146 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ?gen147 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen149 & : ( not ( subseq-pos ( create$ rule11 ?gen146 $$$ $?gen149 ) ) ) ) ) ( test ( eq ( class ?gen147 ) is_theft_lv1 ) ) => ( calc ( bind $?gen152 ( create$ rule11 ?gen146 $?gen149 ) ) ) ?gen147 <- ( is_theft_lv1 ( negative-support $?gen152 ) )"))

([rule10-defeated-dot] of derived-attribute-rule
   (pos-name rule10-defeated-dot-gen706)
   (depends-on declare is_theft_lv2 is_theft_lv4)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule10] ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen141 & : ( subseq-pos ( create$ rule10-defeated rule3 $$$ $?gen141 ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) ( not ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ) => ( calc ( bind $?gen140 ( delete-member$ $?gen141 ( create$ rule10-defeated rule3 ) ) ) ) ?gen138 <- ( is_theft_lv2 ( positive-defeated $?gen140 ) )"))

([rule10-defeated] of derived-attribute-rule
   (pos-name rule10-defeated-gen708)
   (depends-on declare is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule10] ) ) ) ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen141 & : ( not ( subseq-pos ( create$ rule10-defeated rule3 $$$ $?gen141 ) ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) => ( calc ( bind $?gen140 ( create$ rule10-defeated rule3 $?gen141 ) ) ) ?gen138 <- ( is_theft_lv2 ( positive-defeated $?gen140 ) )"))

([rule10-defeasibly-dot] of derived-attribute-rule
   (pos-name rule10-defeasibly-dot-gen710)
   (depends-on declare is_theft_lv2 is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule10] ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule10 $? ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) ( not ( and ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ?gen138 <- ( is_theft_lv2 ( positive ~ 2 ) ( negative-overruled $?gen140 & : ( not ( member$ rule10 $?gen140 ) ) ) ) ) ) => ?gen138 <- ( is_theft_lv2 ( negative 0 ) )"))

([rule10-defeasibly] of derived-attribute-rule
   (pos-name rule10-defeasibly-gen712)
   (depends-on declare is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule10] ) ) ) ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen140 & : ( not ( member$ rule10 $?gen140 ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) => ?gen138 <- ( is_theft_lv2 ( negative 1 ) ( negative-derivator rule10 ?gen145 ) )"))

([rule10-overruled-dot] of derived-attribute-rule
   (pos-name rule10-overruled-dot-gen714)
   (depends-on declare is_theft_lv2 is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule10] ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen141 ) ( positive-overruled $?gen142 & : ( subseq-pos ( create$ rule10-overruled $?gen141 $$$ $?gen142 ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) ( not ( and ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ?gen138 <- ( is_theft_lv2 ( negative-defeated $?gen140 & : ( not ( member$ rule10 $?gen140 ) ) ) ) ) ) => ( calc ( bind $?gen143 ( delete-member$ $?gen142 ( create$ rule10-overruled $?gen141 ) ) ) ) ?gen138 <- ( is_theft_lv2 ( positive-overruled $?gen143 ) )"))

([rule10-overruled] of derived-attribute-rule
   (pos-name rule10-overruled-gen716)
   (depends-on declare is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule10] ) ) ) ?gen145 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen144 & : ( >= ?gen144 1 ) ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen141 ) ( positive-overruled $?gen142 & : ( not ( subseq-pos ( create$ rule10-overruled $?gen141 $$$ $?gen142 ) ) ) ) ( negative-defeated $?gen140 & : ( not ( member$ rule10 $?gen140 ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) => ( calc ( bind $?gen143 ( create$ rule10-overruled $?gen141 $?gen142 ) ) ) ?gen138 <- ( is_theft_lv2 ( positive-overruled $?gen143 ) )"))

([rule10-support] of derived-attribute-rule
   (pos-name rule10-support-gen718)
   (depends-on declare is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule10] ) ) ) ?gen137 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ?gen138 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen140 & : ( not ( subseq-pos ( create$ rule10 ?gen137 $$$ $?gen140 ) ) ) ) ) ( test ( eq ( class ?gen138 ) is_theft_lv2 ) ) => ( calc ( bind $?gen143 ( create$ rule10 ?gen137 $?gen140 ) ) ) ?gen138 <- ( is_theft_lv2 ( negative-support $?gen143 ) )"))

([rule9-defeated-dot] of derived-attribute-rule
   (pos-name rule9-defeated-dot-gen720)
   (depends-on declare is_theft_lv3 is_theft_lv4)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule9] ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen132 & : ( subseq-pos ( create$ rule9-defeated rule5 $$$ $?gen132 ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) ( not ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ) => ( calc ( bind $?gen131 ( delete-member$ $?gen132 ( create$ rule9-defeated rule5 ) ) ) ) ?gen129 <- ( is_theft_lv3 ( positive-defeated $?gen131 ) )"))

([rule9-defeated] of derived-attribute-rule
   (pos-name rule9-defeated-gen722)
   (depends-on declare is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule9] ) ) ) ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-defeated $?gen132 & : ( not ( subseq-pos ( create$ rule9-defeated rule5 $$$ $?gen132 ) ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) => ( calc ( bind $?gen131 ( create$ rule9-defeated rule5 $?gen132 ) ) ) ?gen129 <- ( is_theft_lv3 ( positive-defeated $?gen131 ) )"))

([rule9-defeasibly-dot] of derived-attribute-rule
   (pos-name rule9-defeasibly-dot-gen724)
   (depends-on declare is_theft_lv3 is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule9] ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule9 $? ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) ( not ( and ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ?gen129 <- ( is_theft_lv3 ( positive ~ 2 ) ( negative-overruled $?gen131 & : ( not ( member$ rule9 $?gen131 ) ) ) ) ) ) => ?gen129 <- ( is_theft_lv3 ( negative 0 ) )"))

([rule9-defeasibly] of derived-attribute-rule
   (pos-name rule9-defeasibly-gen726)
   (depends-on declare is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule9] ) ) ) ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen131 & : ( not ( member$ rule9 $?gen131 ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) => ?gen129 <- ( is_theft_lv3 ( negative 1 ) ( negative-derivator rule9 ?gen136 ) )"))

([rule9-overruled-dot] of derived-attribute-rule
   (pos-name rule9-overruled-dot-gen728)
   (depends-on declare is_theft_lv3 is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule9] ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen132 ) ( positive-overruled $?gen133 & : ( subseq-pos ( create$ rule9-overruled $?gen132 $$$ $?gen133 ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) ( not ( and ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ?gen129 <- ( is_theft_lv3 ( negative-defeated $?gen131 & : ( not ( member$ rule9 $?gen131 ) ) ) ) ) ) => ( calc ( bind $?gen134 ( delete-member$ $?gen133 ( create$ rule9-overruled $?gen132 ) ) ) ) ?gen129 <- ( is_theft_lv3 ( positive-overruled $?gen134 ) )"))

([rule9-overruled] of derived-attribute-rule
   (pos-name rule9-overruled-gen730)
   (depends-on declare is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule9] ) ) ) ?gen136 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive ?gen135 & : ( >= ?gen135 1 ) ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen132 ) ( positive-overruled $?gen133 & : ( not ( subseq-pos ( create$ rule9-overruled $?gen132 $$$ $?gen133 ) ) ) ) ( negative-defeated $?gen131 & : ( not ( member$ rule9 $?gen131 ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) => ( calc ( bind $?gen134 ( create$ rule9-overruled $?gen132 $?gen133 ) ) ) ?gen129 <- ( is_theft_lv3 ( positive-overruled $?gen134 ) )"))

([rule9-support] of derived-attribute-rule
   (pos-name rule9-support-gen732)
   (depends-on declare is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule9] ) ) ) ?gen128 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ?gen129 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative-support $?gen131 & : ( not ( subseq-pos ( create$ rule9 ?gen128 $$$ $?gen131 ) ) ) ) ) ( test ( eq ( class ?gen129 ) is_theft_lv3 ) ) => ( calc ( bind $?gen134 ( create$ rule9 ?gen128 $?gen131 ) ) ) ?gen129 <- ( is_theft_lv3 ( negative-support $?gen134 ) )"))

([rule8-defeasibly-dot] of derived-attribute-rule
   (pos-name rule8-defeasibly-dot-gen734)
   (depends-on declare is_theft_lv4 lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule8] ) ) ) ?gen112 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule8 $? ) ) ( test ( eq ( class ?gen112 ) is_theft_lv4 ) ) ( not ( and ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen120 & : ( >= ?gen120 1 ) ) ) ?gen123 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen122 & : ( >= ?gen122 1 ) ) ) ?gen125 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen124 & : ( >= ?gen124 1 ) ) ) ?gen127 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen126 & : ( >= ?gen126 1 ) ) ) ?gen112 <- ( is_theft_lv4 ( negative ~ 2 ) ( positive-overruled $?gen114 & : ( not ( member$ rule8 $?gen114 ) ) ) ) ) ) => ?gen112 <- ( is_theft_lv4 ( positive 0 ) )"))

([rule8-defeasibly] of derived-attribute-rule
   (pos-name rule8-defeasibly-gen736)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule8] ) ) ) ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen120 & : ( >= ?gen120 1 ) ) ) ?gen123 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen122 & : ( >= ?gen122 1 ) ) ) ?gen125 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen124 & : ( >= ?gen124 1 ) ) ) ?gen127 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen126 & : ( >= ?gen126 1 ) ) ) ?gen112 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen114 & : ( not ( member$ rule8 $?gen114 ) ) ) ) ( test ( eq ( class ?gen112 ) is_theft_lv4 ) ) => ?gen112 <- ( is_theft_lv4 ( positive 1 ) ( positive-derivator rule8 ?gen119 ?gen121 ?gen123 ?gen125 ?gen127 ) )"))

([rule8-overruled-dot] of derived-attribute-rule
   (pos-name rule8-overruled-dot-gen738)
   (depends-on declare is_theft_lv4 lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule8] ) ) ) ?gen112 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative-support $?gen115 ) ( negative-overruled $?gen116 & : ( subseq-pos ( create$ rule8-overruled $?gen115 $$$ $?gen116 ) ) ) ) ( test ( eq ( class ?gen112 ) is_theft_lv4 ) ) ( not ( and ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen120 & : ( >= ?gen120 1 ) ) ) ?gen123 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen122 & : ( >= ?gen122 1 ) ) ) ?gen125 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen124 & : ( >= ?gen124 1 ) ) ) ?gen127 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen126 & : ( >= ?gen126 1 ) ) ) ?gen112 <- ( is_theft_lv4 ( positive-defeated $?gen114 & : ( not ( member$ rule8 $?gen114 ) ) ) ) ) ) => ( calc ( bind $?gen117 ( delete-member$ $?gen116 ( create$ rule8-overruled $?gen115 ) ) ) ) ?gen112 <- ( is_theft_lv4 ( negative-overruled $?gen117 ) )"))

([rule8-overruled] of derived-attribute-rule
   (pos-name rule8-overruled-gen740)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule8] ) ) ) ?gen119 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen118 & : ( >= ?gen118 1 ) ) ) ?gen121 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen120 & : ( >= ?gen120 1 ) ) ) ?gen123 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen122 & : ( >= ?gen122 1 ) ) ) ?gen125 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ( positive ?gen124 & : ( >= ?gen124 1 ) ) ) ?gen127 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ( positive ?gen126 & : ( >= ?gen126 1 ) ) ) ?gen112 <- ( is_theft_lv4 ( defendant ?Defendant ) ( negative-support $?gen115 ) ( negative-overruled $?gen116 & : ( not ( subseq-pos ( create$ rule8-overruled $?gen115 $$$ $?gen116 ) ) ) ) ( positive-defeated $?gen114 & : ( not ( member$ rule8 $?gen114 ) ) ) ) ( test ( eq ( class ?gen112 ) is_theft_lv4 ) ) => ( calc ( bind $?gen117 ( create$ rule8-overruled $?gen115 $?gen116 ) ) ) ?gen112 <- ( is_theft_lv4 ( negative-overruled $?gen117 ) )"))

([rule8-support] of derived-attribute-rule
   (pos-name rule8-support-gen742)
   (depends-on declare lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule8] ) ) ) ?gen107 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen108 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen110 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ?gen112 <- ( is_theft_lv4 ( defendant ?Defendant ) ( positive-support $?gen114 & : ( not ( subseq-pos ( create$ rule8 ?gen107 ?gen108 ?gen109 ?gen110 ?gen111 $$$ $?gen114 ) ) ) ) ) ( test ( eq ( class ?gen112 ) is_theft_lv4 ) ) => ( calc ( bind $?gen117 ( create$ rule8 ?gen107 ?gen108 ?gen109 ?gen110 ?gen111 $?gen114 ) ) ) ?gen112 <- ( is_theft_lv4 ( positive-support $?gen117 ) )"))

([rule7-defeated-dot] of derived-attribute-rule
   (pos-name rule7-defeated-dot-gen744)
   (depends-on declare is_theft_lv1 is_theft_lv3)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule7] ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen102 & : ( subseq-pos ( create$ rule7-defeated rule1 $$$ $?gen102 ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) ( not ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ) => ( calc ( bind $?gen101 ( delete-member$ $?gen102 ( create$ rule7-defeated rule1 ) ) ) ) ?gen99 <- ( is_theft_lv1 ( positive-defeated $?gen101 ) )"))

([rule7-defeated] of derived-attribute-rule
   (pos-name rule7-defeated-gen746)
   (depends-on declare is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule7] ) ) ) ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen102 & : ( not ( subseq-pos ( create$ rule7-defeated rule1 $$$ $?gen102 ) ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) => ( calc ( bind $?gen101 ( create$ rule7-defeated rule1 $?gen102 ) ) ) ?gen99 <- ( is_theft_lv1 ( positive-defeated $?gen101 ) )"))

([rule7-defeasibly-dot] of derived-attribute-rule
   (pos-name rule7-defeasibly-dot-gen748)
   (depends-on declare is_theft_lv1 is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule7] ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule7 $? ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) ( not ( and ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ?gen99 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen101 & : ( not ( member$ rule7 $?gen101 ) ) ) ) ) ) => ?gen99 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule7-defeasibly] of derived-attribute-rule
   (pos-name rule7-defeasibly-gen750)
   (depends-on declare is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule7] ) ) ) ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen101 & : ( not ( member$ rule7 $?gen101 ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) => ?gen99 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule7 ?gen106 ) )"))

([rule7-overruled-dot] of derived-attribute-rule
   (pos-name rule7-overruled-dot-gen752)
   (depends-on declare is_theft_lv1 is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule7] ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen102 ) ( positive-overruled $?gen103 & : ( subseq-pos ( create$ rule7-overruled $?gen102 $$$ $?gen103 ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) ( not ( and ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ?gen99 <- ( is_theft_lv1 ( negative-defeated $?gen101 & : ( not ( member$ rule7 $?gen101 ) ) ) ) ) ) => ( calc ( bind $?gen104 ( delete-member$ $?gen103 ( create$ rule7-overruled $?gen102 ) ) ) ) ?gen99 <- ( is_theft_lv1 ( positive-overruled $?gen104 ) )"))

([rule7-overruled] of derived-attribute-rule
   (pos-name rule7-overruled-gen754)
   (depends-on declare is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule7] ) ) ) ?gen106 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen105 & : ( >= ?gen105 1 ) ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen102 ) ( positive-overruled $?gen103 & : ( not ( subseq-pos ( create$ rule7-overruled $?gen102 $$$ $?gen103 ) ) ) ) ( negative-defeated $?gen101 & : ( not ( member$ rule7 $?gen101 ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) => ( calc ( bind $?gen104 ( create$ rule7-overruled $?gen102 $?gen103 ) ) ) ?gen99 <- ( is_theft_lv1 ( positive-overruled $?gen104 ) )"))

([rule7-support] of derived-attribute-rule
   (pos-name rule7-support-gen756)
   (depends-on declare is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule7] ) ) ) ?gen98 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ?gen99 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen101 & : ( not ( subseq-pos ( create$ rule7 ?gen98 $$$ $?gen101 ) ) ) ) ) ( test ( eq ( class ?gen99 ) is_theft_lv1 ) ) => ( calc ( bind $?gen104 ( create$ rule7 ?gen98 $?gen101 ) ) ) ?gen99 <- ( is_theft_lv1 ( negative-support $?gen104 ) )"))

([rule6-defeated-dot] of derived-attribute-rule
   (pos-name rule6-defeated-dot-gen758)
   (depends-on declare is_theft_lv2 is_theft_lv3)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule6] ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen93 & : ( subseq-pos ( create$ rule6-defeated rule3 $$$ $?gen93 ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) ( not ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ) => ( calc ( bind $?gen92 ( delete-member$ $?gen93 ( create$ rule6-defeated rule3 ) ) ) ) ?gen90 <- ( is_theft_lv2 ( positive-defeated $?gen92 ) )"))

([rule6-defeated] of derived-attribute-rule
   (pos-name rule6-defeated-gen760)
   (depends-on declare is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule6] ) ) ) ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-defeated $?gen93 & : ( not ( subseq-pos ( create$ rule6-defeated rule3 $$$ $?gen93 ) ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) => ( calc ( bind $?gen92 ( create$ rule6-defeated rule3 $?gen93 ) ) ) ?gen90 <- ( is_theft_lv2 ( positive-defeated $?gen92 ) )"))

([rule6-defeasibly-dot] of derived-attribute-rule
   (pos-name rule6-defeasibly-dot-gen762)
   (depends-on declare is_theft_lv2 is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule6] ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule6 $? ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) ( not ( and ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen90 <- ( is_theft_lv2 ( positive ~ 2 ) ( negative-overruled $?gen92 & : ( not ( member$ rule6 $?gen92 ) ) ) ) ) ) => ?gen90 <- ( is_theft_lv2 ( negative 0 ) )"))

([rule6-defeasibly] of derived-attribute-rule
   (pos-name rule6-defeasibly-gen764)
   (depends-on declare is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule6] ) ) ) ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen92 & : ( not ( member$ rule6 $?gen92 ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) => ?gen90 <- ( is_theft_lv2 ( negative 1 ) ( negative-derivator rule6 ?gen97 ) )"))

([rule6-overruled-dot] of derived-attribute-rule
   (pos-name rule6-overruled-dot-gen766)
   (depends-on declare is_theft_lv2 is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule6] ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen93 ) ( positive-overruled $?gen94 & : ( subseq-pos ( create$ rule6-overruled $?gen93 $$$ $?gen94 ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) ( not ( and ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen90 <- ( is_theft_lv2 ( negative-defeated $?gen92 & : ( not ( member$ rule6 $?gen92 ) ) ) ) ) ) => ( calc ( bind $?gen95 ( delete-member$ $?gen94 ( create$ rule6-overruled $?gen93 ) ) ) ) ?gen90 <- ( is_theft_lv2 ( positive-overruled $?gen95 ) )"))

([rule6-overruled] of derived-attribute-rule
   (pos-name rule6-overruled-gen768)
   (depends-on declare is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule6] ) ) ) ?gen97 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive ?gen96 & : ( >= ?gen96 1 ) ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen93 ) ( positive-overruled $?gen94 & : ( not ( subseq-pos ( create$ rule6-overruled $?gen93 $$$ $?gen94 ) ) ) ) ( negative-defeated $?gen92 & : ( not ( member$ rule6 $?gen92 ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) => ( calc ( bind $?gen95 ( create$ rule6-overruled $?gen93 $?gen94 ) ) ) ?gen90 <- ( is_theft_lv2 ( positive-overruled $?gen95 ) )"))

([rule6-support] of derived-attribute-rule
   (pos-name rule6-support-gen770)
   (depends-on declare is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule6] ) ) ) ?gen89 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ?gen90 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen92 & : ( not ( subseq-pos ( create$ rule6 ?gen89 $$$ $?gen92 ) ) ) ) ) ( test ( eq ( class ?gen90 ) is_theft_lv2 ) ) => ( calc ( bind $?gen95 ( create$ rule6 ?gen89 $?gen92 ) ) ) ?gen90 <- ( is_theft_lv2 ( negative-support $?gen95 ) )"))

([rule5-defeasibly-dot] of derived-attribute-rule
   (pos-name rule5-defeasibly-dot-gen772)
   (depends-on declare is_theft_lv3 lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule5] ) ) ) ?gen75 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule5 $? ) ) ( test ( eq ( class ?gen75 ) is_theft_lv3 ) ) ( not ( and ?gen82 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen81 & : ( >= ?gen81 1 ) ) ) ?gen84 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen83 & : ( >= ?gen83 1 ) ) ) ?gen86 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen85 & : ( >= ?gen85 1 ) ) ) ?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen87 & : ( >= ?gen87 1 ) ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ?gen75 <- ( is_theft_lv3 ( negative ~ 2 ) ( positive-overruled $?gen77 & : ( not ( member$ rule5 $?gen77 ) ) ) ) ) ) => ?gen75 <- ( is_theft_lv3 ( positive 0 ) )"))

([rule5-defeasibly] of derived-attribute-rule
   (pos-name rule5-defeasibly-gen774)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule5] ) ) ) ?gen82 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen81 & : ( >= ?gen81 1 ) ) ) ?gen84 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen83 & : ( >= ?gen83 1 ) ) ) ?gen86 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen85 & : ( >= ?gen85 1 ) ) ) ?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen87 & : ( >= ?gen87 1 ) ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ?gen75 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen77 & : ( not ( member$ rule5 $?gen77 ) ) ) ) ( test ( eq ( class ?gen75 ) is_theft_lv3 ) ) => ?gen75 <- ( is_theft_lv3 ( positive 1 ) ( positive-derivator rule5 ?gen82 ?gen84 ?gen86 ?gen88 ) )"))

([rule5-overruled-dot] of derived-attribute-rule
   (pos-name rule5-overruled-dot-gen776)
   (depends-on declare is_theft_lv3 lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule5] ) ) ) ?gen75 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative-support $?gen78 ) ( negative-overruled $?gen79 & : ( subseq-pos ( create$ rule5-overruled $?gen78 $$$ $?gen79 ) ) ) ) ( test ( eq ( class ?gen75 ) is_theft_lv3 ) ) ( not ( and ?gen82 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen81 & : ( >= ?gen81 1 ) ) ) ?gen84 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen83 & : ( >= ?gen83 1 ) ) ) ?gen86 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen85 & : ( >= ?gen85 1 ) ) ) ?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen87 & : ( >= ?gen87 1 ) ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ?gen75 <- ( is_theft_lv3 ( positive-defeated $?gen77 & : ( not ( member$ rule5 $?gen77 ) ) ) ) ) ) => ( calc ( bind $?gen80 ( delete-member$ $?gen79 ( create$ rule5-overruled $?gen78 ) ) ) ) ?gen75 <- ( is_theft_lv3 ( negative-overruled $?gen80 ) )"))

([rule5-overruled] of derived-attribute-rule
   (pos-name rule5-overruled-gen778)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule5] ) ) ) ?gen82 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen81 & : ( >= ?gen81 1 ) ) ) ?gen84 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen83 & : ( >= ?gen83 1 ) ) ) ?gen86 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen85 & : ( >= ?gen85 1 ) ) ) ?gen88 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen87 & : ( >= ?gen87 1 ) ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ?gen75 <- ( is_theft_lv3 ( defendant ?Defendant ) ( negative-support $?gen78 ) ( negative-overruled $?gen79 & : ( not ( subseq-pos ( create$ rule5-overruled $?gen78 $$$ $?gen79 ) ) ) ) ( positive-defeated $?gen77 & : ( not ( member$ rule5 $?gen77 ) ) ) ) ( test ( eq ( class ?gen75 ) is_theft_lv3 ) ) => ( calc ( bind $?gen80 ( create$ rule5-overruled $?gen78 $?gen79 ) ) ) ?gen75 <- ( is_theft_lv3 ( negative-overruled $?gen80 ) )"))

([rule5-support] of derived-attribute-rule
   (pos-name rule5-support-gen780)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule5] ) ) ) ?gen70 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen71 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen72 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen73 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ?gen75 <- ( is_theft_lv3 ( defendant ?Defendant ) ( positive-support $?gen77 & : ( not ( subseq-pos ( create$ rule5 ?gen70 ?gen71 ?gen72 ?gen73 $$$ $?gen77 ) ) ) ) ) ( test ( eq ( class ?gen75 ) is_theft_lv3 ) ) => ( calc ( bind $?gen80 ( create$ rule5 ?gen70 ?gen71 ?gen72 ?gen73 $?gen77 ) ) ) ?gen75 <- ( is_theft_lv3 ( positive-support $?gen80 ) )"))

([rule4-defeated-dot] of derived-attribute-rule
   (pos-name rule4-defeated-dot-gen782)
   (depends-on declare is_theft_lv1 is_theft_lv2)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule4] ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen65 & : ( subseq-pos ( create$ rule4-defeated rule1 $$$ $?gen65 ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) ( not ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ) => ( calc ( bind $?gen64 ( delete-member$ $?gen65 ( create$ rule4-defeated rule1 ) ) ) ) ?gen62 <- ( is_theft_lv1 ( positive-defeated $?gen64 ) )"))

([rule4-defeated] of derived-attribute-rule
   (pos-name rule4-defeated-gen784)
   (depends-on declare is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule4] ) ) ) ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-defeated $?gen65 & : ( not ( subseq-pos ( create$ rule4-defeated rule1 $$$ $?gen65 ) ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) => ( calc ( bind $?gen64 ( create$ rule4-defeated rule1 $?gen65 ) ) ) ?gen62 <- ( is_theft_lv1 ( positive-defeated $?gen64 ) )"))

([rule4-defeasibly-dot] of derived-attribute-rule
   (pos-name rule4-defeasibly-dot-gen786)
   (depends-on declare is_theft_lv1 is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule4] ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule4 $? ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) ( not ( and ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen64 & : ( not ( member$ rule4 $?gen64 ) ) ) ) ) ) => ?gen62 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule4-defeasibly] of derived-attribute-rule
   (pos-name rule4-defeasibly-gen788)
   (depends-on declare is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule4] ) ) ) ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen64 & : ( not ( member$ rule4 $?gen64 ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) => ?gen62 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule4 ?gen69 ) )"))

([rule4-overruled-dot] of derived-attribute-rule
   (pos-name rule4-overruled-dot-gen790)
   (depends-on declare is_theft_lv1 is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule4] ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen65 ) ( positive-overruled $?gen66 & : ( subseq-pos ( create$ rule4-overruled $?gen65 $$$ $?gen66 ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) ( not ( and ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( is_theft_lv1 ( negative-defeated $?gen64 & : ( not ( member$ rule4 $?gen64 ) ) ) ) ) ) => ( calc ( bind $?gen67 ( delete-member$ $?gen66 ( create$ rule4-overruled $?gen65 ) ) ) ) ?gen62 <- ( is_theft_lv1 ( positive-overruled $?gen67 ) )"))

([rule4-overruled] of derived-attribute-rule
   (pos-name rule4-overruled-gen792)
   (depends-on declare is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule4] ) ) ) ?gen69 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive ?gen68 & : ( >= ?gen68 1 ) ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen65 ) ( positive-overruled $?gen66 & : ( not ( subseq-pos ( create$ rule4-overruled $?gen65 $$$ $?gen66 ) ) ) ) ( negative-defeated $?gen64 & : ( not ( member$ rule4 $?gen64 ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) => ( calc ( bind $?gen67 ( create$ rule4-overruled $?gen65 $?gen66 ) ) ) ?gen62 <- ( is_theft_lv1 ( positive-overruled $?gen67 ) )"))

([rule4-support] of derived-attribute-rule
   (pos-name rule4-support-gen794)
   (depends-on declare is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule4] ) ) ) ?gen61 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ?gen62 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen64 & : ( not ( subseq-pos ( create$ rule4 ?gen61 $$$ $?gen64 ) ) ) ) ) ( test ( eq ( class ?gen62 ) is_theft_lv1 ) ) => ( calc ( bind $?gen67 ( create$ rule4 ?gen61 $?gen64 ) ) ) ?gen62 <- ( is_theft_lv1 ( negative-support $?gen67 ) )"))

([rule3-defeated-dot] of derived-attribute-rule
   (pos-name rule3-defeated-dot-gen796)
   (depends-on declare is_theft_lv2 lc:case lc:case lc:case lc:case)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -3 [rule3] ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-defeated $?gen50 & : ( subseq-pos ( create$ rule3-defeated rule2 rule1 $$$ $?gen50 ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) ( not ( and ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ) ) => ( calc ( bind $?gen49 ( delete-member$ $?gen50 ( create$ rule3-defeated rule2 rule1 ) ) ) ) ?gen47 <- ( is_theft_lv2 ( negative-defeated $?gen49 ) )"))

([rule3-defeated] of derived-attribute-rule
   (pos-name rule3-defeated-gen798)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 3 [rule3] ) ) ) ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-defeated $?gen50 & : ( not ( subseq-pos ( create$ rule3-defeated rule2 rule1 $$$ $?gen50 ) ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) => ( calc ( bind $?gen49 ( create$ rule3-defeated rule2 rule1 $?gen50 ) ) ) ?gen47 <- ( is_theft_lv2 ( negative-defeated $?gen49 ) )"))

([rule3-defeasibly-dot] of derived-attribute-rule
   (pos-name rule3-defeasibly-dot-gen800)
   (depends-on declare is_theft_lv2 lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule3] ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule3 $? ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) ( not ( and ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen47 <- ( is_theft_lv2 ( negative ~ 2 ) ( positive-overruled $?gen49 & : ( not ( member$ rule3 $?gen49 ) ) ) ) ) ) => ?gen47 <- ( is_theft_lv2 ( positive 0 ) )"))

([rule3-defeasibly] of derived-attribute-rule
   (pos-name rule3-defeasibly-gen802)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule3] ) ) ) ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen49 & : ( not ( member$ rule3 $?gen49 ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) => ?gen47 <- ( is_theft_lv2 ( positive 1 ) ( positive-derivator rule3 ?gen54 ?gen56 ?gen58 ?gen60 ) )"))

([rule3-overruled-dot] of derived-attribute-rule
   (pos-name rule3-overruled-dot-gen804)
   (depends-on declare is_theft_lv2 lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule3] ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen50 ) ( negative-overruled $?gen51 & : ( subseq-pos ( create$ rule3-overruled $?gen50 $$$ $?gen51 ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) ( not ( and ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen47 <- ( is_theft_lv2 ( positive-defeated $?gen49 & : ( not ( member$ rule3 $?gen49 ) ) ) ) ) ) => ( calc ( bind $?gen52 ( delete-member$ $?gen51 ( create$ rule3-overruled $?gen50 ) ) ) ) ?gen47 <- ( is_theft_lv2 ( negative-overruled $?gen52 ) )"))

([rule3-overruled] of derived-attribute-rule
   (pos-name rule3-overruled-gen806)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule3] ) ) ) ?gen54 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen53 & : ( >= ?gen53 1 ) ) ) ?gen56 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen55 & : ( >= ?gen55 1 ) ) ) ?gen58 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen57 & : ( >= ?gen57 1 ) ) ) ?gen60 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ( positive ?gen59 & : ( >= ?gen59 1 ) ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( negative-support $?gen50 ) ( negative-overruled $?gen51 & : ( not ( subseq-pos ( create$ rule3-overruled $?gen50 $$$ $?gen51 ) ) ) ) ( positive-defeated $?gen49 & : ( not ( member$ rule3 $?gen49 ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) => ( calc ( bind $?gen52 ( create$ rule3-overruled $?gen50 $?gen51 ) ) ) ?gen47 <- ( is_theft_lv2 ( negative-overruled $?gen52 ) )"))

([rule3-support] of derived-attribute-rule
   (pos-name rule3-support-gen808)
   (depends-on declare lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule3] ) ) ) ?gen43 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen44 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen45 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen46 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ) ?gen47 <- ( is_theft_lv2 ( defendant ?Defendant ) ( positive-support $?gen49 & : ( not ( subseq-pos ( create$ rule3 ?gen43 ?gen44 ?gen45 ?gen46 $$$ $?gen49 ) ) ) ) ) ( test ( eq ( class ?gen47 ) is_theft_lv2 ) ) => ( calc ( bind $?gen52 ( create$ rule3 ?gen43 ?gen44 ?gen45 ?gen46 $?gen49 ) ) ) ?gen47 <- ( is_theft_lv2 ( positive-support $?gen52 ) )"))

([rule2-defeasibly-dot] of derived-attribute-rule
   (pos-name rule2-defeasibly-dot-gen810)
   (depends-on declare is_theft_lv1 lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule2] ) ) ) ?gen35 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 1 ) ( negative-derivator rule2 $? ) ) ( test ( eq ( class ?gen35 ) is_theft_lv1 ) ) ( not ( and ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ?gen35 <- ( is_theft_lv1 ( positive ~ 2 ) ( negative-overruled $?gen37 & : ( not ( member$ rule2 $?gen37 ) ) ) ) ) ) => ?gen35 <- ( is_theft_lv1 ( negative 0 ) )"))

([rule2-defeasibly] of derived-attribute-rule
   (pos-name rule2-defeasibly-gen812)
   (depends-on declare lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule2] ) ) ) ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ?gen35 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative 0 ) ( positive ~ 2 ) ( negative-overruled $?gen37 & : ( not ( member$ rule2 $?gen37 ) ) ) ) ( test ( eq ( class ?gen35 ) is_theft_lv1 ) ) => ?gen35 <- ( is_theft_lv1 ( negative 1 ) ( negative-derivator rule2 ?gen42 ) )"))

([rule2-overruled-dot] of derived-attribute-rule
   (pos-name rule2-overruled-dot-gen814)
   (depends-on declare is_theft_lv1 lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule2] ) ) ) ?gen35 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen38 ) ( positive-overruled $?gen39 & : ( subseq-pos ( create$ rule2-overruled $?gen38 $$$ $?gen39 ) ) ) ) ( test ( eq ( class ?gen35 ) is_theft_lv1 ) ) ( not ( and ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ?gen35 <- ( is_theft_lv1 ( negative-defeated $?gen37 & : ( not ( member$ rule2 $?gen37 ) ) ) ) ) ) => ( calc ( bind $?gen40 ( delete-member$ $?gen39 ( create$ rule2-overruled $?gen38 ) ) ) ) ?gen35 <- ( is_theft_lv1 ( positive-overruled $?gen40 ) )"))

([rule2-overruled] of derived-attribute-rule
   (pos-name rule2-overruled-gen816)
   (depends-on declare lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule2] ) ) ) ?gen42 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ( positive ?gen41 & : ( >= ?gen41 1 ) ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ?gen35 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen38 ) ( positive-overruled $?gen39 & : ( not ( subseq-pos ( create$ rule2-overruled $?gen38 $$$ $?gen39 ) ) ) ) ( negative-defeated $?gen37 & : ( not ( member$ rule2 $?gen37 ) ) ) ) ( test ( eq ( class ?gen35 ) is_theft_lv1 ) ) => ( calc ( bind $?gen40 ( create$ rule2-overruled $?gen38 $?gen39 ) ) ) ?gen35 <- ( is_theft_lv1 ( positive-overruled $?gen40 ) )"))

([rule2-support] of derived-attribute-rule
   (pos-name rule2-support-gen818)
   (depends-on declare lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule2] ) ) ) ?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ?gen35 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen37 & : ( not ( subseq-pos ( create$ rule2 ?gen33 $$$ $?gen37 ) ) ) ) ) ( test ( eq ( class ?gen35 ) is_theft_lv1 ) ) => ( calc ( bind $?gen40 ( create$ rule2 ?gen33 $?gen37 ) ) ) ?gen35 <- ( is_theft_lv1 ( negative-support $?gen40 ) )"))

([rule1-defeasibly-dot] of derived-attribute-rule
   (pos-name rule1-defeasibly-dot-gen820)
   (depends-on declare is_theft_lv1 lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -1 [rule1] ) ) ) ?gen21 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive 1 ) ( positive-derivator rule1 $? ) ) ( test ( eq ( class ?gen21 ) is_theft_lv1 ) ) ( not ( and ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen27 & : ( >= ?gen27 1 ) ) ) ?gen30 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen29 & : ( >= ?gen29 1 ) ) ) ?gen32 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen31 & : ( >= ?gen31 1 ) ) ) ?gen21 <- ( is_theft_lv1 ( negative ~ 2 ) ( positive-overruled $?gen23 & : ( not ( member$ rule1 $?gen23 ) ) ) ) ) ) => ?gen21 <- ( is_theft_lv1 ( positive 0 ) )"))

([rule1-defeasibly] of derived-attribute-rule
   (pos-name rule1-defeasibly-gen822)
   (depends-on declare lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 1 [rule1] ) ) ) ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen27 & : ( >= ?gen27 1 ) ) ) ?gen30 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen29 & : ( >= ?gen29 1 ) ) ) ?gen32 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen31 & : ( >= ?gen31 1 ) ) ) ?gen21 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive 0 ) ( negative ~ 2 ) ( positive-overruled $?gen23 & : ( not ( member$ rule1 $?gen23 ) ) ) ) ( test ( eq ( class ?gen21 ) is_theft_lv1 ) ) => ?gen21 <- ( is_theft_lv1 ( positive 1 ) ( positive-derivator rule1 ?gen28 ?gen30 ?gen32 ) )"))

([rule1-overruled-dot] of derived-attribute-rule
   (pos-name rule1-overruled-dot-gen824)
   (depends-on declare is_theft_lv1 lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority -2 [rule1] ) ) ) ?gen21 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen24 ) ( negative-overruled $?gen25 & : ( subseq-pos ( create$ rule1-overruled $?gen24 $$$ $?gen25 ) ) ) ) ( test ( eq ( class ?gen21 ) is_theft_lv1 ) ) ( not ( and ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen27 & : ( >= ?gen27 1 ) ) ) ?gen30 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen29 & : ( >= ?gen29 1 ) ) ) ?gen32 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen31 & : ( >= ?gen31 1 ) ) ) ?gen21 <- ( is_theft_lv1 ( positive-defeated $?gen23 & : ( not ( member$ rule1 $?gen23 ) ) ) ) ) ) => ( calc ( bind $?gen26 ( delete-member$ $?gen25 ( create$ rule1-overruled $?gen24 ) ) ) ) ?gen21 <- ( is_theft_lv1 ( negative-overruled $?gen26 ) )"))

([rule1-overruled] of derived-attribute-rule
   (pos-name rule1-overruled-gen826)
   (depends-on declare lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 2 [rule1] ) ) ) ?gen28 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ( positive ?gen27 & : ( >= ?gen27 1 ) ) ) ?gen30 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ( positive ?gen29 & : ( >= ?gen29 1 ) ) ) ?gen32 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ( positive ?gen31 & : ( >= ?gen31 1 ) ) ) ?gen21 <- ( is_theft_lv1 ( defendant ?Defendant ) ( negative-support $?gen24 ) ( negative-overruled $?gen25 & : ( not ( subseq-pos ( create$ rule1-overruled $?gen24 $$$ $?gen25 ) ) ) ) ( positive-defeated $?gen23 & : ( not ( member$ rule1 $?gen23 ) ) ) ) ( test ( eq ( class ?gen21 ) is_theft_lv1 ) ) => ( calc ( bind $?gen26 ( create$ rule1-overruled $?gen24 $?gen25 ) ) ) ?gen21 <- ( is_theft_lv1 ( negative-overruled $?gen26 ) )"))

([rule1-support] of derived-attribute-rule
   (pos-name rule1-support-gen828)
   (depends-on declare lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (del-name nil)
   (derived-attribute-rule "( declare ( priority ( calc-defeasible-priority 5 [rule1] ) ) ) ?gen18 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen19 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen20 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen21 <- ( is_theft_lv1 ( defendant ?Defendant ) ( positive-support $?gen23 & : ( not ( subseq-pos ( create$ rule1 ?gen18 ?gen19 ?gen20 $$$ $?gen23 ) ) ) ) ) ( test ( eq ( class ?gen21 ) is_theft_lv1 ) ) => ( calc ( bind $?gen26 ( create$ rule1 ?gen18 ?gen19 ?gen20 $?gen23 ) ) ) ?gen21 <- ( is_theft_lv1 ( positive-support $?gen26 ) )"))

([pen_lv6_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv6_min-deductive-gen425)
   (depends-on is_theft_lv6 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen383 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 10 ) ) ) => ( min_imprisonment ( value 10 ) )")
   (production-rule "( defrule pen_lv6_min-deductive-gen425 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen383 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 10 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 10 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 10 ) ) ) ( make-instance ?oid of min_imprisonment ( value 10 ) ) )")
   (derived-class min_imprisonment))

([pen_lv5_max-deductive] of ntm-deductive-rule
   (pos-name pen_lv5_max-deductive-gen424)
   (depends-on is_theft_lv5 max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen374 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 15 ) ) ) => ( max_imprisonment ( value 15 ) )")
   (production-rule "( defrule pen_lv5_max-deductive-gen424 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen374 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 15 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 15 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 15 ) ) ) ( make-instance ?oid of max_imprisonment ( value 15 ) ) )")
   (derived-class max_imprisonment))

([pen_lv5_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv5_min-deductive-gen423)
   (depends-on is_theft_lv5 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen365 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 3 ) ) ) => ( min_imprisonment ( value 3 ) )")
   (production-rule "( defrule pen_lv5_min-deductive-gen423 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen365 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 3 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 3 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 3 ) ) ) ( make-instance ?oid of min_imprisonment ( value 3 ) ) )")
   (derived-class min_imprisonment))

([pen_lv4_max-deductive] of ntm-deductive-rule
   (pos-name pen_lv4_max-deductive-gen422)
   (depends-on is_theft_lv4 max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen356 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 8 ) ) ) => ( max_imprisonment ( value 8 ) )")
   (production-rule "( defrule pen_lv4_max-deductive-gen422 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen356 ) ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 8 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ( make-instance ?oid of max_imprisonment ( value 8 ) ) )")
   (derived-class max_imprisonment))

([pen_lv4_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv4_min-deductive-gen421)
   (depends-on is_theft_lv4 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen347 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_lv4_min-deductive-gen421 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen347 ) ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_lv3_max-deductive] of ntm-deductive-rule
   (pos-name pen_lv3_max-deductive-gen420)
   (depends-on is_theft_lv3 max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen338 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 10 ) ) ) => ( max_imprisonment ( value 10 ) )")
   (production-rule "( defrule pen_lv3_max-deductive-gen420 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen338 ) ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 10 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 10 ) ) ) ( make-instance ?oid of max_imprisonment ( value 10 ) ) )")
   (derived-class max_imprisonment))

([pen_lv3_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv3_min-deductive-gen419)
   (depends-on is_theft_lv3 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen329 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 2 ) ) ) => ( min_imprisonment ( value 2 ) )")
   (production-rule "( defrule pen_lv3_min-deductive-gen419 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen329 ) ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 2 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 2 ) ) ) ( make-instance ?oid of min_imprisonment ( value 2 ) ) )")
   (derived-class min_imprisonment))

([pen_lv2_max-deductive] of ntm-deductive-rule
   (pos-name pen_lv2_max-deductive-gen418)
   (depends-on is_theft_lv2 max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen320 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 8 ) ) ) => ( max_imprisonment ( value 8 ) )")
   (production-rule "( defrule pen_lv2_max-deductive-gen418 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen320 ) ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 8 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 8 ) ) ) ( make-instance ?oid of max_imprisonment ( value 8 ) ) )")
   (derived-class max_imprisonment))

([pen_lv2_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv2_min-deductive-gen417)
   (depends-on is_theft_lv2 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen311 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 1 ) ) ) => ( min_imprisonment ( value 1 ) )")
   (production-rule "( defrule pen_lv2_min-deductive-gen417 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen311 ) ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 1 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 1 ) ) ) ( make-instance ?oid of min_imprisonment ( value 1 ) ) )")
   (derived-class min_imprisonment))

([pen_lv1_max-deductive] of ntm-deductive-rule
   (pos-name pen_lv1_max-deductive-gen416)
   (depends-on is_theft_lv1 max_imprisonment)
   (implies max_imprisonment)
   (deductive-rule "?gen302 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ( not ( max_imprisonment ( value 3 ) ) ) => ( max_imprisonment ( value 3 ) )")
   (production-rule "( defrule pen_lv1_max-deductive-gen416 ( declare ( salience ( calc-salience max_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen302 ) ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ( not ( object ( is-a max_imprisonment ) ( value 3 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat max_imprisonment 3 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat max_imprisonment 3 ) ) ) ( make-instance ?oid of max_imprisonment ( value 3 ) ) )")
   (derived-class max_imprisonment))

([pen_lv1_min-deductive] of ntm-deductive-rule
   (pos-name pen_lv1_min-deductive-gen415)
   (depends-on is_theft_lv1 min_imprisonment)
   (implies min_imprisonment)
   (deductive-rule "?gen293 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ( not ( min_imprisonment ( value 0 ) ) ) => ( min_imprisonment ( value 0 ) )")
   (production-rule "( defrule pen_lv1_min-deductive-gen415 ( declare ( salience ( calc-salience min_imprisonment ) ) ) ( run-deductive-rules ) ( object ( name ?gen293 ) ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ( not ( object ( is-a min_imprisonment ) ( value 0 ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat min_imprisonment 0 ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat min_imprisonment 0 ) ) ) ( make-instance ?oid of min_imprisonment ( value 0 ) ) )")
   (derived-class min_imprisonment))

([pen_lv1_monetary-deductive] of ntm-deductive-rule
   (pos-name pen_lv1_monetary-deductive-gen414)
   (depends-on is_theft_lv1 monetary_penalty)
   (implies monetary_penalty)
   (deductive-rule "?gen284 <- ( is_theft_lv1 ( defendant ?Defendant ) ) ( not ( monetary_penalty ( value True ) ) ) => ( monetary_penalty ( value True ) )")
   (production-rule "( defrule pen_lv1_monetary-deductive-gen414 ( declare ( salience ( calc-salience monetary_penalty ) ) ) ( run-deductive-rules ) ( object ( name ?gen284 ) ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ( not ( object ( is-a monetary_penalty ) ( value True ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat monetary_penalty True ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat monetary_penalty True ) ) ) ( make-instance ?oid of monetary_penalty ( value True ) ) )")
   (derived-class monetary_penalty))

([rule22-deductive] of ntm-deductive-rule
   (pos-name rule22-deductive-gen413)
   (depends-on is_theft_lv6 is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen275 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule22-deductive-gen413 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen275 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule21-deductive] of ntm-deductive-rule
   (pos-name rule21-deductive-gen412)
   (depends-on is_theft_lv6 is_theft_lv2)
   (implies is_theft_lv2)
   (deductive-rule "?gen266 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( is_theft_lv2 ( defendant ?Defendant ) ) ) => ( is_theft_lv2 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule21-deductive-gen412 ( declare ( salience ( calc-salience is_theft_lv2 ) ) ) ( run-deductive-rules ) ( object ( name ?gen266 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv2 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv2))

([rule20-deductive] of ntm-deductive-rule
   (pos-name rule20-deductive-gen411)
   (depends-on is_theft_lv6 is_theft_lv3)
   (implies is_theft_lv3)
   (deductive-rule "?gen257 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( is_theft_lv3 ( defendant ?Defendant ) ) ) => ( is_theft_lv3 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule20-deductive-gen411 ( declare ( salience ( calc-salience is_theft_lv3 ) ) ) ( run-deductive-rules ) ( object ( name ?gen257 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv3 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv3))

([rule19-deductive] of ntm-deductive-rule
   (pos-name rule19-deductive-gen410)
   (depends-on is_theft_lv6 is_theft_lv4)
   (implies is_theft_lv4)
   (deductive-rule "?gen248 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( is_theft_lv4 ( defendant ?Defendant ) ) ) => ( is_theft_lv4 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule19-deductive-gen410 ( declare ( salience ( calc-salience is_theft_lv4 ) ) ) ( run-deductive-rules ) ( object ( name ?gen248 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv4 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv4))

([rule18-deductive] of ntm-deductive-rule
   (pos-name rule18-deductive-gen409)
   (depends-on is_theft_lv6 is_theft_lv5)
   (implies is_theft_lv5)
   (deductive-rule "?gen239 <- ( is_theft_lv6 ( defendant ?Defendant ) ) ( not ( is_theft_lv5 ( defendant ?Defendant ) ) ) => ( is_theft_lv5 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule18-deductive-gen409 ( declare ( salience ( calc-salience is_theft_lv5 ) ) ) ( run-deductive-rules ) ( object ( name ?gen239 ) ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv5 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv5 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv5 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv5))

([rule17-deductive] of ntm-deductive-rule
   (pos-name rule17-deductive-gen408)
   (depends-on lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv6)
   (implies is_theft_lv6)
   (deductive-rule "?gen215 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen216 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen217 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen218 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen219 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ?gen220 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ) ( not ( is_theft_lv6 ( defendant ?Defendant ) ) ) => ( is_theft_lv6 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule17-deductive-gen408 ( declare ( salience ( calc-salience is_theft_lv6 ) ) ) ( run-deductive-rules ) ( object ( name ?gen215 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen216 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen217 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( object ( name ?gen218 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ( object ( name ?gen219 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ( object ( name ?gen220 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:death_caused \"true\" ) ) ( not ( object ( is-a is_theft_lv6 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv6 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv6 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv6 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv6))

([rule16-deductive] of ntm-deductive-rule
   (pos-name rule16-deductive-gen407)
   (depends-on is_theft_lv5 is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen206 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule16-deductive-gen407 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen206 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule15-deductive] of ntm-deductive-rule
   (pos-name rule15-deductive-gen406)
   (depends-on is_theft_lv5 is_theft_lv2)
   (implies is_theft_lv2)
   (deductive-rule "?gen197 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( is_theft_lv2 ( defendant ?Defendant ) ) ) => ( is_theft_lv2 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule15-deductive-gen406 ( declare ( salience ( calc-salience is_theft_lv2 ) ) ) ( run-deductive-rules ) ( object ( name ?gen197 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv2 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv2))

([rule14-deductive] of ntm-deductive-rule
   (pos-name rule14-deductive-gen405)
   (depends-on is_theft_lv5 is_theft_lv3)
   (implies is_theft_lv3)
   (deductive-rule "?gen188 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( is_theft_lv3 ( defendant ?Defendant ) ) ) => ( is_theft_lv3 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule14-deductive-gen405 ( declare ( salience ( calc-salience is_theft_lv3 ) ) ) ( run-deductive-rules ) ( object ( name ?gen188 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv3 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv3))

([rule13-deductive] of ntm-deductive-rule
   (pos-name rule13-deductive-gen404)
   (depends-on is_theft_lv5 is_theft_lv4)
   (implies is_theft_lv4)
   (deductive-rule "?gen179 <- ( is_theft_lv5 ( defendant ?Defendant ) ) ( not ( is_theft_lv4 ( defendant ?Defendant ) ) ) => ( is_theft_lv4 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule13-deductive-gen404 ( declare ( salience ( calc-salience is_theft_lv4 ) ) ) ( run-deductive-rules ) ( object ( name ?gen179 ) ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv4 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv4))

([rule12-deductive] of ntm-deductive-rule
   (pos-name rule12-deductive-gen403)
   (depends-on lc:case lc:case lc:case lc:case lc:case lc:case is_theft_lv5)
   (implies is_theft_lv5)
   (deductive-rule "?gen155 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen156 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen157 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen158 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen159 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ?gen160 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ) ( not ( is_theft_lv5 ( defendant ?Defendant ) ) ) => ( is_theft_lv5 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule12-deductive-gen403 ( declare ( salience ( calc-salience is_theft_lv5 ) ) ) ( run-deductive-rules ) ( object ( name ?gen155 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen156 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen157 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( object ( name ?gen158 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ( object ( name ?gen159 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ( object ( name ?gen160 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:caused_severe_injury \"true\" ) ) ( not ( object ( is-a is_theft_lv5 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv5 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv5 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv5 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv5))

([rule11-deductive] of ntm-deductive-rule
   (pos-name rule11-deductive-gen402)
   (depends-on is_theft_lv4 is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen146 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule11-deductive-gen402 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen146 ) ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule10-deductive] of ntm-deductive-rule
   (pos-name rule10-deductive-gen401)
   (depends-on is_theft_lv4 is_theft_lv2)
   (implies is_theft_lv2)
   (deductive-rule "?gen137 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ( not ( is_theft_lv2 ( defendant ?Defendant ) ) ) => ( is_theft_lv2 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule10-deductive-gen401 ( declare ( salience ( calc-salience is_theft_lv2 ) ) ) ( run-deductive-rules ) ( object ( name ?gen137 ) ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv2 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv2))

([rule9-deductive] of ntm-deductive-rule
   (pos-name rule9-deductive-gen400)
   (depends-on is_theft_lv4 is_theft_lv3)
   (implies is_theft_lv3)
   (deductive-rule "?gen128 <- ( is_theft_lv4 ( defendant ?Defendant ) ) ( not ( is_theft_lv3 ( defendant ?Defendant ) ) ) => ( is_theft_lv3 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule9-deductive-gen400 ( declare ( salience ( calc-salience is_theft_lv3 ) ) ) ( run-deductive-rules ) ( object ( name ?gen128 ) ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv3 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv3))

([rule8-deductive] of ntm-deductive-rule
   (pos-name rule8-deductive-gen399)
   (depends-on lc:case lc:case lc:case lc:case lc:case is_theft_lv4)
   (implies is_theft_lv4)
   (deductive-rule "?gen107 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen108 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen109 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen110 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ?gen111 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ( not ( is_theft_lv4 ( defendant ?Defendant ) ) ) => ( is_theft_lv4 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule8-deductive-gen399 ( declare ( salience ( calc-salience is_theft_lv4 ) ) ) ( run-deductive-rules ) ( object ( name ?gen107 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen108 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen109 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( object ( name ?gen110 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:caught_in_the_act \"true\" ) ) ( object ( name ?gen111 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:use_of_force_or_threat \"true\" ) ) ( not ( object ( is-a is_theft_lv4 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv4 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv4 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv4))

([rule7-deductive] of ntm-deductive-rule
   (pos-name rule7-deductive-gen398)
   (depends-on is_theft_lv3 is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen98 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule7-deductive-gen398 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen98 ) ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule6-deductive] of ntm-deductive-rule
   (pos-name rule6-deductive-gen397)
   (depends-on is_theft_lv3 is_theft_lv2)
   (implies is_theft_lv2)
   (deductive-rule "?gen89 <- ( is_theft_lv3 ( defendant ?Defendant ) ) ( not ( is_theft_lv2 ( defendant ?Defendant ) ) ) => ( is_theft_lv2 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule6-deductive-gen397 ( declare ( salience ( calc-salience is_theft_lv2 ) ) ) ( run-deductive-rules ) ( object ( name ?gen89 ) ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv2 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv2))

([rule5-deductive] of ntm-deductive-rule
   (pos-name rule5-deductive-gen396)
   (depends-on lc:case lc:case lc:case lc:case is_theft_lv3)
   (implies is_theft_lv3)
   (deductive-rule "?gen70 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen71 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen72 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen73 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ( not ( is_theft_lv3 ( defendant ?Defendant ) ) ) => ( is_theft_lv3 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule5-deductive-gen396 ( declare ( salience ( calc-salience is_theft_lv3 ) ) ) ( run-deductive-rules ) ( object ( name ?gen70 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen71 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen72 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( object ( name ?gen73 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( > ?value_of_stolen_items 30000 ) ) ( not ( object ( is-a is_theft_lv3 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv3 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv3 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv3))

([rule4-deductive] of ntm-deductive-rule
   (pos-name rule4-deductive-gen395)
   (depends-on is_theft_lv2 is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen61 <- ( is_theft_lv2 ( defendant ?Defendant ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule4-deductive-gen395 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen61 ) ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule3-deductive] of ntm-deductive-rule
   (pos-name rule3-deductive-gen394)
   (depends-on lc:case lc:case lc:case lc:case is_theft_lv2)
   (implies is_theft_lv2)
   (deductive-rule "?gen43 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen44 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen45 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ?gen46 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ) ( not ( is_theft_lv2 ( defendant ?Defendant ) ) ) => ( is_theft_lv2 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule3-deductive-gen394 ( declare ( salience ( calc-salience is_theft_lv2 ) ) ) ( run-deductive-rules ) ( object ( name ?gen43 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen44 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen45 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( object ( name ?gen46 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:breaking_and_entering \"true\" ) ) ( not ( object ( is-a is_theft_lv2 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv2 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv2 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv2))

([rule2-deductive] of ntm-deductive-rule
   (pos-name rule2-deductive-gen393)
   (depends-on lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen33 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule2-deductive-gen393 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen33 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:value_of_stolen_items ?value_of_stolen_items ) ) ( test ( <= ?value_of_stolen_items 150 ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

([rule1-deductive] of ntm-deductive-rule
   (pos-name rule1-deductive-gen392)
   (depends-on lc:case lc:case lc:case is_theft_lv1)
   (implies is_theft_lv1)
   (deductive-rule "?gen18 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ?gen19 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ?gen20 <- ( lc:case ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( not ( is_theft_lv1 ( defendant ?Defendant ) ) ) => ( is_theft_lv1 ( defendant ?Defendant ) )")
   (production-rule "( defrule rule1-deductive-gen392 ( declare ( salience ( calc-salience is_theft_lv1 ) ) ) ( run-deductive-rules ) ( object ( name ?gen18 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_movable_property \"true\" ) ) ( object ( name ?gen19 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:is_taken \"true\" ) ) ( object ( name ?gen20 ) ( is-a lc:case ) ( lc:defendant ?Defendant ) ( lc:intent_to_appropriate \"true\" ) ) ( not ( object ( is-a is_theft_lv1 ) ( defendant ?Defendant ) ) ) ( test ( not ( instance-existp ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ) ) => ( bind ?oid ( symbol-to-instance-name ( sym-cat is_theft_lv1 ?Defendant ) ) ) ( make-instance ?oid of is_theft_lv1 ( defendant ?Defendant ) ) )")
   (derived-class is_theft_lv1))

