# utl_excel_sas_wps_r_import_xlsx_without_sas_access_to_pc_files
SAS WPS R Import XLSX without SAS access to PC-FIles Keywords: sas sql join merge big data analytics macros oracle teradata mysql sas communities stackoverflow statistics artificial inteligence AI Python R Java Javascript WPS Matlab SPSS Scala Perl C C# Excel MS Access JSON graphics maps NLP natural language processing machine learning igraph.
    SAS WPS R Import XLSX without SAS access to PC-FIles

    github
    run;quit;
    https://github.com/rogerjdeangelis/utl_excel_sas_wps_r_import_xlsx_without_sas_access_to_pc_files

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
