;Evenimentul 1
(ag_percept (percept_pobj ev1) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev1) (percept_pname direction) (percept_pval ahead))
(ag_percept (percept_pobj ev1) (percept_pname sem) (percept_pval red))


(ag_percept (percept_pobj p1) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p2) (percept_pname isa) (percept_pval pedestrian))

(ag_percept (percept_pobj p1) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p2) (percept_pname partof) (percept_pval ev1))

(ag_percept (percept_pobj p1) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj p2) (percept_pname gen) (percept_pval m))


(ag_percept (percept_pobj p1) (percept_pname age) (percept_pval 28))
(ag_percept (percept_pobj p2) (percept_pname age) (percept_pval 32))




;Evenimentul 2
(ag_percept (percept_pobj ev2) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev2) (percept_pname direction) (percept_pval left))
(ag_percept (percept_pobj ev2) (percept_pname sem) (percept_pval green))

(ag_percept (percept_pobj b1) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj b2) (percept_pname isa) (percept_pval pedestrian))

(ag_percept (percept_pobj b1) (percept_pname partof) (percept_pval ev2))
(ag_percept (percept_pobj b2) (percept_pname partof) (percept_pval ev2))

(ag_percept (percept_pobj b1) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj b2) (percept_pname gen) (percept_pval m))


(ag_percept (percept_pobj b1) (percept_pname age) (percept_pval 28))
(ag_percept (percept_pobj b2) (percept_pname age) (percept_pval 30))



