/*!
 ******************************************************************************
 * \file       test_m_sys_job_error.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:36:46
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_sys_job_error.sas
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
%m_sys_job_error(?)
 
%* Example 2: Create an example entry in the JOB_ERROR table: ;
%let etls_jobname = %nrquote(TEST_JOB);
%let job_rc = 4;
%let msg_rc = custom_rc4_msg;
%let trans_rc = 0;
%let sqlrc = 0;

%m_sys_job_error(
   ctl_table    = WORK.job_error
 , p_etls_user  = &sysuserid.
 , p_etls_name  = &etls_jobname.
 , p_etls_vers  = &sysver.
 , p_job_rc     = &job_rc.
 , p_syscc      = &syscc.
 , p_syserr     = &syserr.
 , p_message    = &msg_rc.
 , p_load_dttm  =
 , p_trans_rc   = &trans_rc.
 , p_sqlrc      = &sqlrc.
 , debug        = N
   );

proc print data=WORK.job_error label;
run;
 
