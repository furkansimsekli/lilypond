/*
  note-column-reg.cc -- implement Note_column_register

  source file of the LilyPond music typesetter

  (c) 1997 Han-Wen Nienhuys <hanwen@stack.nl>
*/

#include "note-column-reg.hh"
#include "notehead.hh"
#include "stem.hh"
#include "note-column.hh"
#include "script.hh"

bool
Note_column_register::acceptable_elem_b(Staff_elem const*elem_C)const
{
    char const*nC = elem_C->name();
    return (nC == Script::static_name() || nC == Notehead::static_name() 
	    || nC == Stem::static_name());
}

void
Note_column_register::acknowledge_element(Staff_elem_info i)
{
    if (!acceptable_elem_b(i.elem_l_))
	return;

    if (!ncol_p_)
	ncol_p_ = new Note_column;

    char const*nC = i.elem_l_->name();

    if (nC == Script::static_name())
	ncol_p_->add((Script*)i.elem_l_);
    else if (nC == Notehead::static_name())
	ncol_p_->add((Notehead*)i.elem_l_);
    else if (nC == Stem::static_name())
	ncol_p_->add((Stem*)i.elem_l_);
}

void
Note_column_register::pre_move_processing()
{
    if (ncol_p_) {
	typeset_element(ncol_p_);
	ncol_p_ =0;
    }
}
Note_column_register::Note_column_register()
{
    ncol_p_=0;
}
IMPLEMENT_STATIC_NAME(Note_column_register);
ADD_THIS_REGISTER(Note_column_register);
