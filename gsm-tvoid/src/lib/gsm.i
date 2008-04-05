/* -*- c++ -*- */
//%feature("autodoc", "1");		// generate python docstrings
//%include "exception.i"
%import "gnuradio.i"			// the common stuff

%{
#include "gnuradio_swig_bug_workaround.h"	// mandatory bug fix
//#include "gsm_constants.h"
//#include "gsm_burst.h"
#include "gsm_burst_ff.h"
#include "gsm_burst_cf.h"
//#include <stdexcept>

%}

// ----------------------------------------------------------------

#define PRINT_NOTHING		0x00000000
#define PRINT_EVERYTHING	0x7FFFFFFF		//7 for SWIG overflow check work around
#define PRINT_BITS			0x00000001
#define PRINT_ALL_BITS		0x00000002
#define PRINT_CORR_BITS		0x00000004
#define PRINT_STATE			0x00000008

#define PRINT_ALL_TYPES		0x00000FF0
#define PRINT_KNOWN			0x00000FE0
#define PRINT_UNKNOWN		0x00000010
#define PRINT_TS0			0x00000020
#define PRINT_FCCH			0x00000040
#define PRINT_SCH			0x00000080
#define PRINT_DUMMY			0x00000100
#define PRINT_NORMAL		0x00000200

#define PRINT_GSM_DECODE	0x00000400

#define PRINT_HEX			0x00001000

//Timing/clock options
#define QB_NONE				0x00000000
#define QB_QUARTER			0x00000001		//only for internal clocked versions
#define QB_FULL04			0x00000003
#define QB_MASK				0x0000000F

#define CLK_CORR_TRACK		0x00000010		//adjust timing based on correlation offsets

//EQ options
enum EQ_TYPE {
	EQ_NONE,
	EQ_FIXED_LINEAR,
	EQ_ADAPTIVE_LINEAR,
	EQ_FIXED_DFE,
	EQ_ADAPTIVE_DFE,
	EQ_VITERBI
};

//GR_SWIG_BLOCK_MAGIC(gsm,burst);

class gsm_burst {
public:
	~gsm_burst ();
		
	unsigned long	d_clock_options;
	unsigned long	d_print_options;
	EQ_TYPE			d_equalizer_type;

	//stats
	long			d_sync_loss_count;
	long			d_fcch_count;
	long			d_part_sch_count;
	long			d_sch_count;
	long			d_normal_count;
	long			d_dummy_count;
	long			d_unknown_count;
	long			d_total_count;
	
	int				sync_state();
	float 			last_freq_offset(void);
	double 			mean_freq_offset(void);
	
	//Methods
	void full_reset(void);

protected:
	gsm_burst();  
};


GR_SWIG_BLOCK_MAGIC(gsm,burst_ff);
gsm_burst_ff_sptr gsm_make_burst_ff ();

class gsm_burst_ff : public gr_block, public gsm_burst {
private:
	gsm_burst_ff ();
};

GR_SWIG_BLOCK_MAGIC(gsm,burst_cf);
gsm_burst_cf_sptr gsm_make_burst_cf (float);

class gsm_burst_cf : public gr_block, public gsm_burst {
private:
	gsm_burst_cf (float);
};





