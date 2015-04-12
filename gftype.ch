% This is a change file of GFType for GPC, Wolfgang Helbig, Nov. 2007
To be used with the GNU Pascal Compiler Version 2.1
Sep 2008: command line and exit code.

[0] About GF-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt GFtype}

\N0\*. About \namegpc.\fi

This is an adaption of Donald~E. Knuth's \.{GFtype}, version 3.1
from March 1991, to Unix. It is based on GNU~Pascal, version 2.1.

This program expects the input file (\.{.gf}) and the output file,
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
@d banner=='This is GFtype, Version 3.1' {printed when the program starts}
@y
@d banner=='This is GFtype-GPC' {printed when the program starts}
@z

[2] default case branch
@x
@d othercases == others: {default for cases not listed explicitly}
@y
@d othercases == @+else {default for cases not listed explicitly, like Modula 2}
@z

[3] don't use output for output, but typ_file
@x
@d print(#)==write(#)
@d print_ln(#)==write_ln(#)
@d print_nl==write_ln
@y
@d print(#)==write(typ_file, #)
@d print_ln(#)==write_ln(typ_file, #)
@d print_nl==write_ln(typ_file)
@z

[3] file names from command line.
@x
@p program GF_type(@!gf_file,@!output);
@y
@p program GF_type(term_in,term_out);
@z

[3] print banner to typ_file after opening typ_file
@x
  begin print_ln(banner);@/
  @<Set initial values@>@/
@y
  begin @<Set initial values@>@/
  print_ln(banner);@/
@z

[6] 
@x
@d negate(#) == #:=-# {change the sign of a variable}
@y
@d negate(#) == #:=-# {change the sign of a variable}
@d do_nothing == 
@z

[7] set history
@x
@d abort(#)==begin print(' ',#); jump_out;
    end
@y
@d abort(#)==begin print_ln(' ',#); history := 1; jump_out;
             end
@z

[9] the type of text_files is text in ISO Pascal
@x
@!text_file=packed file of text_char;
@y
@!text_file=text;
@z

[11] command line
@x
|xchr| array properly, without needing any system-dependent changes.

@<Set init...@>=
@y
|xchr| array properly, without needing any system-dependent changes.

@d gpc_length == length
@d gpc_param_str == paramstr
@d gpc_param_count == param_count

@<Set init...@>=

if gpc_param_count <> 2 then begin
   write_ln('! Usage: gftype gf_file text_file'); history := 1; goto final_end;
   end;
@z

[20] use GPC extension for packing subranges.
@x
@!eight_bits=0..255; {unsigned one-byte quantity}
@y
@!eight_bits=packed 0..255; {unsigned one-byte quantity}
@z

[21] declare typ_file
@x
@!gf_file:byte_file; {the stuff we are \.{GF}typing}
@y
@!gf_file:byte_file; {the stuff we are \.{GF}typing}
@!typ_file:text; {the outfile}
@z

[22] open GF file with name from command line
@x
begin reset(gf_file);
@y
begin reset(gf_file, gpc_param_str(1));
@z

[26] rewrite out file
@x
wants_mnemonics:=true; wants_pixels:=true;
@y
wants_mnemonics:=true; wants_pixels:=true;
rewrite(typ_file, gpc_param_str(2));
@z


[27] term_in und term_out are input and output
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

[28] break...
@x;
@d update_terminal == break(term_out) {empty the terminal output buffer}
@y;
@d update_terminal == do_nothing {empty the terminal output buffer}
@z

[29]
@x
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
This is changed here: |term_in| is standard input and is not supposed
to be opened. There is never a end of line mark at the beginning of
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

[31] don't rewrite term_out, don't write banner here.
@x
begin rewrite(term_out); {prepare the terminal for output}
write_ln(term_out,banner);@/
@y
begin
@z

[66] write banner to term_out before opening the other files
@x
@p begin initialize; {get all variables initialized}
@y
@p begin write_ln(term_out, banner);
initialize; {get all variables initialized}
@z

[66] print end of line at end of line
@x
print(' altogether.');
@.The file had n characters...@>
final_end:end.
@y
print_ln(' altogether.');
@.The file had n characters...@>
final_end: halt(history) end.
@z

[73] declare and initialize history
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
