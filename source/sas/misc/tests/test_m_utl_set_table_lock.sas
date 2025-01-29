/*!
 ******************************************************************************
 * \file       test_m_utl_set_table_lock.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-03 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_set_table_lock.sas
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha
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
%m_utl_set_table_lock(?)
 
%* Example 2: Set an exclusive lock on a SAS dataset: ;
data WORK.class;
   set SASHELP.class;
run;

%m_utl_set_table_lock(
   member     = WORK.class
 , timeout    = 60
 , retry      = 5
 , global_flg = Y
 , mvar_name  = locked
 , show_err   = Y
 , debug      = Y
   )
%put &=locked.;

proc append base=WORK.class
   data=SASHELP.class;
run;

lock WORK.class clear;
%put &=SYSLCKRC.;
 
