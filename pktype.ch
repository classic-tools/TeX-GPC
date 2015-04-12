% This is a change file of PKType for GPC, Wolfgang Helbig, Apr. 2008
To be used with the GNU Pascal Compiler Version 2.1

[0] About PKtype-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt PKtype}

\N0\*. About \namegpc.\fi

This is an adaption of Donald~E. Knuth's \.{PKtype}, version 2.3
from April 2000, to Unix. It is based on GNU~Pascal, version 2.1.

This program expects the input file (\.{.pk}) and the output file,
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
@d banner=='This is PKtype, Version 2.3' {printed when the program starts}
@y
@d banner=='This is PKtype-GPC'
 {printed when the program starts}
@z

[2] default case branch
@x
@d othercases == others: {default for cases not listed explicitly}
@y
@d othercases == @+else {default for cases not listed explicitly}
@z

[8] set history
@x
@d abort(#)==begin print_ln(' ',#); t_print_ln(' ',#); jump_out; end
@y
@d abort(#)==begin print_ln(' ',#); t_print_ln(' ',#); history := 1; jump_out;
             end
@z

[9] the type of text_files is text in ISO Pascal
@x
@!text_file=packed file of text_char;
@y
@!text_file=text;
@z

[30] use GPC extension for packing subranges.
@x
@!eight_bits=0..255; {packed file byte}
@y
@!eight_bits=packed 0..255; {unsigned one-byte quantity}
@z

[32] 
@x
begin reset(pk_file,pk_name);
@y
begin reset(pk_file,trim(pk_name));
@z

@x
begin rewrite(typ_file,typ_name);
@y
begin rewrite(typ_file,trim(typ_name));
@z

[54] command line
@x
@ @p procedure dialog ;
var i : integer ; {index variable}
buffer : packed array [1..name_length] of char; {input buffer}
begin
   for i := 1 to name_length do begin
      typ_name[i] := ' ' ;
      pk_name[i] := ' ' ;
   end;
   print('Input file name:  ') ;
   flush_buffer ;
   get_line(pk_name) ;
   print('Output file name:  ') ;
   flush_buffer ;
   get_line(typ_name) ;
end ;
@y
@ Here we get the file names from the command line

@d gpc_length == length
@d gpc_param_str == paramstr
@d gpc_param_count == param_count

@p procedure dialog ;
var i : integer ; {index variable}
buffer : packed array [1..name_length] of char; {\2 input buffer}
begin
   if gpc_param_count <> 2 then
      abort('! Usage: pktype pk_file text_file');
   i := 1;      
   while (i <= name_length) and (i <= gpc_length(gpc_param_str(1))) do
     begin pk_name[i] := gpc_param_str(1)[i]; incr(i);
     end;
   while i <= name_length do
     begin pk_name[i] := ' '; incr(i);
     end;
   i := 1;      
   while (i <= name_length) and (i <= gpc_length(gpc_param_str(2))) do
     begin typ_name[i] := gpc_param_str(2)[i]; incr(i);
     end;
   while i <= name_length do
     begin typ_name[i] := ' '; incr(i);
     end;
end ;
@z

[55] set exit code
@x
final_end :
@y
final_end : halt(history);
@z

[56 ff] 
@x
Any additional routines should be inserted here.
@^system dependencies@>
@y
Any additional routines should be inserted here.
@^system dependencies@>

@<Globals...@>=
history : integer;

@
@<Set init...@>=
history := 0;
@z
