% This is a change file of TeX for GNU Pascal, Wolfgang Helbig, Nov. 2007
% Handle command line as the first line, Apr. 2008
% Avoid an underful last line,  use buffered output for dvi file, Jul. 2008
% That "finished" the program. But I kept on improving:
% July 2008: Don't print empty lines on terminal and log file.
% Don't trim input lines.

[0] About TeX-GPC
@x
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
@y
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
\input webmac-gpc

\emergencystretch 0.6in % avoid overfull boxes 

\let\maybe=\iffalse % uncomment to print changed modules only.

% put a mark in the left margin. (see Exercise 14.28 in The TeXbook)
\def\marke#1{\strut\vadjust{\kern-\dp\strutbox\vbox to 0pt{\vss
  \llap{\bf #1\/\quad\strut}}}\ignorespaces }

\def\name{\TeX}

\N0\*.  \[0] About \namegpc.
\namegpc\ is a Unix implementation of Donald~E. Knuth's \TeX82 in
the version 3.1415926 from March 2008. It is based on GNU Pascal.
The accompaning \.{README} file tells you how to build and run
\namegpc.  To help you identify the differences of \TeX82\ and
\namegpc, the numbers of modified modules carry an asterisk. Letters
in the left margin indicate the reason for changes. They mean:
\medskip
\item{\bf E} an error in \TeX82 fixed
\item{\bf e} a small error in \TeX82 fixed
\item{\bf F} a feature suggested by Knuth added
\item{\bf f} a feature I feel worthwhile added
\item{\bf P} a Pascal language violation that I managed to avoid
\item{\bf G} explain and use a GNU Pascal extension
\item{\bf U} adaption to Unix
\item{\bf u} usability in a Unix environment enhanced
\medskip
\noindent \TeX82's error that is fixed in \namegpc\ shows up in a
paragraph whose last line contains only glue. \TeX82\ does not
finish that line with \.{\\parfillskip}, \namegpc\ does.  I sent
an error report to Barbara Beeton, and an anonymous bug checker
answered `No Bug'.  He or she reasoned with the source file of
\TeX82---taking the program for its specification!

The small error: \TeX82\ sometimes saves only the name proper of
an input file, \namegpc\ saves its name including path and extension,
since this is what needs to be passed to the system editor.  Note
that this error does not show with the first input file opened in
a job. Since that is the file you usually want to edit, this error
went unnoticed so long.

\namegpc's uppercase features include: It treats the command line
as the first input line; it invokes \.{vi} if the user types `\.{e}'
during error recovery; and you can interrupt \namegpc\ by typing
\.{\^C}.

Two lowercase features I consider being bug fixes
(1)~With input from your terminal, \TeX82
clutters it and the log file with spurious empty lines;
\namegpc\ doesn't---just like \TeX78, as I noted in the video
``TeX~For~Beginners'', session~3.  (2)~Since January~1983 \TeX82\ removes
trailing spaces from input lines for compatibility with IBM's
80~column cards; (see error number 114 in \.{tex82.bug}.) \namegpc\ does
not whereby addressing an annoyance:  When during error recovery
you insert a line that ends with a number you want to mark the end
of the number with a space.  (At least I want to do that.) But
\TeX82 removes it (and the end-of-line character), and reads further
input until it realizes that the sequence of digits ended.  To
witness, type \.{i\\showbox0\\ } during error recovery while the input
comes from the terminal.

And here is a notable violation of Pascal: \TeX82 assumes that
the terminal input file is positioned {\sl before\/} the first
character after being opened, whereas \namegpc\ assumes that it is
positioned {\sl at\/} the first character. Not realizing that the
\ph\ runtime system works like this, I even mailed an error report
to Barbara Beeton just to revoke it two days later much to my
embarassment. With `Pascal' I mean the language as defined in the
third edition of {\sl The Pascal~User~Manual~and~Report\/} published
1985.

GNU Pascal extensions are needed to specify a file name at run time
and to check the existence of files.  Identifiers from GNU~Pascal
are prefixed with \\{gpc\_} to help distinguish them from Pascal
and \.{WEB} identifiers and to avoid name clashes.  Therefore all
GNU~Pascal identifiers will appear together in the index.

There is only one adaption to Unix needed, namely using `\.{/}'
instead of `\.{:}' as the file name separator.

The production version of \namegpc\ loads the default format file
{\sl before} it reads the first input line, in this respect simulating
what Knuth calls \.{TEX}, whereas web2c based implementations load
the format file after reading the first input line, thus resembling
\.{VIRTEX}. Consequently, \namegpc\ includes the format name in the
banner line on the terminal and web2c based implementations don't.
\filbreak
Valid input characters are the 94~visible ASCII characters together
with the three control characters horizontal tabulator, form~feed,
and space.
\filbreak
On exit, \namegpc\ passes its `history' to the operating system.
This integer is zero when everything is fine, one when something
less serious like an overfull box was detected, two when an error
happened like an undefined control sequence, and three when the
program aborted because one of its tables overflowed or because it
couldn't find an input file while running in batch mode.
\filbreak
\TeX82 does arithmetic overflow checking by way of its \ph\ runtime
system.  As far as I know, GNU~Pascal does no overflow checking.
Since I don't feel like adding this to GNU~Pascal or to the Pascal
source, \namegpc\ must do without it.
\filbreak
\namegpc\ is somewhat slower than web2c based programs.  To compile
the device independend file for this document, te\TeX~3.0 spent
$7.54\rm\,s$ and \namegpc\ needed $11.40\rm\,s$.
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
discussing the `empty last line error', which David does not consider
an error at all. And sometimes I agree. It might be better to tell
the user that there is an empty last line with an \.{Underfull \\hbox}
warning, since those lines are usually not wanted, and if they are,
you are free to ignore the warnings.

% \TeX82 will emit an underfull warning here, \namegpc\ won't.
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

@d banner=='This is TeX-GPC'
@z

[4] program header
@x

Actually the heading shown here is not quite normal: The |program| line
does not mention any |output| file, because \ph\ would ask the \TeX\ user
to specify a file name if |output| were specified here.
@:PASCAL H}{\ph@>
@^system dependencies@>

@d mtype==t@&y@&p@&e {this is a \.{WEB} coding trick:}
@y

\marke P Complying with Pascal, \namegpc\ puts the identifiers of
the standard text files \\{input} and \\{output} in the parameterlist
of the program header.  One of the \.{WEB} macros is named \\{input}
as well. To make \.{TANGLE} write \.{INPUT} into the Pascal source
file instead of the expansion of the macro, you code the name as
a concatenation of one letter identifiers since one letter identifiers
cannot be macro names and are not indexed by \.{WEAVE}. The same
applies to \\{type}.

\marke G To access declarations from GPC's runtime system you need
to |import| @!|gpc|. The `\\{only}' feature avoids name clashes.

@d term_in==i@&n@&p@&u@&t
@d term_out==output
@d mtype==t@&y@&p@&e
@f import==label
@f only==then
@z

[4] program header
@x
program TEX; {all file names are defined dynamically}
@y
program TEX(@!term_in,@!term_out);
import gpc only (gpc_execute,gpc_install_signal_handler,
                 gpc_t_signal_handler, gpc_sig_int);
@z

[4] forward reference for signal handler
@x
procedure initialize; {this procedure gets things started properly}
@y
procedure set_interrupt(signal: gpc_integer); forward; @t\2@>
{|initialize| installs |set_interrupt| as a Unix signal handler}
@#
procedure initialize; {this procedure gets things started properly}
@z

Since @x, @y, and @z only define a change block when they begin a
line, you deactivate a block by indenting it (shift right) and
activate it by unindenting it (shift left).  With vi set the cursor
to the @x line and enter >} or <} to (un)indent a paragraph.

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
	@d tini==@} {change this to `$\\{tini}\equiv $' for \.{INITEX}}
	@z

[9] compiler directives, turn off I/O checking.
@x
@ If the first character of a \PASCAL\ comment is a dollar sign,
\ph\ treats the comment as a list of ``compiler directives'' that will
affect the translation of this program into machine language.  The
directives shown below specify full checking and inclusion of the \PASCAL\
debugger when \TeX\ is being debugged, but they cause range checking and other
redundant code to be eliminated when the production system is being generated.
Arithmetic overflow will be detected in all cases.
@:PASCAL H}{\ph@>
@^system dependencies@>
@^overflow in arithmetic@>
@y
@ \marke G If the first character of a \PASCAL\ comment is a dollar
sign, GNU~Pascal treats the comment as a list of ``compiler
directives'' that will affect the translation of this program into
machine language.  The directive shown below specifies that an I/O
error will not terminate the program. That way \TeX\ may search different
directories for an input file and the user gets a chance to correct
the spelling of a file name without stopping the job.

GNU~Pascal does no arithmetic overflow checking but \TeX82 does.
Here \namegpc\ does not comply with \TeX82.
@^system dependencies@>
@^GNU Pascal@>
@z

[9] compiler directives, turn off I/O checking, continued
@x
@{@&$C-,A+,D-@} {no range check, catch arithmetic overflow, no debug overhead}
@!debug @{@&$C+,D+@}@+ gubed {but turn everything on when debugging}
@y
@{@&$I-@} {no I/O checking}
@z

[10] default case branch
@x
@:PASCAL H}{\ph@>

@d othercases == others: {default for cases not listed explicitly}
@y
@^GNU Pascal@>

@d othercases == @+ else {default for cases not listed explicitly\marke G}
@z

Shift left all `trip' blocks to prepare for TRIP.
Shift right all `pirt' blocks to prepare for TRIP.
[11]
@x pirt
@!mem_max=30000; {greatest index in \TeX's internal |mem| array;
@y
@!mem_max=40000; {increased for mfbook
   greatest index in \TeX's internal |mem| array;
@z

[11]
@x pirt
@!font_mem_size=20000; {number of words of |font_info| for all fonts}
@y
@!font_mem_size=30000; {increased for ibycus4,
  number of words of |font_info| for all fonts}
@z

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
  {string of length |file_name_size|; tells where the string pool appears}
@y
@!pool_name='TeXformats/tex.pool                     ';
  {string of length |file_name_size|;
\marke U tells where the string pool appears}
@z


[12] 
@x pirt
@d mem_top==30000 {largest index in the |mem| array dumped by \.{INITEX};
@y
@d mem_top==40000 {largest index in the |mem| array dumped by \.{INITEX};
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

[23]
@x
for i:=0 to @'37 do xchr[i]:=' ';
@y
for i:=0 to @'37 do xchr[i]:=' ';
xchr[@'11] := chr(@'11); {accept horizontal tab\marke u}
xchr[@'14] := chr(@'14); {accept form feed}
@z

[25]
@x
for us to specify simple operations on word files before they are defined.
@y
for us to specify simple operations on word files before they are
defined.

\marke G Violating Pascal, GNU~Pascal wants you to declare the {\sl
subrange\/} type as |packed|. It seems to ignore |packed| with file
types. GNU~Pascal allows buffered output on |untyped| files only
and we want to take advantage of buffering when writing the DVI
file.  Again, I stumble over a name clash: The Pascal predeclared
type for text files and a \.{WEB} macro both are called |text|.
@^GNU Pascal@>
@z

[25] the type of text_files is text in ISO Pascal
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@!alpha_file=packed file of text_char; {files that contain textual data}
@y
@!eight_bits=packed 0..255; {\marke G unsigned one-byte quantity}
@!alpha_file=t@&e@&x@&t; {\marke P Pascal requires |text|}
@!untyped_file=file; {\marke G for the DVI file} 
@z

[27]
@x
@ The \ph\ compiler with which the present version of \TeX\ was prepared has
extended the rules of \PASCAL\ in a very convenient way. To open file~|f|,
we can write
$$\vbox{\halign{#\hfil\qquad&#\hfil\cr
|reset(f,@t\\{name}@>,'/O')|&for input;\cr
|rewrite(f,@t\\{name}@>,'/O')|&for output.\cr}}$$
The `\\{name}' parameter, which is of type `{\bf packed array
$[\langle\\{any}\rangle]$ of \\{char}}', stands for the name of
the external file that is being opened for input or output.
Blank spaces that might appear in \\{name} are ignored.

The `\.{/O}' parameter tells the operating system not to issue its own
error messages if something goes wrong. If a file of the specified name
cannot be found, or if such a file cannot be opened for some other reason
(e.g., someone may already be trying to write the same file), we will have
|@!erstat(f)<>0| after an unsuccessful |reset| or |rewrite|.  This allows
\TeX\ to undertake appropriate corrective action.
@:PASCAL H}{\ph@>
@^system dependencies@>

\TeX's file-opening procedures return |false| if no file identified by
|name_of_file| could be opened.

@d reset_OK(#)==erstat(#)=0
@d rewrite_OK(#)==erstat(#)=0
@y
@ \marke G GNU~Pascal extends the rules of \PASCAL\ in a very
convenient way. To open file~|f|, you write

$$\vbox{\halign{#\hfil\qquad&#\hfil\cr
|reset(f,@t\\{name}@>)|&for input;\cr
|rewrite(f,@t\\{name}@>)|&for output.\cr}}$$

The `\\{name}' parameter holds the name of the external file
that is being opened for input or output.

For the DVI file, we need to open an `untyped' file. Here
\\{rewrite} takes a third parameter, which is always set to one.

The GNU~Pascal function @!|gpc_trim| removes trailing spaces.  GNU~Pascal's
@!|gpc_io_result| function returns an error number.  This number is
set to a nonzero value if an I/O operation failed.  A successfull
I/O operation does not set the error number to zero, but |gpc_io_result|
resets the error number on each call.  Thus, \TeX\ invokes |gpc_io_result|
before opening a file to clear the error number and afterwards to
check it.

@^GNU Pascal@>
@^system dependencies@>

@d gpc_trim==t@&r@&i@&m
@d gpc_io_result==i@&o@&r@&e@&s@&u@&l@&t
@d reset_OK(#)==gpc_io_result=0
@d rewrite_OK(#)==gpc_io_result=0
@d clear_io_result==@+if gpc_io_result=0 then do_nothing
@z

[27] (reset and rewrite for each of three file types) alpha
@x
begin reset(f,name_of_file,'/O'); a_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); a_open_in:=reset_OK(f);
@z

[27]
@x
begin rewrite(f,name_of_file,'/O'); a_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
a_open_out:=rewrite_OK(f);
@z

[27] byte_file
@x
begin reset(f,name_of_file,'/O'); b_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); b_open_in:=reset_OK(f);
@z

[27]
@x
function b_open_out(var f:byte_file):boolean;
  {open a binary file for output}
begin rewrite(f,name_of_file,'/O'); b_open_out:=rewrite_OK(f);
@y
function u_open_out(var f: untyped_file):boolean;
  {open a binary file for buffered output}
begin clear_io_result; rewrite(f,gpc_trim(name_of_file),1);
  u_open_out:=rewrite_OK(f);
@z

[27] word_file
@x
begin reset(f,name_of_file,'/O'); w_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); w_open_in:=reset_OK(f);
@z

[27]
@x
begin rewrite(f,name_of_file,'/O'); w_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
w_open_out:=rewrite_OK(f);
@z

[28] reference to GNU~Pascal:
@x
@ Files can be closed with the \ph\ routine `|close(f)|', which
@:PASCAL H}{\ph@>
@y
@ \marke G Files are closed by the GNU~Pascal routine `@!|close(f)|', which
@^GNU Pascal@>
@z

[31]
@x
Since the inner loop of |input_ln| is part of \TeX's ``inner loop''---each
character of input comes in at this place---it is wise to reduce system
overhead by making use of special routines that read in an entire array
of characters at once, if such routines are available. The following
code uses standard \PASCAL\ to illustrate what needs to be done, but
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

\marke P \namegpc's |input_ln| ignores |bypass_eoln|.
Instead it assumes the precondition that |f^| holds the first
character of the line which is established by Pascal's |reset| and
maintained by |input_ln| in that it bypasses the end-of-line marker
before returning. \ph\ does not establish the condition if opening
a terminal file, and you need to call |get(f)| before you access
|f^|. \TeX82 controls this with the |bypass_eoln| parameter: It
is set to |true| to read the first line from the terminal and set
to |false| to read the first line from a disk file. In the first
case, |input_ln| does not bypass an end-of-line marker but advances
the file pointer to the first character.  GNU~Pascal employs `lazy
input' as suggested by the Pascal~User~Manual:  The program does
not wait for input on behalf of a |reset(f)| or |get(f)| but delays
reading until it uses |f^|.  Unlike \TeX82 \namegpc\ leaves trailing
spaces in the input line. \marke f

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
@ \marke P The \ph\ implementation opened |term_in| with the file
positioned `before' the first character, violating Pascal.  Pascal's
standard text files are opened implicitly with |term_in| positioned
at the first character.

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
GNU~Pascal does not employ buffered output on typed files. I do
not know how to clear the type ahead buffer, so \namegpc\ does
nothing here.  Unix holds terminal output, when it receives \.{\^S}
and continues writing to the terminal, when it receives \.{\^Q}.
These `flow control' characters only work when sent from the terminal
but not when sent to the terminal.  Here I give up, since I don't
know how to restart the output from the `wrong' side so \namegpc\
does nothing.
 
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

\marke G GNU~Pascal's function~@!|gpc_param_count| gives the number of
command line arguments. The function~@!|gpc_param_str(n)| returns the
n-th argument for |1 <= n <= gpc_param_count| in a @!|gpc_string|,
whose length is returned by the function~@!|gpc_length|. Again we
need to resolve a naming conflict here with a \.{WEB} macro.  A
|gpc_string| is like a |packed array[1..gpc_length] of char| with
varying length.

@^GNU Pascal@>
@^system dependencies@>

@d loc==cur_input.loc_field {location of first unread character in |buffer|}
@d gpc_string==s@&t@&r@&i@&n@&g {a string with varying length}
@d gpc_length==l@&e@&n@&g@&t@&h
@d gpc_param_count==p@&a@&r@&a@&m@&c@&o@&u@&n@&t
@d gpc_param_str==p@&a@&r@&a@&m@&s@&t@&r

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
@ \marke F The following program treats a nonempty command line as
the first line.

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
loc := first; {trim leading spaces}
while buffer[loc]=" " do incr(loc);
init_terminal:=true;
exit: end;
@z

[79] start editor
@x
@!use_err_help:boolean; {should the |err_help| list be shown?}
@y
@!use_err_help:boolean; {should the |err_help| list be shown?}
@!edit_line: integer; {line number to be passed to the system editor\marke F}
@!edit_file_name: str_number; {file name to be passed to the system editor}
@z

[80] initial value for edit arguments
@x
help_ptr:=0; use_err_help:=false;
@y
help_ptr:=0; use_err_help:=false; edit_line:=0; edit_file_name:=0; 
{initialize system edit arguments \marke F}
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
which seems a bug. \.{WEB} provides an simple workaround.
@^GNU Pascal@>
@d interrupt==buginterrupt
@f interrupt==true
@z

@x
other data structures. Thus |glue_ratio| should be equivalent to
|short_real| in some implementations of \PASCAL. Alternatively,
@y
other data structures. In GNU~Pascal a |short_real| has the desired size.
Alternatively,
@z

[109]
@x
@!glue_ratio=real; {one-word representation of a glue expansion factor}
@y
@!glue_ratio=short_real; {one-word representation of a glue expansion
			 factor in GNU~Pascal\marke G}
@^GNU Pascal@>
@z

[113]
@x
@!quarterword = min_quarterword..max_quarterword; {1/4 of a word}
@!halfword=min_halfword..max_halfword; {1/2 of a word}
@y
@!quarterword = packed min_quarterword..max_quarterword; {1/4 of a word\marke G}
@!halfword=packed min_halfword..max_halfword; {1/2 of a word\marke G}
@^GNU Pascal@>
@z

[241]
@x
users probably want a better approximation to the truth.
@y
users probably want a better approximation to the truth.

\marke G GNU~Pascal provides the |get_time_stamp|~function, which stores the
system time in its argument. Since \\{day, month,} and \\{year}
are \.{WEB} macros I need to resolve the naming conflict.
@^GNU Pascal@>
@z

[241]
@x
begin time:=12*60; {minutes since midnight}
day:=4; {fourth day of the month}
month:=7; {seventh month of the year}
year:=1776; {Anno Domini}
end;
@y
var t: time_stamp;
begin
get_time_stamp(t);
time:=t.minute + t.hour*60; {minutes since midnight}
day:=t.d@&a@&y;
month:=t.m@&o@&n@&t@&h;
year:=t.y@&e@&a@&r; {Anno Domini}
end;
@z

[360] Don't print empty lines
@x
    print_ln; first:=start;
    prompt_input("*"); {input on-line into |buffer|}
@y
@.Please type...@>
    print_nl("");
    first:=start; {avoid empty lines on terminal and log file\marke f}
    prompt_input("*"); {input on-line into |buffer|}
@z

@x [514]
@ Input files that can't be found in the user's area may appear in a standard
system area called |TEX_area|. Font metric files whose areas are not given
explicitly are assumed to appear in a standard system area called
|TEX_font_area|.  These system area names will, of course, vary from place
to place.
@y
@ \marke U Input files that can't be found in the working directory
may appear in a directory called |TEX_area|. Font metric files
whose directory path are not given explicitly are assumed to appear
in the working directory or in a standard system directory \marke f called
|TEX_font_area|.  In this implementation the system directories
are sub directories of the working directory.
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

[532] use buffered output for dvi file
@x
  while not b_open_out(dvi_file) do
    prompt_file_name("file name for output",".dvi");
  output_file_name:=b_make_name_string(dvi_file);
@y
  while not u_open_out(dvi_file) do
    prompt_file_name("file name for output",".dvi");
  output_file_name:=make_name_string;
@z

[532] use buffered output for dvi file
@x
@!dvi_file: byte_file; {the device-independent output goes here}
@y
@!dvi_file: untyped_file; {the device-independent output goes here\marke G}
@z

[536] banner line does not fit (it does fit with the short banner now)
	@x
	slow_print(format_ident); print("  ");
	@y
	slow_print(format_ident);
	{print date on a new line if it doesn't fit on the banner line\marke u}
	if file_offset+gpc_length(banner)+19 <= max_print_line then
	 print("  ") else print_ln; {date needs at most 19 characters\marke G}
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

GNU~Pascal's @!|block_write| procedure takes a untyped |file|, an
|array| and the number of blocks to be written. When opening the
file, we specified the block length to be one, so the number of
blocks equals the number of bytes.  The |array| here is given as
a `slice', another extension of GNU~Pascal. It should be clear,
what \\{buffer[a..b]} means.  This simple change was suggested by
Emil Jerabek.
@^Jerabek, Emil@>
@z

[597] use buffered output for dvi file
@x
begin for k:=a to b do write(dvi_file,dvi_buf[k]);
@y
begin block_write(dvi_file,dvi_buf[a..b], b-a+1);
{buffered  output with GNU~Pascal\marke G}
@z

[642] use buffered output for dvi file
@x
  b_close(dvi_file);
@y
  close(dvi_file);
@z

[816] save pointer to penalty_node
@x
link(tail):=new_param_glue(par_fill_skip_code);
@y
non_prunable_p := tail; {save a pointer to the penalty before \.{\\parfillskip}
\marke E}
link(tail):=new_param_glue(par_fill_skip_code);
@z

[862] declare non_prunable_p
@x
@!auto_breaking:boolean; {is node |cur_p| outside a formula?}
@y
@!auto_breaking:boolean; {is node |cur_p| outside a formula?}
@!non_prunable_p:pointer; {\marke E pointer to the infinite penalty node
                          at the end of the paragraph}
@z

[876] pass non_prunable_p
@x
post_line_break(final_widow_penalty)
@y
post_line_break(final_widow_penalty, non_prunable_p) {pass |non_prunable_p|
\marke E}
@z

[877] pass non_prunable_p
@x
procedure post_line_break(@!final_widow_penalty:integer);
@y
procedure post_line_break(@!final_widow_penalty:integer;
  @!non_prunable_p:pointer);
{add another parameter needed when pruning a line\marke E}
@z

[879]
@x
are computed for non-discretionary breakpoints.
@y
are computed for non-discretionary breakpoints.

\marke E The pointer |non_prunable_p| references the infinite penalty
node preceding the \.{\\parfillskip} node at the end of the paragraph.
These nodes must not be pruned. \TeX82 deletes them whenever the last
line of a paragraph containes only glue and thus violates the
specification in The \TeX book.
@z

[879]
@x
  if non_discardable(q) then goto done1;
@y
  if non_discardable(q) then goto done1;
  if q = non_prunable_p then goto done1; {keep \.{\\parfillskip}\marke E}
@z

[1332]
@x
@ Now this is really it: \TeX\ starts and ends here.

The initial test involving |ready_already| should be deleted if the
\PASCAL\ runtime system is smart enough to detect such a ``mistake.''
@^system dependencies@>
@y
@ Now this is really it: \TeX\ starts and ends here.  The function
|gpc_execute| will start the system editor (vi) and @!|gpc_halt|
passes the |history| as an exit code to the system.

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
@ Here we do whatever is needed to complete \TeX's job gracefully on the
local operating system. The code here might come into play after a fatal
@y
@ \marke u Here we do whatever is needed to complete \TeX's job
gracefully. Special care is taken to put an end-of-line marker at
the end of the last line since that looks better.  The code
here might come into play after a fatal
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
  if term_offset > 0 then wterm_cr; {write |eoln| if necessary\marke u}
end;
@z

[1338] return if eof.
@x
  read(term_in,m);
@y
  if eof(term_in) then return;
  {\marke P don't try to read past end of file}
  read(term_in,m);
@z

[1338] return if eof
@x
  else  begin read(term_in,n);
@y
  else  begin if eof(term_in) then return;
  {\marke Pdon't try to read past end of file}
  read(term_in,n);
@z

[1339] return if eof
@x
13: begin read(term_in,l); print_cmd_chr(n,l);
@y
13: begin if eof(term_in) then return;
  {\marke Pdon't try to read past end of file}
read(term_in,l); print_cmd_chr(n,l);
@z

[1379 and modules added for TeX-GPC]
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.

@ \marke fTry to preload the default format file. This is called
even before the first line is read from the terminal, and thus
turns \.{VIRTEX} into \.{TEX}, at least as seen by the user.
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

@ \marke FIf the user typed |'E'| to edit a file after confronted
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
@!|gpc_write_str| function writes its arguments into a \\{string} to
build the command line.  The @!|gpc_execute| function is part of the
GNU~Pascal Runtime System. Its parameter is a |gpc_string| which
holds the command line to be executed.

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

@d gpc_t_signal_handler == t@&s@&i@&g@&n@&a@&l@&h@&a@&n@&d@&l@&e@&r
@d gpc_install_signal_handler ==
 i@&n@&s@&t@&a@&l@&l@&s@&i@&g@&n@&a@&l@&h@&a@&n@&d@&l@&e@&r
@d gpc_sig_int == s@&i@&g@&i@&n@&t
@d gpc_null == n@&u@&l@&l
@d gpc_integer == integer {for later versions of GPC (3.4+) replace
  \\{integer} by \\{cinteger}}

@<Error hand...@>=
procedure set_interrupt(signal: gpc_integer);
begin interrupt := 1 @+end;

@ To install |set_interrupt| as our `signal handler', I use
procedure @!|gpc_install_signal_handler|.  It works
with these arguments, but don't ask why. GNU~Pascal's @!|gpc_sig_int|
constant denotes the Unix interrupt signal, which is sent when the
user types \.{\^C}. Then |set_interrupt| is called, which sets the
global variable |interrupt| to one, thus causing \TeX\ to invoke
|error| to ask the user what he wants.

@<Initialize whatever ... @>=
if gpc_install_signal_handler(gpc_sig_int,set_interrupt,
  true,true,gpc_null,gpc_null) then do_nothing;
@z

@ Here are two variables that are needed to install |set_interrupt|.
@<Local variables for initialization@> =
dummy_handler: gpc_t_signal_handler;
dummy_boolean: boolean;
 @z
