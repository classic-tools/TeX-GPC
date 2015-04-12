This is a change file of GFtoDVI for GPC, Wolfgang Helbig, Apr. 2008
To be used with the GNU Pascal Compiler Version 2.1
Juli 2008: Added command line support and exit code.

[0] About GFtoDVI-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt GFtoDVI}

\N0\*. About \namegpc.\fi
This is an adaption of Donald~E. Knuth's \.{GFtoDVI}, version 3.0
from March 1991, to Unix. \namegpc\ is based on GNU~Pascal, version 2.1.

\namegpc\ expects the input file name (\.{.gf}) on the command
line.  To support shell scripting, it sets the exit code to one
when something was wrong with the input file.

\hint

Comments and questions are welcome!
\bigskip
\address
@z

[1] Change the banner line
@x
@d banner=='This is GFtoDVI, Version 3.0' {printed when the program starts}
@y
@d banner=='This is GFtoDVI-GPC' {printed when the program starts}
@z

[2] default case branch
@x
@d othercases == others: {default for cases not listed explicitly}
@y
@d othercases == @+else {default for cases not listed explicitly}
@z

[3] we'll use input and output for term_in and term_out
@x
@d print(#)==write(#)
@d print_ln(#)==write_ln(#)
@d print_nl(#)==@+begin write_ln; write(#);@+end
@y
@d term_in==i@&n@&p@&u@&t
@d term_out==o@&u@&t@&p@&u@&t
@d print(#)==write(term_out, #)
@d print_ln(#)==write_ln(term_out, #)
@d print_nl(#)==@+begin write_ln(term_out); write(term_out, #);@+end
@z

[3] program header:
@x
@p program GF_to_DVI(@!output);
@y
@p program GF_to_DVI(@!term_in, @!term_out);
@z

[8] print end of line
@x
@d abort(#)==@+begin print(' ',#); jump_out;@+end
@y
@d abort(#)==@+begin print_ln(' ',#); history := 1; jump_out;@+end
@z

[11] Don't need text_file
@x
@!text_file=packed file of text_char;
@y
@z

[16] Don't update a terminal
@x
@d update_terminal == break(output) {empty the terminal output buffer}
@y
@d update_terminal == do_nothing {empty the terminal output buffer}
@z

[16] Must not define the type of term_in.
@x
@!term_in:text_file; {the terminal, considered as an input file}
@y
@z

[17] Don't reopen term_in.
Assume that a line is always terminated by end of line.
@x
@p procedure input_ln; {inputs a line from the terminal}
begin update_terminal; reset(term_in);
if eoln(term_in) then read_ln(term_in);
line_length:=0;
while (line_length<terminal_line_length)and not eoln(term_in) do
  begin buffer[line_length]:=xord[term_in^]; incr(line_length); get(term_in);
  end;
end;
@y
@p procedure input_ln; {inputs a line from the terminal}
begin update_terminal;
line_length:=0;
while (line_length<terminal_line_length)and not eoln(term_in) do
  begin buffer[line_length]:=xord[term_in^]; incr(line_length); get(term_in);
  end;
read_ln(term_in); {read eoln}
end;
@z

[45] GPC wants you to pack the range instead of the structure.
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@y
@!eight_bits=packed 0..255; {unsigned one-byte quantity}
@z

[47] dynamic opening files
@x
begin reset(gf_file,name_of_file);
@y
begin reset(gf_file,trim(name_of_file));
@z
@x
begin reset(tfm_file,name_of_file);
@y
begin reset(tfm_file,trim(name_of_file));
@z
@x
begin rewrite(dvi_file,name_of_file);
@y
begin rewrite(dvi_file,trim(name_of_file));
@z

[52] GPC wants you to pack the range instead of the structure.
@x
@!font_index = 0..font_mem_size;
@!quarterword = min_quarterword..max_quarterword; {1/4 of a word}
@y
@!font_index = packed 0..font_mem_size;
@!quarterword = packed min_quarterword..max_quarterword; {1/4 of a word}
@z

[88] File names: area delimeter is '/'.
@x
l:=9; init_str9("T")("e")("X")("f")("o")("n")("t")("s")(":")(home_font_area);@/
@y
l:=9; init_str9("T")("e")("X")("f")("o")("n")("t")("s")("/")(home_font_area);@/
@z

[90] File names: area delimeter is '/'.
@x
else  begin if (c=">")or(c=":") then
@y
else  begin if c="/" then
@z

[94] Get gf file from command line
@x
@ The |start_gf| procedure prompts the user for the name of the generic
font file to be input. It opens the file, making sure that some input is
present; then it opens the output file.

Although this routine is system-independent, it should probably be
modified to take the file name from the command line (without an initial
prompt), on systems that permit such things.

@p procedure start_gf;
label found,done;
begin loop@+begin print_nl('GF file name: '); input_ln;
@.GF file name@>
  buf_ptr:=0; buffer[line_length]:="?";
  while buffer[buf_ptr]=" " do incr(buf_ptr);
  if buf_ptr<line_length then
    begin @<Scan the file name in the buffer@>;
    if cur_ext=null_string then cur_ext:=gf_ext;
    pack_file_name(cur_name,cur_area,cur_ext); open_gf_file;
    if not eof(gf_file) then goto found;
    print_nl('Oops... I can''t find file '); print(name_of_file);
@.Oops...@>
@.I can't find...@>
    end;
  end;
found:job_name:=cur_name; pack_file_name(job_name,null_string,dvi_ext);
open_dvi_file;
end;
@y
@ The |start_gf| procedure gets the name of the generic font file
from the command line. It opens the file, making sure that some
input is present; then it opens the output file.

@d gpc_param_str == p@&a@&r@&a@&m@&s@&t@&r
@d gpc_param_count == p@&a@&r@&a@&m@&c@&o@&u@&n@&t
@d gpc_length == l@&e@&n@&g@&t@&h

@p procedure start_gf;
label done;
var i : integer;
  arg : string(255);
begin if gpc_param_count <> 1 then abort('! missing gf-file');
arg := gpc_param_str(1);
line_length := 0; i := 1;
while (line_length < terminal_line_length) and (i <= gpc_length(arg)) do
   begin buffer[line_length] := xord[arg[i]]; incr(line_length); incr(i);
   end;
@.GF file name@>
buf_ptr:=0; buffer[line_length]:="?";
while buffer[buf_ptr]=" " do incr(buf_ptr);
if buf_ptr<line_length then
  begin @<Scan the file name in the buffer@>;
  if cur_ext=null_string then cur_ext:=gf_ext;
  pack_file_name(cur_name,cur_area,cur_ext); open_gf_file;
  if eof(gf_file) then abort(name_of_file, 'is empty');
  end;
job_name:=cur_name; pack_file_name(job_name,null_string,dvi_ext);
open_dvi_file;
end;
@z

[219] exit code
@x
final_end:end.
@y
final_end: halt(history); end.
@z

[222 ff] system dependent changes
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.
@^system dependencies@>

@<Glob...@>=
@! history : integer;

@ @<Set init...@>=
history := 0;
@z
