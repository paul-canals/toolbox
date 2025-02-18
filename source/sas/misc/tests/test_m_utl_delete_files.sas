/*!
 ******************************************************************************
 * \file       test_m_utl_delete_files.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-11-23 00:00:00
 * \version    23.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_delete_files.sas
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
%m_utl_delete_files(?)
 
%* Example 2: Delete files from a given directory: ;
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/temp";
libname TEMP clear;

filename text1 "%sysfunc(getoption(WORK))/temp/delete_me.txt";

data _null_;
   file text1;
   put "file to be deleted";
run;

filename text1 clear;

filename text2 "%sysfunc(getoption(WORK))/temp/keep_me.txt";

data _null_;
   file text2;
   put "file to be deleted";
run;

filename text2 clear;

%m_utl_delete_files(
   path  = %sysfunc(getoption(WORK))/temp
 , keep  = keep_me.txt
 , debug = Y
   );
 
