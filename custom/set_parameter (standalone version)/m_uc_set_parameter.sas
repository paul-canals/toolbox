/*!
 ******************************************************************************
 * \file       m_uc_set_parameter.sas
 * \ingroup    Custom
 * \brief      Custom macro to register global macro variables from a file.
 * \details    This program reads a list of macro variables defined in an
 *             input CSV file or SAS dataset. Records in the file can either
 *             be environment dependent (INHOST) or not, or set inactive in
 *             case of PRMFLG set to 0. 
 * 
 *             The following macro variable types are valid:
 * 
 *             + CHAR : Character value(s list)
 *             + DATE : Uses DATE format on date() input, returns numerical 
 *                      value on DDMONYYYY input 
 *                      (e.g.\ 31dec2016) 
 *             + DTTM : Uses DATETIME format on datetime() input, returns  
 *                      numerical value on DDMONYYYY HH:MM:SS input 
 *                      (e.g.\ 31dec2016 23:59:59)
 *             + FUNC : Uses %sysfunc() function
 *             + MVAR : Uses %str(&)PRMVAL%str(.)
 *             + NUM  : Numerical value(s list)
 *             + SGET : Uses %sysget() function
 * 
 * \note       It is also possible to create macro variables containing 
 *             a list of values. This is valid for CHAR and NUM type
 *             macro vaiables only. The key is to name the PRMVAR macro 
 *             variable identically (e.g.\ list the values in the list 
 *             as records in the INFILE file or dataset).  
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-10-31 00:00:00
 * \version    21.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  infile      Full qualified path to the parameter file, or 
 *                         full LIBNAME.TABLENAME name of the SAS dataset.
 * \param[in]  intype      Indicator [CSV|TBL] for the INFILE type.
 *                         The default value is: CSV.
 * \param[in]  inhost      Indicator [DEV|TST|UAT|PRD] for the environment.
 *                         If omitted, the records in the INFILE with PRMENV
 *                         value ALL will be set, all other will be ignored. 
 * \param[in]  prmenv      Name of the parameter environment column.
 *                         The Default value is: PARAM_ENV. 
 * \param[in]  prmvar      Name of the parameter name column.
 *                         The Default value is: PARAM_NAME.
 * \param[in]  prmval      Name of the parameter value column.
 *                         The Default value is: PARAM_VALUE.
 * \param[in]  prmtyp      Name of the parameter type column.
 *                         The Default value is: PARAM_TYPE.
 * \param[in]  prmtxt      Name of the parameter description column.
 *                         The Default value is: PARAM_TEXT.
 * \param[in]  prmflg      Name of the parameter active/inactive flag column.
 *                         The Default value is: MACRO_FLG.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     List of globally declared SAS macro variables
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_set_parameter(?)
 * \endcode
 * 
 * \example    Example 2 - Step 1: Create macro variable parameter table:
 * \code
 *             data WORK.params;
 *                attrib PARAM_ENV    length = $3;
 *                attrib PARAM_NAME   length = $32; 
 *                attrib PARAM_VALUE  length = $100;
 *                attrib PARAM_TYPE   length = $4; 
 *                attrib PARAM_TEXT   length = $100;
 *                attrib MACRO_FLG    length = 8;
 * 
 *                * Date Function;
 * 
 *                PARAM_ENV   = "ALL";
 *                PARAM_NAME  = "X_TODAY_FUNC";
 *                PARAM_VALUE = "date()";
 *                PARAM_TYPE  = "FUNC";
 *                PARAM_TEXT  = "Represents today in numerical string";
 *                MACRO_FLG   = 1;
 *                output;
 * 
 *                * Date Type with date() input;
 * 
 *                PARAM_ENV   = "ALL";
 *                PARAM_NAME  = "X_TODAY_DATE";
 *                PARAM_VALUE = "date()";
 *                PARAM_TYPE  = "DATE";
 *                PARAM_TEXT  = "Represents today in date format";
 *                MACRO_FLG   = 1;
 *                output;
 * 
 *                * Date Type with 31dec2016 input;
 * 
 *                PARAM_ENV   = "ALL";
 *                PARAM_NAME  = "X_DAY_DATE";
 *                PARAM_VALUE = "31dec2016";
 *                PARAM_TYPE  = "DATE";
 *                PARAM_TEXT  = "Represents today in date format";
 *                MACRO_FLG   = 1;
 *                output;
 * 
 *                * List Character Type;
 * 
 *                PARAM_ENV   = "ALL";
 *                PARAM_NAME  = "X_WEEKEND_LIST";
 *                PARAM_VALUE = "Saturday";
 *                PARAM_TYPE  = "CHAR";
 *                PARAM_TEXT  = "Represents the weekend day names";
 *                MACRO_FLG   = 1;
 *                output;
 * 
 *                PARAM_ENV   = "ALL";
 *                PARAM_NAME  = "X_WEEKEND_LIST";
 *                PARAM_VALUE = "Sunday";
 *                PARAM_TYPE  = "CHAR";
 *                PARAM_TEXT  = "Represents the weekend day names";
 *                MACRO_FLG   = 1;
 *                output;
 *             run;
 * 
 * \endcode
 * 
 * \example    Example 2 - Step 2: Register macro variables from params table:
 * \code
 *             %m_uc_set_parameter(
 *                infile = WORK.params
 *              , intype = TBL
 *              , inhost = 
 *              , prmenv = PARAM_ENV
 *              , prmvar = PARAM_NAME
 *              , prmval = PARAM_VALUE
 *              , prmtyp = PARAM_TYPE
 *              , prmtxt = PARAM_TEXT
 *              , prmflg = MACRO_FLG
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 2 - Step 3: Check registered macro variables in log:
 * \code
 *             %put &=X_TODAY_FUNC.;
 *             %put &=X_TODAY_DATE.;
 *             %put &=X_DAY_DATE.;
 *             %put &=X_WEEKEND_LIST.;
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
%macro m_uc_set_parameter(
   help
 , vers   = 21.1.10
 , infile = 
 , intype = CSV
 , inhost = 
 , prmenv = PARAM_ENV
 , prmvar = PARAM_NAME
 , prmval = PARAM_VALUE
 , prmtyp = PARAM_TYPE
 , prmtxt = PARAM_TEXT
 , prmflg = MACRO_FLG
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

   %if &help. eq ? or %upcase(&help.) = HELP %then %do;

      %put ;
      %put %nrstr(Help for macro definition %m_uc_set_parameter.sas) (v&vers.);
      %put;
      %put %nrstr(%m_uc_set_parameter%( );
      %put %nrstr(   infile = [<libref>.<dataset>|<patht>/<filename>] );
      %put %nrstr( , intype = [CSV|TBL] );
      %put %nrstr( , inhost = [ALL|[DEV|TST|TUA|PRD]] );
      %put %nrstr( , prmenv = [PARAM_ENV|<environment column>] );
      %put %nrstr( , prmvar = [PARAM_NAME|<macro name column>] );
      %put %nrstr( , prmval = [PARAM_VALUE|<macro value column>] );
      %put %nrstr( , prmtyp = [PARAM_TYPE|<macro type column>] );
      %put %nrstr( , prmtxt = [PARAM_TEXT|<macro desc column>] );
      %put %nrstr( , prmflg = [MACRO_FLG|<macro flag column>] );
      %put %nrstr( , debug  = [Y|N] );
      %put %nrstr(   %); );
      %put;
      %put %nrstr(Custom macro to register global macro variables from a file. );
      %put;
      %put %nrstr(This program reads a list of macro variables defined in an );
      %put %nrstr(input CSV file or SAS dataset. Records in the file can either );
      %put %nrstr(be environment dependent (INHOST) or not, or set inactive in );
      %put %nrstr(case of PRMFLG set to 0. );
      %put ;
      %put %nrstr(The following macro variable types are valid: );
      %put;
      %put %nrstr(+ CHAR : Character value(s list) );
      %put %nrstr(+ DATE : Uses DATE format on date() input, returns numerical );
      %put %nrstr(         value on DDMONYYYY input );
      %put %nrstr(         (e.g. 31dec2016) );
      %put %nrstr(+ DTTM : Uses DATETIME format on datetime() input, returns );
      %put %nrstr(         numerical value on DDMONYYYY HH:MM:SS input );
      %put %nrstr(         (e.g. 31dec2016 23:59:59) );
      %put %nrstr(+ FUNC : Uses %sysfunc() function );
      %put %nrstr(+ MVAR : Uses %str(&)PRMVAL%str(.) );
      %put %nrstr(+ NUM  : Numerical value(s list) );
      %put %nrstr(+ SGET : Uses %sysget() function );
      %put;
      %put %nrstr(It is also possible to create macro variables containing );
      %put %nrstr(a list of values. This is valid for CHAR and NUM type );
      %put %nrstr(macro vaiables only. The key is to name the PRMVAR macro ); 
      %put %nrstr(variable identically %(e.g. list the values in the list );
      %put %nrstr(as records in the INFILE file or dataset%). );
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
      fexist
      msg1
      msg2
      prgm
      start
      stop
      time
      ;
      
   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1 = %nrstr(The given parameter file (&infile.) does not exist!);
   %let msg2 = %nrstr(The given parameter type (&intype.) is not valid!);
   
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
   %* If fyle type is CSV, connect to the external parameter file:            ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&intype.) eq CSV %then %do;

      %*----------------------------------------------------------------------;
      %* Connect to the external parameter file:                              ;
      %*----------------------------------------------------------------------;

      %let fexist = %eval(%sysfunc(fileexist(&infile.)));
   
      %if &fexist. %then %do;

         data WORK.input; 

            infile "&infile."
               lrecl = 256
               delimiter = ';'
               dsd
               missover
               firstobs = 2 
               ; 

            attrib 
               &prmenv.  length = $3
               &prmvar.  length = $32
               &prmval.  length = $100
               &prmtyp.  length = $4
               &prmtxt.  length = $100
               &prmflg.  length = 8
               ;
   
            input
               &prmenv. 
               &prmvar. 
               &prmval.
               &prmtyp. 
               &prmtxt. 
               &prmflg.
               ; 
   
         run;
         
      %end;
      
      %else %do;
      
         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg1.)
            )
         %goto exit;
      
      %end;

   %end;

   %if %upcase(&intype.) eq TBL %then %do;

      %*----------------------------------------------------------------------;
      %* Connect to the external parameter dataset:                           ;
      %*----------------------------------------------------------------------;

      %let fexist = %eval(%sysfunc(exist(&infile., data)));
   
      %if &fexist. %then %do;

         %*-------------------------------------------------------------------;
         %* Sort data before processing:                                      ;
         %*-------------------------------------------------------------------;

         proc sort data=&infile.
            out=WORK.input;
            by &prmvar.;
         run;

      %end;
      
      %else %do;
      
         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg1.)
            )
         %goto exit;
      
      %end;

   %end;

   %*-------------------------------------------------------------------------;
   %* if file or table exist for type (CSV / TBL), start processing:          ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&intype.) in (CSV TBL) %then %do;

      %*----------------------------------------------------------------------;
      %* Load sorted parameter data from file into a SAS dataset:             ;
      %*----------------------------------------------------------------------;

      proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

         create table WORK.temp as
         select &prmvar.
              , &prmval.
              , &prmtyp.
              , &prmtxt.
              , &prmflg.
              , datetime() as LOADING_DTTM 
                   length = 8
                   format = datetime20.
                   informat = datetime20.
                   label = 'Loading Date Time'
           from WORK.input
          where &prmflg. eq 1
            and &prmenv. in ('ALL', "&inhost.")
          order by &prmvar.
         ;
      quit;

      %*----------------------------------------------------------------------;
      %* Create Macro variable list:                                          ;
      %*----------------------------------------------------------------------;

      data WORK.result;
         set WORK.temp;
         by &prmvar.;
         keep
            &prmvar. 
            macro_string
            ;
         length macro_string $200;
         retain macro_string;

         %*-------------------------------------------------------------------;
         %* Add DATE type parameters:                                         ;
         %*-------------------------------------------------------------------;

         if &prmtyp. eq 'DATE' then do;
            if &prmval. eq 'date()' then 
               macro_string = put(date(), date9.);
            else macro_string = compress(input(&prmval., date9.));
            output;
         end;

         %*-------------------------------------------------------------------;
         %* Add DTTM type parameters:                                         ;
         %*-------------------------------------------------------------------;

         else if &prmtyp. eq 'DTTM' then do;
            if &prmval. eq 'datetime()' then
               macro_string = put(dhms(datepart( datetime() ),0,0,timepart( datetime() )), datetime.);
            else macro_string = compress(dhms(datepart(input(&prmval., datetime.)),0,0,timepart(input(&prmval., datetime.))));
            output;
         end;

         %*-------------------------------------------------------------------;
         %* Add FUNC type parameters:                                         ;
         %*-------------------------------------------------------------------;

         else if &prmtyp. eq 'FUNC' then do;
            macro_string = %str('%sysfunc(' || compress(&prmval.) || ')');
            output;
         end;

         %*-------------------------------------------------------------------;
         %* Add SGET type parameters:                                         ;
         %*-------------------------------------------------------------------;

         else if &prmtyp. eq 'SGET' then do;
            macro_string = %str('%sysget(' || compress(&prmval.) || ')');
            output;
         end;

         %*-------------------------------------------------------------------;
         %* Add MVAR type parameters:                                         ;
         %*-------------------------------------------------------------------;

         else if &prmtyp. eq 'MVAR' then do;
            macro_string = %str('&' || compress(&prmval.) || '.');
            output;
         end;

         %*-------------------------------------------------------------------;
         %* Add NUM type parameters:                                          ;
         %*-------------------------------------------------------------------;

         else if &prmtyp. eq "NUM" then do;
            if first.&prmvar. eq 1 & last.&prmvar. eq 1 then do;
               macro_string = &prmval.;
               output;
            end;
            else if first.&prmvar. eq 1 & last.&prmvar. eq 0 then
               macro_string = compress(&prmval.);
            else if last.&prmvar. eq 0 then
               macro_string = compress(macro_string||', '||&prmval.);
            else if last.&prmvar. eq 1 then do;
               macro_string = compress(macro_string||', '||&prmval.);
               output;
            end;
         end;

         %*-------------------------------------------------------------------;
         %* Add CHAR type parameters:                                         ;
         %*-------------------------------------------------------------------;

         else do;
            if first.&prmvar. eq 1 & last.&prmvar. eq 1 then do;
               macro_string = trim(&prmval.);
               output;
            end;
            else if first.&prmvar. eq 1 & last.&prmvar. eq 0 then
               macro_string = compress("'"||&prmval.)||"'";
            else if last.&prmvar. eq 0 then
               macro_string = compress(macro_string||", '"||&prmval.)||"'";
            else if last.&prmvar. eq 1 then do;
               macro_string = compress(macro_string||", '"||&prmval.||"'");
               output;
            end;
         end;

      run;

      %*----------------------------------------------------------------------;
      %* Generate Global Macro Variables from list:                           ;
      %*----------------------------------------------------------------------;

      data _null_;
         set WORK.result;
         call symputx(&prmvar.,macro_string,"G");
         put "NOTE: &sysmacroname. " &prmvar. " = " macro_string;
      run;

      %*----------------------------------------------------------------------;
      %* Clean up before we leave:                                            ;
      %*----------------------------------------------------------------------;

      %if %upcase(&debug.) ne Y %then %do;

         proc datasets lib = WORK nolist nowarn memtype = (data view);
            delete input result temp;
         quit;

      %end;

   %end;

   %else %do;
   
      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg2.)
         )
   
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

%mend m_uc_set_parameter;
