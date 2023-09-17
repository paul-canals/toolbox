/*!
 ******************************************************************************
 * \file       test_m_utl_chg_delimiter.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:04
 * \version    20.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chg_delimiter.sas
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
%m_utl_chg_delimiter(?)
 
%* Example 2: Change a blank delimited list into a comma separated list: ;
proc sql noprint;
   select Name
     into :girls separated by ' '
     from SASHELP.class
    where Sex='F'
   ;
quit;

%put &=girls.;

%let list=
   %m_utl_chg_delimiter(
      list   = %str(&girls.)
    , newdlm = %str(, )
    , debug  = Y
      );

%put &=list.;

 
%* Example 3: Change a blank delimited list into a single quoted and comma separated list: ;
proc sql noprint;
   select Name
     into :girls separated by ' '
     from SASHELP.class
    where Sex='F'
   ;
quit;

%put &=girls.;

%let list=
   %m_utl_chg_delimiter(
      list   = %str(&girls.)
    , newdlm = %str(', ')
    , quotes = SINGLE
    , debug  = Y
      );

%put &=list.;

proc print data=SASHELP.class(where=(Name in (&list.)));
run;

 
%* Example 4: Change a multi separated list into a single comma separated list: ;
%let list=
   %m_utl_chg_delimiter(
      list   = %str(James,Jeffrey#John Philip,Robert)
    , dlm    = %str(,# )
    , newdlm = %str(", ")
    , quotes = Y
    , debug  = Y
      );

%put &=list.;

proc print data=SASHELP.class(where=(Name in (&list.)));
run;

 
%* Example 5: Change a name-quotes comma separated list into a blank separated list: ;
data WORK.class;
   set SASHELP.class;
   rename
      name = 'Name (Student)'n
      sex  = 'Gender (F/M)'n
      age  = 'Age (Years)'n
      ;
run;

%let list=
   %m_utl_chg_delimiter(
      list   = %str('Name (Student)'n,'Gender (F/M)'n,'Age (Years)'n)
    , dlm    = %str(,)
    , newdlm = %str( )
    , quotes = N
    , debug  = Y
      );

%put &=list.;

proc print data=WORK.class (keep=&list.);
run;

 
