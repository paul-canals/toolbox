/*!
 ******************************************************************************
 * \file       test_m_adm_ctrl_rcaccess.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:48:27
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_ctrl_rcaccess.sas
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
%m_adm_ctrl_rcaccess(?)
 
%* Example 2: Create new RCACCESS table (Mode=C): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: Insert a new Remote Connection entry (Mode=I and access: technical): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
 
%* Example 4: Insert a new Remote Connection entry (Mode=I and access: personal): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(hermes.local 7551)
 , racc    = P
 , lusr    = sasdemo
 , rusr    = sasdemo
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = Y
   );
 
%* Example 5: View the technical Remote Connection entry for HMSDEV (Mode=V): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rsel    = %str(rcname='HMSDEV' and rcaccs='T')
 , mode    = V
 , print   = Y
 , debug   = Y
   );
 
%* Example 6: Send the complete Remote Connection entry list by mail (Mode=V): ;
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
 , mode     = V
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
   );
 
%* Example 7: Deactivate a Remote Connection entry (Mode=U and access: technical): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , ract    = N
 , mode    = U
 , print   = Y
 , debug   = N
   );
 
%* Example 8: View the current Remote Connection entry list (Mode=V): ;
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = Y
   );

 
%* Example 9: Delete a Remote Connection entry (Mode=D and access: technical): ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , racc    = T
 , mode    = D
 , print   = Y
 , debug   = N
   );
 
%* Example 10: View the current Remote Connection entry list (Mode=V): ;
%m_adm_ctrl_rcaccess(
   rctable  = WORK.rcaccess
 , rckey    = aespasskey
 , mode     = V
 , print    = Y
 , debug    = N
   );
 
