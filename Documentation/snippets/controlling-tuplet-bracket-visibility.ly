%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.17.15"

\header {
  lsrtags = "rhythms, tweaks-and-overrides"

  texidoc = "
The default behavior of tuplet-bracket visibility is to print a bracket
unless there is a beam of the same length as the tuplet. To control the
visibility of tuplet brackets, set the property
@code{'bracket-visibility} to either @code{#t} (always print a
bracket), @code{#f} (never print a bracket) or @code{#'if-no-beam}
(only print a bracket if there is no beam).

"
  doctitle = "Controlling tuplet bracket visibility"
} % begin verbatim


music = \relative c'' {
  \tuplet 3/2 { c16[ d e } f8]
  \tuplet 3/2 { c8 d e }
  \tuplet 3/2 { c4 d e }
}

\new Voice {
  \relative c' {
    << \music s4^"default" >>
    \override TupletBracket.bracket-visibility = #'if-no-beam
    << \music s4^"'if-no-beam" >>
    \override TupletBracket.bracket-visibility = ##t
    << \music s4^"#t" >>
    \override TupletBracket.bracket-visibility = ##f
    << \music s4^"#f" >>
  }
}
