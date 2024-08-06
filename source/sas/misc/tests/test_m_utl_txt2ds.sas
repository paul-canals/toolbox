/*!
 ******************************************************************************
 * \file       test_m_utl_txt2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-04-24 00:00:00
 * \version    24.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_txt2ds.sas
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
%m_utl_txt2ds(?)
 
%* Example 2: Step 1 - Export a SAS dataset into a semicolon delimited TXT file: ;
proc export
   data=SASHELP.cars
   outfile="%sysfunc(getoption(WORK))/cars.txt"
   dbms=dlm
   replace;
   delimiter='3B'x;
run;
 
%* Example 2: Step 2 - Import the semicolon delimited file into a SAS dataset: ;
%m_utl_txt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/cars.txt)
 , out_ds  = WORK.cars
 , engine  = dlm
 , debug   = Y
   );

proc print data=WORK.cars;
run;
 
%* Example 3: Step 1 - Export a SAS dataset into a tab delimited TXT file: ;
proc export
   data=SASHELP.cars
   outfile="%sysfunc(getoption(WORK))/cars.txt"
   dbms=dlm
   replace;
   delimiter='09'x;
run;
 
%* Example 3: Step 2 - Import the tab delimited file into a SAS dataset: ;
%m_utl_txt2ds(
   in_file = %str(%sysfunc(getoption(WORK))/cars.txt)
 , out_ds  = WORK.cars
 , engine  = tab
 , debug   = Y
   );

proc print data=WORK.cars;
run;
 
