/*!
 ******************************************************************************
 * \file       test_m_val_chk_invalid.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-03-27 00:00:00
 * \version    21.1.03
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_chk_invalid.sas
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
%m_val_chk_invalid(?)
 
%* Example 2: Validate SASHELP.class to verify that all male students are minor: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.class
 , col_name = Age
 , val_max  = 17
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 3: Validate SASHELP.class to verify that all student have a gender: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.class
 , col_name = Sex
 , val_list = F M
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 4: Validate SASHELP.class to ensure that all students are female: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.class
 , col_name = Sex
 , val_max  = F
 , action   = Move
 , print    = Y
 , debug    = Y
   );

 
%* Example 5: Validate SASHELP.class to abort when not all students are female: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.class
 , col_name = Sex
 , val_list = F
 , action   = Abort
 , print    = Y
 , debug    = Y
   );

 
%* Example 6: Validate SASHELP.baseball to ensure all players salaries are listed: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.baseball
 , col_name = Salary
 , val_min  = 0
 , action   = Move
 , print    = Y
 , debug    = Y
   );

proc print data=WORK.baseball_exc label;
run;

 
%* Example 7: Validate SASHELP.baseball to check if all players salaries are listed: ;
%m_val_chk_invalid(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_invalid
 , col_name = Salary
 , val_min  = 0
 , val_max  = 10000
 , action   = Check
 , print    = Y
 , debug    = N
   );

%m_val_chk_invalid(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_invalid
 , col_name = logSalary
 , val_min  = 0
 , val_max  = 10000
 , action   = Check
 , print    = Y
 , debug    = N
   );

proc print data=WORK.baseball_invalid label;
run;

 
