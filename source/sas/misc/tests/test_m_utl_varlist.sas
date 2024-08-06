/*!
 ******************************************************************************
 * \file       test_m_utl_varlist.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-16 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_varlist.sas
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
%m_utl_varlist(?)
 
%* Example 2: Select only CHAR columns from SASHELP.class and add a new column: ;
data WORK.class;
   set SASHELP.class (keep=%m_utl_varlist(table=SASHELP.class,type=CHAR,debug=Y));
   attrib Load_DTTM length=8 format=datetime.;
   Load_DTTM=datetime();
run;

proc print data=WORK.class;
run;
 
%* Example 3: Select columns from encrypted WORK.class and rename column Name into Scholar: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

data WORK.class (keep=%m_utl_varlist(table=WORK.class(rename=(Name=Scholar)),creds=%str(encryptkey=aespasskey)));
   set WORK.class(encryptkey=aespasskey);
   Scholar=Name;
run;

proc print data=WORK.class;
run;
 
%* Example 4: Select only CHAR columns from SASHELP.class into a quoted list: ;
%let list=
   %m_utl_varlist(
      table  = SASHELP.class
    , type   = CHAR
    , quotes = DOUBLE
    , debug  = Y
      );

%put &=list.;
 
%* Example 5: Select columns from SASHELP.class into a comma separated list: ;
%let list=
   %m_utl_varlist(
      table   = SASHELP.class
    , out_dlm = COMMA
    , debug   = Y
      );

%put &=list.;
 
%* Example 6: Select columns from SASHELP.class into a custom separated list: ;
%let list=
   %m_utl_varlist(
      table   = SASHELP.class
    , out_dlm = %str($)
    , debug   = Y
      );

%put &=list.;
 
%* Example 7: Select only NUM columns from SASHELP.workers (including Date): ;
data WORK.workers;
   set SASHELP.workers;
   keep %m_utl_varlist(table=SASHELP.workers,type=NUM,debug=Y);
run;

proc print data=WORK.workers;
run;
 
%* Example 8: Select only DATE columns from SASHELP.workers: ;
data WORK.workers;
   set SASHELP.workers;
   keep %m_utl_varlist(table=SASHELP.workers,type=DATE,debug=Y);
run;

proc print data=WORK.workers;
run;
 
%* Example 9: Select columns from SASHELP.class and add a prefix to the names: ;
%let list=
   %m_utl_varlist(
      table  = SASHELP.class
    , prefix = CLASS_
    , debug  = Y
      );

%put &=list.;
 
%* Example 10: Select only columns from SASHELP.class into the output table: ;
data WORK.class;
   set SASHELP.class;
   keep %m_utl_varlist(table=SASHELP.class,debug=Y);
   dummy='this is just a temporary column';
run;

proc print data=WORK.class;
run;
 
%* Example 11: To check if a column exists in a given table: ;
%macro findColumn(table=,colnm=);

   %if %m_utl_varlist(table=&table.,include=&colnm.) ne %str()
      %then %put Column &colnm. exists in table &table.!;

%mend findColumn;

%findColumn(table=SASHELP.class,colnm=Sex);
 
%* Example 12: To search for common columns between two tables: ;
data WORK.class;
   set SASHELP.class;
   keep Name Age;
run;

%let list=
   %m_utl_varlist(
      table    = SASHELP.class
    , limit_to = %m_utl_varlist(table=WORK.class)
    , debug    = Y
   );

%put Common columns are: &list.;
 
%* Example 13: Generic Join on common columns with two tables: ;
data WORK.class;
   set SASHELP.class;
   keep %m_utl_varlist(table=SASHELP.class,type=NUM) Name;
run;

proc sql noprint;
   create table WORK.join as
   select %m_utl_varlist(
             table=SASHELP.class
           , prefix=a.
           , newdlm=COMMA
           , exclude=
                %m_utl_varlist(
                   table=WORK.class
                   )
             )
        , %m_utl_varlist(
             table=WORK.class
           , prefix=b.
           , newdlm=COMMA
             )
     from SASHELP.class a
        , WORK.class b
    where a.Name eq b.Name
    order by Sex, Name
   ;
quit;

proc print data=WORK.join;
run;
 
%* Example 14: Select columns from WORK.class into a named quoted list: ;
data WORK.class;
   set SASHELP.class;
   rename
      name = '/bic/Name'n
      sex  = '/bic/Sex'n
      ;
run;

%let list=
   %m_utl_varlist(
      table  = WORK.class
    , quotes = NAMED
    , debug  = Y
   );

%put Result column list: &list.;
 
