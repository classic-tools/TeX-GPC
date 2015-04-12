% This is a change file of Metafont for GPC, Wolfgang Helbig, Nov. 2007
[0] to print changed sections only
@x
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
@y
\def\gglob{20, 26} % this should be the next two sections of "<Global...>"
\input webmac-gpc
\emergencystretch 0.5in % avoid overfull boxes

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\MF}

\N0\*.  \[0] About \namegpc.

This is an adaption of Donald~E. Knuth's \MF, version 2.718281
from March 2008, to Unix. It is based on GNU~Pascal, version 2.1.

The features added include treating the command line as the first
input line and invoking a system editor, in this case \.{vi}, to
let the user correct the input file.
On exit, \namegpc\ passes its `history' to the operating system.

\hint

Comments and questions are welcome!

\bigskip
\address
\fi
@z

[2] Change the banner line
@x
@d banner=='This is METAFONT, Version 2.718281' {printed when \MF\ starts}
@y
@d banner=='This is METAFONT-GPC' {printed when \MF\ starts}
@z

[4] terminal output and input
@x
@^system dependencies@>

@d mtype==t@&y@&p@&e {this is a \.{WEB} coding trick:}
@y
@^system dependencies@>

@d term_in==i@&n@&p@&u@&t
@d term_out==o@&u@&t@&p@&u@&t
@d mtype==t@&y@&p@&e {this is a \.{WEB} coding trick:}
@z

[4] terminal output and input
@x
program MF; {all file names are defined dynamically}
@y
program MF(@!term_in,@!term_out);
{all other file names are defined dynamically}
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
activate it by unindenting it (shift left).  With vi set the   
cursor to the @x line and enter >} or <} to (un)indent a paragraph.

[7] shift left to turn debugging on, right to turn it off
@x
@d debug==@{ {change this to `$\\{debug}\equiv\null$' when debugging}
@d gubed==@t@>@} {change this to `$\\{gubed}\equiv\null$' when debugging}
@y
@d debug== {change this to `$\\{debug}\equiv\.{@@\{}$' when not debugging}
@d gubed== {change this to `$\\{gubed}\equiv\.{@@\}}$' when not debugging}
@z

[7] shift left to turn on statistics, shift rigth to turn off statistics
@x
@d stat==@{ {change this to `$\\{stat}\equiv\null$' when gathering
  usage statistics}
@d tats==@t@>@} {change this to `$\\{tats}\equiv\null$' when gathering
  usage statistics}
@y
@d stat== {change this to `$\\{stat}\equiv\.{@@\{}$' to turn off statistics}
@d tats== {change this to `$\\{tats}\equiv\.{@@\}}$' to turn off statistics}
@z

[8] shift left to build MF and right it to build INIMF.
	@x inimf
	@d init== {change this to `$\\{init}\equiv\.{@@\{}$' in the production version}
	@d tini== {change this to `$\\{tini}\equiv\.{@@\}}$' in the production version}
	@y
	@d init==@{
	@d tini==@}
	@z

[9] compiler directives, turn off I/O checking.
@x
@{@&$C-,A+,D-@} {no range check, catch arithmetic overflow, no debug overhead}
@!debug @{@&$C+,D+@}@+ gubed {but turn everything on when debugging}
@y
@{@&$I-@} {no I/O checking}
@z

[10] default case branch
@x
@d othercases == others: {default for cases not listed explicitly}
@y
@d othercases == @+ else {default for cases not listed explicitly}
@z

Shift left all `trap' blocks to prepare for TRAP.
Shift right all `part' blocks to prepare for TRAP.
[11]
@x part
@!mem_max=30000; {greatest index in \MF's internal |mem| array;
@y
@!mem_max=35000; {increased for ibycus4,
 greatest index in \MF's internal |mem| array;
@z

[11]
@x part
@!max_strings=2000; {maximum number of strings; must not exceed |max_halfword|}
@y
@!max_strings=6000; {maximum number of strings; increased for ibycus4}
@z

@x part
@!pool_size=32000; {maximum number of characters in strings, including all
@y
@!pool_size=60000; {increased for ibycus4,
  maximum number of characters in strings, including all
@z

[11]
	@x trap
	@!mem_max=30000; {greatest index in \MF's internal |mem| array;
	@y
	@!mem_max=3000; {greatest index in \MF's internal |mem| array;
	@z

[11]
	@x trap
	@!error_line=72; {width of context lines on terminal error messages}
	@!half_error_line=42; {width of first lines of contexts in terminal
	  error messages; should be between 30 and |error_line-15|}
	@!max_print_line=79; {width of longest text lines output; should be at least 60}
	@!screen_width=768; {number of pixels in each row of screen display}
	@!screen_depth=1024; {number of pixels in each column of screen display}
	@y
	@!error_line=64; {width of context lines on terminal error messages}
	@!half_error_line=32; {width of first lines of contexts in terminal
	  error messages; should be between 30 and |error_line-15|}
	@!max_print_line=72; {width of longest text lines output; should be at least 60}
	@!screen_width=100; {number of pixels in each row of screen display}
	@!screen_depth=200; {number of pixels in each column of screen display}
	@z

[11]
	@x trap
	@!gf_buf_size=800; {size of the output buffer, must be a multiple of 8}
	@y
	@!gf_buf_size=8; {size of the output buffer, must be a multiple of 8}
	@z

[11] location of pool file
@x
@!pool_name='MFbases:MF.POOL                         ';
@y
@!pool_name='MFbases/mf.pool                         ';
@z


[12]
@x part
@d mem_top==30000 {largest index in the |mem| array dumped by \.{INIMF};
@y
@d mem_top==35000 {largest index in the |mem| array dumped by \.{INIMF};
@z

	[12]
	@x trap
	@d mem_top==30000 {largest index in the |mem| array dumped by \.{INIMF};
	@y
	@d mem_top==3000 {largest index in the |mem| array dumped by \.{INIMF};
	@z

[12] Silvio levy' greek fonts need more opened input files.
@x
@d max_in_open=6 {maximum number of input files and error insertions that
@y
@d max_in_open=10 {maximum number of input files and error insertions that
@z

[22] accept tab and formfeed
@x
for i:=0 to @'37 do xchr[i]:=' ';
@y
for i:=0 to @'37 do xchr[i]:=' ';
xchr[@'11] := chr(@'11); {accept horizontal tab}
xchr[@'14] := chr(@'14); {accept form feed}
@z

[24] the type of text_files is text in ISO Pascal
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@!alpha_file=packed file of text_char; {files that contain textual data}
@y
@!eight_bits=packed 0..255; {unsigned one-byte quantity}
@!alpha_file=t@&e@&x@&t; {coding trick is needed since |text| is a macro}
@z

[26] dynamic io
@x
@d reset_OK(#)==erstat(#)=0
@d rewrite_OK(#)==erstat(#)=0
@y
@d gpc_trim==t@&r@&i@&m
@d gpc_io_result==i@&o@&r@&e@&s@&u@&l@&t
@d reset_OK(#)==gpc_io_result=0
@d rewrite_OK(#)==gpc_io_result=0
@d clear_io_result==@+if gpc_io_result=0 then do_nothing
@z

[26] (reset and rewrite for each of three file types) alpha
@x
begin reset(f,name_of_file,'/O'); a_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); a_open_in:=reset_OK(f);
@z

[26]
@x
begin rewrite(f,name_of_file,'/O'); a_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
a_open_out:=rewrite_OK(f);
@z

[26] byte file output only
@x
begin rewrite(f,name_of_file,'/O'); b_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
b_open_out:=reset_OK(f);
@z

[26] word_file
@x
begin reset(f,name_of_file,'/O'); w_open_in:=reset_OK(f);
@y
begin clear_io_result; reset(f,gpc_trim(name_of_file)); w_open_in:=reset_OK(f);
@z

[26]
@x
begin rewrite(f,name_of_file,'/O'); w_open_out:=rewrite_OK(f);
@y
begin clear_io_result; rewrite(f,gpc_trim(name_of_file));
w_open_out:=rewrite_OK(f);
@z

[30] eoln handling
@x
@p function input_ln(var @!f:alpha_file;@!bypass_eoln:boolean):boolean;
  {inputs the next line or returns |false|}
var @!last_nonblank:0..buf_size; {|last| with trailing blanks removed}
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

[31] term_in and term_out are the standard pascal files
@x
is considered an output file the file variable is |term_out|.
@^system dependencies@>

@<Glob...@>=
@!term_in:alpha_file; {the terminal as an input file}
@!term_out:alpha_file; {the terminal as an output file}
@y
is considered an output file the file variable is |term_out|.
The file |term_in| is declared as \\{input} and |term_out| as
\\{output} in the program header.
@^system dependencies@>
@z

[32]
@x
@d t_open_in==reset(term_in,'TTY:','/O/I') {open the terminal for text input}
@d t_open_out==rewrite(term_out,'TTY:','/O')
 {open the terminal for text output}
@y
@d t_open_in==do_nothing {open the terminal for text input}
@d t_open_out==do_nothing {open the terminal for text output}
@z

[33]
@x
@d update_terminal == break(term_out) {empty the terminal output buffer}
@d clear_terminal == break_in(term_in,true) {clear the terminal input buffer}
@y
@d update_terminal == do_nothing {empty the terminal output buffer}
@d clear_terminal == do_nothing {clear the terminal input buffer}
@z

[35] command line
@x
@d loc==cur_input.loc_field {location of first unread character in |buffer|}
@y
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
    buffer[last] := " "; incr(last);
    end;
  end;
end;
@z

[36] command line
@x
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

[74] start editor
@x
@!use_err_help:boolean; {should the |err_help| string be shown?}
@y
@!use_err_help:boolean; {should the |err_help| string be shown?}
@!edit_line: integer; {line number to be passed to the system editor}
@!edit_file_name: str_number; {file name to be passed to the system editor}
@z

[75] initial value for edit argument
@x
help_ptr:=0; use_err_help:=false; err_help:=0;
@y
help_ptr:=0; use_err_help:=false; err_help:=0;
edit_line:=0; edit_file_name:=0;
@z

[79] set edit_cmd
@x
  begin print_nl("You want to edit file ");
@.You want to edit file x@>
  slow_print(input_stack[file_ptr].name_field);
  print(" at line "); print_int(line);@/
  interaction:=scroll_mode; jump_out;
  end;
@y
  begin {save values to be passed to the system editor}
  edit_file_name := input_stack[file_ptr].name_field;
  edit_line := line; add_str_ref(edit_file_name);
  interaction:=scroll_mode; jump_out;
  end;
@z

[91] interrupt is predefined and not implemented in GNU~Pascal
@x
@d check_interrupt==begin if interrupt<>0 then pause_for_instructions;
@y
@d interrupt==buginterrupt
@f interrupt==true
@d check_interrupt==begin if interrupt<>0 then pause_for_instructions;
@z

[156] pack subranges
@x
@!quarterword = min_quarterword..max_quarterword; {1/4 of a word}
@!halfword=min_halfword..max_halfword; {1/2 of a word}
@y
@!quarterword = packed min_quarterword..max_quarterword; {1/4 of a word}
@!halfword=packed min_halfword..max_halfword; {1/2 of a word}
@z

[194] time and date
@x
begin internal[time]:=12*60*unity; {minutes since midnight}
internal[day]:=4*unity; {fourth day of the month}
internal[month]:=7*unity; {seventh month of the year}
internal[year]:=1776*unity; {Anno Domini}
@y
var t: time_stamp;
begin
get_time_stamp(t);
internal[time]:=(t.minute + t.hour*60)*unity; {minutes since midnight}
internal[day]:=t.d@&a@&y*unity;
internal[month]:=t.m@&o@&n@&t@&h*unity;
internal[year]:=t.y@&e@&a@&r*unity; {Anno Domini}
@z

[199] character class for tab and lf
@x
for k:=127 to 255 do char_class[k]:=invalid_class;
@y
for k:=127 to 255 do char_class[k]:=invalid_class;
char_class[@'11] := space_class;
char_class[@'14] := space_class;
@z

[564]
	@x trap
	begin init_screen:=false;
	@y
	begin init_screen:=true;
	@z

[679] spurious empty line on terminal
@x
    print_ln; first:=start;
    prompt_input("*"); {input on-line into |buffer|}
@y
@.Please type...@>
    print_nl("");
    first:=start; {avoid empty lines on terminal and log file}
    prompt_input("*"); {input on-line into |buffer|}
@z

[769] Path separator in Unix
@x
@d MF_area=="MFinputs:"
@y
@d MF_area=="MFinputs/"
@z

[771]
@x
else  begin if (c=">")or(c=":") then
@y
else  begin if c="/" then
@z

[776]
@x
MF_base_default:='MFbases:plain.base';
@y
MF_base_default:='MFbases/plain.base';
@z

[793] don't forget the input file name
@x
if name=str_ptr-1 then {we can conserve string pool space now}
  begin flush_string(name); name:=cur_name;
  end;
@y
@z

[1204]
@x
@p begin @!{|start_here|}
@y
@d gpc_halt == h@&a@&l@&t

@p begin @!{|start_here|}
@z

[1204] load the base file before printing the banner line
@x
start_of_MF: @<Initialize the output routines@>;
@y
start_of_MF: @<Preload the default base file@>;
@<Initialize the output routines@>;
@z

[1204] start editor and pass history
@x
final_end: ready_already:=0;
@y
final_end:
if edit_file_name > 0 then start_editor; {user typed `\.{E}'}
gpc_halt(history);
  {pass |history| as the exit value to the system}
@z

[1205] print last end-of-line marker if needed
@x
if log_opened then
  begin wlog_cr;
  a_close(log_file); selector:=selector-2;
  if selector=term_only then
    begin print_nl("Transcript written on ");
@.Transcript written...@>
    slow_print(log_name); print_char(".");
    end;
  end;
end;
@y
if log_opened then
  begin if file_offset > 0 then wlog_cr;
  a_close(log_file); selector:=selector-2;
  if selector=term_only then
    begin print_nl("Transcript written on ");
@.Transcript written...@>
    slow_print(log_name); print_char(".");
    end;
  end;
  if term_offset > 0 then wterm_cr;
end;
@z

[1212] return if eof 
@x
  read(term_in,m);
@y
  if eof(term_in) then return;
  {don't try to read past end of file}
  read(term_in,m);
@z

[1212] return if eof
@x
  else  begin read(term_in,n);
@y
  else  begin if eof(term_in) then return;
  {don't try to read past end of file}
  read(term_in,n);
@z

[1213] return eof
@x
13: begin read(term_in,l); print_cmd_mod(n,l);
@y
13: begin if eof(term_in) then return;
  {don't try to read past end of file}
read(term_in,l); print_cmd_mod(n,l);
@z

[1214 and modules added for METAFONT-GPC]
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.
@^system dependencies@>

@ Try to preload the default base file. This is called even before
the first line is read from the terminal, and thus turns \.{VIRMF}
into \.{MF}, at least as seen by the user.

\indent\.{INIMF} sets |base_ident| to `\.{INIMF}' and won't load a base
file here.

@<Preload the default base file@> =
if base_ident = 0 then
  begin pack_buffered_name(base_default_length - base_ext_length, 1, 0);
  if not w_open_in(base_file) then
    begin
    wterm_ln('I can''t find the base file ', name_of_file);
    goto final_end
    end;
  if not load_base_file then
    begin w_close(base_file); goto final_end
    end;
  w_close(base_file);
  end

@ 
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
gpc_write_str(cmd_line, 'vi +', edit_line, ' ', gpc_trim(name_of_file));
if 0 <> gpc_execute(cmd_line) then
  write_ln(gpc_param_str(0), ': could not start editor with: "',
    cmd_line, '"');
end;

@
@d gpc_t_signal_handler == t@&s@&i@&g@&n@&a@&l@&h@&a@&n@&d@&l@&e@&r
@d gpc_install_signal_handler ==
 i@&n@&s@&t@&a@&l@&l@&s@&i@&g@&n@&a@&l@&h@&a@&n@&d@&l@&e@&r
@d gpc_sig_int == s@&i@&g@&i@&n@&t
@d gpc_integer == integer {for later versions of GPC (3.4+) replace
  \\{integer} by \\{cinteger}}
  
@<Error hand...@>=
procedure set_interrupt(signal: gpc_integer);
begin interrupt := 1 @+end;
  
@
@<Set initial values ... @>=
gpc_install_signal_handler(gpc_sig_int,set_interrupt,true,true,dummy_handler,
  dummy_boolean);
  
@ Here are two variables that are needed to install |set_interrupt|.
@<Local variables for initialization@> =
dummy_handler: gpc_t_signal_handler;
dummy_boolean: boolean;
@z
