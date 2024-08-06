/*!
 ******************************************************************************
 * \file       test_m_adm_migrate_data.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-13 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_migrate_data.sas
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
%m_adm_migrate_data(?)
 
%* Example 2: Migrate data from MAPS to WORK (Mode=Full): ;
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/maps)
 , trg_path = %str(%sysfunc(getoption(WORK))/maps)
 , xpt_fmt  = AUTO
 , mode     = FULL
 , type     = ALL
 , print    = Y
 , debug    = N
   );
 
%* Example 3: Export data from SASHELP to WORK (Mode=Export): ;
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/nls/u8/sashelp)
 , trg_path = %str(%sysfunc(getoption(WORK))/export)
 , mode     = EXPORT
 , type     = ALL
 , finfo    = Y
 , print    = Y
 , debug    = N
   );
 
%* Example 4: Import SAS datasets to SASHELP (Mode=Import): ;
%m_adm_migrate_data(
   src_path = %str(%sysfunc(getoption(WORK))/export)
 , trg_path = %str(%sysfunc(getoption(WORK))/sashelp)
 , mode     = IMPORT
 , type     = DS
 , subdirs  = Y
 , finfo    = Y
 , print    = Y
 , debug    = N
   );
 
%* Example 5: Validate source against target (Mode=Validate): ;
%m_adm_migrate_data(
   src_path = %str(%sysget(SASROOT)/nls/u8/sashelp)
 , trg_path = %str(%sysfunc(getoption(WORK))/sashelp)
 , mode     = V
 , type     = ALL
 , subdirs  = Y
 , print    = Y
 , debug    = N
   );
 
