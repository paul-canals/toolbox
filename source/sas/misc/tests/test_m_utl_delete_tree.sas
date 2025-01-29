/*!
 ******************************************************************************
 * \file       test_m_utl_delete_tree.sas
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
 *             + m_utl_delete_tree.sas
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
%m_utl_delete_tree(?)
 
%* Example 2: Delete all files and dirs from a given path directory: ;
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/tmpdir";
libname TEMP clear;

filename text1 "%sysfunc(getoption(WORK))/tmpdir/delete_1.txt";

data _null_;
   file text1;
   put "file to be deleted";
run;

filename text1 clear;

filename text2 "%sysfunc(getoption(WORK))/tmpdir/delete_2.txt";

data _null_;
   file text2;
   put "file to be deleted";
run;

filename text2 clear;

libname TEMP "%sysfunc(getoption(WORK))/tmpdir/subdir";
libname TEMP clear;

filename text3 "%sysfunc(getoption(WORK))/tmpdir/subdir/delete_3.txt";

data _null_;
   file text3;
   put "file to be deleted";
run;

filename text3 clear;

%m_utl_delete_tree(
   path    = %sysfunc(getoption(WORK))/tmpdir
 , subdirs = Y
 , print   = Y
 , debug   = Y
   );
 
