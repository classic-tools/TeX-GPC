% This is a change file of TeX for GNU Pascal, Wolfgang Helbig, Nov. 2007
% Handle command line as the first line, Apr. 2008
% Open vi at the offending line in error dialog Apr. 2008
% Avoid an underful last line,  use buffered output for dvi file, Jul. 2008
% That "finished" the program. But I kept on improving:
% July 2008:
% Don't print empty lines on terminal and log file.
% Don't trim input lines.
% November 2009:
% The last improvement caused an error: On reading a blank only
% first line might go into a loop. This error cannot be noticed by the user.
% It was noticed by Joachim Kuebart
% Some changes were necessary run TeX_GPC to Mac OS X
% with the current version of GPC. (pointed out by Martin Monperrus and
% Luis Rivera)
% 

[0] About TeX-GPC
@x
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
@y
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
\input webmac-gpc

\emergencystretch 0.6in % avoid overfull boxes 

% \let\maybe=\iffalse % uncomment to print changed modules only.

% put a mark in the left margin. (see Exercise 14.28 in The TeXbook)
\def\marke#1{\strut\vadjust{\kern-\dp\strutbox\vbox to 0pt{\vss
  \llap{\bf #1\/\quad\strut}}}\ignorespaces }

\def\name{\TeX}

\N0\*.  \[0] About \namegpc.
\namegpc\ is a Unix implementation of Donald~E. Knuth's \TeX82 in
the version 3.1415926 from March 2008. It is based on GNU Pascal.
The accompaning \.{README} file tells you how to build and run
\namegpc.  To help you identify the differences of \TeX82 and
\namegpc, the numbers of modified modules carry an asterisk. Letters
in the left margin indicate the reason for a change. They mean:
\medskip
\item{\bf E} fixes an error in \TeX82
\item{\bf e} fixes a small error in \TeX82
\item{\bf F} adds a feature as suggested by Knuth
\item{\bf P} removes a violation of Pascal (Jensen, Wirth: {\sl Pascal
User Manual and Report\/}, 3rd edition, 1985)
\item{\bf G} a GNU Pascal extension (Version 20070904)
\item{\bf U} make Unix happy
\item{\bf u} make Unix user happy
\item{\bf h} make Helbig happy
\item{\bf N} a note that helped me to understand this program.
\item{\bf B} a bug I couldn't fix.
\medskip

Identifiers that come with GNU~Pascal are coded as \.{WEB} macros and prefixed
by `\\{gpc\_}'. That helps to resolve name clashes.
\filbreak
\namegpc\ is slightly slower than web2c based programs.  To compile
the device independend file for this document, the web2c version from \TeX~Life 2008
ran 1.1 seconds and \namegpc\ 1.2 seconds.
\filbreak
Going with Dijkstra, see
\.{http://www.cs.utexas.edu/users/EWD/videos/noorderlicht.mpg}, I
don't believe in version numbers, since I don't believe in maintaining
software---I consider \namegpc\ finished---and it must go without
a number. This does not mean that I don't care any more about
\namegpc; comments or questions are quite welcome.  In fact, I
tried to explain why I changed what and how in order to encourage
you to undertake further modifications or bugfixes yourself and
I'll be glad to help.
\filbreak
I wish to thank Frank Heckenbach and Emil Jerabek from the GNU
Pascal mailing list for clarifying GPC's I/O buffering strategies,
and David Kastrup from the \.{de.comp.text.tex} news group for
enlightening articles on some of \TeX's more obscure features and for
discussing the `empty last line error'.
\filbreak
The 2008 edition of \namegpc\ was tested on NetBSD 3.1 and GPC~20020510,
which happens to be the version of GNU~Pascal offered in the NetBSD
package collection. This edition was run on Mac~OS~X 10.6.2 and
GPC~20070904.  Most people seem to run \namegpc\ with the current GPC
version, which caused trouble in two cases:
(1) The integer parameter to be passed to \\{gpc\_install\_signal\_handler}
is now of type \\{cinteger} instead of \\{integer}. (2) The function
\\{gpc\_install\_signal\_handler} was mistreated as a procedure by
\namegpc, and the current version of GPC won't let you go away with
that anymore. Luis Rivera and Martin Monperrus detected this error,
and Martin suggested to publish an edition that runs with the current
version of GPC which is this one.

Joachim Kuebart spotted another error in the 2008 edition. When the
first line consists of blanks only, a loop is not terminated properly.
Joachim found this by reading this document, not by running \namegpc.
This in turn motivated me to improve the comments resulting in a
lot of changes.

\namegpc\ slightly differs from \TeX: On input, trailing blanks are
not removed, on input of the first line, leading blanks are not
removed either. This lets you interactively enter `\.{I \\showbox0\
}' to make \namegpc\ show box 0.  This doesn't work if the trailing
blank were removed.

\TeX\ writes an additional empty line whenever it prompts you on
the terminal.  \namegpc\ doesn't. Finally \TeX\ emits an `\.{Underfull
\\hbox}' warning whenever the last line of a paragraph happens to include
glue only, because then \TeX\ would erroneously remove the
\.{parfillskip}. \namegpc\ will keep it.

% \TeX82 will emit an underfull box warning here, \namegpc\ won't.
\setbox0=\hbox to \hsize {\hfil\ \strut}
\noindent\box0\ \ \par
\bigskip
\address
\fi
@z

[2] Change the banner line
@x
known as `\TeX' [cf.~Stanford Computer Science report CS1027,
November 1984].

@d banner=='This is TeX, Version 3.1415926' {printed when \TeX\ starts}
@y
known as `\TeX' [cf.~Stanford Computer Science report CS1027,
November 1984].

\marke h Since \namegpc\ differs from \TeX\ to make me happy, I have to
change the banner line.

@d banner=='This is TeX-GPC'
@z

[4] program header
@x
@d mtype==t@&y@&p@&e {this is a \.{WEB} coding trick:}
@y

\marke P Pascal wants the identifiers of the standard text files
\\{input} and \\{output} in the parameterlist of the program header.

\marke N One of the \.{WEB} macros is named \\{input}
as well. To make \.{TANGLE} write \.{INPUT} into the Pascal source
file instead of the expansion of the macro, you code the name as
a concatenation of one letter identifiers since one letter identifiers
cannot be macro names. The same
applies to \\{type}.

\marke G To access declarations from GPC's runtime system you need
to |gpc_import| @!|gpc_gpc|. |gpc_only| avoids further name clashes.

\marke N The procedure |initialize| passes |set_interrupt| to
|gpc_install_signal_handler|. Since |set_interrupt| is declared
further down, you need a |forward| declaration.

@d term_in==i @& n @& p @& u @& t
@d term_out==o @& u @& t @& p @& u @& t
@d mtype==t @& y @& p @& e
@f mtype==type
@d gpc_import==i @& m @& p @& o @& r @& t
@f gpc_import==label
@d gpc_only==o @& n @& l @& y
@f gpc_only==then
@d gpc_gpc==g @& p @& c
@z

[4] program header
@x
program TEX; {all file names are defined dynamically}
@y
program TEX(@!term_in,@!term_out);
gpc_import gpc_gpc gpc_only
(gpc_execute,gpc_install_signal_handler, gpc_sig_int);
@z

[4] forward reference for signal handler
@x
procedure initialize; {this procedure gets things started properly}
@y
procedure set_interrupt(signal: gpc_integer); forward; @t\2@>
@#
procedure initialize; {this procedure gets things started properly}
@z

Since @x, @y, and @z only define a change block when they begin a
line, you deactivate a block by indenting it (shift right) and
activate it by unindenting it (shift left).  With vi set the cursor
to the @x line and type >} or <} to (un)indent a paragraph.

[7] shift left to turn debugging on, right to turn it off
@x
@d debug==@{ {change this to `$\\{debug}\equiv\null$' when debugging}
@d gubed==@t@>@} {change this to `$\\{gubed}\equiv\null$' when debugging}
@y
@d debug== {change this to `$\\{debug}\equiv\.{@@\{}$' when not debugging}
@d gubed== {change this to `$\\{gubed}\equiv\.{@@\}}$' when not debugging}
@z

[7] shift left to turn stats on, right to turn them off.
@x
@d stat==@{ {change this to `$\\{stat}\equiv\null$' when gathering
  usage statistics}
@d tats==@t@>@} {change this to `$\\{tats}\equiv\null$' when gathering
  usage statistics}
@y
@d stat== {change this to `$\\{stat}\equiv\.{@@\{}$' to turn off statistics}
@d tats== {change this to `$\\{tats}\equiv\.{@@\}}$' to turn off statistics}
@z


[8] shift left to build TEX and right to build INITEX.
	@x initex
	@d init== {change this to `$\\{init}\equiv\.{@@\{}$' in the production version}
	@d tini== {change this to `$\\{tini}\equiv\.{@@\}}$' in the production version}
	@y
	@d init==@{ {change this to `$\\{init}\equiv $' for \.{INITEX}}
	@d tini==@t@>@} {change this to `$\\{tini}\equiv $' for \.{INITEX}}
	@z

[9] compiler directives, turn off I/O checking.
@x
@^overflow in arithmetic@>
@y
@^overflow in arithmetic@>

\marke G If the first character of a \PASCAL\ comment is a dollar
sign, GNU~Pascal treats the comment as a ``compiler directive''.
GPC aborts when it detects an I/O error. To let  \namegpc\ handle
an I/O error while opening an input file, you have to turn off I/O
checking altogether by the \.{I-} directive.

\marke b In contrast to \ph\ GNU~Pascal offers no directive to
check for arithmetic overflow.

\marke e Knuth suggests to turn on range checking while debugging.
GPC aborts when it spots range violation. Those violations might
happen when the debugger shows a memeroy cell assumed to contain a
|glue_ratio|.  Even though turning of range checking doubles the
speed of \TeX\ I suggest to turn it on when not debugging, just to
get another check from Knuth for discovering an error.

@^system dependencies@>
@^GNU Pascal@>
@z

[9] compiler directives, turn off I/O checking, continued
@x
@{@&$C-,A+,D-@} {no range check, catch arithmetic overflow, no debug overhead}
@!debug @{@&$C+,D+@}@+ gubed {but turn everything on when debugging}
@y
@{@&$I-@} {no I/O checking}
@!debug @{@&$R-@}@+ gubed {no range check while debugging}
@z

[10] default case branch
@x
\PASCAL s have, in fact, done this, successfully but not happily!)
@:PASCAL H}{\ph@>

@d othercases == others: {default for cases not listed explicitly}
@y
\PASCAL s have, in fact, done this, successfully but not happily!)
@:PASCAL H}{\ph@>

\marke G This is the only place I voluntarily use a GPC extension
to Pascal. GPC offers |otherwise| and |else|. I decided for |else|
because I do not want to add
another gpc-keyword. Furthermore, Wirth uses |else| in Modula~2.
@^GNU Pascal@>

@d othercases == @+ else {default for cases not listed explicitly}
@z

[11]
@x
in production versions of \TeX.
@y
in production versions of \TeX.

\marke N I didn't change the constants, leaving it up to you to
adopt them to your task. Just keep the Pascal source for \.{tex}
around. So you can change them without going all the way through
modifying \.{tex.ch} and tangeling it.  Note that for \.{initex}
|mem_top| and |mem_max| must agree.

\marke U One of the constants is the filename of the string pool
file which needs an adoption to Unix.
@z

The changes headed by trip need to be made for the trip test suite.

[11]
	@x trip
	@!mem_max=30000; {greatest index in \TeX's internal |mem| array;
	@y
	@!mem_max=3000; {greatest index in \TeX's internal |mem| array;
	@z

[11]
	@x trip
	@!mem_min=0; {smallest index in \TeX's internal |mem| array;
	@y
	@!mem_min=1; {smallest index in \TeX's internal |mem| array;
	@z

[11]
	@x trip
	@!error_line=72; {width of context lines on terminal error messages}
	@!half_error_line=42; {width of first lines of contexts in terminal
	  error messages; should be between 30 and |error_line-15|}
	@!max_print_line=79; {width of longest text lines output; should be at least 60}
	@y
	@!error_line=64; {width of context lines on terminal error messages}
	@!half_error_line=32; {width of first lines of contexts in terminal
	  error messages; should be between 30 and |error_line-15|}
	@!max_print_line=72; {width of longest text lines output; should be at least 60}
	@z

[11] location of pool file
@x
@!pool_name='TeXformats:TEX.POOL                     ';
@y
@!pool_name='TeXformats/tex.pool                     ';
@z


[12]
	@x trip
	@d mem_bot=0 {smallest index in the |mem| array dumped by \.{INITEX};
	  must not be less than |mem_min|}
	@d mem_top==30000 {largest index in the |mem| array dumped by \.{INITEX};
	  must be substantially larger than |mem_bot|
	  and not greater than |mem_max|}
	@y
	@d mem_bot=1 {smallest index in the |mem| array dumped by \.{INITEX};
	  must not be less than |mem_min|}
	@d mem_top==3000 {largest index in the |mem| array dumped by \.{INITEX};
	  must be substantially larger than |mem_bot|
	  and not greater than |mem_max|}
	@z


[25]
@x
for us to specify simple operations on word files before they are defined.
@y
for us to specify simple operations on word files before they are
defined.

\marke G
GNU~Pascal ignores |packed| for file types. Integer subranges occupy
32 bits, so it writes 4 byte for every |eight_bits| element.
GNU~Pascal offers two extensions to get at 8 bit bytes: Use the
predefined type |byte| for |eight_bits| or pack the subrange type.
Since packing subrange types is rather strange extension to Pascal, I decided
for the byte.
@d gpc_byte==b @& y @& t @& e

@^GNU Pascal@>
@z

[25] the type of text_files is text
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@!alpha_file=packed file of text_char; {files that contain textual data}
@y
@!eight_bits=gpc_byte; {unsigned one-byte quantity}
@!alpha_file=t @& e @& x @& t; {\marke P Pascal requires |text|}
@z

[27]
@x
\TeX's file-opening procedures return |false| if no file identified by
|name_of_file| could be opened.

@d reset_OK(#)==erstat(#)=0
@d rewrite_OK(#)==erstat(#)=0
@y
\marke G In Pascal, external files must occur in the program heading
and GNU~Pascal asks the user whenever an external file is
opened.  But \.{initex} wants to reset \.{tex.pool} and rewrite
\.{plain.fmt} without asking
the user for the file name.
We are lucky: GNU~Pascal lets you open external files by passing its name as
a second argument to |reset| resp. |rewrite|. The function |gpc_trim|
removes trailing spaces that would otherwise be part of the file
name. The function |gpc_io_result| returns a nonzero value if any
error occurred since the last invocation of |gpc_io_result|.

\marke G Buffering output of the DVI file accelerates \namegpc\
dramatically.  To get at output buffering, the file needs to be a
|gpc_untyped_file|;

@^GNU Pascal@>
@^system dependencies@>

@d gpc_trim==t@&r@&i@&m
@d gpc_io_result==i@&o@&r@&e@&s@&u@&l@&t
@d reset_OK(#)==gpc_io_result=0
@d rewrite_OK(#)==gpc_io_result=0
@d clear_io_result==@+if gpc_io_result=0 then do_nothing
@z

[27] reset and rewrite for each of three file types
@x alpha_file
begin reset(f,name_of_file,'/O'); a_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); a_open_in:=reset_OK(f);
@z
@x 
begin rewrite(f,name_of_file,'/O'); a_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
a_open_out:=rewrite_OK(f);
@z

byte_file
@x
begin reset(f,name_of_file,'/O'); b_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); b_open_in:=reset_OK(f);
@z
@x
function b_open_out(var f:byte_file):boolean;
  {open a binary file for output}
begin rewrite(f,name_of_file,'/O'); b_open_out:=rewrite_OK(f);
@y
function b_open_out(var f:gpc_untyped_file):boolean;
  {open a binary file for output}
begin clear_io_result; rewrite(f,gpc_trim(name_of_file),1);
b_open_out:=rewrite_OK(f);
@z

@x word_file
begin reset(f,name_of_file,'/O'); w_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); w_open_in:=reset_OK(f);
@z
@x
begin rewrite(f,name_of_file,'/O'); w_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
w_open_out:=rewrite_OK(f);
@z

[28] reference to GNU~Pascal:
@x
These procedures should not generate error messages if a file is
being closed before it has been successfully opened.
@y
These procedures should not generate error messages if a file is
being closed before it has been successfully opened.

\marke G GNU~Pascal has accidently a very similar procedure |gpc_close|.
But we need another routine to close a |gpc_untyped_file|, which is
necessary for buffering the output.
@^GNU Pascal@>

@d gpc_close==c@&l@&o@&s@&e
@z

@x
procedure w_close(var f:word_file); {close a word file}
begin close(f);
end;
@y
procedure w_close(var f:word_file); {close a word file}
begin close(f);
end;
@#
procedure u_close(var f:gpc_untyped_file); {close an untyped file}
begin close(f);
end;
@z

[31]
@x
finer tuning is often possible at well-developed \PASCAL\ sites.
@^inner loop@>

@p function input_ln(var f:alpha_file;@!bypass_eoln:boolean):boolean;
  {inputs the next line or returns |false|}
var last_nonblank:0..buf_size; {|last| with trailing blanks removed}
begin if bypass_eoln then if not eof(f) then get(f);
  {input the first character of the line into |f^|}
last:=first; {cf.\ Matthew 19\thinspace:\thinspace30}
if eof(f) then input_ln:=false
else  begin last_nonblank:=first;
  while not eoln(f) do
    begin if last>=max_buf_stack then
      begin max_buf_stack:=last+1;
      if max_buf_stack=buf_size then
        @<Report overflow of the input buffer, and abort@>;
      end;
    buffer[last]:=xord[f^]; get(f); incr(last);
    if buffer[last-1]<>" " then last_nonblank:=last;
    end;
  last:=last_nonblank; input_ln:=true;
  end;
end;
@y
finer tuning is often possible at well-developed \PASCAL\ sites.
@^inner loop@>

\marke h Since \namegpc\ does not remove trailing spaces, |buffer[last-1]|
might hold a space.

\marke P
\ph\ lets you |reset| the terminal input file with the first |get|
`surpressed'.  For several reasons, this feature is not exploited by
\namegpc. First, it is not provided by GPC. Second rightly so, since it violates the
specification of Pascal. Third, it makes the program quite ugly by
destroying the beautiful equivalence of terminal and disk files.
Fourth, since \namegpc\ uses Pascal's standard text file |input|,
it should not reset that file at all.  Fifth, surpressing the first
|get| is offered by \ph\ to address a problem, namely that the
program stays in the reset function waiting for user input and this
problem is solved much more beautiful by ``lazy I/O'', whereby the
program only waits for user input if it is needed. This is suggested
in the {\sl Pascal User Manual}, implemented by GNU~Pascal and
exploited by \namegpc. This leads to a much cleaner implementaion
of |input_ln|, which can always savely assume that |f^| holds the
first character of the next line. This condition is established by
Pascal's |reset| and maintained by |input_ln|.

\marke h
Unlike \TeX82 \namegpc\ leaves trailing spaces in the input line.

\marke G Frank Heckenbach pointed out that GNU~Pascal employes
buffered I/O on input files---no need to avoid high system overhead
here.
@^Heckenbach, Frank@>

@p function input_ln(var f:alpha_file;@!bypass_eoln:boolean):boolean;
  {inputs the next line or returns |false|}
begin
  {ignore |bypass_eoln|. Assuming |f| being positioned at the first character}
last:=first; {cf.\ Matthew 19\thinspace:\thinspace30}
if eof(f) then input_ln:=false
else  begin 
  while not eoln(f) do
    begin if last>=max_buf_stack then
      begin max_buf_stack:=last+1;
      if max_buf_stack=buf_size then begin
	read_ln(f); {complete the current line}
	@<Report overflow of the input buffer, and abort@>;
	end;
      end;
    buffer[last]:=xord[f^]; get(f); incr(last);
    end;
  get(f); {Advance |f| to the first character of the next line}
  input_ln:=true;
  end;
end;
@z

[32] term_in and term_out are the standard pascal files
@x
is considered an output file the file variable is |term_out|.
@^system dependencies@>

@<Glob...@>=
@!term_in:alpha_file; {the terminal as an input file}
@!term_out:alpha_file; {the terminal as an output file}
@y
is considered an output file the file variable is |term_out|.
\marke P Pascal's standard text files are declared implicitly.
@z

[33]
@x
@ Here is how to open the terminal files
in \ph. The `\.{/I}' switch suppresses the first |get|.
@:PASCAL H}{\ph@>
@^system dependencies@>

@d t_open_in==reset(term_in,'TTY:','/O/I') {open the terminal for text input}
@d t_open_out==rewrite(term_out,'TTY:','/O') {open the terminal for text output}
@y
@ Here is how to open the terminal files
in \ph. The `\.{/I}' switch suppresses the first |get|.
@:PASCAL H}{\ph@>
@^system dependencies@>

\marke P In Pascal, the standard text files are openend implicitly.

@d t_open_in==do_nothing {open the terminal for text input}
@d t_open_out==do_nothing {open the terminal for text output}
@z

[34]
@x
some instruction to the operating system.  The following macros show how
these operations can be specified in \ph:
@:PASCAL H}{\ph@>
@^system dependencies@>
@y
some instruction to the operating system.

\marke G Nothing needs to be done to update the terminal, since
GNU~Pascal does not employ buffered output on typed files. I do not
know how to clear the type ahead buffer, so \namegpc\ does nothing
here.  Unix holds terminal output, when it receives \.{\^S} and
continues writing to the terminal, when it receives \.{\^Q}.  These
`flow control' characters only work when sent from the terminal but
not when sent to the terminal.  \marke B Here I give up, since I
don't know how to restart the output from the writing side so
\namegpc\ does nothing. Mac OS X does not stop terminal output when
it receives \.{\^S}.

@^GNU Pascal@>
@^system dependencies@>
@z

[34]
@x
@d update_terminal == break(term_out) {empty the terminal output buffer}
@d clear_terminal == break_in(term_in,true) {clear the terminal input buffer}
@d wake_up_terminal == do_nothing {cancel the user's cancellation of output}
@y
@d update_terminal == do_nothing {empty the terminal output buffer}
@d clear_terminal == do_nothing {clear the terminal input buffer}
@d wake_up_terminal == do_nothing {cancel the user's cancellation of output}
@z

[36] command line
@x
not be typed immediately after~`\.{**}'.)

@d loc==cur_input.loc_field {location of first unread character in |buffer|}

@y
not be typed immediately after~`\.{**}'.)

\marke F This procedure puts the command line arguments separated
by spaces into |buffer|. Like |input_ln| it updates |last| so that
|buffer[first..last)| will contain the command line.

\marke G GNU~Pascal's function~|@!gpc_param_count| gives the number of
command line arguments. The function~|@!gpc_param_str(n)| returns the
n-th argument for |0 <= n <= gpc_param_count| in a |@!gpc_string|,
whose length is returned by the function~|@!gpc_length|.
A |gpc_string| is like a |packed array[1..gpc_length] of char| with
varying length.

@^GNU Pascal@>
@^system dependencies@>

@d loc==cur_input.loc_field {location of first unread character in |buffer|}
@d gpc_string==s @& t @& r @& i @& n @& g {a string with varying length}
@d gpc_length==l @& e @& n @& g @& t @& h
@d gpc_param_count==p @& a @& r @& a @& m @& c @& o @& u @& n @& t
@d gpc_param_str==p @& a @& r @& a @& m @&s @& t @& r
  {GPC function returning the length of a |gpc_string|}

@p procedure input_command_ln; {get the command line in |buffer|}
var argc: integer; {argument counter}
    arg: gpc_string; {argument}
    cc: integer; {character counter in argument}
begin last := first; argc := 1;
while argc <= gpc_param_count do
  begin cc := 1; arg := gpc_param_str(argc); incr(argc);
  while cc <= gpc_length(arg) do
    begin
    if last+1>=buf_size then
      @<Report overflow of the input buffer, and abort@>;
    buffer[last] := xord[arg[cc]]; incr(last); incr(cc);
    end;
  if (argc <= gpc_param_count) then begin
    buffer[last] := " "; incr(last); {insert a space between arguments}
    end;
  end;
end;
@z

[37] command line.
@x
@ The following program does the required initialization
without retrieving a possible command line.
It should be clear how to modify this routine to deal with command lines,
if the system permits them.
@^system dependencies@>

@p function init_terminal:boolean; {gets the terminal input started}
label exit;
begin t_open_in;
loop@+begin wake_up_terminal; write(term_out,'**'); update_terminal;
@.**@>
  if not input_ln(term_in,true) then {this shouldn't happen}
    begin write_ln(term_out);
    write(term_out,'! End of file on the terminal... why?');
@.End of file on the terminal@>
    init_terminal:=false; return;
    end;
  loc:=first;
  while (loc<last)and(buffer[loc]=" ") do incr(loc);
  if loc<last then
    begin init_terminal:=true;
    return; {return unless the line was all blank}
    end;
  write_ln(term_out,'Please type the name of your input file.');
  end;
exit:end;
@y
@ \marke F The following program treats a non empty command line as
the first line.

The 2008 edition of \namegpc\ erranously assumed |buffer[last-1] <> " "|
which does not hold if your first line is all blank as Joachim Kuebart noted.
@^Kuebart, Joachim@>

@p function init_terminal:boolean; {gets the terminal input started}
label exit;
begin t_open_in; input_command_ln;
while first=last do begin
  wake_up_terminal; write(term_out,'**'); update_terminal;
@.**@>
  if not input_ln(term_in, true) then {this shouldn't happen}
    begin write_ln(term_out);
    write_ln(term_out,'! End of file on the terminal... why?');
@.End of file on the terminal@>
    init_terminal:=false; return;
    end;
  if first=last then
    write_ln(term_out,'Please type the name of your input file.');
  end;
loc := first;
init_terminal:=true;
exit: end;
@z

[79] start editor
@x
contains entries in positions |0..(help_ptr-1)|. They should be printed
in reverse order, i.e., with |help_line[0]| appearing last.
@y
contains entries in positions |0..(help_ptr-1)|. They should be printed
in reverse order, i.e., with |help_line[0]| appearing last.

\marke F \namegpc\ lets the user jump into \.{vi} to edit the current input
file at the current line. After saveing line number and file name
\namegpc\ jumps out and then launches \.{vi} passing the saved values.

@z

@x
@!use_err_help:boolean; {should the |err_help| list be shown?}
@y
@!use_err_help:boolean; {should the |err_help| list be shown?}
@!edit_line: integer; {line number to be passed to the system editor}
@!edit_file_name: str_number; {file name to be passed to the system editor}
@z

[80] initial value for edit arguments
@x
help_ptr:=0; use_err_help:=false;
@y
help_ptr:=0; use_err_help:=false; edit_line:=0; edit_file_name:=0; 
@z

[84] set edit_cmd
@x
  begin print_nl("You want to edit file ");
@.You want to edit file x@>
  slow_print(input_stack[base_ptr].name_field);
  print(" at line "); print_int(line);
  interaction:=scroll_mode; jump_out;
  end;
@y
  begin {save values to be passed to the system editor\marke F}
  edit_file_name := input_stack[base_ptr].name_field;
  edit_line := line;
  interaction:=scroll_mode; jump_out;
  end;
@z

[96] interrupt is predefined and not implemented in GNU~Pascal
@x
a way to make |interrupt| nonzero using the \PASCAL\ debugger.
@y
a way to make |interrupt| nonzero using the \PASCAL\ debugger.

\marke G GNU~Pascal reserves the identifier \\{interrupt},
which seems a bug. \.{WEB} provides a simple workaround.
@^GNU Pascal@>
@d interrupt==tex_interrupt
@f interrupt==true
@z

[109]
@x
routines cited there must be modified to allow negative glue ratios.)
@y
routines cited there must be modified to allow negative glue ratios.)

\marke G In GNU~Pascal a |gpc_short_real| has the desired size.
@d gpc_short_real==s @& h @& o @& r @& t @& r @& e @& a @& l
@z

@x
@!glue_ratio=real; {one-word representation of a glue expansion factor}
@y
@!glue_ratio=gpc_short_real; {one-word representation of a glue expansion
			 factor in GNU~Pascal}
@^GNU Pascal@>
@z

[112]
@x
macros are simplified in the obvious way when |min_quarterword=0|.
@^inner loop@>@^system dependencies@>

@d qi(#)==#+min_quarterword
  {to put an |eight_bits| item into a quarterword}
@d qo(#)==#-min_quarterword
  {to take an |eight_bits| item out of a quarterword}
@d hi(#)==#+min_halfword
  {to put a sixteen-bit item into a halfword}
@d ho(#)==#-min_halfword
  {to take a sixteen-bit item from a halfword}
@y
macros are simplified in the obvious way when |min_quarterword=0|.
\marke G And this can be done here!
@^inner loop@>@^system dependencies@>

@d qi(#)==#
  {to put an |eight_bits| item into a quarterword}
@d qo(#)==#
  {to take an |eight_bits| item out of a quarterword}
@d hi(#)==#
  {to put a sixteen-bit item into a halfword}
@d ho(#)==#
  {to take a sixteen-bit item from a halfword}
@z

[241]
@x
users probably want a better approximation to the truth.
@y
users probably want a better approximation to the truth.

\marke G GNU~Pascal provides the |gpc_get_time_stamp|~function,
which stores the system time in its argument.

@^GNU Pascal@>
@d gpc_time_stamp == t@&i@&m@&e@&s@&t@&a@&m@&p
@d gpc_get_time_stamp == g@&e@&t@&t@&i@&m@&e@&s@&t@&a@&m@&p
@d gpc_minute == m@&i@&n@&u@&t@&e
@d gpc_hour == h@&o@&u@&r
@d gpc_day==d@&a@&y
@d gpc_month==m@&o@&n@&t@&h
@d gpc_year==y@&e@&a@&r
@z

[241]
@x
begin time:=12*60; {minutes since midnight}
day:=4; {fourth day of the month}
month:=7; {seventh month of the year}
year:=1776; {Anno Domini}
end;
@y
var t: gpc_time_stamp;
begin
gpc_get_time_stamp(t);
time:=t.gpc_minute + t.gpc_hour*60; {minutes since midnight}
day:=t.gpc_day;
month:=t.gpc_month;
year:=t.gpc_year; {Anno Domini}
end;
@z

[360] Don't print empty lines
@x
@ All of the easy branches of |get_next| have now been taken care of.
There is one more branch.
@y
@ All of the easy branches of |get_next| have now been taken care of.
There is one more branch.

\marke h \TeX82 ends the current line by calling |print_ln| even
if the line is empty.  This causes an additional empty line that I
want to avoid.  Calling |print_nl("")| is smarter.  It ends
the current line only if it is not empty.
@z

@x
    print_ln; first:=start;
@y
    print_nl(""); first:=start;
@z

@x [514]
|TEX_font_area|.  These system area names will, of course, vary from place
to place.
@y
|TEX_font_area|.  These system area names will, of course, vary from place
to place.

\marke U Use the Unix file separator.
@z

[514]
@x
@d TEX_area=="TeXinputs:"
@.TeXinputs@>
@d TEX_font_area=="TeXfonts:"
@.TeXfonts@>
@y
@d TEX_area=="TeXinputs/" {i.e., a subdirectory of the working directory}
@.TeXinputs@>
@d TEX_font_area=="TeXfonts/" {dito}
@.TeXfonts@>
@z

[516]
@x
  if (c=">")or(c=":") then
@y
  if c="/" then {use ``/'' as a file name separator\marke U}
@z

[521]
@x
TEX_format_default:='TeXformats:plain.fmt';
@y
TEX_format_default:='TeXformats/plain.fmt';
 {``/'' is the Unix file name separator\marke U}
@z

[532] untyped file inclusion
@x
ship out a box of stuff, we shall use the macro |ensure_dvi_open|.
@y
ship out a box of stuff, we shall use the macro |ensure_dvi_open|.

\marke G To get buffered output, the file needs to be a |gpc_untyped_file|.

@d gpc_untyped_file == f@&i@&l@&e
@z

@x
  output_file_name:=b_make_name_string(dvi_file);
@y
  output_file_name:=make_name_string;
@z

@x
@!dvi_file: byte_file; {the device-independent output goes here}
@y
@!dvi_file: gpc_untyped_file; {the device-independent output goes here}
@z

[537]
@x
@ Let's turn now to the procedure that is used to initiate file reading
when an `\.{\\input}' command is being processed.

@y
@ Let's turn now to the procedure that is used to initiate file reading
when an `\.{\\input}' command is being processed.

\marke e Keep the complete file name since it might be needed to
be passed to the system editor.
(\TeX82 strips off area and extension to conserve string
pool space.)
@z

[537]
@x
if name=str_ptr-1 then {we can conserve string pool space now}
  begin flush_string; name:=cur_name;
  end;
@y
@z

[597] use buffered output for dvi file
@x
output an array of words with one system call.
@y
output an array of words with one system call.

\marke G In fact, buffering dramatically cuts down system overhead.  To
compile this document, a program without buffering spent $48.45\rm\,s$
in the kernel but with buffering only $0.57\rm\,s$.  The total
times were $64.45\rm\,s$ vs. $11.40\rm\,s$.

GNU~Pascal's |@!gpc_block_write| procedure takes an untyped |file|, an
|array| and the number of bytes to be written.
The |array| here is given as
a `slice', another extension of GNU~Pascal. It should be clear,
what |buffer[a..b]| means.  This simple change was suggested by
Emil Jerabek.
@^Jerabek, Emil@>

@d gpc_block_write == b @& l @& o @& c @& k @& w @& r @& i @& t @& e 
@z

[597] use buffered output for dvi file
@x
@p procedure write_dvi(@!a,@!b:dvi_index);
var k:dvi_index;
begin for k:=a to b do write(dvi_file,dvi_buf[k]);
end;
@y
@p procedure write_dvi(@!a,@!b:dvi_index);
begin gpc_block_write(dvi_file,dvi_buf[a..b], b-a+1);
end;
@z

[642]
@x
  b_close(dvi_file);
@y
  u_close(dvi_file); {\marke G |dvi_file| is an untyped file}
@z

[816] save pointer to penalty_node
@x
same number of |mem|~words.
@^data structure assumptions@>
@y
same number of |mem|~words.
@^data structure assumptions@>

\marke E
\TeX82 prunes discardable nodes from the beginning of a new line until
it reaches a nondiscardable node. Now, if the last line of a paragraph
contains discardables only, the \.{\\parfillskip} glue at the end of the
paragraph will also be removed, since it is a discardable. This will
give you an empty \.{\\hbox}. Finally \TeX\ appends \.{\\rightskip} glue.
This gives you a nonempty \.{\\hbox}, raising a \.{Underfull \\hbox}
warning.

To avoid this happening, \namegpc\ saves a pointer to the node
immediately preceding the \.{\\parfillskip} node and quits pruning
when it encounters this node several procedures later.
@^Underfull \\hbox...@>
@z

@x
link(tail):=new_param_glue(par_fill_skip_code);
@y
non_prunable_p := tail; {points to the node immediately before
\.{\\parfillskip}}
link(tail):=new_param_glue(par_fill_skip_code);
@z

[862] declare non_prunable_p
@x
The following declarations provide for a few other local variables that are
used in special calculations.

@y
The following declarations provide for a few other local variables that are
used in special calculations.

\marke E Declare the |non_prunable_p| pointer.
@z

@x
@!auto_breaking:boolean; {is node |cur_p| outside a formula?}
@y
@!auto_breaking:boolean; {is node |cur_p| outside a formula?}
non_prunable_p:pointer; {pointer to the node before \.{\\parfillskip}}
@z

[876] pass non_prunable_p
@x
(By introducing this subprocedure, we are able to keep |line_break|
from getting extremely long.)
@y
(By introducing this subprocedure, we are able to keep |line_break|
from getting extremely long.)

\marke E Pass |non_prunable_p| to the |post_line_break|~procedure.
@z

@x
post_line_break(final_widow_penalty)
@y
post_line_break(final_widow_penalty, non_prunable_p)
@z

[877] declare non_prunable_p
@x
of their new significance.) Then the lines are justified, one by one.

@y
of their new significance.) Then the lines are justified, one by one.

\marke E Declare another parameter. It holds the pointer to the node
immediately preceding \.{\\parfillskip}.
@z

@x
procedure post_line_break(@!final_widow_penalty:integer);
@y
procedure post_line_break(@!final_widow_penalty:integer;
  non_prunable_p:pointer);
@z

[879]
@x
are computed for non-discretionary breakpoints.
@y
are computed for non-discretionary breakpoints.

\marke E The pointer |non_prunable_p| references the node immediately
preceding the \.{\\parfillskip} node at the end of the paragraph.
Stop pruning at this node.
@z

[879]
@x
  if non_discardable(q) then goto done1;
@y
  if non_discardable(q) then goto done1;
  if q = non_prunable_p then goto done1; {retain \.{\\parfillskip} glue}
@z

[1332]
@x
The initial test involving |ready_already| should be deleted if the
\PASCAL\ runtime system is smart enough to detect such a ``mistake.''
@^system dependencies@>
@y
The initial test involving |ready_already| should be deleted if the
\PASCAL\ runtime system is smart enough to detect such a ``mistake.''
@^system dependencies@>

\marke h \namegpc\ tries to load the format file even before it
initializes the output routines. That way, it will print the name of
the format file on the terminal.

\marke G 
|@!gpc_execute| starts the system editor (vi) and |@!gpc_halt|
passes the |history| as an exit code to the shell.

@^system dependencies@>
@^GNU Pascal@>
@^Unix@>

@d gpc_halt == h@&a@&l@&t
@z

[1332]
@x
start_of_TEX: @<Initialize the output routines@>;
@y
start_of_TEX: @<Preload the default format file@>;
@<Initialize the output routines@>;
@z

[1332]
@x
final_end: ready_already:=0;
@y
final_end:
if edit_file_name > 0 then start_editor; {user typed `\.{E}' \marke F}
gpc_halt(history);
  {pass |history| as the exit value to the system\marke u}
@z

[1333] print last end-of-line marker if needed
@x
This program doesn't bother to close the input files that may still be open.
@y
This program doesn't bother to close the input files that may still be open.

\marke h
Special care is taken to terminate the last line on the terminal.

@z

[1333] print last end-of-line marker if needed
@x
    slow_print(log_name); print_char(".");
    end;
  end;
end;
@y
    slow_print(log_name); print_char(".");
    end;
  end;
  if term_offset > 0 then wterm_cr;
end;
@z

[1338] return if eof.
@x
program below. (If |m=13|, there is an additional argument, |l|.)
@.debug \#@>

@y
program below. (If |m=13|, there is an additional argument, |l|.)
@.debug \#@>

\marke P A Pascal program must not read from the standard text file
if the end of file is reached. Even in this respect, Unix and Pascal
treat terminals and disk files alike.

@z
@x
begin loop begin wake_up_terminal;
@y
begin loop begin; wake_up_terminal;
@z

@x
  read(term_in,m);
@y
  if eof(term_in) then return;
  read(term_in,m);
@z

[1338] return if eof
@x
  else  begin read(term_in,n);
@y
  else  begin if eof(term_in) then return;
  read(term_in,n);
@z

[1339] return if eof
@x
13: begin read(term_in,l); print_cmd_chr(n,l);
@y
13: begin if eof(term_in) then return;
read(term_in,l); print_cmd_chr(n,l);
@z

[1379 and modules added for TeX-GPC]
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.

\marke h Try to preload the default format file. This is called
even before the first line is read from the terminal, and thus
turns \.{VIRTEX} into \.{TEX}, at least as experienced by the user.
\.{INITEX} sets |format_ident| to `\.{INITEX}' and won't load a
format file here.

@<Preload the default format file@>=
if format_ident = 0 then
  begin pack_buffered_name(format_default_length - format_ext_length, 1, 0);
  if not w_open_in(fmt_file) then
    begin
    wterm_ln('I can''t find the format file ', name_of_file);
    goto final_end
    end;
  if not load_fmt_file then
    begin w_close(fmt_file); goto final_end
    end;
  w_close(fmt_file);
  end

@ \marke F If the user typed |'E'| to edit a file after confronted
with an error message, \TeX\ will clean up and then call |start_editor|
as its last feat.  The file name and line number to be
passed to the system editor are saved in |edit_file_name| and
|edit_line|.

This procedure must not print error messages, since all files are already
closed.

Beware of using any \.{WEB} strings like \.{"vi +"} since that
would change the string pool file and you'll need to rebuild all
format files with the new string pool in case you disagree which
editor is the system editor.

An overflow of |name_of_file| cannot happen, since |name_of_file|
kept the file name while the file was being opened. \marke G The
@!|gpc_write_str| function writes its arguments into a |gpc_string| to
build the command line.  The function~|@!gpc_execute|
takes a |gpc_string| which holds the command line to be executed.

@^GNU Pascal@>

@d gpc_execute == e@&x@&e@&c@&u@&t@&e
@d gpc_write_str == w@&r@&i@&t@&e@&s@&t@&r

@<Error hand...@>=
procedure start_editor;
var i: integer; {index into |name_of_file|}
    j: pool_pointer; {index into |str_pool|}
    cmd_line: gpc_string(200); {area to build the command line}
begin i := 1; j := str_start[edit_file_name];
while j<str_start[edit_file_name + 1] do
  begin name_of_file[i] := xchr[str_pool[j]]; incr(i); incr(j)
  end;
while i<=file_name_size do begin name_of_file[i] := ' '; incr(i) end;
gpc_write_str(cmd_line, 'vi +', line, ' ', gpc_trim(name_of_file));
if 0 <> gpc_execute(cmd_line) then
  write_ln(gpc_param_str(0), ': could not start editor with: "',
    cmd_line, '"');
end;

@ \marke F The next modules declare and install the interrupt procedure
|set_interrupt|.

The identifiers are truncated by \.{TANGLE} to twelve characters.
We use this trick to persuade \.{TANGLE} to transfer the complete
name to the Pascal source.

@d gpc_install_signal_handler ==
 i@&n@&s@&t@&a@&l@&l@&s@&i@&g@&n@&a@&l@&h@&a@&n@&d@&l@&e@&r
@d gpc_sig_int == s@&i@&g@&i@&n@&t
@d gpc_null == n@&u@&l@&l
@d gpc_integer == cinteger {for earlier versions of GPC (3.2) replace
  \\{cinteger} by \\{integer}}

@<Error hand...@>=
procedure set_interrupt(signal: gpc_integer);
begin interrupt := 1 @+end;

@ To install |set_interrupt| as our `signal handler', I use the
procedure @!|gpc_install_signal_handler|.  It works with these
arguments, but don't ask why. GNU~Pascal's @!|gpc_sig_int| constant
denotes the Unix interrupt signal, which is sent when the user types
\.{\^C}. Then |set_interrupt| is called, which sets the global
variable |interrupt| to one, thus causing \TeX\ to invoke |error|
to engage the user in an error dialog.

The 2008 edition had a bug: It treated the function
|gpc_install_signal_handler| as a procedure. The old GPC version
didn't care, but the current one does.  This was discovered by Luis
Rivera and Martin Monperrus.

@^Rivera, Luis@>
@^Monperrus, Martin@>

@<Initialize whatever ... @>=
if gpc_install_signal_handler(gpc_sig_int,set_interrupt,
  true,true,gpc_null,gpc_null) then do_nothing;
@z
