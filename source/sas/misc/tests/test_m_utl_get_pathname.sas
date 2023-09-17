/*!
 ******************************************************************************
 * \file       test_m_utl_get_pathname.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:59
 * \version    20.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_pathname.sas
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
%m_utl_get_pathname(?)
 
%* Example 2: obtain the full path for SAS libref SASUSER: ;
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASUSER';
   path = strip("%m_utl_get_pathname(ref=SASUSER,type=L,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
 
%* Example 3: obtain all paths for concatenated SAS libref SASHELP: ;
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASHELP';
   path = strip("%m_utl_get_pathname(ref=SASHELP,type=L,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
 
%* Example 4: obtain second path for concatenated SAS libref SASHELP: ;
data WORK.result;
   attrib libref length=$8 label='Library';
   attrib path length=$4096 label='Path';
   libref = 'SASHELP';
   path = strip("%m_utl_get_pathname(ref=SASHELP,type=L,pos=2,debug=N)");
run;

proc print data=WORK.result label noobs;
run;
 
