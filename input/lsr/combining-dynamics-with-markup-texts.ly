%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.49"

\header {
  lsrtags = "expressive-marks, text"

  texidoc = "
Some dynamics may involve text indications (such as \"più forte\" or
\"piano subito\"). They can be produced using a @code{\\markup} block.

"
  doctitle = "Combining dynamics with markup texts"
} % begin verbatim
piuF = \markup { \italic più \dynamic f }
\layout { ragged-right = ##f }
\relative c'' {
  c2\f c-\piuF
}

