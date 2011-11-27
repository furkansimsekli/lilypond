%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.dsi.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.14.0"

\header {
  lsrtags = "chords, tweaks-and-overrides"

%% Translation of GIT committish: 8b93de6ce951b7b14bc7818f31019524295b990f
  texidoces = "
Allí donde se utilicen líneas extensoras para el bajo cifrado mediante
el establecimiento de @code{useBassFigureExtenders} al valor
verdadero, las parejas de líneas extensoras congruentes se centran
verticalmente si el valor de @code{figuredBassCenterContinuations}
tiene el valor verdadero.

"
  doctitlees = "Centrado vertical de las líneas de bajo cifrado emparejadas"



  texidoc = "
Where figured bass extender lines are being used by setting
@code{useBassFigureExtenders} to true, pairs of congruent figured bass
extender lines are vertically centered if
@code{figuredBassCenterContinuations} is set to true.

"
  doctitle = "Vertically centering paired figured bass extenders"
} % begin verbatim

<<
  \relative c' {
    c8 c b b a a c16 c b b
    c8 c b b a a c16 c b b
    c8 c b b a a c c b b
  }
  \figures {
    \set useBassFigureExtenders = ##t
    <6+ 4 3>4 <6 4 3>8 r
    <6+ 4 3>4 <6 4 3>8 <4 3+>16 r
    \set figuredBassCenterContinuations = ##t
    <6+ 4 3>4 <6 4 3>8 r
    <6+ 4 3>4 <6 4 3>8 <4 3+>16 r
    \set figuredBassCenterContinuations = ##f
    <6+ 4 3>4 <6 4 3>8 r
    <6+ 4 3>4 <6 4 3>8 <4 3+>8
  }
>>

