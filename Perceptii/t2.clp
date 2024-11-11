;Evenimentul 1
;In fata am 3 femei si 2 barbati. In stanga am 3 barbati si 2 caini. Suma varstelor pentru fiecare grup de persoane
;este egal. Culoarea semaforului fiind rosie in ambele parti, o sa salvez grupul format din mai multe femei
(ag_percept (percept_pobj ev1) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev1) (percept_pname direction) (percept_pval left))

(ag_percept (percept_pobj p1) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p2) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p3) (percept_pname isa) (percept_pval pedestrian))
(ag_percept (percept_pobj p4) (percept_pname isa) (percept_pval pedestrian))
;(ag_percept (percept_pobj c1) (percept_pname isa) (percept_pval dog))

(ag_percept (percept_pobj p1) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p2) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p3) (percept_pname partof) (percept_pval ev1))
(ag_percept (percept_pobj p4) (percept_pname partof) (percept_pval ev1))
;(ag_percept (percept_pobj c1) (percept_pname partof) (percept_pval ev1))

(ag_percept (percept_pobj p1) (percept_pname gen) (percept_pval m))
(ag_percept (percept_pobj p2) (percept_pname gen) (percept_pval f))
(ag_percept (percept_pobj p3) (percept_pname gen) (percept_pval m))
(ag_percept (percept_pobj p4) (percept_pname gen) (percept_pval m))

(ag_percept (percept_pobj p1) (percept_pname age) (percept_pval 80))
(ag_percept (percept_pobj p2) (percept_pname age) (percept_pval 70))
(ag_percept (percept_pobj p3) (percept_pname age) (percept_pval 45))
(ag_percept (percept_pobj p4) (percept_pname age) (percept_pval 43))



;Evenimentul 2
;In fata am un copil (fata) de 5 ani. In stanga am 2 barbati, 2 femei si 1 caine
;Nu exista semafoare. Se va calcula suma varstelor pentru fiecare grup si se va salva
;grupul cu cea mai mica valoare a varstelor

(ag_percept (percept_pobj ev2) (percept_pname isa) (percept_pval eveniment))
(ag_percept (percept_pobj ev2) (percept_pname direction) (percept_pval ahead))


(ag_percept (percept_pobj f1) (percept_pname isa) (percept_pval pedestrian))

(ag_percept (percept_pobj f1) (percept_pname partof) (percept_pval ev2))

(ag_percept (percept_pobj f1) (percept_pname gen) (percept_pval f))

(ag_percept (percept_pobj f1) (percept_pname age) (percept_pval 5))




