/*!
 ******************************************************************************
 * \file       test_m_sys_get_dbaccess.sas
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
 *             + m_sys_get_dbaccess.sas
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
%m_sys_get_dbaccess(?)
 
%* Example 2 - Step 1: Create a new DBACCESS table: ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
   );
 
%* Example 2 - Step 2: Insert a new Database entry: ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEST
 , dtyp    = ORA
 , dusr    = orademo
 , dpwd    = ORApw123
 , dpth    = XE
 , dsch    = pact
 , dopt    = %str(ACCESS=READONLY)
 , dacc    = T
 , mode    = I
   );
 
%* Example 2 - Step 3: Retrieve Database entry string: ;
%let string =
   %m_sys_get_dbaccess(
      dstable = WORK.dbaccess
    , dskey   = aespasskey
    , dbname  = TEST
    , dbtype  = ORA
    , dbaccs  = T
    , schema  = N
    , rw_flg  = Y
      );

%m_utl_print_message(
   program = M_SYS_GET_DBACCESS
 , status  = OK
 , message = %quote(&string.)
 , print   = Y
 , debug   = N
   );
 
