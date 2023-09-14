/*!
 ******************************************************************************
 * \file       m_uc_describe_view.sas
 * \ingroup    Custom
 * \brief      Custom macro to export code to recreate a SAS DS or SQL view.
 * \details    This macro can be used to transfer data step or SQL type views
 *             across different operating environments. The program uses the
 *             SAS dictionary tables to determine the view type, which can be
 *             a SAS data step or SQL type view, and then uses the describe
 *             statement accordingly to obtain the view code to recreate it.
 * 
 * \note       The macro returns the source path, view name, and view code
 *             information as result in a SAS dataset, which could be ported
 *             into a XPT type file, and transferred to another SAS system. 
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-04-11 00:00:00
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  pathnm      Parameter to specify the the full path and SAS 
 *                         view name including extension (.sas7bvew). 
 *                         The default value for PATHNM is: _NONE.
 * \param[in]  viewnm      Optional. Full qualified name <library.view>
 *                         for the source SAS view. 
 *                         The default value for VIEWNM is: _NONE_.
 * \param[in]  libref      Parameter to specify the target library name
 *                         that will be used for the view creation code. 
 *                         The default value for LIBREF is: _TMP_.
 * \param[in]  outtbl      Optional. Full qualified name <library.view>
 *                         for the result output table containing the 
 *                         view description information.
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by using proc report steps with style HtmlBlue. 
 *                         The default value for PRINT is: N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     Returns a table with SAS view type information and creation code.
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_describe_view(?)
 * \endcode
 * 
 * \example    For the next examples create a SAS data step and a proc sql type view:
 * \code
 *             data WORK._dsvview / view=WORK._dsvview;
 *                set SASHELP.class;
 *                where Sex eq "F";
 *             run;
 * 
 *             proc sql noprint;
 *                create view WORK._sqlview as
 *                select *
 *                  from SASHELP.class
 *                 where Sex eq "M"
 *                ;
 *             quit;
 *
 *             proc print data=SASHELP.vview 
 *                (where=(upcase(libname) eq 'WORK')) label noobs;
 *             run;
 * \endcode
 * 
 * \example    Example 2: Obtain SAS data step view type code description information:
 * \code
 *             %m_uc_describe_view(
 *                pathnm   = %sysfunc(getoption(WORK))/_dsvview.sas7bvew
 *              , libref   = TMP
 *              , outtbl   = WORK.dsv_p_result
 *              , print    = Y
 *              , debug    = N
 *                );
 * \endcode
 * 
 * \example    Example 3: Obtain SAS proc SQL view type code description information:
 * \code
 *             %m_uc_describe_view(
 *                pathnm   = %sysfunc(getoption(WORK))/_sqlview.sas7bvew
 *              , libref   = TMP
 *              , outtbl   = WORK.sql_p_result
 *              , print    = Y
 *              , debug    = N
 *                );
 * \endcode
 * 
 * \example    Example 4: Obtain SAS view description information from existing library:
 * \code
 *             %m_uc_describe_view(
 *                viewnm   = WORK._dsvview
 *              , libref   = TMP
 *              , outtbl   = WORK.dsv_l_result
 *              , print    = Y
 *              , debug    = N
 *                );
 * \endcode
 * 
 * \example    Example 5: Obtain SQL view description information from existing library:
 * \code
 *             %m_uc_describe_view(
 *                viewnm   = WORK._sqlview
 *              , libref   = TMP
 *              , outtbl   = WORK.sql_l_result
 *              , print    = Y
 *              , debug    = N
 *                );
 * \endcode
 * 
 * \copyright  Copyright 2008-2021 Paul Alexander Canals y Trocha.
 * 
 *     This program is free software: you can redistribute it and/or modify
 *     it under the terms of the GNU General Public License as published by
 *     the Free Software Foundation, either version 3 of the License, or
 *     (at your option) any later version.
 * 
 *     This program is distributed in the hope that it will be useful,
 *     but WITHOUT ANY WARRANTY; without even the implied warranty of
 *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *     GNU General Public License for more details.
 * 
 *     You should have received a copy of the GNU General Public License
 *     along with this program. If not, see <https://www.gnu.org/licenses/>.
 * 
 ******************************************************************************
 */
%macro m_uc_describe_view(
   help
 , vers   = 21.1.04
 , pathnm = _NONE_
 , viewnm = _NONE_
 , libref = _TMP_
 , outtbl = 
 , print  = N
 , debug  = N
   );

   %if %upcase(&debug.) eq Y or &help. eq ? %then %do;

   %put INFO: ================================================================;
   %put INFO: Autocall SAS Macro "&sysmacroname." is starting..               ;
   %put INFO: ================================================================;

   %end;

   %*-------------------------------------------------------------------------;
   %* If macro called with "HELP" or "?" show info in log:                    ;
   %*-------------------------------------------------------------------------;

   %if &help. eq ? or %upcase(&help.) eq HELP %then %do;

      %put ;
      %put %nrstr(Help for macro definition %m_uc_describe_view.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_describe_view%( );
      %put %nrstr(   pathnm    = <full path>/<view name>.sas7bvew );
      %put %nrstr( , viewnm    = [<libname>.<viewname>] (optional) );
      %put %nrstr( , libref    = [_TMP_|<target library name>] );
      %put %nrstr( , outtbl    = [<libname>.<tablename>] (optional) );
      %put %nrstr( , print     = [Y|N] );
      %put %nrstr( , debug     = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to export code to recreate a SAS DS or SQL view. );
      %put ;
      %put %nrstr(This macro can be used to transfer data step or SQL type views );
      %put %nrstr(across different operating environments. The program uses the );
      %put %nrstr(SAS dictionary tables to determine the view type, which can be );
      %put %nrstr(a SAS data step or SQL type view, and then uses the describe );
      %put %nrstr(statement accordingly to obtain the view code to recreate it. );
      %put ;
      %put %nrstr(The macro returns the source path, view name, and view code );
      %put %nrstr(information as result in a SAS dataset, which could be ported );
      %put %nrstr(into a XPT type file, and transferred to another SAS system. );
      %put ;
      %put %str(Copyright 2008-%sysfunc(today(),year4.) Paul Alexander Canals y Trocha );
      %put ;
      %put %str(This program is free software: you can redistribute it and/or modify );
      %put %str(it under the terms of the GNU General Public License as published by );
      %put %str(the Free Software Foundation, either version 3 of the License, or );
      %put %str((at your option) any later version. );
      %put ;
      %put %str(This program is distributed in the hope that it will be useful, );
      %put %str(but WITHOUT ANY WARRANTY; without even the implied warranty of );
      %put %str(MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the );
      %put %str(GNU General Public License for more details. );
      %put ;
      %put %str(You should have received a copy of the GNU General Public License );
      %put %str(along with this program. If not, see <https://www.gnu.org/licenses/>. );
      %put ;

      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Set local macro variables and initialize environment:                   ;
   %*-------------------------------------------------------------------------;

   %local 
      date
      delim
      engine
      fname
      fpath
      msg1
      msg2
      msg3
      msg4
      msg5
      msg6
      msg7
      path
      prgm
      savemauto
      savemode
      savemlogic
      savenest
      savemprint
      savenotes
      savesource
      savesource2
      savestimer
      savesymbols
      source
      start
      stop
      time
      view
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1 = %nrstr(Parameter PATHNM is not given but is mandatory!);
   %let msg2 = %nrstr(Path and file (&pathnm.) does not exist. Exiting!);
   %let msg3 = %nrstr(Parameter VIEWNM is not given but is mandatory!);
   %let msg4 = %nrstr(Libref for VIEWNM not given. Changed libref to: WORK!);
   %let msg5 = %nrstr(View %upcase(&viewnm.) does not exist. Exiting!);
   %let msg6 = %nrstr(The engine type for %upcase(&view.) is: &engine.);
   %let msg7 = %nrstr(Engine type &engine. for %upcase(&view.) is invalid!);

   %*-------------------------------------------------------------------------;
   %* Submacro: print a message to the log and/or result output:              ;
   %*-------------------------------------------------------------------------;

   %macro print_message(
      program = &sysmacroname.
    , status  = OK
    , message = %quote()
    , print   = N
      );

      %local report;

      %* Check if STATUS has been given a valid value: ;
      %let status = %upcase(%substr(&status.,1,1));
      %let status = %scan(Abort Debug Error Info Ok Warning,%eval(1+%index(DEIOW,&status.)));

      %* If status code is invalid, set to default value: ;
      %if &status. eq Abort %then %do;
         %let status = OK;
      %end;

      %* Check STATUS and print the message into the log output: ;
      %if &status. eq Error %then %do;
         %put %str(ERR)OR: &program. &message.;
      %end;
      %else %if &status. eq Info %then %do;
         %put %str(INF)O: &program. &message.;
      %end;
      %else %if &status. eq Warning %then %do;
         %put %str(WAR)NING: &program. &message.;
      %end;
      %else %if &status. eq Debug %then %do;
         %put %str(DEB)UG: &program. &message.;
      %end;
      %else %do;
         %put NOTE: &program. &message.;
      %end;

      %* If PRINT = Y, do a SAS proc report step and output to result tab: ;
      %if %upcase(&print.) eq Y %then %do;

         %* Create a temporary report table, and load the messsage info: ;
         data WORK.report;
            attrib program length=$32  label='Program';
            attrib message length=$200 label='Message';
            attrib status  length=$10  label='Status';
            program = "%upcase(&program.)";
            message = "&message.";
            status  = "%upcase(&status.)";
         run;

         %* Build report content layout: ;
         title "%upcase(&syshostname.) - Status Message for Program: %lowcase(&program.)";
         footnote "Generated on &date. at &time.";
         footnote2 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %let report = %str(%sysfunc(compbl(

            proc report data=WORK.report nowd headline headskip;
               columns 
                  program 
                  message
                  status 
                  ;
               define program / display 'Program' format=$32.;
               define message / display 'Message' format=$200.;
               define status  / display 'Status'  format=$10.;
               compute status;
                  if substr(status,1,1) eq 'D' then call define (_COL_,'style','style=[background=cxac74d9]');
                  if substr(status,1,1) eq 'E' then call define (_COL_,'style','style=[background=verylightred]');
                  if substr(status,1,1) eq 'O' then call define (_COL_,'style','style=[background=lightgreen]');
                  if substr(status,1,1) eq 'W' then call define (_COL_,'style','style=[background=cxffff99]');
               endcomp;
            run;

            )));

         %* Display report list in Result tab: ;
         &report.

         title;
         footnote;
         footnote2;

         %* Clean up before we leave: ;
         %if %upcase(&debug.) ne Y %then %do;
            proc datasets lib=WORK nolist nowarn memtype = (data view);
               delete report;
            quit;
         %end;

      %end; %* print=Y ;

   %mend print_message;

   %*-------------------------------------------------------------------------;
   %* IF DEBUG = Y, set SAS verbose logging / debugging options:              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) eq Y %then %do;
      options fullstimer msglevel=i;
   %end;

   %*-------------------------------------------------------------------------;
   %* Save current SAS system logging options:                                ;
   %*-------------------------------------------------------------------------;

   %let savedate    = %lowcase(%sysfunc(getoption(date)));
   %let savemauto   = %lowcase(%sysfunc(getoption(mautolocdisplay)));
   %let savemlogic  = %lowcase(%sysfunc(getoption(mlogic)));
   %let savenest    = %lowcase(%sysfunc(getoption(mlogicnest)));
   %let savemprint  = %lowcase(%sysfunc(getoption(mprint)));
   %let savenotes   = %lowcase(%sysfunc(getoption(notes)));
   %let savenumber  = %lowcase(%sysfunc(getoption(number)));
   %let savesource  = %lowcase(%sysfunc(getoption(source)));
   %let savesource2 = %lowcase(%sysfunc(getoption(source2)));
   %let savestimer  = %lowcase(%sysfunc(getoption(fullstimer)));
   %let savesymbols = %lowcase(%sysfunc(getoption(symbolgen)));

   %*-------------------------------------------------------------------------;
   %* Detect and set the proper delimiter for UNIX versus Windows:            ;
   %*-------------------------------------------------------------------------;

   %let delim = %sysfunc(ifc(%eval(&sysscp. eq WIN),\,/));
   %let pathnm = %sysfunc(tranwrd(&pathnm.,%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.));

   %*-------------------------------------------------------------------------;
   %* Check if the PATHNM parameter has been given a value:                   ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&viewnm.)) eq 0 or %nrbquote(&viewnm.) eq _NONE_ %then %do;

      %if %length(%nrbquote(&pathnm.)) eq 0 or %nrbquote(&pathnm.) eq _NONE_ %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg1.)
          , print   = &print.
            )
         %goto exit;

      %end;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if PATHNM path and file exists and can be assigned:               ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&viewnm.)) eq 0 or %nrbquote(&viewnm.) eq _NONE_ %then %do;

      %if not %sysfunc(fileexist(&pathnm.)) %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg2.)
          , print   = &print.
            )
         %goto exit;

      %end;

      %let path = %sysfunc(tranwrd(&pathnm.,&delim.%scan(&pathnm.,-1,%str(/\)),%str()));
      %let view = %upcase(%scan(%scan(&pathnm.,-1,%str(&delim.)),1,%str(.)));

      %* Set source value: ;
      %let source = file;

      %* Assign temporary libref: ;
      libname &libref. "&path." access=readonly;

      %* Set VIEWNM value: ;
      %let viewnm = &libref..&view.;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if the VIEWNM parameter has been given a value:                   ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&pathnm.)) eq 0 or %nrbquote(&pathnm.) eq _NONE_ %then %do;

      %if %length(%nrbquote(&viewnm.)) eq 0 or %nrbquote(&viewnm.) eq _NONE_ %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg3.)
          , print   = &print.
            )
         %goto exit;

      %end;

      %* Set source value: ;
      %let source = lib;

   %end;

   %*-------------------------------------------------------------------------;
   %* If libname is missing, then set WORK as default library:                ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&pathnm.)) eq 0 or %nrbquote(&pathnm.) eq _NONE_ %then %do;

      %if %index(&viewnm.,%str(.)) eq 0 %then %do;

         %print_message(
            program = &prgm.
          , status  = OK
          , message = %unquote(&msg4.)
          , print   = N
            )
         %let viewnm = WORK.&viewnm.;

      %end;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if VIEWNM SAS view reference exists and is assigned:              ;
   %*-------------------------------------------------------------------------;

   %if not %sysfunc(exist(&viewnm.,view)) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg5.)
       , print   = &print.
         )

      %* Clear LIBREF if set: ;
      %if not %sysfunc(libref(&libref.)) %then %do;
         libname &libref. clear;
      %end;

      %goto exit;

   %end;

   %let view = %upcase(%scan(&viewnm.,-1,%str(.)));

   %*-------------------------------------------------------------------------;
   %* Obtain VIEWNM view type engine (data step or SQL type view:             ;
   %*-------------------------------------------------------------------------;

   proc sql feedback stimer noprint;
      select engine into :engine
        from SASHELP.vview
       where upcase(libname) eq "%upcase(%scan(&viewnm.,1,%str(.)))" 
         and upcase(memname) eq "%upcase(%scan(&viewnm.,2,%str(.)))"
      ;
   quit;

   %* Remove trailing blanks: ;
   %let engine = &engine.;

   %if %upcase(&engine.) in (SASDSV SASESQL) %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg6.)
       , print   = N
         )

   %end;
   %else %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg7.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* IF ENGINE=SASDV create SAS data step style view creation code:          ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&engine.) eq SASDSV %then %do;

      %*----------------------------------------------------------------------;
      %* Turn off SAS log options to assure clean log output :                ;
      %*----------------------------------------------------------------------;

      options  
         nodate
         nomautolocdisplay
         nomlogic 
         nomlogicnest
         nomprint 
         nonotes
         nonumber
         nosource 
         nosource2 
         nofullstimer
         nosymbolgen 
         ;

      %*----------------------------------------------------------------------;
      %* Print Log output to a temporary external file:                       ;
      %*----------------------------------------------------------------------;

      proc printto log="%sysfunc(getoption(WORK))&delim.describe.log" new;
      run;

      %*----------------------------------------------------------------------;
      %* Run SAS data step DESCRIBE statement for VIEWNM:                     ;
      %*----------------------------------------------------------------------;

      data view=&viewnm.;
         describe;
      run;

      %*----------------------------------------------------------------------;
      %* Redirect log output back to SAS default log destiantion:             ;
      %*----------------------------------------------------------------------;
     
      proc printto log=log;
      run;

      %*----------------------------------------------------------------------;
      %* Set the debug logging options back to its original state:            ;
      %*----------------------------------------------------------------------;

      options 
         &savedate.
         &savemauto.
         &savemlogic.
         &savenest.
         &savemprint.
         &savenotes.
         &savenumber.
         &savesource.
         &savesource2.
         &savestimer.
         &savesymbols.
         ;

   %end;  %* engine = SASDSV ;

   %*-------------------------------------------------------------------------;
   %* IF ENGINE=SASESQL create SQL style view creation code:                  ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&engine.) eq SASESQL %then %do;

      %*----------------------------------------------------------------------;
      %* Turn off SAS log options to assure clean log output :                ;
      %*----------------------------------------------------------------------;

      options  
         nodate
         nomautolocdisplay
         nomlogic 
         nomlogicnest
         nomprint 
         nonotes
         nonumber
         nosource 
         nosource2 
         nofullstimer
         nosymbolgen 
         ;

      %*----------------------------------------------------------------------;
      %* Print Log output to a temporary external file:                       ;
      %*----------------------------------------------------------------------;

      proc printto log="%sysfunc(getoption(WORK))&delim.describe.log" new ;
      run;

      %*----------------------------------------------------------------------;
      %* Run SQL proc step DESCRIBE statement for VIEWNM:                     ;
      %*----------------------------------------------------------------------;

      proc sql noprint feedback stimer;
         describe view &viewnm.;
      quit;

      %*----------------------------------------------------------------------;
      %* Redirect log output back to SAS default log destiantion:             ;
      %*----------------------------------------------------------------------;
     
      proc printto log=log;
      run;

      %*----------------------------------------------------------------------;
      %* Set the debug logging options back to its original state:            ;
      %*----------------------------------------------------------------------;

      options 
         &savedate.
         &savemauto.
         &savemlogic.
         &savenest.
         &savemprint.
         &savenotes.
         &savenumber.
         &savesource.
         &savesource2.
         &savestimer.
         &savesymbols.
         ;

   %end;  %* engine = SASESQL ;


   data WORK.t_describe;

      attrib 
         source length = $1024  label = 'Source'
         libref length = $8     label = 'Libref'
         view   length = $32    label = 'View'
         type   length = $7     label = 'Type'
         code   length = $1024  label = 'Code'
         ;

      retain 
         source
         libref
         view 
         type
         code
         ;

      keep
         source
         libref
         view 
         type
         code
         ;

      infile "%sysfunc(getoption(WORK))&delim.describe.log" truncover end=eof;
      input line $255.;

      source = "%sysfunc(ifc(&source. eq file,&pathnm.,&viewnm.))";
      libref = "&libref.";
      view   = "&view.";
      type   = "&engine.";

      %if %upcase(&engine.) eq SASDSV %then %do;

         if _n_ eq 1 then do;
            code = "data &libref..&view. / view=&libref..&view.;";
         end;
         else if line ne '' then do;
            if index(line,'The SAS System') eq 0 then do;
               code = catt(code,'0a'x,line);
            end;
         end;

         if eof then do;
            output;
         end;

      %end;
      %else %do;

         if _n_ eq 1 then do;
            code = "proc sql noprint feedback stimer;";
            code = catt(code,'0a'x,"create view &libref..&view. as");
         end;
         else if line ne '' then do;
            if index(line,'The SAS System') eq 0 then do;
               code = catt(code,'0a'x,line);
            end;
         end;

         if eof then do;
            code = catt(code,'0a'x,'quit;');
            output;
         end;

      %end;

   run;

   %*-------------------------------------------------------------------------;
   %* IF OUTTBL is set, then copy the result into OUTTBL:                     ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&outtbl.)) gt 0 %then %do;

      data &outtbl.;
         set WORK.t_describe;
      run;

   %end;

   %*-------------------------------------------------------------------------;
   %* IF PRINT = Y, print information to SAS default result output:           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      title "%upcase(&syshostname.) - SAS View Code Generation Summary for %upcase(&view.)";
      footnote "Generated on %sysfunc(date(), ddmmyyp10.) at %substr(%sysfunc(time(), time10.),1,5)";
      footnote2 "Copyright 2008-%scan(%sysfunc(date(), ddmmyyp10.),-1) Paul Alexander Canals y Trocha";

      proc print data=WORK.t_describe label noobs;
         var source libref view type;
         var code / style(data)=[font_face=courier];
      run;

      title;
      footnote;
      footnote2;

   %end;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      proc datasets lib = WORK nolist nowarn memtype = (data view);
         delete t_describe ;
      quit;

      %if not %sysfunc(libref(&libref.)) %then %do;
         libname &libref. clear;
      %end;

   %end;

   %*-------------------------------------------------------------------------;
   %* Calculate processing time:                                              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) eq Y %then %do;

      %let stop = %sysfunc(datetime());
      %let time = %sysfunc(intck(SECOND, &start., &stop.), time10.);

      %put NOTE: &sysmacroname. Total Processing time &time. (hh:mm:ss);

   %end;

   %exit:

   %if %upcase(&debug.) eq Y or &help. eq ? %then %do;

   %put INFO: ================================================================;
   %put INFO: Autocall SAS Macro "&sysmacroname." has finished.               ;
   %put INFO: ================================================================;

   %end;

%mend m_uc_describe_view;
