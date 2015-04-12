% This is a change file of TFtoPL for GPC, Wolfgang Helbig, Apr. 2008
[0] About TFtoPL-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt TFtoPL}

\N0\*. About \namegpc.\fi

This is an adaption of Donald~E. Knuth's \.{TFtoPL}, version 3.2
from March 2008, to Unix. It is based on GNU~Pascal, version 2.1.

This program expects an input file (\.{.tfm}) and an output file
(\.{.pl}), which is a text file, on the command line.  To support
shell scripting, \namegpc\ sets the exit code to one when something
was wrong with the input file.

\hint

Comments and questions are welcome!

\bigskip
\address
@z
[1]
@x
@d banner=='This is TFtoPL, Version 3.2' {printed when the program starts}
@y
@d banner=='This is TFtoPL-GPC' {printed when the program starts}
@z

[2] files from command line
@x
@p program TFtoPL(@!tfm_file,@!pl_file,@!output);
@y
@p program TFtoPL(@!output);
@z

[6]
@x
@!tfm_file:packed file of 0..255;
@y
@!tfm_file:packed file of packed 0..255;
@z

[7]
@x
reset(tfm_file);
@y
if param_count <> 2 then begin
  print_ln('Usage: tftopl tfm-file pl-file');
  goto final_end;
  end;
reset(tfm_file, param_str(1));
@z

[17]
@x
rewrite(pl_file);
@y
if param_count <> 2 then abort('Usage: tftopl tfm-file pl-file');
rewrite(pl_file, param_str(2));
@z

[20] set history in abort
@x
  goto final_end;
@y
  history := 1; goto final_end;
@z

[99]
@x
final_end:end.
@y
final_end:halt(history);end.
@z

[100]
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
