%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.17.15"

\header {
  lsrtags = "chords, simultaneous-notes, workaround"

  texidoc = "
Here is a way to display a chord where the same note is played twice
with different accidentals.

"
  doctitle = "Displaying complex chords"
} % begin verbatim

fixA = {
  \once \override Stem.length = #9
}
fixB = {
  \once \override NoteHead.X-offset = #1.7
  \once \override Stem.rotation = #'(45 0 0)
  \once \override Stem.extra-offset = #'(-0.2 . -0.2)
  \once \override Flag.style = #'no-flag
  \once \override Accidental.extra-offset = #'(4 . 0)
}

\relative c' {
  << { \fixA <b d!>8 } \\ { \voiceThree \fixB dis } >> s
}
