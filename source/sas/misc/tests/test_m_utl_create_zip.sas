/*!
 ******************************************************************************
 * \file       test_m_utl_create_zip.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-26 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_create_zip.sas
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
%m_utl_create_zip(?)
 
%* Example 2: Copy SAS core samples into a ZIP file using Auto mode: ;
%m_utl_create_zip(
   indir   = %sysget(SASROOT)/core/sample
 , outdir  = %sysfunc(getoption(WORK))/backup
 , zipname = &sysuserid._sasuser.zip
 , runmode = AUTO
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: Copy SAS core samples into a ZIP file using ODS package: ;
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sample
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasuser.zip
 , runmode   = ODS
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
 
%* Example 4: Copy SAS core samples into a ZIP file using ZIP fileref: ;
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sample
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = &sysuserid._sasuser.zip
 , runmode   = FILEREF
 , overwrite = Y
 , subdirs   = Y
 , print     = Y
 , debug     = Y
   );
 
%* Example 5: Copy a single file into a ZIP archive using Auto mode: ;
%m_utl_create_zip(
   indir     = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , runmode   = AUTO
 , overwrite = Y
 , print     = Y
 , debug     = Y
   );
 
%* Example 6: Step 1 - Copy a first file into a new ZIP archive: ; ;
%m_utl_create_zip(
   infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = class.zip
 , runmode   = FILEREF
 , overwrite = Y
 , print     = Y
 , debug     = Y
   );
 
%* Example 6: Step 2 - Copy a second file into the ZIP archive: ; ;
%m_utl_create_zip(
   infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 , outdir    = %sysfunc(getoption(WORK))/backup
 , zipname   = class.zip
 , runmode   = FILEREF
 , overwrite = N
 , print     = Y
 , debug     = Y
   );
 
