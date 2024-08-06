/*!
 ******************************************************************************
 * \file       test_m_sys_get_mdaccess.sas
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
 *             + m_sys_get_mdaccess.sas
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
%m_sys_get_mdaccess(?)
 
%* Prepare a MDACCESS table for the next examples: ;
%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %str(dev.hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , menv    = DEV
 , mhost   = %sysfunc(getoption(METASERVER))
 , mport   = %sysfunc(getoption(METAPORT))
 , macc    = P
 , lusr    = &sysuserid.
 , musr    = &sysuserid.
 , mpwd    = %str(P@ul1970)
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSUAT
 , menv    = UAT
 , mhost   = %str(uat.hermes.local)
 , mport   = 8561
 , macc    = T
 , musr    = dummy
 , mpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mode    = V
 , print   = Y
 , debug   = N
   );
 
%* Example 2: Get metadata server connection information for a technical user (MENV=): ;
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , menv    = DEV
 , debug   = Y
   );

proc options group=meta short;
run;
 
%* Example 3: Get metadata server connection information for a technical user (MNAME=): ;
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , debug   = N
   );

proc options group=meta short;
run;
 
%* Example 4: Get metadata server connection information for a personal user (MENV=): ;
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , menv    = DEV
 , macc    = P
 , lusr    = &sysuserid.
 , debug   = Y
   );

proc options group=meta short;
run;
 
%* Example 5: Get metadata server connection information for a personal user (MNAME=): ;
%m_sys_get_mdaccess(
   mdtable = WORK.mdaccess
 , mdkey   = aespasskey
 , mname   = HMSDEV
 , macc    = P
 , lusr    = &sysuserid.
 , debug   = N
   );

proc options group=meta short;
run;
 
