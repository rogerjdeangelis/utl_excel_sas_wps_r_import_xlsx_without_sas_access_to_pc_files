SAS WPS R Import XLSX without SAS access to PC-FIles

Original topic
PROC IMPORT

see
https://communities.sas.com/t5/General-SAS-Programming/PROC-IMPORT/m-p/424527

/* T1005450 SAS Forum: Unable to import Excel file

If you have IML/R you can paste the code into IML. If you don't
you can install R and the free WPS express and use my code below.
Free WPS does not limit the size of the output SAS dataset.

WORKING CODE
    WPS/R IML/R

      want<-readWorksheet(wb, "class");
      import r=want data=wrk.wantwps;

see
https://goo.gl/UNMLuB
https://communities.sas.com/t5/SAS-Procedures/Unable-to-import-Excel-file/m-p/365900

HAVE excel sheet
==============================

d:/xls/class.xlsx

    +----------------------------------------+
    |  A    |  B    |  C    |  D    |   E    |
    +----------------------------------------+
1   |NAME   |AGE    |SEX    |HEIGHT |WEIGHT  |
    |-------+-------+-------+-------+--------|
2   |Alfred |14     |M      |69     |112.5   |
    |-------+-------+-------+-------+--------+
3   |Alice  |13     |F      |56.5   |84      |
    |-------+-------+-------+-------+--------+
4   |Barbara|13     |F      |65.3   |98      |
    |-------+-------+-------+-------+--------+
5   |Carol  |14     |F      |62.8   |102.5   |
    |-------+-------+-------+-------+--------+
6   |Henry  |14     |M      |63.5   |102.5   |
    ------------------------------------------
...

[CLASS]

WANT SAS dataset wantwps.sas7bdat
=================================

The WPS System

Up to 40 obs from want total obs=19

Obs    NAME       SEX    AGE    HEIGHT    WEIGHT

  1    Alfred      M      14     69.0      112.5
  2    Alice       F      13     56.5       84.0
  3    Barbara     F      13     65.3       98.0
  4    Carol       F      14     62.8      102.5
  5    Henry       M      14     63.5      102.5
  6    James       M      12     57.3       83.0
  7    Jane        F      12     59.8       84.5
  8    Janet       F      15     62.5      112.5
  9    Jeffrey     M      13     62.5       84.0
...

*                _               _
 _ __ ___   __ _| | _____  __  _| |_____  __
| '_ ` _ \ / _` | |/ / _ \ \ \/ / / __\ \/ /
| | | | | | (_| |   <  __/  >  <| \__ \>  <
|_| |_| |_|\__,_|_|\_\___| /_/\_\_|___/_/\_\
;

%utlfkil(d:/xls/class.xlsx);
libname xel "d:/xls/class.xlsx";
data xel.class;
  set sashelp.class;
run;quit;
libname xel clear;

*          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|
;

%utl_submit_wps64('
options set=R_HOME "C:/Program Files/R/R-3.4.0";
libname wrk "%sysfunc(pathname(work))";
proc r;
submit;
library(XLConnect);
wb <- loadWorkbook("d:/xls/class.xlsx",create = FALSE);
want<-readWorksheet(wb, "class");
want;
endsubmit;
import r=want data=wrk.wantwps;
run;quit;
');

proc print data=wantwps;
run;quit;


\ \ /\ / / '_ \/ __| | | | | '_ \ / _` |/ _` | __/ _ \
 \ V  V /| |_) \__ \ | |_| | |_) | (_| | (_| | ||  __/
  \_/\_/ | .__/|___/  \__,_| .__/ \__,_|\__,_|\__\___|
         |_|               |_|
;

With perhaps the exception of WPS Express, but for all versions at v3.3
or higher of WPS and running on any for the following OS platforms
AIX
Linux on ARM
Linux on System P
Linux on x86
Mac OS
Solaris on SPARC and X86
Windows
Linux on System z
And z/OS on System z
I'd opt for the XLSX access engine that is included as part of the license.
It's just easier and in my opinion more portable. You don’t need the MS data
access engines and you get cross-platform compatibility. The other bonus is
that you don’t have to worry whether the customer has R installed.
Also, PROC IMPORT and PROC Export are part of the base package and
can utilize the XLSX engine.
/*************** Code ***************/
  data a;
    do ii=1 to 10;
    x=ranuni(0); y=rannor(0); z=ranuni(0);
    output;
  end;
  run;
  libname mylib xlsx 'c:\temp\simple.xlsx' replace;
  data mylib.simple1;
  set a;
  run;
  proc print data=mylib.simple1;
  run;
  data b; set mylib.simple1;
  xyz=sum(of x y z);
  run;
/**************** LOG ******************/
342         data a;
343           do ii=1 to 10;
344           x=ranuni(0); y=rannor(0); z=ranuni(0);
345           output;
346         end;
347         run;
NOTE: Data set "WORK.a" has 10 observation(s) and 4 variable(s)
NOTE: The data step took :
      real time : 0.007
      cpu time  : 0.000
348
349
350         libname mylib xlsx 'c:\temp\simple1.xlsx' replace;
NOTE: Library mylib assigned as follows:
      Engine:        XLSX
      Physical Name: c:\temp\simple1.xlsx
351
352         data mylib.simple1;
353         set a;
354         run;
NOTE: A Sheet named simple1 already exists in the workbook, and will be overwritten.
NOTE: Attempting to clear data in sheet simple1 (note, this does not delete the sheet itself)
NOTE: 10 observations were read from "WORK.a"
NOTE: Data set "MYLIB.simple1" has 10 observation(s) and 4 variable(s)
NOTE: The data step took :
      real time : 0.006
      cpu time  : 0.000
355
356         proc print data=mylib.simple1;
357         run;
NOTE: 10 observations were read from "MYLIB.simple1"
NOTE: Procedure print step took :
      real time : 0.010
      cpu time  : 0.000
359         data b; set mylib.simple1;
360         xyz=sum(of x y z);
361         run;
NOTE: 10 observations were read from "MYLIB.simple1"
NOTE: Data set "WORK.b" has 10 observation(s) and 5 variable(s)
NOTE: The data step took :
      real time : 0.009
      cpu time  : 0.015
NOTE: DATA statement used (Total process time):
      real time           0.02 seconds
      user cpu time       0.00 seconds
      system cpu time     0.03 seconds
      memory              240.15k
      OS Memory           18412.00k
      Timestamp           01/04/2018 03:57:47 PM
      Step Count                        468  Switch Count  0


2957  ;;;;




