;
;----------Modul: MAIN-------------
;
(defmodule MAIN
    (export deftemplate initial-fact)
    (export deftemplate tic)
)

(deftemplate MAIN::tic)
(deftemplate MAIN::initial-fact)

(defglobal ?*main-in-debug* = FALSE)
;(defglobal ?*main-in-debug* = TRUE)
(defglobal ?*ag-tic-in-debug* = FALSE)
;(defglobal ?*ag-tic-in-debug* = TRUE)

;
;----------Modul: PERCEPT-MANAGER-----------
;
(defmodule PERCEPT-MANAGER
 (import MAIN deftemplate initial-fact)
 (import MAIN deftemplate tic)
 (export deftemplate timp)
 (export deftemplate ag_percept)
)


(defglobal ?*sim-in-debug* = FALSE)
;(defglobal ?*sim-in-debug* = TRUE)
(defglobal ?*percepts-in-debug* = FALSE)
;(defglobal ?*percepts-in-debug* = TRUE)
(defglobal ?*perceptsDir* = "./Perceptii/")


(deftemplate PERCEPT-MANAGER::timp (slot valoare))

(deftemplate PERCEPT-MANAGER::ag_percept 
    (slot percept_pobj)
    (slot percept_pname) ; animal|indicator|marcaj
    (slot percept_pval); albina|barza|... or depasire_interzisa|... or (linie_continua|...)
)
;
;-------------Modul: DRIVER-AGENT
;
(defmodule AGENT
    (import MAIN deftemplate initial-fact)
    (import PERCEPT-MANAGER deftemplate timp)
    (import PERCEPT-MANAGER deftemplate ag_percept)
)

(defglobal ?*ag-measure-time* = FALSE)
(defglobal ?*ag-measure-time* = TRUE)

(defglobal ?*ag-in-debug* = FALSE)
;(defglobal ?*ag-in-debug* = TRUE)
(defglobal ?*ag-percepts-in-debug* = FALSE)
;(defglobal ?*ag-percepts-in-debug* = TRUE)
(deftemplate ag_bel
    (slot bel_type) ; fluent|moment 
    (slot bel_timeslice) ; in which time slice bel_type is true: 0=crt, 1,2,...=future
    (slot bel_pobj)
    (slot bel_pname) ; which property we're talking about: overtaking-maneuver|no-overtaking-zone|speed_limit
    (slot bel_pval) ; bel_pname value: (prohibited|allowed) or (yes|no) or (50|90|100|130)
)

(deftemplate priority
    (slot dir); ahead/left 
    (slot val); 
)

(defglobal ?*gender_priority* = 10)
(defglobal ?*pregnant_priority* = 50)
(defglobal ?*age_priority* = 40)
(defglobal ?*red_priority* = 20)
(defglobal ?*fat_priority* = 30)
(defglobal ?*barrier_priority* = 60)


