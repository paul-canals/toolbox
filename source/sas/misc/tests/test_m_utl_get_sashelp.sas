/*!
 ******************************************************************************
 * \file       test_m_utl_get_sashelp.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:35
 * \version    21.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_sashelp.sas
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
%m_utl_get_sashelp(?)
 
%* Example 2: Print content information on all SAS dictionary tables: ;
%m_utl_get_sashelp(
   table = _ALL_
 , info  = Y
 , debug = N
   )
 
%* Example 3: Obtain information on all currently assigned libraries: ;
%m_utl_get_sashelp(
   table = VLIBNAM
 , info  = Y
 , debug = N
   )
 
%* Example 4: Obtain information on all temporary assigned libraries: ;
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(temp)='YES'))
 , print = Y
 , debug = N
   )
 
%* Example 5: Create output table with all temporary assigned libraries: ;
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(temp)='YES' and upcase(sysname)='FILENAME'))
 , out   = WORK.tmplibs
 , print = N
 , debug = N
   )

proc print data=WORK.tmplibs label;
run;
 
%* Example 6: Obtain information on all SASHELP paths, sorted by libname and level: ;
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(libname)='SASHELP' and upcase(sysname)='FILENAME'))
 , out   = WORK.sashelp (keep=libname engine path level readonly temp)
 , sort  = libname descending level
 , print = Y
 , debug = N
   )

proc contents data=WORK.sashelp;
run;
 
%* Example 7: Obtain information on concatenated libraries, sorted by libname and path: ;
%m_utl_get_sashelp(
   table = VLIBNAM (where=(upcase(sysname) = 'FILENAME' and level > 0))
 , out   = WORK.libraries (keep=libname engine path level readonly temp)
 , sort  = libname path
 , print = N
 , debug = N
   )

data WORK.libraries (drop=level);
   set WORK.libraries;
   attrib concat length=$3 label='Concatenated?';
   if level gt 0 then concat='yes';
   else concat='no';
run;

proc print data=WORK.libraries label;
run;
 
