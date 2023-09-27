/*!
 ******************************************************************************
 * \file       test_m_utl_get_col_code.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:25
 * \version    20.1.12
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_col_code.sas
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
%m_utl_get_col_code(?)
 
%* Example 2: Step 1 - Print original SASHELP.class table with missing labels: ;
proc print data=SASHELP.class(obs=1) noobs label;
run;
 
%* Example 2: Step 2 - Add the missing column label and format to the class table: ;
data WORK.class;
   attrib Name label='Name';
   attrib Sex label='Gender';
   attrib Age label='Age';
   attrib Height format=8.2 label='Height';
   attrib Weight format=8.2 label='Weight';
   set SASHELP.class (obs=1);
run;
 
%* Example 2: Step 3 - Create new table with added column attribute information: ;
data WORK.class2;
   attrib
   %m_utl_get_col_code(
      table = WORK.class
    , type  = DATA
    , debug = Y
      );
   set SASHELP.class (obs=1);
run;

proc print data=WORK.class noobs label;
run;
 
