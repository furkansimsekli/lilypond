
\header {

    texidoc = "Own markup commands may be defined by using the
    @code{def-markup-command} scheme macro."


      }

\version "2.1.28" % to be updated

#(def-markup-command (upcase paper props str) (string?)
  "Upcase the string characters. Syntax: \\upcase #\"string\""
   (interpret-markup paper props (make-simple-markup (string-upcase str))))

\score { 
    \notes { 
        c''-\markup \upcase #"hello world"
        % produces a "HELLO WORLD" markup
    }
    \paper { raggedright = ##t }
}
