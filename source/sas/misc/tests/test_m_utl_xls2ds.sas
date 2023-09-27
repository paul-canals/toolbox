/*!
 ******************************************************************************
 * \file       test_m_utl_xls2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:38:02
 * \version    23.1.07
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_xls2ds.sas
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha
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
%m_utl_xls2ds(?)
 
%* Example 2: Step 1 - Export the CLASS table to a XLSX file named class.xlsx: ;
proc export
   data=SASHELP.class(where=(SEX='M'))
   dbms=xlsx
   outfile="%sysfunc(getoption(WORK))/class.xlsx"
   replace;
   sheet='Male';
run;

proc export
   data=SASHELP.class(where=(SEX='F'))
   dbms=xlsx
   outfile="%sysfunc(getoption(WORK))/class.xlsx"
   replace;
   sheet='Female';
run;
 
%* Example 2: Step 2 - Import the class.xlsx file with all existing worksheets: ;
%m_utl_xls2ds(
   in_file = %str(%sysfunc(getoption(WORK))/class.xlsx)
 , out_lib = WORK
 , engine  = xlsx
 , debug   = Y
   );

proc print data=WORK.male;
run;

proc print data=WORK.female;
run;
 
%* Example 3: Step 1 - Export the CLASSFIT table to a XLS file named classfit.xls: ;
*proc export
*   data=SASHELP.classfit
*   dbms=excelcs
*   outfile="%sysfunc(getoption(WORK))/classfit.xls"
*   replace;
*   sheet='Fitness';
*run;
 
%* Example 3: Step 2 - Import the class.xls file with worksheet Class: ;
*%m_utl_xls2ds(
*   in_file   = %str(%sysfunc(getoption(WORK))/classfit.xls)
* , out_lib   = WORK
* , engine    = pcfiles
* , pcfport   = 9621
* , pcfhost   = localhost
* , pcfuser   = "" %* user always in quotes, even if not set ;
* , pcfpass   = "" %* pass always in quotes, even if not set ;
* , worksheet = Fitness
* , debug     = Y
*   );

*proc print data=WORK.fitness;
*run;
 
%* Example 4: Step 1 - Create a table EXAMINED with a date format column: ;
data WORK.examined;
   set SASHELP.class;
   attrib Date format=ddmmyyp10.;
   if Name ne 'John' then
   date=today();
run;
 
%* Example 4: Step 2 - Export the EXAMINED table to a XLS file named examined.xlsx: ;
proc export
   data=WORK.examined
   dbms=xlsx
   outfile="%sysfunc(getoption(WORK))/examined.xlsx"
   replace;
   sheet='Class';
run;
 
%* Example 4: Step 3 - Import the examined.xlsx file with date column: ;
%m_utl_xls2ds(
   in_file   = %str(%sysfunc(getoption(WORK))/examined.xlsx)
 , out_lib   = WORK
 , engine    = xlsx
 , worksheet = Class
 , debug     = Y
   );

proc print data=WORK.examined;
run;
 
