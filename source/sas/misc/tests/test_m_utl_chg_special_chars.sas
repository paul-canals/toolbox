/*!
 ******************************************************************************
 * \file       test_m_utl_chg_special_chars.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:05
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chg_special_chars.sas
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
%m_utl_chg_special_chars(?)
 
%* Example 2: Replace special characters (SAS datastep context): ;
proc print data=SASHELP.class;
   where name = 'Janet';
run;

data WORK.class;
   set SASHELP.class;
   if name eq 'Janet'
      then name=tranwrd(name,'a','ä');
run;

proc print data=WORK.class;
   where name = 'Jänet';
run;

data WORK.class_replaced;
   set WORK.class;
   name=%m_utl_chg_special_chars(colnm=name,context=D,debug=Y);
run;

proc print data=WORK.class_replaced;
   where name = 'Jaenet';
run;
 
%* Example 3: Replace special characters (SAS macro context): ;
%let string = Jänet iß a female stüdent;

%let result=
   %m_utl_chg_special_chars(
      in_var  = &string.
    , context = M
    , debug   = Y
      );
%put &=result.;
 
%* Example 3: Replace special characters (SAS datastep context): ;
%let result=;
data _null_;
   string = "Jänet iß a female stüdent";
   call symput('result', %m_utl_chg_special_chars(colnm=string,context=M,debug=Y));
run;
%put &=result.;
 
