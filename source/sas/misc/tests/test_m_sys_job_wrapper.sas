/*!
 ******************************************************************************
 * \file       test_m_sys_job_wrapper.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:48:59
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_sys_job_wrapper.sas
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
 
%* Example 1 - Step 1: Create an example job: ;
filename tmp "C:\SAS\Config\Lev1\SASMeta\SASEnvironment\SASCode\Jobs\Hello_World.sas";
data _null_;
   file tmp mod;
   put '*Show in log:;';
   put '%put HELLO WORLD!;';
run;
 
%* Example 1 - Step 2: Run the example job: ;
%m_sys_job_wrapper(
   job_path   = C:\SAS\Config\Lev1\SASMeta\SASEnvironment\SASCode\Jobs
 , log_path   = C:\SAS\Config\Lev1\SASMeta\SASEnvironment\SASCode\Logs
 , job_name   = Hello_World
 , global_flg = Y
 , mvar_name  = M_JOB_LOG
 , debug      = N
   );

%put LOG=&M_JOB_LOG.;
 
