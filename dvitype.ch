% This is a change file of DVIType for GPC, Wolfgang Helbig, Nov. 2007
To be used with the GNU Pascal Compiler Version 2.1

[0] About DVItype-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt DVItype}

\N0\*. About \namegpc.\fi

This is an adaption of Donald~E. Knuth's \.{DVItype}, version 3.6
from December 1995, to Unix. It is based on GNU~Pascal, version 2.1.

This program expects the input file (\.{.dvi}) and the output file,
which is a text file, on the command line.  To support shell
scripting, \namegpc\ sets the exit code to one when something was
wrong with the input file.

\hint

Comments and questions are welcome!

\bigskip
\address
@z
[1] Change the banner line
@x
@d banner=='This is DVItype, Version 3.6' {printed when the program starts}
@y
@d banner=='This is DVItype-GPC'
   {printed when the program starts}
@z

[2] default case branch / no random_reading
@x
@d random_reading==true {should we skip around in the file?}
@d othercases == others: {default for cases not listed explicitly}
@y
@d random_reading==false {should we skip around in the file?}
@d othercases == @+else {default for cases not listed explicitly}
@z

[3] don't use output for output, but out_file
@x
@d print(#)==write(#)
@d print_ln(#)==write_ln(#)
@y
@d print(#)==write(out_file, #)
@d print_ln(#)==write_ln(out_file, #)
@z

[3] suppress io error messages
@x
@p program DVI_type(@!dvi_file,@!output);
@y
@p program DVI_type(term_in,term_out);
@z

[3] write banner on terminal and on outfile only when opened!
@x
  begin print_ln(banner);@/
@y
  begin write_ln(banner);@/
@z

[7] end output line
@x
@d abort(#)==begin print(' ',#); jump_out;
@y
@d abort(#)==begin write_ln(' ', #); print_ln(' ', #);
history := 1; goto final_end;
@z

[9] the type of text_files is text in ISO Pascal
@x
@!text_file=packed file of text_char;
@y
@!text_file=text;
@z

[21] use GPC extension for packing subranges.
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@y
@!eight_bits=packed 0..255; {unsigned one-byte quantity}
@z

[22] declare out_file
@x
@!tfm_file:byte_file; {a font metric file}
@y
@!tfm_file:byte_file; {a font metric file}
@!out_file:text; {the outfile}
@z

[23] open file whose name is not known at compile time
@x
begin reset(dvi_file);
@y
begin reset(dvi_file, param_str(1));
@z

@x
begin reset(tfm_file,cur_name);
@y
begin reset(tfm_file,trim(cur_name)); {ignore leading and trailing blanks}
@z

[28] no random access
@x;
begin set_pos(dvi_file,-1); dvi_length:=cur_pos(dvi_file);
end;
@#
procedure move_to_byte(n:integer);
begin set_pos(dvi_file,n); cur_loc:=n;
end;
@y;
begin do_nothing;
end;
@#
procedure move_to_byte(n:integer);
begin do_nothing;
end;
@z

[43] out_file muss geoeffnet werden!
@x
out_mode:=the_works; max_pages:=1000000; start_vals:=0; start_there[0]:=false;
@y
out_mode:=the_works; max_pages:=1000000; start_vals:=0; start_there[0]:=false;
if param_count <> 2 then
begin write_ln('Usage: dvitype dvi_file text_file'); halt(1);
end;
rewrite(out_file, param_str(2)); print_ln(banner);
@z

[45] term_in und term_out sind input und output
@x
and |term_out| for terminal output.
@^system dependencies@>

@y
and |term_out| for terminal output.
@^system dependencies@>

@d term_in == input
@d term_out == output
@z

@x
@!term_in:text_file; {the terminal, considered as an input file}
@!term_out:text_file; {the terminal, considered as an output file}
@y
@z

[46]
@x
@d update_terminal == break(term_out) {empty the terminal output buffer}
@y
@d update_terminal == do_nothing {empty the terminal output buffer}
@z

[47]
@x
is always at least one blank space in |buffer|.
@^system dependencies@>

@p procedure input_ln; {inputs a line from the terminal}
var k:0..terminal_line_length;
begin update_terminal; reset(term_in);
if eoln(term_in) then read_ln(term_in);
k:=0;
while (k<terminal_line_length)and not eoln(term_in) do
  begin buffer[k]:=xord[term_in^]; incr(k); get(term_in);
  end;
buffer[k]:=" ";
end;
@y
is always at least one blank space in |buffer|.
This is changed here: |term_in| is standard input and is not supposed
to be opened. There is never an end-of-line marker at the beginning of
a line but always at the end of a line.
@^system dependencies@>

@p procedure input_ln; {inputs a line from the terminal}
var k:0..terminal_line_length;
begin update_terminal;
k:=0;
while (k<terminal_line_length)and not eoln(term_in) do
  begin buffer[k]:=xord[term_in^]; incr(k); get(term_in);
  end;
read_ln(term_in);
buffer[k]:=" ";
end;
@z

[50] don't rewrite output file, write the banner while initializing
@x
begin rewrite(term_out); {prepare the terminal for output}
write_ln(term_out,banner);
@y
begin
@z

[64]
@x
@d default_directory_name=='TeXfonts:' {change this to the correct name}
@y
@d default_directory_name=='TeXfonts/' {change this to the correct name}
@z

[66] lowercase filename
@x
  if (names[k]>="a")and(names[k]<="z") then
      cur_name[r]:=xchr[names[k]-@'40]
  else cur_name[r]:=xchr[names[k]];
  end;
cur_name[r+1]:='.'; cur_name[r+2]:='T'; cur_name[r+3]:='F'; cur_name[r+4]:='M'
@y
  cur_name[r]:=xchr[names[k]]
  end;
cur_name[r+1]:='.'; cur_name[r+2]:='t'; cur_name[r+3]:='f'; cur_name[r+4]:='m'
@z

[107] set exit code
@x
final_end:end.
@y
final_end:halt(history) end.
@z

[112] declare and initialize history
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.
@^system dependencies@>

@<Globals...@>=
history : integer;

@
@<Set init...@>=
history := 0;
@z
