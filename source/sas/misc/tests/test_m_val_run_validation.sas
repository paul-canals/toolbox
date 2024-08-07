/*!
 ******************************************************************************
 * \file       test_m_val_run_validation.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \author     Dr. Simone Kossmann (simone.kossmann@web.de)
 * \date       2024-08-03 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_run_validation.sas
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
%m_val_run_validation(?)
 
%* Example 2: Step 1 - Create a validation control table: ;
data WORK.rules;
   length
      rule_id    8
      rule_grp   $32
      rule_type  $20
      library    $10
      table      $32
      columns    $1024
      range_min  $32
      range_max  $32
      value_list $1024
      expression $1024
      ;
   infile datalines4 dlm=';'
   missover;
   input
      rule_id
      rule_grp   $
      rule_type  $
      library    $
      table      $
      columns    $
      range_min  $
      range_max  $
      value_list $
      expression $
      ;
datalines4;
1; ;Missing;WORK;CARS;Make; ; ; ; ;
2; ;Missing;WORK;CARS;Model Type; ; ; ; ;
3; ;Duplicate;WORK;CARS;Make Model Type; ; ; ; ;
4; ;Invalid;WORK;CARS;Cylinders; ; ;4 6 8 10 12; ;
5; ;Invalid;WORK;CARS;Invoice;30000;50000; ; ;
6; ;Invalid;WORK;CARS;Invoice;30000; ; ; ;
7; ;Invalid;WORK;CARS;Invoice; ;50000; ; ;
8;Mobile;Custom;WORK;CARS; ; ; ; ;Invoice lt 50000;
9;Mobile;Custom;WORK;CARS; ; ; ; ;(substr(Make,1,1) ne "") and (Type ^= '');
10;Student;Missing;WORK;CLASS;Name Sex; ; ; ; ;
11;Student;Invalid;WORK;CLASS;Sex; ; ;F M; ;
12;Student;Invalid;WORK;CLASS;Age; ;18; ; ;
15;Fittness;Custom;WORK;CLASS; ; ; ; ;Name in (select Name from SASHELP.classfit where Name ne 'John'); ; ;
16;Fittness;Custom;WORK;CLASS; ; ; ; ;Height in (select Height from SASHELP.classfit where Height > 55); ; ;
17;Fittness;Custom;WORK;CLASS; ; ; ; ;Weight in (select Weight from SASHELP.classfit where Weight gt 70); ; ;
30; ;Missing;SASHELP;PRDSAL2;COUNTRY STATE; ; ; ; ;
31; ;Invalid;SASHELP;PRDSAL2;QUARTER;1;4; ; ;
32; ;Invalid;SASHELP;PRDSAL2;QUARTER; ; ;1 2 3 4; ;
33; ;Invalid;SASHELP;PRDSAL2;YEAR;1996;1998; ; ;
35; ;Custom;SASHELP;PRDSAL2; ; ; ; ;COUNTRY in (lookup COUNTRY from SASHELP.prdsal3 where COUNTY ne '');
;;;;
run;
 
%* Example 2: Step 2 - Prepare the SASHELP.cars table for missing values: ;
data WORK.cars;
   set SASHELP.cars;
   if mod(_N_,10) eq 0 then do;
      type = '';
      length = .;
   end;
run;
 
%* Example 2: Step 3 - Prepare the SASHELP.class table for invalid values: ;
data WORK.class / view=WORK.class;
   set SASHELP.class;
   if Name eq 'John' then Sex = '';
run;
 
%* Example 2: Step 4 - Run all of the listed valdiation checks: ;
%m_val_run_validation(
   ctl_tbl = WORK.rules
 , exc_sum = WORK.summary
 , exc_tbl = WORK.exceptions
 , print   = Y
 , debug   = N
   );

proc print data=WORK.exceptions (obs=10) label;
run;
 
%* Example 2: Step 5 - Run only filtered list of valdiation checks: ;
%m_val_run_validation(
   ctl_tbl = WORK.rules
 , exc_sum = WORK.summary
 , exc_tbl = WORK.exceptions
 , filter  = %str(Student Fittness)
 , replace = Y
 , print   = Y
 , debug   = N
   );

proc print data=WORK.exceptions (obs=10) label;
run;
 
%* Example 2: Step 6 - Since we are done delete modified tables: ;
proc datasets lib=WORK memtype=(DATA VIEW) nodetails noprint;
   delete cars class ;
quit;
 
