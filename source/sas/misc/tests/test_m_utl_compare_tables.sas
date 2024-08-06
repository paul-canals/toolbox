/*!
 ******************************************************************************
 * \file       test_m_utl_compare_tables.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-01 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_compare_tables.sas
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
%m_utl_compare_tables(?)
 
%* Example 2: Step 1 - Create a new comparison table WORK.class: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John'
      then Sex = 'F';
   if name eq 'Janet' then do;
      Height = 57.3;
      Weight = 99;
   end;
   if _n_ lt 18 then do;
      output;
      if name eq 'Henry' then do;
         name = 'Paul';
         output;
      end;
      if name eq 'Philip' then do;
         output;
      end;
   end;
run;
 
%* Example 2: Step 2 - Compare SASHELP.class against WORK.class: ;
%m_utl_compare_tables(
   base   = SASHELP.class (drop=Height)
 , comp   = WORK.class (drop=Height)
 , idcols = Name Age
 , stats  = N
 , print  = Y
 , debug  = Y
   );
 
%* Example 3: Compare SASHELP.class against SASHELP.classfit: ;
%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = SASHELP.classfit
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
 
%* Example 4: Compare SASHELP.classfit against SASHELP.class: ;
%m_utl_compare_tables(
   base   = SASHELP.classfit
 , comp   = SASHELP.class
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
 
%* Example 5: Compare SASHELP.class against WORK.class without IDCOLS=: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then do;
      Name = 'Joan';
      Sex = 'F';
   end;
   if name eq 'Janet' then do;
      height = 57.3;
      weight = 99;
   end;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , diff   = WORK.diff
 , print  = Y
 , debug  = N
   );
 
%* Example 6: Compare SASHELP.class against WORK.class with IDCOLS=Name value: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , print  = Y
 , debug  = N
   );

%put &=_comp_rc.;
%put &=_comp_msg.;
 
%* Example 7: Compare SASHELP.class against WORK.class with IDCOLS value change: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
 
%* Example 8: Summarize and compare SASHELP.prdsal3 against SASHELP.prdsal2: ;
proc sql noprint;
   create table WORK.prdsal2 as
   select country, state, prodtype, product, year, quarter, month
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal2 (drop=county monyr)
    group by country, state, prodtype, product
        , year, quarter, month
    order by year, quarter, month
   ;
quit;

proc sql noprint;
   create table WORK.prdsal3 as
   select country, state, prodtype, product, year, quarter, month
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal3 (drop=county date)
    group by country, state, prodtype, product
        , year, quarter, month
    order by year, quarter, month
   ;
quit;

%m_utl_compare_tables(
   base   = WORK.prdsal3
 , comp   = WORK.prdsal2
 , diff   = WORK.prdsal_grp_diff
 , idcols = Country State Prodtype Product Year Quarter Month
 , nodups = N
 , print  = Y
 , debug  = N
   );
 
%* Example 9: Compare SASHELP.prdsal3 against SASHELP.prdsal2 directly: ;
%m_utl_compare_tables(
   base   = SASHELP.prdsal3 (drop=date)
 , comp   = SASHELP.prdsal2 (drop=monyr)
 , diff   = WORK.prdsal_diff
 , idcols = Country State County Prodtype Product Year Quarter Month
 , nodups = Y
 , print  = Y
 , debug  = N
   );
 
%* Example 10: Compare SASHELP.class against WORK.class using METHOD=ABS: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Height = 59.000001;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , method = ABSOLUTE
 , gamma  = 0.000001
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
 
%* Example 11: Compare SASHELP.class against WORK.class using METHOD=PCT: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Height = 59.000001;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , method = PERCENT
 , gamma  = 0.000001
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
 
%* Example 12: Compare SASHELP.class against WORK.class using NOMISS=N: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = . ;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , print  = Y
 , debug  = N
   );
 
%* Example 13: Compare SASHELP.class against WORK.class using NOMISS=Y: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = . ;
run;

%m_utl_compare_tables(
   base   = SASHELP.class
 , comp   = WORK.class
 , idcols = Name
 , nomiss = Y
 , print  = Y
 , debug  = N
   );
 
