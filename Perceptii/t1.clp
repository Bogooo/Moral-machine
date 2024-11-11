;Evenimentul 1
(ag_percept (percept_pobj ev1) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev1) (percept_pname direction) (percept_pval ahead))
(ag_percept (percept_pobj ev1) (percept_pname sem) (percept_pval red))


(ag_percept (percept_pobj p1) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p2) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p3) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p4) (percept_pname isa) (percept_pval pedestrian))
;(ag_percept (percept_pobj p5) (percept_pname isa) (percept_pval pedestrian))

(ag_percept (percept_pobj p1) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p2) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p3) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p4) (percept_pname partof) (percept_pval ev1))
;(ag_percept (percept_pobj p5) (percept_pname partof) (percept_pval ev1))

(ag_percept (percept_pobj p1) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj p2) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj p3) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj p4) (percept_pname gen) (percept_pval m))
(ag_percept (percept_pobj p5) (percept_pname gen) (percept_pval m))


(ag_percept (percept_pobj p1) (percept_pname age) (percept_pval 40))
(ag_percept (percept_pobj p2) (percept_pname age) (percept_pval 30))
(ag_percept (percept_pobj p3) (percept_pname age) (percept_pval 25))
(ag_percept (percept_pobj p4) (percept_pname age) (percept_pval 45))
(ag_percept (percept_pobj p5) (percept_pname age) (percept_pval 25))




;Evenimentul 2
(ag_percept (percept_pobj ev2) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev2) (percept_pname direction) (percept_pval left))
(ag_percept (percept_pobj ev2) (percept_pname barrier) (percept_pval exists))

(ag_percept (percept_pobj b1) (percept_pname isa) (percept_pval passenger))
(ag_percept (percept_pobj b2) (percept_pname isa) (percept_pval passenger))
(ag_percept (percept_pobj b3) (percept_pname isa) (percept_pval passenger))
(ag_percept (percept_pobj c1) (percept_pname isa) (percept_pval dog))
(ag_percept (percept_pobj c2) (percept_pname isa) (percept_pval dog))

(ag_percept (percept_pobj b1) (percept_pname partof) (percept_pval ev2))
(ag_percept (percept_pobj b2) (percept_pname partof) (percept_pval ev2))
(ag_percept (percept_pobj b3) (percept_pname partof) (percept_pval ev2))
(ag_percept (percept_pobj c1) (percept_pname partof) (percept_pval ev2))
(ag_percept (percept_pobj c2) (percept_pname partof) (percept_pval ev2))

(ag_percept (percept_pobj b1) (percept_pname gen) (percept_pval m))
(ag_percept (percept_pobj b2) (percept_pname gen) (percept_pval m))
(ag_percept (percept_pobj b3) (percept_pname gen) (percept_pval m))

(ag_percept (percept_pobj b1) (percept_pname age) (percept_pval 60))
(ag_percept (percept_pobj b2) (percept_pname age) (percept_pval 55))
(ag_percept (percept_pobj b3) (percept_pname age) (percept_pval 50))




