%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.17.15"

\header {
  lsrtags = "staff-notation, symbols-and-glyphs, vocal-music"

  texidoc = "
This snippet defines the @code{\\splitStaffBarLine} command, which adds
arrows in north-east and south-east directions at a bar line, to denote
that several voices sharing a staff will each continue on a staff of
their own in the next system.

"
  doctitle = "Adding indicators to staves which get split after a break"
} % begin verbatim

#(define-markup-command (arrow-at-angle layout props angle-deg length fill)
   (number? number? boolean?)
   (let* (
          ;; PI-OVER-180 and degrees->radians are taken from flag-styles.scm
          (PI-OVER-180 (/ (atan 1 1) 45))
          (degrees->radians (lambda (degrees) (* degrees PI-OVER-180)))
          (angle-rad (degrees->radians angle-deg))
          (target-x (* length (cos angle-rad)))
          (target-y (* length (sin angle-rad))))
     (interpret-markup layout props
                       (markup
                        #:translate (cons (/ target-x 2) (/ target-y 2))
                        #:rotate angle-deg
                        #:translate (cons (/ length -2) 0)
                        #:concat (#:draw-line (cons length 0)
                                              #:arrow-head X RIGHT fill)))))

splitStaffBarLineMarkup = \markup \with-dimensions #'(0 . 0) #'(0 . 0) {
  \combine
    \arrow-at-angle #45 #(sqrt 8) ##f
    \arrow-at-angle #-45 #(sqrt 8) ##f
}

splitStaffBarLine = {
  \once \override Staff.BarLine.stencil =
    #(lambda (grob)
       (ly:stencil-combine-at-edge
        (ly:bar-line::print grob)
        X RIGHT
        (grob-interpret-markup grob splitStaffBarLineMarkup)
        0))
  \break
}

\paper {
  ragged-right = ##t
  short-indent = 5\mm
}

\score {
  <<
    \new ChoirStaff <<
      \new Staff \with { instrumentName = #"High I + II" } {
        <<
          \repeat unfold 4 f''1
          \\
          \repeat unfold 4 d''1
        >>
        \splitStaffBarLine
      }
      \new Staff \with { instrumentName = #"Low" } {
        <<
          \repeat unfold 4 b'1
          \\
          \repeat unfold 4 g'1
        >>
      }

      \new Staff \with { shortInstrumentName = #"H I" } {
        R1*4
        \repeat unfold 2 { r4 f''2 r4 } \repeat unfold 2 e''1
      }
      \new Staff \with { shortInstrumentName = #"H II" } {
        R1*4
        \repeat unfold 4 b'2 \repeat unfold 2 c''1
      }
      \new Staff \with { shortInstrumentName = #"L" } {
        R1*4
        <<
          \repeat unfold 4 g'1
          \\
          \repeat unfold 4 c'1
        >>
      }
    >>
  >>
  \layout {
    \context {
      \Staff \RemoveEmptyStaves
      \override VerticalAxisGroup.remove-first = ##t
    }
  }
}
