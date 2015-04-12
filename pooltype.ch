
@x
  \centerline{(Version 3, September 1989)}
@y
  \centerline{(GPC-Version, October 2009)}
@z

[2]
@x
@p program POOLtype(@!pool_file,@!output);
@y
@p program POOLtype(@!output);
@z

[18]
@x
@!pool_file:packed file of text_char;
  {the string-pool file output by \.{TANGLE}}
@y
@z

[19]
@x
reset(pool_file); xsum:=false;
@y
xsum:=false;
@z

[20]
@x
  write_ln('"'); incr(s);
  end
@y
  write_ln('"'); incr(s);
  if not eoln(pool_file) then
     abort('! That POOL line was too long');
  end
@z

[21]
@x
itself will get a new section number.
@^system dependencies@>
@y
itself will get a new section number.
@^system dependencies@>

@<Glob...@>=
@!pool_file: text;

@ @<Set init...@>=
if param_count <> 1 then
  begin abort('Usage: pooltype pool_file')
  end;
reset(pool_file, param_str(1));
@z
