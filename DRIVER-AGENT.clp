(deffunction AGENT::calcAge (?ev)
	(bind ?sum 0)
	(do-for-all-facts ((?f ag_percept)) (and (eq ?f:percept_pval ?ev) (eq ?f:percept_pname partof))
		(do-for-all-facts ((?ff ag_percept)) (and (eq ?ff:percept_pobj ?f:percept_pobj) (eq ?ff:percept_pname age))	
			(bind ?sum (+ ?sum ?ff:percept_pval))
		)
	)	
	(return ?sum)
)

(deffunction AGENT::calcWomen (?ev)
	(bind ?quan 0)
	(do-for-all-facts ((?f ag_percept)) (and (eq ?f:percept_pval ?ev) (eq ?f:percept_pname partof))
		(do-for-all-facts ((?ff ag_percept)) (and (eq ?ff:percept_pobj ?f:percept_pobj) (and (eq ?ff:percept_pname gen) (eq ?ff:percept_pval f)))	
			(bind ?quan (+ ?quan 1))
		)
	)	
	(return ?quan)
)


(deffunction AGENT::calcPregnant (?ev)
	(bind ?quan 0)
	(do-for-all-facts ((?f ag_percept)) (and (eq ?f:percept_pval ?ev) (eq ?f:percept_pname partof))
		(do-for-all-facts ((?ff ag_percept)) (and (eq ?ff:percept_pobj ?f:percept_pobj) (and (eq ?ff:percept_pname physical) (eq ?ff:percept_pval pregnant)))	
			(bind ?quan (+ ?quan 1))
		)
	)	
	(return ?quan)
)


(deffunction AGENT::calcFat (?ev)
	(bind ?quan 0)
	(do-for-all-facts ((?f ag_percept)) (and (eq ?f:percept_pval ?ev) (eq ?f:percept_pname partof))
		(do-for-all-facts ((?ff ag_percept)) (and (eq ?ff:percept_pobj ?f:percept_pobj) (and (eq ?ff:percept_pname physical) (eq ?ff:percept_pval fat)))	
			(bind ?quan (+ ?quan 1))
		)
	)	
	(return ?quan)
)





;;criteriu 1 - in functie de numarul de femei

(defrule AGENT::gender1
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcWomen ?ev1) (calcWomen ?ev2))))(> (calcWomen ?ev1) (calcWomen ?ev2) )))
        
=>
	(retract ?id1)
    (retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir2)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
)

(defrule AGENT::gender2
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcWomen ?ev1) (calcWomen ?ev2))))(< (calcWomen ?ev1) (calcWomen ?ev2) )))
        
=>
	(retract ?id1)
	(retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir1)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1))))
)

;;criteriul 2 - femei insarcinate

(defrule AGENT::pregnant1
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcPregnant ?ev1) (calcPregnant ?ev2))))(> (calcPregnant ?ev1) (calcPregnant ?ev2) )))
        
=>
	(retract ?id1)
    (retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir2)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
)

(defrule AGENT::pregnant2
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcPregnant ?ev1) (calcPregnant ?ev2))))(< (calcPregnant ?ev1) (calcPregnant ?ev2) )))
        
=>
	(retract ?id1)
	(retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir1)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1))))
)

;;criteriu 3 - in functie de varsta

(defrule AGENT::age1
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcAge ?ev1) (calcAge ?ev2))))(< (calcAge ?ev1) (calcAge ?ev2))))
        
=>
	(retract ?id1)
    (retract ?id2)	
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1)))
	;daca varsta primului grup de oameni e mai mica decat varsta celui de-al doilea grup, directia -> ahead
)

(defrule AGENT::age2
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcAge ?ev1) (calcAge ?ev2))))(> (calcAge ?ev1) (calcAge ?ev2))))
        
=>
	(retract ?id1)
    (retract ?id2)	
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	;daca varsta primului grup de oameni e mai mica decat varsta celui de-al doilea grup, directia -> left
)


;criteriu 4 - in functie de culoarea semaforului

(defrule AGENT::red_light
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	?sem1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname sem) (bel_pval ?s1)) ;culoarea semaforului din evenimentul 1
	?sem2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname sem) (bel_pval ?s2)) ;culoarea semaforului din evenimentul 2

	(test (and (not (eq ?ev1 ?ev2)) (not (eq ?s1 ?s2))))
        
=>
	(if (eq ?s1 red) then
	(retract ?id1)
    (retract ?id2)	
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1)))
	else 
		(if (eq ?s2 red)then
			(retract ?id1)
        	(retract ?id2)	
			(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2))))
		)
)

(defrule AGENT::red_light1
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	?sem1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname sem) (bel_pval ?s1)) ;culoarea semaforului din evenimentul 1
	?sem2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname sem) (bel_pval ?s2)) ;culoarea semaforului din evenimentul 2

	(test (and(and (not (eq ?ev1 ?ev2)) (not (eq ?s1 ?s2)))(eq ?s1 red)))
        
=>
	(retract ?id1)
    (retract ?id2)	
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1)))
	
)

(defrule AGENT::red_light2
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	?sem1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname sem) (bel_pval ?s1)) ;culoarea semaforului din evenimentul 1
	?sem2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname sem) (bel_pval ?s2)) ;culoarea semaforului din evenimentul 2

	(test (and(and (not (eq ?ev1 ?ev2)) (not (eq ?s1 ?s2)))(eq ?s2 red)))
        
=>
	(retract ?id1)
    (retract ?id2)	
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	
)


;;criteriu 5 - in functie de fizic

(defrule AGENT::fat1
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcFat ?ev1) (calcFat ?ev2))))(> (calcFat ?ev1) (calcFat ?ev2) )))
        
=>
	(retract ?id1)
    (retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir2)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
)

(defrule AGENT::fat2
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ?dir1))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval ?dir2))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcFat ?ev1) (calcFat ?ev2))))(< (calcFat ?ev1) (calcFat ?ev2) )))
        
=>
	(retract ?id1)
	(retract ?id2)	
	;(assert (ag_bel (bel_pobj maneuver) (bel_pname go) (bel_pval ?dir1)))
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1))))
)

