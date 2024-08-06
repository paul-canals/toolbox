/*!
 ******************************************************************************
 * \file       test_m_utl_copy_file.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-14 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_copy_file.sas
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
%m_utl_copy_file(?)
 
%* Example 2: Copy an external file to another directory (byte-for-byte): ;
%m_utl_copy_file(
   infile    = %sysfunc(pathname(SASROOT))/maps/counties.sas7bdat
 , outfile   = %sysfunc(getoption(WORK))/backup/counties.sas7bdat
 , overwrite = Y
 , debug     = N
   );

libname OUT "%sysfunc(getoption(WORK))/backup";

proc contents data=MAPS.counties;
run;

proc contents data=OUT.counties;
run;

libname OUT clear;

 
%* Example 3: Copy an external file to another directory (using chunks): ;
%m_utl_copy_file(
   infile    = %sysfunc(pathname(SASROOT))/maps/counties.sas7bdat
 , outfile   = %sysfunc(getoption(WORK))/backup/counties.sas7bdat
 , chunksize = 8192
 , overwrite = Y
 , debug     = N
   );

libname OUT "%sysfunc(getoption(WORK))/backup";

proc contents data=OUT.counties;
run;

libname OUT clear;

 
%* Example 4: Avoid copying to an existing external file (no error thrown): ;
%m_utl_copy_file(
   infile    = %sysfunc(pathname(SASROOT))/maps/counties.sas7bdat
 , outfile   = %sysfunc(getoption(WORK))/backup/counties.sas7bdat
 , chunksize = 8192
 , overwrite = N
 , show_err  = N
 , debug     = Y
   );

 
