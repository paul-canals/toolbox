/*!
 ******************************************************************************
 * \file       test_m_val_chk_duplicates.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:38:05
 * \version    21.1.03
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_chk_duplicates.sas
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
%m_val_chk_duplicates(?)
 
%* Example 2: Validate SASHELP.class to check if all student names are unique: ;
%m_val_chk_duplicates(
   src_tbl  = SASHELP.class
 , col_list = Name
 , action   = Check
 , print    = Y
 , debug    = Y
   );

 
%* Example 3: Validate SASHELP.class to ensure all student info is unique: ;
%m_val_chk_duplicates(
   src_tbl  = SASHELP.class
 , col_list = Weight Height
 , action   = Move
 , print    = Y
 , debug    = N
   );

proc print data=WORK.class_exc label;
run;

 
%* Example 4: Validate SASHELP.class to check if all student info is unique: ;
%m_val_chk_duplicates(
   src_tbl  = SASHELP.class
 , exc_tbl  = WORK.class_dups
 , col_list = Weight
 , action   = Check
 , print    = Y
 , debug    = N
   );

%m_val_chk_duplicates(
   src_tbl  = SASHELP.class
 , exc_tbl  = WORK.class_dups
 , col_list = Height
 , action   = Check
 , print    = Y
 , debug    = N
   );

proc print data=WORK.class_dups label;
run;

 
