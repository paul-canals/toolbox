/*!
 ******************************************************************************
 * \file       test_m_utl_quote_elems.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2022-10-22 00:00:00
 * \version    22.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_quote_elems.sas
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
%m_utl_quote_elems(?)
 
%* Example 2: Select all female names from Class dataset: ;
%let list=
   %m_utl_quote_elems(
      list    = %str(Alice, Jane, Janet, Joyce, Judy)
    , in_dlm  = COMMA
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name in (&list.);
run;

proc print data=WORK.class;
run;

 
%* Example 3: Select all male names from Class dataset: ;
%let list=
   %m_utl_quote_elems(
      list    = %str(Alfred Henry Jeffrey James John)
    , in_dlm  = BLANK
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name in (&list.);
run;

proc print data=WORK.class;
run;

 
%* Example 4: Quote a list of numeric numbers: ;
%let list=
   %m_utl_quote_elems(
      list    = %str(1 2 3 4 5 6 7 8 9)
    , in_dlm  = BLANK
    , out_dlm = COMMA
    , debug   = Y
      );

%put &=list.;

 
%* Example 5: Quote a list of numeric numbers: ;
%let list=
   %m_utl_quote_elems(
      list    = %str(1, 2, 3, 4, 5, 6, 7, 8, 9)
    , in_dlm  = COMMA
    , out_dlm = BLANK
    , debug   = Y
      );

%put LIST=(&list.);

 
