/*!
 ******************************************************************************
 * \file       test_m_utl_map_tables.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-08 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_map_tables.sas
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
%m_utl_map_tables(?)
 
%* Example 2: Copy all data from SASHELP.class to WORK.classfit: ;
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = Y
   );

 
%* Example 3: Copy data from selected columns of SASHELP.class to WORK.classfit: ;
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , src_cols = Name Sex Age
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = Y
   );

 
%* Example 4: Copy data from SASHELP.class to selected columns of WORK.classfit: ;
data WORK.classfit;
   set SASHELP.classfit;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age
 , print    = Y
 , debug    = N
   );

 
%* Example 5: Copy all data from SASHELP.class to WORK.classfit: ;
data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , print    = Y
 , debug    = N
   );

 
%* Example 6: Copy data from SASHELP.class to selected columns of WORK.classfit: ;
data WORK.class;
   set SASHELP.class;
   if Name eq 'John' then weight = . ;
run;

data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age Weight
 , print    = Y
 , debug    = N
   );

proc print data=WORK.classfit (keep=Name Sex Age Weight) label;
run;

 
%* Example 7: Copy data from selected columns of SASHELP.class to WORK.result: ;
data WORK.classfit (rename=(_Name=Name _Age=Age _Weight=Weight));
   attrib _Name length=$7. label='Name';
   attrib _Age length=$3. label='Age';
   attrib _Weight length=$8. label='Weight';
   set SASHELP.classfit;
   drop Name Age Weight;
   stop;
run;

proc datasets lib = WORK nolist nowarn memtype = (data view);
   delete result ;
quit;

%m_utl_map_tables(
   src_tbl  = SASHELP.class
 , trg_tbl  = WORK.classfit
 , trg_cols = Name Sex Age Weight
 , out_tbl  = WORK.result
 , print    = Y
 , debug    = N
   );

proc print data=WORK.result label;
run;

 
%* Example 8: Copy data from SASHELP.air and map to column names of WORK.airline: ;
data WORK.airline(rename=(Air=Flights));
   set SASHELP.airline;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = SASHELP.air
 , src_cols = Date Air
 , trg_tbl  = WORK.airline
 , trg_cols = Date Flights
 , print    = Y
 , debug    = N
   );

proc print data=WORK.airline (keep=Date Flights obs=10);
run;

 
%* Example 9: Map and load data with column type and format change (Num->Char): ;
data WORK.prdsale;
   set SASHELP.prdsale;
   attrib DATE length=8 format=MONYY. informat=MONYY.;
   DATE = MONTH;
run;

data WORK.prdsal3 (rename=(_DATE=DATE));
   set SASHELP.prdsal3;
   attrib _DATE length=$4 format=$4.;
   _DATE = put(DATE, monyy.);
   drop DATE;
   stop;
run;

%m_utl_map_tables(
   src_tbl  = WORK.prdsale
 , src_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , trg_tbl  = WORK.prdsal3
 , trg_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , out_tbl  = WORK.prdsal3
 , print    = Y
 , debug    = Y
   );

 
%* Example 10: Map and load data with column type and format change (Char->Num): ;
data WORK.prdsale;
   set SASHELP.prdsale;
   attrib DATE length=$5 format=$5.;
   DATE = put(MONTH, monyy.);
run;

proc datasets lib = WORK nolist nowarn memtype = (data view);
   delete result ;
quit;

%m_utl_map_tables(
   src_tbl  = WORK.prdsale
 , src_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , trg_tbl  = SASHELP.prdsal3
 , trg_cols = ACTUAL COUNTRY DATE MONTH PREDICT PRODTYPE PRODUCT QUARTER YEAR
 , out_tbl  = WORK.result
 , print    = Y
 , debug    = N
   );

 
