/*   
  grace-iterator.hh -- declare Grace_iterator
  
  source file of the GNU LilyPond music typesetter
  
  (c) 1999--2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
  
 */

#ifndef GRACE_ITERATOR_HH
#define GRACE_ITERATOR_HH

#include "music-wrapper-iterator.hh"

class Grace_iterator : public Music_wrapper_iterator
{
public:
  VIRTUAL_COPY_CONS (Music_iterator);
  ~Grace_iterator ();
  virtual void construct_children () ;
  virtual void do_process (Moment);

  Moment next_moment () const;
};



#endif /* GRACE_ITERATOR_HH */


