/*!
 ******************************************************************************
 * \file       test_m_sys_get_rcaccess.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:36:45
 * \version    20.1.12
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_sys_get_rcaccess.sas
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
%m_sys_get_rcaccess(?)
 
%* Prepare a RCACCESS table for the next examples: ;
%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = C
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(dev.hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , rdest   = HERMES
 , renv    = DEV
 , rhost   = %str(dev.hermes.local 7551)
 , racc    = P
 , lusr    = &sysuserid.
 , rusr    = &sysuserid.
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSUAT
 , rdest   = HERMES
 , renv    = UAT
 , rhost   = %str(uat.hermes.local 7551)
 , racc    = T
 , rusr    = dummy
 , rpwd    = XXX
 , mode    = I
 , print   = Y
 , debug   = N
   );

%m_adm_ctrl_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , mode    = V
 , print   = Y
 , debug   = N
   );
 
%* Example 2: Get remote host information for a technical user (RENV= and RDEST=): ;
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rdest   = HERMES
 , renv    = DEV
 , debug   = Y
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
 
%* Example 3: Get remote host information for a technical user (RNAME=): ;
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , debug   = N
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
 
%* Example 4: Get remote host information for a personal user (RENV= and RDEST=): ;
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rdest   = HERMES
 , renv    = DEV
 , racc    = P
 , lusr    = &sysuserid.
 , debug   = Y
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
 
%* Example 5: Get remote host information for a personal user (RNAME=): ;
%m_sys_get_rcaccess(
   rctable = WORK.rcaccess
 , rckey   = aespasskey
 , rname   = HMSDEV
 , racc    = P
 , lusr    = &sysuserid.
 , debug   = N
   );

data WORK.result;
   host = "&host.";
   tcpsec = "&tcpsec.";
run;

proc print data=WORK.result noobs;
run;
 
