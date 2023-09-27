/*!
 ******************************************************************************
 * \file       test_m_utl_csv2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:08
 * \version    23.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_csv2ds.sas
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
%m_utl_csv2ds(?)
 
%* Example 2: Step 1 - Export the CARS table to a CSV file named cars.csv: ;
proc export
   data=SASHELP.cars
   dbms=csv
   outfile="%sysfunc(getoption(WORK))/cars.csv"
   replace;
run;
 
%* Example 2: Step 2 - Import the cars.csv file into a SAS dataset: ;
%m_utl_csv2ds(
   in_file=%str(%sysfunc(getoption(WORK))/cars.csv)
 , out_ds  = WORK.cars
 , engine  = csv
 , replace = Y
 , debug   = Y
   );

proc print data=WORK.cars;
run;
 
