/*
  musical-request.hh -- declare Musical requests

  source file of the GNU LilyPond music typesetter

  (c)  1997--2000 Han-Wen Nienhuys <hanwen@cs.uu.nl>
*/


#ifndef MUSICALREQUESTS_HH
#define MUSICALREQUESTS_HH

#include "lily-proto.hh"
#include "request.hh"
#include "duration.hh"
#include "musical-pitch.hh"
#include "array.hh"


/** a request with a duration.
  This request is used only used as a base class.
 */
class Rhythmic_req  : public virtual Request  {
public:
  Duration duration_;


  bool do_equal_b (Request const*) const;
  void compress (Moment);
  virtual Moment length_mom () const;
  static int compare (Rhythmic_req const&,Rhythmic_req const&);
  VIRTUAL_COPY_CONS(Music);
};

class Skip_req  : public Rhythmic_req  {
public:
  VIRTUAL_COPY_CONS(Music);
};


struct Tremolo_req : public Request {
  VIRTUAL_COPY_CONS (Music);
  Tremolo_req ();
  int type_i_;

};


/** a syllable  or lyric is a string with rhythm.
  */
class Lyric_req  : public  Rhythmic_req  {
public:

  String text_str_;
  VIRTUAL_COPY_CONS(Music);
};


class Articulation_req : public Script_req
{
public:
  String articulation_str_;
protected:
  virtual bool do_equal_b (Request const*) const;

  VIRTUAL_COPY_CONS(Music);
};

class Text_script_req : public Script_req {
public:
  String text_str_;

  // should be generic property of some kind.. 
  String style_str_;
protected:
  VIRTUAL_COPY_CONS(Music);
  virtual bool do_equal_b (Request const*)const;

};


/// request which has some kind of pitch
struct Melodic_req :virtual Request
{
  Musical_pitch pitch_;

  static int compare (Melodic_req const&,Melodic_req const&);
  
protected:
  /// transpose. #delta# is relative to central c.
  virtual void transpose (Musical_pitch delta);
  virtual bool do_equal_b (Request const*) const;

  VIRTUAL_COPY_CONS(Music);
};

/// specify tonic of a chord
struct Tonic_req : public Melodic_req
{
  VIRTUAL_COPY_CONS (Music);
};

/// specify inversion of a chord
struct Inversion_req : public Melodic_req
{
  VIRTUAL_COPY_CONS (Music);
};

/// specify bass of a chord
struct Bass_req : public Melodic_req
{
  VIRTUAL_COPY_CONS (Music);
};

/// Put a note of specified type, height, and with accidental on the staff.
class Note_req  : public Rhythmic_req, virtual public Melodic_req  {
public:
    
  /// force/supress printing of accidental.
  bool forceacc_b_;
  /// Cautionary, i.e. parenthesized accidental.
  bool cautionary_b_;
  Note_req();
protected:

  bool do_equal_b (Request const*) const;
  VIRTUAL_COPY_CONS(Music);
};

/**
Put a rest on the staff. Why a request? It might be a good idea to not typeset the rest, if the paper is too crowded.
*/
class Rest_req : public Rhythmic_req {
public:
  VIRTUAL_COPY_CONS(Music);
};


/// an extender line
class Extender_req : public Request  {
public:
  VIRTUAL_COPY_CONS(Music);
};

/// a centred hyphen
class Hyphen_req : public Request  {
public:
  VIRTUAL_COPY_CONS(Music);
};

/** is anyone  playing a note?
    Used for communication between Music & Lyrics
 */
class Busy_playing_req : public Request
{
public:
  VIRTUAL_COPY_CONS (Music);
};



/**
   instruct lyric context to alter typesetting (unimplemented).  */
class Melisma_req : public Span_req
{
public:
  VIRTUAL_COPY_CONS(Music);
};


/**
   Helping req to signal start of a melisma from within a context, and
   to   */
class Melisma_playing_req : public Request
{
public:
  VIRTUAL_COPY_CONS (Music);
};
#endif // MUSICALREQUESTS_HH
