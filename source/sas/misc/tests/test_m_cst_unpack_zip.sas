/*!
 ******************************************************************************
 * \file       test_m_cst_unpack_zip.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-22 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_cst_unpack_zip.sas
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
%m_cst_unpack_zip(?)
 
%* Example 2: Step 1 - Create and load from SASHELP into a ZIP archive: ;
proc copy out=WORK in=SASHELP clone;
   select cars class;
run;

filename tmpfile "%sysfunc(getoption(WORK))/cars.sas7bdat";
filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="cars.sas7bdat";

%* byte-by-byte copy ;
data _null_;
   infile tmpfile recfm=n;
   file zipfile recfm=n;
   input byte $char1. @;
   put byte $char1. @;
run;

filename tmpfile "%sysfunc(getoption(WORK))/class.sas7bdat";
filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="class.sas7bdat";

%* byte-by-byte copy ;
data _null_;
   infile tmpfile recfm=n;
   file zipfile recfm=n;
   input byte $char1. @;
   put byte $char1. @;
run;

filename tmpfile clear;
filename zipfile clear;
 
%* Example 3: Step 3 - Extract all files listed in a ZIP archive (mode: Extract): ;
%m_cst_unpack_zip(
   infile  = %sysfunc(getoption(WORK))/sashelp.zip
 , outdir  = %sysfunc(getoption(WORK))/sashelp
 , runmode = EXTRACT
 , print   = Y
 , debug   = Y
   );
 
