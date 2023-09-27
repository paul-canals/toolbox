/*!
 ******************************************************************************
 * \file       test_m_adm_statistics_report.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \author     Dr. Simone Kossmann (simone.kossmann@web.de)
 * \date       2023-09-26 15:36:25
 * \version    23.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_statistics_report.sas
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
%m_adm_statistics_report(?)
 
%* Example 2: Perform year-to-date monthly user connection analysis. Exclude type: \@saspw and user: system from statistics.
 ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , mode     = Y2D
 , type     = MTH
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );

 
%* Example 3: Perform all time hourly user connection analysis. Exclude type: \@saspw and user: system from statistics.
 ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , mode     = HIS
 , type     = HRS
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );

 
%* Example 4: Perform year-to-date analysis per user with top 5 users. Exclude type: \@saspw and user: system from statistics.
 ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , mode     = Y2D
 , type     = USR
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );

 
%* Example 5: Perform all time complete server connection analysis. Exclude type: \@saspw and user: system from statistics.
 ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , mode     = HIS
 , type     = ALL
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );

 
%* Example 6: Perform a complete server connection analysis for a given month. Exclude type: \@saspw and user: system from statistics.
 ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , mode     = 1M
 , type     = ALL
 , lastdate = 31012021
 , firstday = MON
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );

 
%* Example 7: Perform a file system directory analysis for a given month. ;
%m_adm_statistics_report(
   rootdir = %str(&APPL_BASE.)
 , mode    = Y2D
 , type    = DIR
 , debug   = Y
   );

 
%* Example 8: Send the year-to-date statistics report as PDF to a given email address. ;
%let sascfg = %sysfunc(getoption(SASINITIALFOLDER));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&sascfg./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&sascfg./../ObjectSpawner/Logs)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );

 
