/*!
 ******************************************************************************
 * \file       test_m_utl_ddl2ds.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:08
 * \version    22.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ddl2ds.sas
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
%m_utl_ddl2ds(?)
 
%* Example 2: Step 1 - Create a Data Definition Language file for table class: ;
filename class "%sysfunc(getoption(WORK))/ddl_class.sas";

data _null_;
   file class;
   put 'proc sql noprint feedback stimer;';
   put '   create table WORK.class  (';
   put '      Name      VARCHAR(8)';
   put '    , Sex       VARCHAR(1)';
   put '    , Age       NUMERIC(8)';
   put '    , Height    NUMERIC(8)';
   put '    , Weight    NUMERIC(8)';
   put '      );';
   put '   create index Name on WORK.class (Name);';
   put 'quit;';
run;

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
%* Example 2: Step 2 - Import the Data Definition Language file to create class: ;
%m_utl_ddl2ds(
   in_file = %str(%sysfunc(getoption(WORK))/ddl_class.sas)
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: Step 1 - Create a Data Definition Language file for table class: ;
filename class "%sysfunc(getoption(WORK))/ddl_class.sas";

data _null_;
   file class;
   put 'proc sql noprint feedback stimer;';
   put '   create table &libref..class  (';
   put '      Name      VARCHAR(8)';
   put '    , Sex       VARCHAR(1)';
   put '    , Age       NUMERIC(8)';
   put '    , Height    NUMERIC(8)';
   put '    , Weight    NUMERIC(8)';
   put '      );';
   put '   create index Name on &libref..class (Name);';
   put 'quit;';
run;

data _null_;
   infile class;
   input;
   put _infile_;
run;
 
%* Example 3: Step 2 - Import the Data Definition Language file to create class: ;
%m_utl_ddl2ds(
   in_file = %str(%sysfunc(getoption(WORK))/ddl_class.sas)
 , prm_flg = Y
 , prm_lib = WORK
 , print   = Y
 , debug   = Y
   );
 
