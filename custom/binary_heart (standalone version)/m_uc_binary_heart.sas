/*!
 ******************************************************************************
 * \file       m_uc_binary_heart.sas
 * \ingroup    Custom
 * \brief      Custom macro to create a valentines day binary heart graph card.
 * \details    The macro generates a radom binary heart, similar to xkcd comic
 *             post (http://xkcd.com/99/), using parametric expression by Rick
 *             Wicklin (r=2-2*sin(t)+sin(t)#sqrt(abs(cos(t)))/(sin(t)+1.4)) at
 *             blogs.sas.com/content/iml/2011/02/14/a-parametric-view-of-love
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-02-14 00:00:00
 * \version    24.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  to          Full name of the person the Heart is meant for.
 *                         The default value for TO is: _NONE_.
 * \param[in]  from        Full name of the person the heart is sent from.
 *                         The default value for FROM is: _NONE_.
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by using proc report steps with style HtmlBlue. 
 *                         The default value for PRINT is: Y.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose mode
 *                         information. The default value for DEBUG is: N.
 * 
 * \return     Binary shaped valentines day heart graph.
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_binary_heart(?)
 * \endcode
 * 
 * \example    Example 2: Create a binary valentines day heart for SAS:
 * \code
 *             %m_uc_binary_heart(
 *                to     = SAS
 *              , from   = Paul
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \copyright  Copyright 2008-2024 Paul Alexander Canals y Trocha.
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
%macro m_uc_binary_heart(
   help
 , vers   = 24.1.02
 , to     = _NONE_
 , from   = _NONE_
 , width  = 400
 , height = 500
 , size   = 12
 , print  = Y
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
      %put %nrstr(Help for macro definition %m_uc_binary_heart.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_binary_heart%( );
      %put %nrstr(   to     = <name of the person to send the heart to> );
      %put %nrstr( , from   = <name of the person the heart is sent from> );
      %put %nrstr( , width  = [400|<the width of the graph in pixels>] );
      %put %nrstr( , height = [500|<the height of the graph in pixels>] );
      %put %nrstr( , size   = [12|<font size of the binary digits>] );
      %put %nrstr( , print  = [Y|N] );
      %put %nrstr( , debug  = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to create a valentines day binary heart graph card. );
      %put ;
      %put %nrstr(The macro generates a radom binary heart, similar to xkcd comic );
      %put %nrstr(post (http://xkcd.com/99/), using parametric expression by Rick );
      %put %nrstr(Wicklin (r=2-2*sin(t)+sin(t)#sqrt(abs(cos(t)))/(sin(t)+1.4)) at );
      %put %nrstr(blogs.sas.com/content/iml/2011/02/14/a-parametric-view-of-love );
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

   %let msg1 = %nrstr(The required TO value is not given but is mandatory!);
   %let msg2 = %nrstr(The required FROM value is not given but is mandatory!);

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
   %* Check if parameter TO has been given a value:                           ;
   %*-------------------------------------------------------------------------;

   %if %length(&to.) le 1 or &to. eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if parameter FROM has been given a value:                         ;
   %*-------------------------------------------------------------------------;

   %if %length(&from.) le 1 or &from. eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg2.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Lets Generate the parametric expressions binary values:                 ;
   %*-------------------------------------------------------------------------;

   data WORK.binaryheart;
      drop Nx Ny t r;
      Nx = 21; Ny = 23;
      call streaminit(2142015);
      do x = -2.6 to 2.6 by 5.2/(Nx-1);
         do y = -4.4 to 1.5 by 6/(Ny-1);
            %* convert (x,y) to polar coordinates (r, t): ;
            r = sqrt( x**2 + y**2 );
            t = atan2(y,x);
            heart = (r < 2 - 2*sin(t) + sin(t)*sqrt(abs(cos(t))) / (sin(t)+1.4)) and (y > -3.5);
            b = rand("Bernoulli", 0.5);
            output;
         end;
      end;
   run;
 
   %*-------------------------------------------------------------------------;
   %* If PRINT=Y, create the Valentines Day binary heart Graph:               ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      ods graphics / width=&width.px height=&height.px;

      title "Happy Valentine's Day &to.!";
      footnote "with love, &from.";

      proc sgplot data=WORK.binaryheart noautolegend;
         styleattrs datacontrastcolors=(verylightgray red); 
         scatter x=x y=y / group=heart markerchar=b markercharattrs=(size=&size.);
         xaxis display=none offsetmin=0 offsetmax=0.06;
         yaxis display=none;
      run;

      title;
      footnote;

   %end;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      proc datasets library=WORK nolist nowarn memtype=(data view);
         delete binaryheart ;
      quit;

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

%mend m_uc_binary_heart;
