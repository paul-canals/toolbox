/*!
 ******************************************************************************
 * \file       test_m_utl_xpt2vw.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-07 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_xpt2vw.sas
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
%m_utl_xpt2vw(?)
 
%* Example 2: Step 1 - Create a SAS DSV view description table VW_DESCRIBE: ;
data WORK.vw_describe;
   source = 'WORK.dsv_class';
   libref = 'WORK';
   view   = 'DSV_CLASS';
   type   = 'SASDSV';
   code   = 'data WORK.dsv_class / view=WORK.dsv_class; set SASHELP.class; run;';
run;
 
%* Example 2: Step 2 - Export the description table to a XPT transport file: ;
%loc2xpt(
   libref   = WORK
 , memlist  = vw_describe
 , filespec = %unquote(%bquote('%sysfunc(getoption(WORK))/class.xpt'))
 , format   = AUTO
   );
 
%* Example 2: Step 3 - Import the class.xpt transport file into a SAS view: ;
%m_utl_xpt2vw(
   in_file = %str(%sysfunc(getoption(WORK))/class.xpt)
 , out_lib = WORK
 , replace = Y
 , debug   = Y
   );

proc contents data=WORK.dsv_class;
run;
 
%* Example 3: Step 1 - Create a SAS SQL view description table VW_DESCRIBE: ;
data WORK.vw_describe;
   source = 'WORK.sql_class';
   libref = 'WORK';
   view   = 'SQL_CLASS';
   type   = 'SASESQL';
   code   = 'proc sql; create view WORK.sql_class as select * from SASHELP.class; quit;';
run;
 
%* Example 2: Step 2 - Export the description table to a XPT transport file: ;
%loc2xpt(
   libref   = WORK
 , memlist  = vw_describe
 , filespec = %unquote(%bquote('%sysfunc(getoption(WORK))/class.xpt'))
 , format   = AUTO
   );
 
%* Example 2: Step 3 - Import the class.xpt transport file into a SAS view: ;
%m_utl_xpt2vw(
   in_file = %str(%sysfunc(getoption(WORK))/class.xpt)
 , out_lib = WORK
 , replace = Y
 , debug   = Y
   );

proc contents data=WORK.sql_class;
run;
 
