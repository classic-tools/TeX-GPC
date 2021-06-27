July 2014
This directory contains change files for Donald E. Knuth's suite
of TeX related programs. The change files (.ch) and Don Knuth's
WEB files (.web) from January 2014 are the key components of a
construction kit for "TeX-GPC"---a TeX system which is based on
the GNU Pascal compiler and runs in a Unix environment.  It's
smaller, less configurable and therefore easier to master than
other TeX distributions and should compile and run on Unix alikes.

These building bricks are glued together by shell scripts in
the---guess where---shell subdirectory.

The MFT directory contains shell scripts for installing fonts
(xxxfonts), and the directory iby that shows how to install fonts
with TeX-GPC. In this case a polytonic Greek font, suited for ancient
Greek texts.

The mp directory helps to include John Hobby's MetaPost in TeX-GPC.
MetaPost lets you define pictures to be included in your TeX
document.

The directories dvipsnk and xdvi show how to install Tom Rokicki's
dvips and Paul Vojta's xdvi.

I was somewhat intrigued while building TeX from its sources, since
some of these depend on others to be built and installed.  Knuth
wrote these programs in the WEB language (WEB is only remotely
related to the last W from CERN's WWW). WEB programs are converted
to Pascal sources by tangle and to a TeX input file by weave. Of
course, tangle and weave are WEB programs as well. So one needs
tangle to build tangle---and weave and TeX to read a beautifully
typeset WEB program.  But don't despair, I cut this indefinite
recursion and provided tangle.p, the Pascal source of tangle, and
tex.pdf. It shows what, why and how I changed Knuth's program.
see
  https://github.com/classic-tools/TeX-GPC/raw/master/tex.pdf

Preparation:
===========
Martin Monperrus suggested to create a second edition of TeX-GPC, just to
make it compile with current releases of GPC. And here it is.

The previous edition of TeX-GPC was born in a NetBSD 3.0 system,
compiled by the latest stable version of GNU Pascal, which is 2.1,
from the NetBSD package gpc-2.1nb3.

Luis Rivera successfully built TeX-GPC under CYGWIN with GPC 3.4.4
and found out that newer versions of GPC expect the parameter type
"cinteger" instead of "integer" in a certain function.  Change the
WEB macro "gpc_integer" in tex.ch and mf.ch accordingly.

This release of TeX-GPC was tested on Mac OS X 10.8.
and GPC 20070904, based on gcc-3.4.6.

The changes are:
Now works out of the box with contemporary GPC's. But not with NetBSD-3.0

The directory MF was renamed to MFT, because OS X yet has to learn
how uppercase and lowercase differ.

The old GPC let you mistreat a function as a procedure.  And, of
course, I did. This is fixed now.

Another bug pointed out by Joachim Kuebart is fixed: If the first
input line (or the command line) contains spaces only, a loop might
not terminate properly. (Well it worked anyhow, you'll have to read
the source to find this bug, testing wouldn't help!)

A new directory, ,,tech'', that supports german style and hyphenation
was added.

The pascal sources initex.p and inimf.p are to be kept around now,
to let you easily change constants, automated by the shell script itgl.

The documentation in tex.pdf is largely improved. 

Overview:
=========

File formats and their documentation:
-------------------------------------
WEB files:
.web	WEB programs, "The WEB System of Structured Documentation" (webman.tex)
.ch	Change files for WEB programs (patches to be applied to .web files)
.p	GNU Pascal source
.pool   String pool, contains the string constants of a WEB program.


METAFONT files:
.mf	METAFONT source, "The METAFONTbook" (mfbook.tex)
.base   Base file, a compact representation of METAFONT's memory.
.tfm    TeX font metric, "TeX: The Program" (tex.web) part 30
.nnngf	generic font file, "METAFONT: The Program" (mf.web), part 46
.nnnpk	packed font file, gftopk.web, modules 21-36
        The last two are bitmap font formats, where nnn is a number that
        stands for "dots per inch". The number equals resolution of the
        output device as specified in your mode times the magnification.
.log    a log file
 
TeX files:
.tex	TeX source, "The TeXbook" (texbook.tex)
.fmt    Format file, a compact representation of TeX's memory.
        contains the string pool (tex.pool) and preloaded .tfm files.
.dvi	device independent file, "TeX: The Program" (tex.web), part 31
.log    a log file



Files and their processors:
--------------------------
WEB:
		   tangle
       .web, .ch --------> .p, .pool

                   gpc
             .p  --------> a.out

                   tgl
       .web, .ch --------> a.out (linking the last two steps)

                   itgl
      x.web, x.ch --------> a.out,  inix.p, .pool (links the first two steps
                                                  and keeps the pascal sources)

		   weave
       .web, .ch --------> .tex (Description of the program)

		   wve
       .web, .ch --------> .dvi (linking the above step and tex)


METAFONT:
		   inimf
	plain.mf --------> plain.base

                    mf
	     .mf --------> .nnngf, tfm

                  gftopk
          .nnngf --------> .nnnpk

                  mkfont
             .mf --------> TeXfonts/.tfm, PKfonts/.nnnpk

                 mkpkfont
             .mf --------> PKfonts/.nnnpk


TeX:
		   initex
 .tfm, plain.tex --------> plain.fmt

                    tex
  [ .tfm ], .tex --------> .dvi


DVI drivers:
                   dvips
    .dvi, .nnnpk --------> .ps, PostScript printer

                   xdvi
    .dvi, .nnnpk --------> X-Window


File names:
-----------
TeX-GPC searches files in directories which are local to the working
directory:
	TeXinputs  .tex
	TeXfonts   .tfm
	TeXformats .pool, .fmt
	MFinputs   .mf
	MFbases    .pool, .base
	PKfonts    .nnnpk
	DVIPSconf  .pro, .ps, .map (Header and configuration files for dvips)

I created one set of "master directories" and used symbolic links
to my working directory like:

	ln -s ~/TeXformats .

The scripts mk_TeX_dir and mk_MF_dir help to prepare a directory
for running TeX resp. METAFONT.  Adapt these scripts to the locations
of your master directories.

TeX-GPC's path searching applies to file names without directory
components, i.e. without a /:
	.tex   local directory and then TeXinputs 
	.mf    local directory and then MFinputs
	.tfm   TeXfonts

Depending on the context, TeX-GPC programs append ".mf", ".tex",
or ".tfm" to file names without extensions.

builtin file names:
------------------
TeXformats/tex.pool	string pool for tex, (in initex)
MFbases/mf.pool		string pool for mf, (in inimf)
TeXformats/plain.fmt 	format file for Plain TeX, (in tex)
MFbases/plain.base  	base file for Plain METAFONT, (in mf)

Fonts in TeX-GPC:
----------------
For each font TeX needs one .tfm file. For each font and
resolution/magnification the DVI drivers need one .nnnpk file.
The script mkfont will install both a .tfm and an .nnnpk file, the
script mkpkfont will install an .nnnpk file only.  You specify the
resolution in your METAFONT mode and the magnification as an optional
second argument to mkpkfont or mkfont.  The DVI drivers will invoke
mkpkfont automatically to create missing .nnnpk files.

Running TeX-GPC
===============
Missing files
-------------
Search missing macro files like (webmac.tex) in Knuth's lib
directory and copy them to the working directory or to TeXinputs.
My change files import webmac-gpc.tex; move it to TeXinputs.

Search the sources of missing fonts in the lib directory (.mf),
copy them to MFinputs and use the scripts mkfont  or mkpkfont to
create and install .tfm files respective .pk files. The shell scripts
assume the METAFONT mode localfont which is defined in MFT/local.mf.
Remember, you've loaded local.mf into the file plain.base. Or you
might want to grep for font assignments in your .tex files. The
command line
	grep '\\font.*=' plain.tex > plainfonts
creates a list of the font names used by plain.tex. I edited
plainfonts to convert it to a shell script that creates all fonts
of the plain format. In the MFT directory you'll find other examples.

Installing new fonts from CTAN
------------------------------
The directory MFT/iby contains instructions on how to install a font
from CTAN, in this case ibygrk to typeset polytonic ancient Greek.

Printing the documentation
--------------------------
The weave program generates an xxx.tex file from an xxx.web file
and a possibly empty change file. Use tex to generate an xxx.dvi
file. This is done by the script wve. For example, to view the
description of TeX-GPC, use
	wve tex.web tex.ch && xdvi tex
The web-macros need another font. Use webfonts to install it.
The scripts texwebfonts installs additional fonts for  tex.tex, 
and mfwebfonts for mf.tex.

TRIP TRAP
---------
Both tests might not be passed by TeX-GPC: TeX and METAFONT trim
trailing spaces from input lines for compatibility with IBM's
punched cards. TeX-GPC's programs don't.


Installing TeX-GPC:
===================

Get Knuth's source files:
------------------------
Make a stage directory, say tex-gpc, which mirrors Knuth's distribution
from

	ftp://ftp.dante.de/pub/tex/systems/knuth/dist

This gives you the WEB files, manuals, macros and some .mf files.
At least you need the directories lib, tex, mfware, mf and web.

You need another set of source files, namely the METAFONT source
files (.mf) for Knuth's font Computer Modern.

Copy the .mf files from
	ftp://ftp.dante.de/pub/tex/fonts/cm/mf/
to MFinputs.

And Copy the .mf files from the lib directory to MFinputs.
        cp -p lib/*.mf MFinputs

I prefer the DANTE server, because that server preserves modification
times. This is not true with other CTAN mirrors.

Building from WEB sources, (xxx.web and xxx.ch --> xxx, xxx.pool)
----------------------------------------------------------------
The general procedure to build a binary xxx from its WEB files is:
Move xxx.ch to the directory that contains xxx.web, apply tangle
to xxx.web and xxx.ch to generate xxx.p and xxx.pool, and compile the
Pascal source with gpc. The command line
   tgl xxx.web xxx.ch
will do all that. It produces an a.out file that should be moved
to your binary directory as xxx. ("binary directory" means a
directory in your PATH.)

Step by step procedure to bootstrap TeX-GPC
-------------------------------------------

0. Make tangle                                       tangle.p --> tangle
------------------------------------------------------------------------
Compile tangle.p (gpc tangle.p) and move a.out as tangle to your
binary directory.

1. Make inimf and initex  mf.web,  mf.ch --> inimf, inimf.p, MFbases/mf.pool
                         tex.web, tex.ch --> initex,initex.p TeXformats/tex.pool
------------------------------------------------------------------------
Build the ini-programs and save them as initex, resp. inimf.
Move tex.pool to TeXformats and mf.pool to MFbases, use itgl instead
of tgl to keep inimf.p and initex.p.

2. Make plain.base                   lib/plain.mf --> MFbases/plain.base
------------------------------------------------------------------------
Go to the directory tex-gpc/mf and use inimf to create plain.base.
The file local.mf contains mode definitions for my HP LaserJet 1320
printer. Adapt local.mf to your printer and then type
	inimf ../lib/plain input ../MFT/local dump

Move plain.base to MFbases.

3. Make mf 					    mf.web, mf.ch --> mf
------------------------------------------------------------------------
Edit mf.ch and look for the string @x inimf that introduces a change
block. This change block is commented out, since it is shifted
right.  Shift left this block to uncomment it. This way mf.ch is
changed to build a production version.

4. Make gftopk                          gftopk.web, gftopk.ch --> gftopk
------------------------------------------------------------------------
Build gftopk in the mfware directory. You need gftopk to install
packed font files (.nnnpk) in the next step.

5. Install fonts:         MFinputs/*.mf --> TeXfonts/*.tfm, PKfonts/*.pk
------------------------------------------------------------------------
Prepare tex-gpc to run both METAFONT (mk_MF_dir) and TeX (mk_TeX_dir)
and run the shell script plainfonts from there.
Check the file trouble that might contain commands that failed.

6. Make plain.fmt                 lib/plain.tex --> TeXformats/plain.fmt
------------------------------------------------------------------------
Copy lib/hyphen.tex to TeXinputs and go to the directory tex-gpc/tex
to build plain.fmt.
This command line will do 
    initex ../lib/plain \\dump # one backslash is consumend by sh!
Move plain.fmt to TeXformats.

7. Finally build tex                             tex.web, tex.ch --> tex
------------------------------------------------------------------------
Change tex.ch for production, and build it with tgl.

Enjoy,
Wolfgang Helbig, Programmierer

Comments welcome: helbig aet lehre dot ba-stuttgart dot de

TeX is a trademark of the American Mathematical Society.
METAFONT is a trademark of Addison Wesley Publishing Company.
