/*!
 ******************************************************************************
 * \file       test_m_utl_ds2xls.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-07 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ds2xls.sas
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
%m_utl_ds2xls(?)
 
%* Example 2: Create a new XLS file from SASHELP.class: ;
%m_utl_ds2xls(
   base_ds  = SASHELP.class
 , xls_file = %str(%sysfunc(getoption(WORK))/class.xls)
 , engine   = XLS
 , newfile  = Y
 , debug    = Y
   );
 
%* Example 3: Create a XLS file from SASHELP.class with variable selection: ;
%m_utl_ds2xls(
   base_ds  = SASHELP.class
 , xls_file = %str(%sysfunc(getoption(WORK))/class.xls)
 , engine   = XLS
 , varlist  = %str(Name Sex Age)
 , debug    = Y
   );
 
%* Example 4: Create a XLSX file with worksheet 'Boys' from SASHELP.class: ;
%m_utl_ds2xls(
   base_ds   = SASHELP.class
 , xls_file  = %str(%sysfunc(getoption(WORK))/class.xlsx)
 , engine    = XLSX
 , replace   = Y
 , labels    = Y
 , worksheet = Boys
 , where     = %str(Sex = 'M')
 , debug     = Y
   );
 
%* Example 5: Add worksheet 'Girls' from SASHELP.class to class.xlsx: ;
%m_utl_ds2xls(
   base_ds   = SASHELP.class
 , xls_file  = %str(%sysfunc(getoption(WORK))/class.xlsx)
 , engine    = XLSX
 , replace   = Y
 , labels    = Y
 , worksheet = Girls
 , where     = %str(Sex = 'F')
 , debug     = Y
   );
 
%* Example 6: Replace worksheet contents from an encrypted table to class.xlsx: ;
data WORK.classfit(encrypt=aes encryptkey=key);
   set SASHELP.classfit;
run;

%m_utl_ds2xls(
   base_ds   = WORK.classfit
 , xls_file  = %str(%sysfunc(getoption(WORK))/class.xlsx)
 , engine    = XLSX
 , replace   = Y
 , labels    = Y
 , worksheet = Boys
 , password  = key
 , where     = %str(Sex = 'M')
 , debug     = Y
   );

%m_utl_ds2xls(
   base_ds   = WORK.classfit
 , xls_file  = %str(%sysfunc(getoption(WORK))/class.xlsx)
 , engine    = XLSX
 , replace   = Y
 , labels    = Y
 , worksheet = Girls
 , password  = key
 , where     = %str(Sex = 'F')
 , debug     = Y
   );
 
