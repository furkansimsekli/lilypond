%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.55"

\header {
  lsrtags = "keyboards"

  texidoc = "
An arpeggio bracket can indicate that notes on two different staves are
to be played with the same hand. In order to do this, the
@code{PianoStaff} must be set to accept cross-staff arpeggios and the
arpeggios must be set to the bracket shape in the @code{PianoStaff}
context.


(Debussy, Les collines d’Anacapri, m. 65) 

"
  doctitle = "Indicating cross-staff chords with arpeggio bracket"
} % begin verbatim
\paper { ragged-right = ##t }

\new PianoStaff <<
  \set PianoStaff.connectArpeggios = ##t
  \override PianoStaff.Arpeggio #'stencil = #ly:arpeggio::brew-chord-bracket
  \new Staff {
    \relative c' {
      \key b \major
      \time 6/8
      b8-.(\arpeggio fis'-.\> cis-. e-. gis-. b-.)\!\fermata^\laissezVibrer
      \bar "||"
    }
  }
  \new Staff {
    \relative c' {
      \clef bass
      \key b \major
      <<
        {
          <a e cis>2.\arpeggio
        }
        \\
        {
          <a, e a,>2.
        }
      >>
    }
  }
>>
