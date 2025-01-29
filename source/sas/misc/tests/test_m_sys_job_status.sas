/*!
 ******************************************************************************
 * \file       test_m_sys_job_status.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-07 00:00:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_sys_job_status.sas
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
%m_sys_job_status(?)
 
%* Example 2: Create an example entry in the JOB_STATUS table: ;
%let etls_jobname = %nrquote(TEST_JOB);
%let etls_lib = WORK;
%let etls_table = TEST;
%let etls_recordsAfter = 19;
%let etls_starttime = %sysfunc(putn(%sysfunc(datetime()), datetime.));
%let etls_endTime = %sysfunc(putn(%sysfunc(datetime()), datetime.));
%let job_log = %sysfunc(getoption(WORK))/job.log;
%let job_rc = 0;

%m_sys_job_status(
   ctl_table    = WORK.job_status
 , p_etls_user  = &sysuserid.
 , p_etls_name  = &etls_jobname.
 , p_etls_vers  = &sysver.
 , p_job_rc     = &job_rc.
 , p_syscc      = &syscc.
 , p_message    =
 , p_load_dttm  =
 , p_etls_lib   = &etls_lib.
 , p_etls_table = &etls_table.
 , p_etls_recs  = &etls_recordsAfter.
 , p_etls_start = &etls_startTime.
 , p_etls_end   = &etls_endTime.
 , p_job_log    = &job_log.
 , debug        = N
   );

proc print data=WORK.job_status label;
run;
 
