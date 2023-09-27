/*!
 ******************************************************************************
 * \file       test_m_val_chk_custom.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:38:04
 * \version    22.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_chk_custom.sas
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
%m_val_chk_custom(?)
 
%* Example 2: Validate SASHELP.class to check that all male students are minor: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , val_rule = %str(Sex='M' and Age<18)
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 3: Validate SASHELP.class to check that all student names start with a 'J': ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , val_rule = %str(substr(Name,1,1)='J')
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 4: Validate SASHELP.class to ensure that all students are female: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , val_rule = %str(Sex eq 'F')
 , action   = Move
 , print    = Y
 , debug    = Y
   );

 
%* Example 5: Validate SASHELP.class to abort when not all students are female: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , val_rule = %str(Sex eq 'F')
 , action   = Abort
 , print    = Y
 , debug    = Y
   );

 
%* Example 6: Validate SASHELP.class to ensure the students BMI is lesser than 22: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , val_rule = %str(((Weight/2)/(((Height*2.54)/100)**2) < 22))
 , action   = Move
 , print    = Y
 , debug    = Y
   );

 
%* Example 7: Validate SASHELP.baseball to check if all players salaries are listed: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.baseball
 , val_rule = %str(Salary ne . and logSalary ^= .)
 , action   = Move
 , print    = Y
 , debug    = N
   );

proc print data=WORK.baseball_exc label;
run;

 
%* Example 8: Validate SASHELP.baseball to check if all players salaries are listed: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_custom
 , val_rule = %str(Salary <> .)
 , action   = Check
 , print    = Y
 , debug    = N
   );

%m_val_chk_custom(
   src_tbl  = SASHELP.baseball
 , exc_tbl  = WORK.baseball_custom
 , val_rule = %str(logSalary ^= .)
 , action   = Check
 , print    = Y
 , debug    = N
   );

proc print data=WORK.baseball_custom label;
run;

 
%* Example 9: Validate SASHELP.class to check Name against SASHELP.classfit: ;
%m_val_chk_custom(
   src_tbl  = SASHELP.class
 , exc_tbl  = WORK.class_custom
 , val_rule = %str(Name in (select Name from SASHELP.classfit where Name ne 'John'))
 , sql_type = Y
 , action   = Check
 , print    = Y
 , debug    = N
   );

proc print data=WORK.class_custom label;
run;

 
