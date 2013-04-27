%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.17.15"

\header {
  lsrtags = "editorial-annotations, really-simple, tweaks-and-overrides"

  texidoc = "
Simple horizontal analysis brackets are added below the staff by
default. The following example shows a way to place them above the
staff instead.

"
  doctitle = "Analysis brackets above the staff"
} % begin verbatim


\layout {
  \context {
    \Voice
    \consists "Horizontal_bracket_engraver"
  }
}
\relative c'' {
  \once \override HorizontalBracket.direction = #UP
  c2\startGroup
  d2\stopGroup
}
