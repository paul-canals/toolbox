/*!
 ******************************************************************************
 * \file       test_m_sys_set_dbaccess.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:36:51
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_sys_set_dbaccess.sas
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
%m_sys_set_dbaccess(?)
 
%* Example 2 - Step 1: Create new DBACCESS table: ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
   );
 
%* Example 2 - Step 2: Insert a new entry with access readonly: ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dpth    = %str(%sysfunc(getoption(WORK)))
 , dacc    = T
 , dopt    = %str(access=readonly)
 , mode    = I
   );
 
%* Example 2 - Step 3: View the newly made DBACCESS entry: ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dsel    = %str(dbname='TEMP')
 , mode    = V
   );
 
%* Example 2 - Step 4: Set the new entry with write access: ;
%m_sys_set_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , list    = %quote(TEMP)
 , rw_flg  = Y
 , debug   = N
   );
 
