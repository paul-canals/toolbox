/*!
 ******************************************************************************
 * \file       test_m_utl_ds2json.sas
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
 *             + m_utl_ds2json.sas
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
%m_utl_ds2json(?)
 
%* Example 2: Create a JSON file from SASHELP.class: ;
%m_utl_ds2json(
   base_ds   = SASHELP.class
 , json_file = %str(%sysfunc(getoption(WORK))/class_f.json)
 , runmode   = S
 , sastags   = Y
 , where     = %str(Sex = 'F')
 , debug     = Y
   );

filename class "%sysfunc(getoption(WORK))/class_f.json";

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
%* Example 3: Create a JSON file from SASHELP.class: ;
%m_utl_ds2json(
   base_ds   = SASHELP.class
 , json_file = %str(%sysfunc(getoption(WORK))/class_m.json)
 , runmode   = C
 , pretty    = N
 , sastags   = Y
 , where     = %str(Sex = 'M')
 , debug     = Y
   );

filename class "%sysfunc(getoption(WORK))/class_m.json";

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
%* Example 4: Create a JSON file with missing values (NULL): ;
data WORK.class;
   set SASHELP.class;
   if name in ('John','James') then do;
      sex = '';
      weight = .;
   end;
run;

%m_utl_ds2json(
   base_ds   = WORK.class
 , json_file = %str(%sysfunc(getoption(WORK))/class.json)
 , runmode   = C
 , pretty    = Y
 , sastags   = Y
 , debug     = Y
   );

filename class "%sysfunc(getoption(WORK))/class.json";

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
