% This is a change file for TANGLE-GPC, Wolfgang Helbig, Nov. 2007
% Apr. 2008 take file names from command line
% Jul. 2008 pass the exit code

[0] About TANGLE-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc
\def\name{{\tt TANGLE}}

% \let\maybe=\iffalse % uncomment to print changed modules only.

\N0\*. About \namegpc.\fi
This is an adaption of Donald~E. Knuth's \.{TANGLE}, version 4.5
from December 2002, to Unix. \namegpc\ is based on GNU~Pascal, version
2.1.

This program expects four file names on the command line: Two input
files, the web and change file, followed by two output files, the
Pascal and string pool file. If you call \namegpc\ with the wrong number
of command line arguments, it will tell you and exit.

To support shell scripting, this version sets the exit code to its
`\\{history}'---zero means ok, one means a warning was issued, two
an error occurred and three means \.{TANGLE} ended prematurely.

\hint

Comments and questions are welcome!
\bigskip
\address
@z

[1] Change the banner line
@x
@d banner=='This is TANGLE, Version 4.5'
@y
@d banner=='This is TANGLE-GPC'
@z

[2] terminal output and input
@x
program TANGLE(@!web_file,@!change_file,@!Pascal_file,@!pool);
@y
program TANGLE(@!input,@!output);
@z

	[3] turn debugging on
	@x
	@d debug==@{ {change this to `$\\{debug}\equiv\null$' when debugging}
	@d gubed==@t@>@} {change this to `$\\{gubed}\equiv\null$' when debugging}
	@y
	@d debug==
	@d gubed==
	@z

[3] turn stats on
@x
@d stat==@{ {change this to `$\\{stat}\equiv\null$'
  when gathering usage statistics}
@d tats==@t@>@} {change this to `$\\{tats}\equiv\null$'
  when gathering usage statistics}
@y
@d stat==
@d tats==
@z

[4] compiler directives
@x
@{@&$C-,A+,D-@} {no range check, catch arithmetic overflow, no debug overhead}
@!debug @{@&$C+,D+@}@+ gubed {but turn everything on when debugging}
@y
@z

[7] default case branch
@x
@d othercases == others: {default for cases not listed explicitly}
@y
@d othercases == @+else  {default for cases not listed explicitly}
@z

[12] the type of text_files is text in ISO Pascal
@x
@!text_file=packed file of text_char;
@y
@!text_file=text;
@z

[20] terminal output
@x
@d print(#)==write(term_out,#) {`|print|' means write on the terminal}
@y
@d term_out == output
@d term_in == input
@d print(#)==write(term_out,#) {`|print|' means write on the terminal}
@z

[20] terminal output, implicitely defined in ISO Pasal
@x
@<Globals...@>=
@!term_out:text_file; {the terminal as an output file}
@y
@z

[21] terminal output, output is rewritten implicitely in ISO Pascal
@x
@<Set init...@>=
rewrite(term_out,'TTY:'); {send |term_out| output to the terminal}
@y
@z

[22] terminal output, don't need update in ISO Pascal
@x
@d update_terminal == break(term_out) {empty the terminal output buffer}
@y
@d update_terminal == do_nothing
@z

[24] get file names from command line arguments
@x
begin reset(web_file); reset(change_file);
@y
begin
reset(web_file, param_str(1)); reset(change_file, param_str(2));
@z

[26] get file names from command line arguments
@x
rewrite(Pascal_file); rewrite(pool);
@y
if param_count <> 4 then begin
   fatal_error('Usage: tangle web_file change_file pascal_file pool_file');
   end;
rewrite(Pascal_file, param_str(3)); rewrite(pool, param_str(4));
@z

[38] increase token capacity to tangle mf.
@x
@d zz=3 {we multiply the token capacity by approximately this amount}
@y
@d zz=4 {we need 4 not 3 to tangle mf}
@z

[179]
@x
@!term_in:text_file; {the user's terminal as an input file}
@y
@z

[180] terminal input, implicitely done by Pascal
@x
reset(term_in,'TTY:','/I'); {open |term_in| as the terminal, don't do a |get|}
@y
@z

[187] put eol after last terminal out line
@x
fatal_message: print_nl('(That was a fatal error, my friend.)');
end {there are no other cases}
@y
fatal_message: print_nl('(That was a fatal error, my friend.)');
end; {there are no other cases}
new_line;
halt(history) {pass the history as exit code to the operating system}
@z
