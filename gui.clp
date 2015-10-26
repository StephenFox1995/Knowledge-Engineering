; -*- clips -*-

;; **********************************************************************
;;                           Frame.clp
;;
;; A nifty example of building a a Swing GUI using jess reflection.
;; Using this package, we can create java objects, call their methods,
;; access their fields, and respond to GUI events.
;; You can therefore build an entire GUI application without actually
;; writing any Java code!
;;
;; **********************************************************************

;; ******************************
;; Declarations

(import javax.swing.*)
;; Explicit import so we get JFrame.EXIT_ON_CLOSE
(import javax.swing.JFrame)
(import java.awt.event.ActionListener)
(import java.awt.BorderLayout)
(import java.awt.Color)

;; ******************************
;; DEFGLOBALS

(defglobal ?*frame* = 0)
(defglobal ?*cPane* = 0)
(defglobal ?*textField* = 0)
(defglobal ?*button* = 0)

;; ******************************
;; DEFFUNCTIONS

(deffunction create-frame ()
  (bind ?*frame* (new JFrame "Jess Reflection Demo"))
  (bind ?*cPane* (?*frame* getContentPane))
  (set ?*cPane* background (Color.white)))


(deffunction add-widgets ()
  (bind ?*textField* (new JTextField "Search for:"))
  (?*cPane* add ?*textField* (BorderLayout.NORTH))

  (bind ?*button* (new JButton "Search"))
  (?*cPane* add ?*button* ))



(deffunction add-behaviours ()
  (?*frame* setDefaultCloseOperation (JFrame.EXIT_ON_CLOSE))
  (?*button* addActionListener (implement ActionListener using
    (lambda (?name ?event)
      (printout t "Search for:" (?*textField* getText) crlf)))))


(deffunction show-frame ()
  ;(?*frame* pack)
    (?*frame* setSize 200 300)
  (?*frame* setVisible TRUE))


;; ******************************
;; Run the program

(defrule init-rule
    (initial-fact)
    =>
    (create-frame)
    (add-widgets)
    (add-behaviours)
    (show-frame))

(reset)
(run)
