/*!
 ******************************************************************************
 * \file       test_m_utl_sort_elems.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-28 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_sort_elems.sas
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
%m_utl_sort_elems(?)
 
%* Example 2: Sort all words in the text string (blank): ;
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy Joyce Jane Alice Janet Chris)
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 2;
   list = "Judy Joyce Jane Alice Janet Chris";
   output;
   example = 2;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

 
%* Example 3: Sort all words in the text string (comma): ;
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy Joyce Jane Alice Janet Chris)
    , out_dlm = COMMA
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 3;
   list = "Judy Joyce Jane Alice Janet Chris";
   output;
   example = 3;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

 
%* Example 4: Sort all words in the text string (quoted): ;
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy, Joyce, Jane, Alice, Janet, Chris)
    , quoted  = Y
    , in_dlm  = C
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 4;
   list = "Judy, Joyce, Jane, Alice, Janet, Chris";
   output;
   example = 4;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

 
%* Example 5: Sort all words in the text string (quoted,comma): ;
%let list =
   %m_utl_sort_elems(
      list    = %str(Judy, Joyce, Jane, Alice, Janet, Chris)
    , quoted  = Y
    , in_dlm  = C
    , out_dlm = C
    , debug   = Y
      );

data WORK.result;
   length example 8 list $50.;
   example = 5;
   list = "Judy, Joyce, Jane, Alice, Janet, Chris";
   output;
   example = 5;
   list = "&list.";
   output;
run;

proc print data=WORK.result;
run;

 
%* Example 6: Sort all numbers in the text string (comma): ;
%let str = %str(10 9 8 1 3 2 4 7 5 6);

data WORK.result;
   length example 8 list $50.;
   example = 6;
   list = "&str.";
   output;
   example = 6;
   list = "%m_utl_sort_elems(list=&str.,in_dlm=B,out_dlm=C)";
   output;
run;

proc print data=WORK.result;
run;

 
%* Example 7: Sort the text string in descending order (blank): ;
%let str = %str(10 9 8 1 3 2 4 7 5 6);

data WORK.result;
   length example 8 list $50.;
   example = 7;
   list = "&str.";
   output;
   example = 7;
   list = "%m_utl_sort_elems(list=&str.,in_dlm=B,mode=D)";
   output;
run;

proc print data=WORK.result;
run;

 
