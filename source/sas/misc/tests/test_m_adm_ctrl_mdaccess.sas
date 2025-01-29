/*!
 ******************************************************************************
 * \file       test_m_adm_ctrl_mdaccess.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-26 00:00:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_ctrl_mdaccess.sas
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
%m_adm_ctrl_mdaccess(?)
 
%* Example 2: Create new MDACCESS table (Mode=C): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: Insert a new SAS Metadata server connection entry (Mode=I and access: technical): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
 
%* Example 4: Insert a new SAS Metadata server connection entry (Mode=I and access: personal): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(hermes.local)
 , mport   = 8561
 , macc    = P
 , lusr    = sasdemo
 , musr    = sasdemo
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
 
%* Example 5: View the technical SAS Metadata server connection entry for HMSDEV (Mode=V): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , msel    = %str(mdname='HMSDEV' and mdaccs='T')
 , mode    = V
 , print   = Y
 , debug   = Y
   );
 
%* Example 6: Send the complete SAS Metadata server connection entry list by mail (Mode=V): ;
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
   );
 
%* Example 7: Deactivate a SAS Metadata server connection entry (Mode=U and access: technical): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , mact    = N
 , mode    = U
 , print   = Y
 , debug   = N
   );
 
%* Example 8: View the current SAS Metadata server connection entry list (Mode=V): ;
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

 
%* Example 9: Delete a SAS Metadata server connection entry (Mode=D and access: technical): ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , macc    = T
 , mode    = D
 , print   = Y
 , debug   = N
   );
 
%* Example 10: View the current SAS Metadata server connection entry list (Mode=V): ;
%m_adm_ctrl_mdaccess(
   mdtable  = WORK.mdaccess
 , mdkey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = N
   );
 
