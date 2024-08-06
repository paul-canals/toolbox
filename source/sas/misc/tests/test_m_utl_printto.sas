/*!
 ******************************************************************************
 * \file       test_m_utl_printto.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-16 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_printto.sas
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
%m_utl_printto(?)
 
%* Example 2: Set the proc printto log output destination to a file: ;
%m_utl_printto(
   log_dest = FILE
 , log_file = %str(%sysfunc(getoption(WORK))/output.log)
 , debug    = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_utl_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "%sysfunc(getoption(WORK))/output.log";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;
 
%* Example 3: Set the proc printto log output to a file with prefix: ;
%m_utl_printto(
   log_dest = FILE
 , log_file = %str(%sysfunc(getoption(WORK))/output.log)
 , prefix   = test
 , debug    = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_utl_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "%sysfunc(getoption(WORK))/test_output.log";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;
 
%* Example 4: Set the proc printto log output to a file with timestamp in name: ;
%m_utl_printto(
   log_dest   = FILE
 , log_file   = %str(%sysfunc(getoption(WORK))/output.log)
 , timestamp  = Y
 , global_flg = Y
 , mvar_name  = _printto_file
 , debug      = Y
   );

data WORK.class;
   set SASHELP.class;
run;

%m_utl_printto(
   log_dest = LOG
 , debug    = Y
   );

%put PRINT LOG_FILE:;

filename log_file "&_printto_file.";

data _null_;
   infile log_file;
   input;
   put _infile_;
run;
 
%* Example 5: Set nested proc printto log outputs to multiple log files: ;
%m_utl_printto(
   log_dest = FILE
 , log_file = %sysfunc(getoption(WORK))/log1.log
 , debug    = Y
   );
%put &_sysprinttolist.;

data WORK.class;
   set SASHELP.class;
run;

%m_utl_printto(
   log_dest = FILE
 , log_file = %sysfunc(getoption(WORK))/log2.log
 , debug    = Y
   );
%put &_sysprinttolist.;

data WORK.classfit;
   set SASHELP.classfit;
run;

%m_utl_printto(
   log_dest = FILE
 , log_file = %sysfunc(getoption(WORK))/log3.log
 , debug    = Y
   );
%put &_sysprinttolist.;

%m_utl_printto(log_dest = LOG, debug = Y);

proc print data=WORK.classfit;
run;

%m_utl_printto(log_dest = LOG, debug = Y);

proc print data=WORK.class;
run;

%m_utl_printto(log_dest = LOG, debug = Y);

filename log_file "%sysfunc(getoption(WORK))/log1.log";
data _null_;
   infile log_file;
   input;
   put 'PRINT LOG1:' _infile_;
run;

filename log_file "%sysfunc(getoption(WORK))/log2.log";
data _null_;
   infile log_file;
   input;
   put 'PRINT LOG2:' _infile_;
run;

filename log_file "%sysfunc(getoption(WORK))/log3.log";
data _null_;
   infile log_file;
   input;
   put 'PRINT LOG3:' _infile_;
run;
 
