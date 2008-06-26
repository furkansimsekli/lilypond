%% Do not edit this file; it is auto-generated from LSR http://lsr.dsi.unimi.it
%% This file is in the public domain.
\version "2.11.49"

\header {
  lsrtags = "staff-notation, contexts-and-engravers, tweaks-and-overrides"

  texidoc = "
The property @code{systemStartDelimiterHierarchy} can be used to make
more complex nested staff groups. The command @code{\\set
StaffGroup.systemStartDelimiterHierarchy} takes an alphabetical list of
the number of staves produced. Before each staff a system start
delimiter can be given. It has to be enclosed in brackets and takes as
much staves as the brackets enclose. Elements in the list can be
omitted, but the first bracket takes always the complete number of
staves. The possibilities are @code{SystemStartBar},
@code{SystemStartBracket}, @code{SystemStartBrace}, and
@code{SystemStartSquare}.

"
  doctitle = "Nesting staves"
} % begin verbatim
\new StaffGroup
\relative c'' <<
  \set StaffGroup.systemStartDelimiterHierarchy
    = #'(SystemStartSquare (SystemStartBrace (SystemStartBracket a
                             (SystemStartSquare b)  ) c ) d)
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
  \new Staff { c1 }
>>
