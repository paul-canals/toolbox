/*!
 ******************************************************************************
 * \file       test_m_log_run_analysis.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-25 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_log_run_analysis.sas
 * 
 * \copyright  Copyright 2008-2024 Paul Alexander Canals y Trocha
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
 
%* Example 1: Show help information: ;
%m_log_run_analysis(?)
 
%* Example 2: Step 1 - Set the log destination to a log file: ;
options fullstimer;

%let _sysprinttolog = %sysfunc(tranwrd(%nrquote(&sysprinttolog.),%str(%"),%str()));
%put &=_sysprinttolog.;

filename tmpfile "%sysfunc(getoption(work))/sas.log";

proc printto log=tmpfile new;
run;
 
%* Example 2: Step 2 - Run some data steps and procedures: ;
data WORK.blaat;
   set SASHELP.class;
   where John eq 'John';
run;

proc sql noprint;
   create table WORK.cars as
   select *
     from SASHELP.cars
   ;
quit;

proc sort data=SASHELP.prdsale
   out=WORK.prdsale;
   by descending year month;
run;
 
%* Example 2: Step 3 - Return to the default log destination: ;
proc printto log=%sysfunc(ifc(%length(%nrbquote(&_sysprinttolog.)) eq 0,
   log,"&_sysprinttolog."));
run;

filename tmpfile clear;

options nofullstimer;
 
%* Example 2: Step 4 - Reset return code and syntaxcheck options: ;
%let syscc = 0;

options nosyntaxcheck obs=max;
 
%* Example 2: Step 5 - Perfom runtime analysis on sas.log file: ;
%m_log_run_analysis(
   in_file   = %str(%sysfunc(getoption(work))/sas.log)
 , program   = LOG_ANALYSIS
 , print     = Y
 , print_sum = Y
 , print_pdf = Y
 , print_htm = Y
 , debug     = N
   );
 
%* Example 3: Perfom performance analysis on a data step copy: ;
%m_log_run_analysis(
   in_file    = %str(%sysfunc(getoption(work))/sas.log)
 , program    = RUN_ANALYSIS
 , run_mode   = COPY
 , in_tbl     = SASHELP.cars
 , out_tbl    = WORK.cars
 , file_flg   = Y
 , print      = Y
 , print_log  = Y
 , print_pdf  = Y
 , print_htm  = Y
 , debug      = N
   );
 
