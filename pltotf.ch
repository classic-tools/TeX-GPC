% This is a change file of PLtoTF for GPC, Wolfgang Helbig, Nov. 2007

[0] About PLtoTF-GPC
@x
\pageno=\contentspagenumber \advance\pageno by 1
@y
\pageno=\contentspagenumber \advance\pageno by 1
\input webmac-gpc

% \let\maybe=\iffalse % uncomment to print changed modules only.

\def\name{\tt PLtoTF}

\N0\*. About \namegpc.\fi

This is an adaption of Donald~E. Knuth's \.{PLtoTF}, version 3.5
from March 1995, to Unix. It is based on GNU~Pascal, version 2.1.

This program expects an input file (\.{.tfm}) and an output file
(\.{.pl}), which is a text file, on the command line. \namegpc.
stops with a nonzero exit code, if the number of command line
arguments is not two or if the files cannot be opened.

\hint

Comments and questions are welcome!

\bigskip
\address
@z

[1]
@x
@d banner=='This is PLtoTF, Version 3.5' {printed when the program starts}
@y
@d banner=='This is PLtoTF-GPC'
{printed when the program starts}
@z

[6] use command line
@x
reset(pl_file);
@y
if param_count <> 2 then begin
  write_ln('Usage: pltotf pl-file tfm-file');
  halt(1);
  end;
reset(pl_file, param_str(1));
@z

[15]
@x
@!tfm_file:packed file of 0..255;
@y
@!tfm_file:packed file of packed 0..255;
@z

[16] use command line
@x
rewrite(tfm_file);
@y
rewrite(tfm_file, param_str(2));
@z
