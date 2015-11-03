(deftemplate environment "Environment"
  (slot value))

(deftemplate stimulus-situation "Stimulus Situation"
  (slot value))

(deftemplate job "Job"
  (slot value))

(deftemplate stimulus-response "Response"
  (slot value))

(deftemplate feedback "Feedback"
  (slot value))

(deftemplate medium "Medium"
  (slot value))



(defrule rule1
  (environment (value papers | manuals | documents | documents | textbooks))
  =>
  (assert (stimulus-situation (value verbal))))


(defrule rule2
  (environment (value pictures | illustrations | photographs | diagrams))
  =>
  (assert (stimulus-situation (value verbal))))


(defrule rule3
  (environment (value machines | buildings | tools))
  =>
  (assert (stimulus-situation (value physical-object))))


(defrule rule4
  (environment (value numbers | formulas | computer-programs))
  =>
  (assert (stimulus-situation (value symbolic))))


(defrule rule5
  (job (value lecturing | advising | counselling))
  =>
  (assert (stimulus-response (value oral))))


(defrule rule6
  (job (value building | repairing | troubleshooting))
  =>
  (assert (stimulus-response (value hands-on))))


(defrule rule7
  (job (value writing | typing | drawing))
  =>
  (assert (stimulus-response (value documented))))


(defrule rule8
  (job (value evaluating | reasoning | investigating))
  =>
  (assert (stimulus-response (value analytical))))


(defrule rule9
  (stimulus-situation (value physical-object))
  (stimulus-response (value hands-on))
  (feedback (value true))
  =>
  (assert (medium (value workshop))))


(defrule rule10
  (stimulus-situation (value symbolic))
  (stimulus-response (value analytical))
  (feedback (value true))
  =>
  (assert (medium (value lecuture-tutorial))))


(defrule rule11
  (stimulus-situation (value visual))
  (stimulus-response (value documented))
  (feedback (value false))
  =>
  (assert (medium (value video-cassette))))

(defrule rule12
  (stimulus-situation (value visual))
  (stimulus-response (value oral))
  (feedback (value true))
  =>
  (assert (medium (value lecture-tutorial))))


(defrule rule13
  (stimulus-situation (value verbal))
  (stimulus-response (value analytical))
  (feedback (value true))
  =>
  (assert (medium (value lecture-tutorial))))

(defrule rule14
  (stimulus-situation (value verbal))
  (stimulus-response (value analytical))
  (feedback (value true))
  =>
  (assert (medium (value role-play-exercises))))

(defrule rule15
  (stimulus-situation (value symbolic))
  (stimulus-response (value documented))
  (environment (value computer-programs))
  =>
  (assert (medium (value computer-room))))

(defrule rule16
  (environment (value illustrations))
  (stimulus-response (value documented))
  =>
  (assert (medium (value art-gallery))))
