#include "keyitem.hh"
#include "key.hh"
#include "debug.hh"
#include "molecule.hh"
#include "paper.hh"
#include "lookup.hh"


Keyitem::Keyitem(int c)
{
    c_position = c;
}

void
Keyitem::read(Array<int> s)
{
    for (int i = 0 ; i< s.size(); ) {
	int note = s[i++];
	int acc = s[i++];
	    
	add(note, acc);
    }
}

void
Keyitem::add(int p, int a)
{
    pitch.add(p);
    acc.add(a);
}


Molecule*
Keyitem::brew_molecule_p()const
{
    Molecule*output = new Molecule;
    Real inter = paper()->interline()/2;
    
    for (int i =0; i < pitch.size(); i++) {
	Symbol s= paper()->lookup_p_->accidental(acc[i]);
	Atom a(s);
	a.translate(Offset(0,(c_position + pitch[i]) * inter));
	Molecule m(a);
	output->add_right(m);	
    }
    Molecule m(paper()->lookup_p_->fill(Box(
	Interval(0, paper()->note_width()),
	Interval(0,0))));
    output->add_right(m);
    return output;
}
