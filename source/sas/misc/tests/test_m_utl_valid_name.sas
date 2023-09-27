/*!
 ******************************************************************************
 * \file       test_m_utl_valid_name.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:38:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_valid_name.sas
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
%m_utl_valid_name(?)
 
%* Example 2: Macro context remove "0" to circumvent illegal first character: ;
%let varname=
  %m_utl_valid_name(
     var   = 0COUNTRY
   , debug = Y
     );

%put &=varname.;

 
%* Example 3: Macro context add underscore to circumvent illegal first character: ;
%let varname=
  %m_utl_valid_name(
     var       = 0COUNTRY
   , chk_first = N
   , debug     = Y
     );

%put &=varname.;

 
%* Example 4: Macro context no change between IN_VAR and VARNAME: ;
%let varname=
  %m_utl_valid_name(
     var   = NO_CHANGE
   , debug = Y
     );

%put &=varname.;

 
%* Example 5: Datastep context no change between INVAR and OUTVAR: ;
data WORK.result;
   invar="NO_CHANGE";
   %m_utl_valid_name(
      in_var  = invar
    , out_var = outvar
    , context = D
    , debug   = Y
      );
run;

proc print data=WORK.result;
run;

 
%* Example 6: Datastep context convert INVAR to valid OUTVAR with BW_SPECIAL=Y: ;
data WORK.result;
   invar="/BIC/BA_1FTRAN";
   %m_utl_valid_name(
      in_var     = invar
    , out_var    = outvar
    , context    = D
    , bw_special = Y
    , chk_first  = N
    , debug      = Y
      );
run;

proc print data=WORK.result;
run;

 
%* Example 7: Datastep context convert INVAR to valid OUTVAR with BW_SPECIAL=N: ;
data WORK.result;
   invar="/BIC/BA_1FTRAN";
   %m_utl_valid_name(
      in_var  = invar
    , out_var = outvar
    , context = D
    , debug   = Y
      );
run;

proc print data=WORK.result;
run;

 
%* Example 8: Datastep context convert /BIC/class to valid SAS table name: ;
data WORK.%m_utl_valid_name(var=%nrstr(/BIC/class),chk_first=N);
   set SASHELP.class;
run;

proc print data=WORK._BIC_class;
run;

 
