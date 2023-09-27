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
 * \date       2023-09-26 15:37:03
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_compare_tables.sas
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
 , idcols = Name
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
 , print  = Y
 , debug  = N
   );
 
%* Example 6: Compare SASHELP.class against WORK.class with IDCOLS value change: ;
data WORK.class;
   set SASHELP.class;
   if name eq 'John' then Age = 19;
run;

%m_utl_compare_tables(
   base   = SASHELP.class (drop=Height)
 , comp   = SASHELP.class (drop=Height)
 , idcols = Name Age
 , print  = Y
 , debug  = N
   );
 
%* Example 7: Summarize and compare SASHELP.prdsal3 against SASHELP.prdsal2: ;
proc sql noprint;
   create table WORK.prdsal2 as
   select country, state, county, prodtype, product, year, quarter
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal2 (drop=month monyr)
    group by country, state, county, prodtype
        , product, year, quarter
    order by year, quarter
   ;
quit;

proc sql noprint;
   create table WORK.prdsal3 as
   select country, state, county, prodtype, product, year, quarter
        , sum(actual) as actual, sum(predict) as predict
     from SASHELP.prdsal3 (drop=month date)
    group by country, state, county, prodtype
        , product, year, quarter
    order by year, quarter
   ;
quit;

%m_utl_compare_tables(
   base   = WORK.prdsal3
 , comp   = WORK.prdsal2
 , diff   = WORK.prdsal_grp_diff
 , idcols = Country State County Prodtype Product Year Quarter
 , print  = Y
 , debug  = N
   );
 
%* Example 8: Compare SASHELP.prdsal3 against SASHELP.prdsal2 directly: ;
%m_utl_compare_tables(
   base   = SASHELP.prdsal3 (drop=date)
 , comp   = SASHELP.prdsal2 (drop=monyr)
 , diff   = WORK.prdsal_diff
 , idcols = Country State County Prodtype Product Year Quarter
 , print  = N
 , debug  = N
   );

title "Attribute Summary (Differences) between SASHELP.prdsal3 and SASHELP.prdsal2";
proc print data=WORK.prdsal_diff (drop=_key_) label;
run;
title;
 
