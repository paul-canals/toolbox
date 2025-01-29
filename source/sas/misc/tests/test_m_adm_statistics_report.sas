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
 * \date       2024-08-25 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_statistics_report.sas
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
%m_adm_statistics_report(?)
 
%* Example 2: Perform year-to-date monthly user connection analysis: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = Y2D
 , type     = MTH
 , interpol = Y
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
 
%* Example 3: Perform 12 months hourly user connection analysis: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = 12M
 , type     = HRS
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
 
%* Example 4: Perform 6 months analysis per user with top 5 users: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = 6M
 , type     = USR
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
 
%* Example 5: Perform 3 months complete server connection analysis: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = 3M
 , type     = ALL
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
 
%* Example 6: Perform a complete server connection analysis for a given month: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));
* Exclude type: \@saspw and user: system from statistics ;
%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , mode     = 1M
 , type     = ALL
 , lastdate = %sysfunc(putn(%sysfunc(today()),ddmmyyn8.))
 , firstday = MON
 , topusers = 5
 , excltype = @saspw
 , excluser = system
 , debug    = N
   );
 
%* Example 7: Perform a year-to-date file system directory analysis: ;
%m_adm_statistics_report(
   rootdir = %str(&APPL_BASE.)
 , mode    = Y2D
 , type    = DIR
 , debug   = Y
   );
 
%* Example 8: Send the year-to-date statistics report as PDF in an email: ;
%let rc = %sysfunc(filename(fref,.));
%let cd = %sysfunc(pathname(&fref.));
%let rc = %sysfunc(filename(fref));

%m_adm_statistics_report(
   rootdir  = %str(&APPL_BASE.)
 , mslogs   = %str(&cd./../SASMeta/MetadataServer/Logs)
 , wslogs   = %str(&cd./../ObjectSpawner/Logs)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
 
