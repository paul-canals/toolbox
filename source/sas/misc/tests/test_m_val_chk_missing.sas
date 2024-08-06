/*!
 ******************************************************************************
 * \file       test_m_val_chk_missing.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-02-29 00:00:00
 * \version    24.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_chk_missing.sas
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
%m_val_chk_missing(?)
 
%* Example 2: Validate SASHELP.class to verify that no student names are missing: ;
%m_val_chk_missing(
   src_tbl  = SASHELP.class
 , col_list = Name
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 3: Validate SASHELP.baseball to ensure all players salaries are listed: ;
%m_val_chk_missing(
   src_tbl  = SASHELP.baseball
 , col_list = Salary logSalary
 , action   = Move
 , print    = Y
 , debug    = N
   );

proc print data=WORK.baseball_exc label;
run;

 
%* Example 4: Validate SASHELP.baseball to check if all players salaries are listed: ;
%m_val_chk_missing(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_missing
 , col_list = Salary
 , action   = Check
 , print    = Y
 , debug    = N
   );

%m_val_chk_missing(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_missing
 , col_list = logSalary
 , action   = Check
 , print    = Y
 , debug    = N
   );

proc print data=WORK.baseball_missing label;
run;

 
