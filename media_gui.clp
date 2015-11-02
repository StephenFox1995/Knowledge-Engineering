(import javax.swing.*)
(import javax.swing.JFrame)
(import java.awt.event.ActionListener)
(import java.awt.BorderLayout)
(import java.awt.Color)

(watch all)

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



;; ****************************************
;; GUI Code here.
;; ****************************************


(defglobal ?*frame* = 0)
(defglobal ?*textField* = 0)
(defglobal ?*button* = 0)
(defglobal ?*comboBox* = 0)
(defglobal ?*resetButton* = 0)
(defglobal ?*showFactsButton* = 0)


(deffunction submit-fact (?object ?value)
  ;; Convert to symbol so we can use
  ;; within our rules.
  (bind ?object-sym (sym-cat ?object))
  (bind ?value-sym (sym-cat ?value))

  (if (eq ?object-sym Job) then
    (assert (job (value ?value-sym)))
  elif (eq ?object-sym Environment) then
    (assert (environment (value ?value-sym)))
  else (eq ?object-sym Feedback)
    (assert (feedback (value ?value-sym))))
  (run))



(deffunction create-frame ()
  (bind ?*frame* (new JFrame "Media Advisor"))
  (bind ?*cPane* (?*frame* getContentPane))
  (set ?*cPane* background (Color.white)))


(deffunction add-widgets ()
  (bind ?*textField* (new JTextField "Add:"))
  (?*cPane* add ?*textField* (BorderLayout.NORTH))

  (bind ?*button* (new JButton "Add"))
  (?*cPane* add ?*button*  (BorderLayout.SOUTH))

  (bind ?*resetButton* (new JButton "Reset"))
  (?*resetButton* setLocation 50 40)
  (?*resetButton* setSize 50 20);
  (?*cPane* add ?*resetButton*)

  (bind ?*showFactsButton* (new JButton "Facts"))
  (?*showFactsButton* setLocation 105 40)
  (?*showFactsButton* setSize 50 20)
  (?*cPane* add ?*showFactsButton*)

  (bind ?*comboBox* (new JComboBox))
  (?*comboBox* addItem "Environment")
  (?*comboBox* addItem "Job")
  (?*comboBox* addItem "Feedback")
  (?*cPane* add ?*comboBox* (BorderLayout.CENTER)))



(deffunction add-behaviours ()
  (?*frame* setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE))
    (?*button* addActionListener (implement ActionListener using
      (lambda (?event)
        (submit-fact (get ?*comboBox* selectedItem) (?*textField* getText)))))

    ;; Resets working memory.
    (?*resetButton* addActionListener (implement ActionListener using
      (lambda (?event)
        (printout t "Working memory reset." crlf)
        (reset)
        (run))))

    ;; Shows facts.
    (?*showFactsButton* addActionListener (implement ActionListener using
      (lambda (?event)
        (facts)))))


(deffunction show-frame ()
  (?*frame* setSize 200 300)
  (?*frame* setVisible TRUE))


(defrule init-rule
  (initial-fact)
  =>
  (create-frame)
  (add-widgets)
  (add-behaviours)
  (show-frame))

(reset)
(run)
