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

(deffunction AGENT::calcLeft ()
    (bind ?score 0)
    (do-for-all-facts 
        ((?p priority))
        (eq (fact-slot-value ?p dir) left)
        (bind ?score (+ ?score (fact-slot-value ?p val)))
        ;(printout t "left " ?score crlf)
    )
	;(printout t " total left " ?score crlf)
    (return ?score)
)

(deffunction AGENT::calcAhead ()
    (bind ?score 0)
    (do-for-all-facts 
        ((?p priority))
        (eq (fact-slot-value ?p dir) ahead)
        (bind ?score (+ ?score (fact-slot-value ?p val)))
        ;(printout t "ahead " ?score crlf)
    )
	;(printout t " total ahead " ?score crlf)
    (return ?score)
)


;;criteriu 1 - in functie de numarul de femei

(defrule AGENT::gender1
	(declare (salience 12))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test 
		(and
			(and 
				(not (eq ?ev1 ?ev2)) 
				(not (= (calcWomen ?ev1) (calcWomen ?ev2)))
				)
			(> (calcWomen ?ev1) (calcWomen ?ev2) )
		))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(printout t " gender left " ?ev1 ?ev2 crlf)
	(assert (priority (dir left) (val ?*gender_priority*)))
)

(defrule AGENT::gender2
	(declare (salience 12))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test 
		(and
			(and 
				(not (eq ?ev1 ?ev2)) 
				(not (= (calcWomen ?ev1) (calcWomen ?ev2)))
				)
			(< (calcWomen ?ev1) (calcWomen ?ev2) )
		))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(printout t " gender left " ?ev1 ?ev2 crlf)
	(assert (priority (dir ahead) (val ?*gender_priority*)))
)

;;criteriul 2 - femei insarcinate

(defrule AGENT::pregnant1
	(declare (salience 10))
	(timp (valoare ?t))
     ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcPregnant ?ev1) (calcPregnant ?ev2))))(> (calcPregnant ?ev1) (calcPregnant ?ev2) )))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(printout t " pregnant left"  crlf)
	(assert (priority (dir left) (val ?*pregnant_priority*)))
)

(defrule AGENT::pregnant2
	(declare (salience 9))
	(timp (valoare ?t))
     ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcPregnant ?ev1) (calcPregnant ?ev2))))(< (calcPregnant ?ev1) (calcPregnant ?ev2) )))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1))))
	(printout t " pregnant ahead"  crlf)
	(assert (priority (dir ahead) (val ?*pregnant_priority*)))
)

;;criteriu 3 - in functie de varsta

(defrule AGENT::age1
	(declare (salience 8))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcAge ?ev1) (calcAge ?ev2))))(< (calcAge ?ev1) (calcAge ?ev2))))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1)))
	(assert (priority (dir left) (val ?*age_priority*)))
	(printout t " age left"  crlf)
	;daca varsta primului grup de oameni e mai mica decat varsta celui de-al doilea grup, directia -> ahead
)

(defrule AGENT::age2
	(declare (salience 7))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcAge ?ev1) (calcAge ?ev2))))(> (calcAge ?ev1) (calcAge ?ev2))))
        
=>	
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(assert (priority (dir ahead) (val ?*age_priority*)))
	(printout t " age ahead"  crlf)
	;daca varsta primului grup de oameni e mai mica decat varsta celui de-al doilea grup, directia -> left
)


;criteriu 4 - in functie de culoarea semaforului



(defrule AGENT::red_light1
	(declare (salience 6))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	?sem1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname sem) (bel_pval ?s1)) ;culoarea semaforului din evenimentul 1
	?sem2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname sem) (bel_pval ?s2)) ;culoarea semaforului din evenimentul 2

	(test (and(and (not (eq ?ev1 ?ev2)) (not (eq ?s1 ?s2)))(eq ?s1 red)))
        
=>	
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1)))
	(assert (priority (dir ahead) (val ?*red_priority*)))
	(printout t " red ahead"  crlf)
	
)

(defrule AGENT::red_light2
	(declare (salience 5))
	(timp (valoare ?t))
	?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	?sem1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname sem) (bel_pval ?s1)) ;culoarea semaforului din evenimentul 1
	?sem2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname sem) (bel_pval ?s2)) ;culoarea semaforului din evenimentul 2

	(test (and(and (not (eq ?ev1 ?ev2)) (not (eq ?s1 ?s2)))(eq ?s2 red)))
        
=>	
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(assert (priority (dir left) (val ?*red_priority*)))
	(printout t " red left"  crlf)
	
)


;;criteriu 5 - in functie de fizic

(defrule AGENT::fat1
	(declare (salience 4))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcFat ?ev1) (calcFat ?ev2))))(> (calcFat ?ev1) (calcFat ?ev2) )))
        
=>	
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir2)))
	(assert (priority (dir left) (val ?*fat_priority*)))
	(printout t " fat left"  crlf)
)

(defrule AGENT::fat2
	(declare (salience 3))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcFat ?ev1) (calcFat ?ev2))))(< (calcFat ?ev1) (calcFat ?ev2) )))
        
=>
	;(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ?dir1))))
	(assert (priority (dir ahead) (val ?*fat_priority*)))
	(printout t " fac ahead"  crlf)
)

;;calculeaza ponderea deciziilor
(defrule AGENT::decision1
	(declare (salience -10))
	(timp (valoare ?t))
    ?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (and(and (not (eq ?ev1 ?ev2)) (not (= (calcAhead) (calcLeft))))(< (calcAhead) (calcLeft ))))
=>
	(retract ?id1)
	(retract ?id2)
	(printout t "left decision" crlf)
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval left)))
)

(defrule AGENT::decision2
	(declare (salience -11))
	(timp (valoare ?t))
	?id1<-(ag_bel (bel_type moment) (bel_pobj ?ev1) (bel_pname direction) (bel_pval ahead))
	?id2<-(ag_bel (bel_type moment) (bel_pobj ?ev2) (bel_pname direction) (bel_pval left))
	(test (not (eq ?ev1 ?ev2)))
=>
	(retract ?id1)
	(retract ?id2)
	(printout t "ahead decision" crlf)
	(assert (ag_bel (bel_type moment) (bel_pname manuever_go) (bel_pval ahead)))
)