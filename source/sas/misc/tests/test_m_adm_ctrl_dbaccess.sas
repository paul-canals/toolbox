/*!
 ******************************************************************************
 * \file       test_m_adm_ctrl_dbaccess.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-10-27 00:00:00
 * \version    20.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_ctrl_dbaccess.sas
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
%m_adm_ctrl_dbaccess(?)
 
%* Example 2: Create new DBACCESS table (Mode=C): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , mode    = C
 , print   = Y
   );
 
%* Example 3: Insert a new Database entry (Mode=I): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dpth    = %str(%sysfunc(getoption(WORK))/archived)
 , dacc    = T
 , mode    = I
 , print   = Y
   );
 
%* Example 4: Update the new entry options (Mode=U): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dopt    = %str(access=readonly)
 , mode    = U
 , print   = Y
   );
 
%* Example 5: View the DBACCESS entries (Mode=V): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dsel    = %str(dbname="TEMP")
 , mode    = V
 , print   = Y
   );
 
%* Example 6: Send the entry list by mail (Mode=V): ;
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
   );
 
%* Example 7 Deactivate a Database entry (Mode=U): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , dact    = N
 , mode    = U
 , print   = Y
   );
 
%* Example 8: View the current Database entry list (Mode=V): ;
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

 
%* Example 9: Delete a Database entry (Mode=D): ;
%m_adm_ctrl_dbaccess(
   dstable = WORK.dbaccess
 , dskey   = aespasskey
 , dnam    = TEMP
 , dtyp    = SAS
 , mode    = D
 , print   = Y
   );
 
%* Example 10: View the current Database entry list (Mode=V): ;
%m_adm_ctrl_dbaccess(
   dstable  = WORK.dbaccess
 , dskey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = N
   );

 
