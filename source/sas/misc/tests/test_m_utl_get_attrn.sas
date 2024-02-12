/*!
 ******************************************************************************
 * \file       test_m_utl_get_attrn.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-07 00:00:00
 * \version    20.1.07
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_attrn.sas
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
%m_utl_get_attrn(?)
 
%* Example 2: Get the number of observations in a SAS dataset (ignores WHERE statement): ;
%let numobs =
   %m_utl_get_attrn(
      intable = SASHELP.class (where=(Sex eq 'F'))
    , attr_nm = NLOBS
    , debug   = Y
      );

%put &=numobs.;

 
%* Example 3: Get the number of columns in a SAS dataset: ;
%let numcols =
   %m_utl_get_attrn(
      intable = SASHELP.class
    , attr_nm = NVARS
    , debug   = Y
      );

%put &=numcols.;

 
%* Example 4: Check if the SAS dataset is password protected: ;
%let pwdexist =
   %m_utl_get_attrn(
      intable = SASHELP.class
    , attr_nm = PW
    , debug   = Y
      );

%put &=pwdexist.;

data WORK.class (pw=password);
   set SASHELP.class;
run;

%let pwdexist =
   %m_utl_get_attrn(
      intable = WORK.class (pw=password)
    , attr_nm = PW
    , debug   = Y
      );

%put &=pwdexist.;

proc datasets lib=WORK nolist nowarn;
   modify class(pw=password/);
   delete class;
quit;

 
