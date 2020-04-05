%% DO NOT EDIT this file manually; it is automatically
%% generated from LSR http://lsr.di.unimi.it
%% Make any changes in LSR itself, or in Documentation/snippets/new/ ,
%% and then run scripts/auxiliar/makelsr.py
%%
%% This file is in the public domain.
\version "2.18.0"

\header {
  lsrtags = "midi, percussion, pitches, specific-notation"

  texidoc = "
If you want to use customized drum-pitch-names for an own drum-style
with proper output for layout and midi, follow the steps as
demonstrated in the code below. In short:

* define the names * define the appearence * tell LilyPond to use it
for layout * assign pitches to the names * tell LilyPond to use them
for midi

"
  doctitle = "Customize drumPitchNames drumStyleTable and drumPitchTable in layout and midi"
} % begin verbatim

%% This snippet tries to amend
%% NR 2.5.1 Common notation for percussion - Custom percussion staves
%% http://lilypond.org/doc/v2.18/Documentation/notation/common-notation-for-percussion#custom-percussion-staves

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%
%% To use custom drum-pitch-names for your score and midi you need to follow
%% this route:
%%
%%%%%%%%%%%%
%% LAYOUT:
%%%%%%%%%%%%
%%
%% (1) Define a name and put it in `drumPitchNames'
%%     This can be done at toplevel with
%%         drumPitchNames.my-name  = #'my-name
%%     It's possible to add an alias as well.
%% (2) Define how it should be printed
%%     Therefore put them into a toplevel-list, where each entry should look:
%%         (my-name
%%           note-head-style-or-default
%%             articulation-string-or-#f
%%               staff-position)
%%     Example:
%%         #(define my-style
%%           '(
%%             (my-name default "tenuto" -1)
%%             ; ...
%%             ))
%% (3) Tell LilyPond to use this custom-definitions, with
%%         drumStyleTable = #(alist->hash-table my-style)
%%     in a \layout or \with
%%
%%     Now we're done for layout, here a short, but complete example:
%%         \new DrumStaff
%%           \with { drumStyleTable = #(alist->hash-table my-style) }
%%           \drummode { my-name }
%%
%%%%%%%%%%%%
%% MIDI:
%%%%%%%%%%%%
%%
%% (1) Again at toplvel, assign a pitch to your custom-note-name
%%         midiDrumPitches.my-name = ges
%%     Note that you have to use the name, which is in drumPitchNames, no alias
%% (2) Tell LilyPond to use this pitch(es), with
%%         drumPitchTable = #(alist->hash-table midiDrumPitches)
%%
%%     Example:
%%         \score {
%%            \new DrumStaff
%%             \with {
%%               drumStyleTable = #(alist->hash-table my-style)
%%               drumPitchTable = #(alist->hash-table midiDrumPitches)
%%             }
%%             \drummode { my-name4 }
%%           \layout {}
%%           \midi {}
%%         }
%%
%%%%%%%%%%%%
%% TESTING
%%%%%%%%%%%%
%%
%% To test whether all is fine, run the following sequence in terminal:
%%         lilypond my-file.ly
%%         midi2ly my-file.midi
%%         gedit my-file-midi.ly
%%
%% Which will do:
%% 1. create pdf and midi
%% 2. transform the midi back to a .ly-file
%%    (note: midi2ly is not always good in correctly identifying enharmonic pitches)
%% 3. open this file in gedit (or use another editor)
%% Now watch what you've got.
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% FULL EXAMPLE
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

drumPitchNames.dbass      = #'dbass
drumPitchNames.dba        = #'dbass  % 'db is in use already
drumPitchNames.dbassmute  = #'dbassmute
drumPitchNames.dbm        = #'dbassmute
drumPitchNames.do         = #'dopen
drumPitchNames.dopenmute  = #'dopenmute
drumPitchNames.dom        = #'dopenmute
drumPitchNames.dslap      = #'dslap
drumPitchNames.ds         = #'dslap
drumPitchNames.dslapmute  = #'dslapmute
drumPitchNames.dsm        = #'dslapmute

#(define djembe
  '((dbass      default  #f         -2)
    (dbassmute  default  "stopped"  -2)
    (dopen      default  #f          0)
    (dopenmute  default  "stopped"   0)
    (dslap      default  #f          2)
    (dslapmute  default  "stopped"   2)))

midiDrumPitches.dbass = g
midiDrumPitches.dbassmute = fis
midiDrumPitches.dopen =  a
midiDrumPitches.dopenmute = gis
midiDrumPitches.dslap =  b
midiDrumPitches.dslapmute = ais

one = \drummode { r4 dba4 do ds r dbm dom dsm }

\score {
   \new DrumStaff
    \with {
      \override StaffSymbol.line-count =  #3
      instrumentName = #"Djembe "
      drumStyleTable = #(alist->hash-table djembe)
      drumPitchTable = #(alist->hash-table midiDrumPitches)
    }
    \one
  \layout {}
  \midi {}
}
