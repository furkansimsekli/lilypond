%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "vocal-music, template"

%% Translation of GIT committish: 8b93de6ce951b7b14bc7818f31019524295b990f

  texidoces = "
Plantilla de coro SATB (en cuatro pentagramas)

"
  doctitlees = "Plantilla de coro SATB a cuatro pentagramas"

%% Translation of GIT committish: 34607d3e36a93030690ccd780a7ffce621ca1e0f
  texidocit = "
Modello per coro SATB (quattro righi)

"
  doctitleit = "Modello per coro SATB - quattro righi"

%% Translation of GIT committish:  144cd434d02e6d90b2fb738eeee99119a7c5e1d2

  texidocde = "
SATB-Chorvorlage auf vier Systemen

"
  doctitlede = "SATB-Chorvorlage auf vier Systemen"


%% Translation of GIT committish: 092f85605dcea69efff5ef31de4ff100346d6ef8

  texidocfr = "
Modèle pour chœur à quatre voix mixtes, chaque pupitre ayant sa propre
portée.

"
  doctitlefr = "Modèle pour chœur SATB sur quatre portées"


  texidoc = "
SATB choir template (four staves)

"
  doctitle = "SATB Choir template - four staves"
} % begin verbatim

global = {
  \key c \major
  \time 4/4
  \dynamicUp
}
sopranonotes = \relative c'' {
  c2 \p \< d c d \f
}
sopranowords = \lyricmode { do do do do }
altonotes = \relative c'' {
  c2\p d c d
}
altowords = \lyricmode { re re re re }
tenornotes = {
  \clef "G_8"
  c2\mp d c d
}
tenorwords = \lyricmode { mi mi mi mi }
bassnotes = {
  \clef bass
  c2\mf d c d
}
basswords = \lyricmode { mi mi mi mi }

\score {
  \new ChoirStaff <<
    \new Staff <<
      \new Voice = "soprano" <<
        \global
        \sopranonotes
      >>
      \lyricsto "soprano" \new Lyrics \sopranowords
    >>
    \new Staff <<
      \new Voice = "alto" <<
        \global
        \altonotes
      >>
      \lyricsto "alto" \new Lyrics \altowords
    >>
    \new Staff <<
      \new Voice = "tenor" <<
        \global
        \tenornotes
      >>
      \lyricsto "tenor" \new Lyrics \tenorwords
    >>
    \new Staff <<
      \new Voice = "bass" <<
        \global
        \bassnotes
      >>
      \lyricsto "bass" \new Lyrics \basswords
    >>
  >>
}

