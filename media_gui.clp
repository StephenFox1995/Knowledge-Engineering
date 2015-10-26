(import javax.swing.*)
(import javax.swing.JFrame)
(import java.awt.event.ActionListener)
(import java.awt.BorderLayout)
(import java.awt.Color)



(defglobal ?*frame* = 0)
(defglobal ?*textField* = 0)
(defglobal ?*button* = 0)

(deffunction create-frame ()
  (bind ?*frame* (new JFrame "Media Advisor"))
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
