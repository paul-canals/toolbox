/*!
 ******************************************************************************
 * \file       test_m_utl_set_parameter.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-30 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_set_parameter.sas
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
%m_utl_set_parameter(?)
 
%* Example 2 - Step 1: Create macro variable parameter table: ;
data WORK.params;
   attrib
      PARAM_ENV    length=$3    label='Environment'
      PARAM_NAME   length=$32   label='Name'
      PARAM_VALUE  length=$100  label='Value'
      PARAM_TYPE   length=$4    label='Type'
      PARAM_TEXT   length=$100  label='Description'
      MACRO_FLG    length=8     label='Active Flag'
      ;
   * Date Function;
   PARAM_ENV   = "ALL";
   PARAM_NAME  = "X_TODAY_FUNC";
   PARAM_VALUE = "date()";
   PARAM_TYPE  = "FUNC";
   PARAM_TEXT  = "Represents today in numerical string";
   MACRO_FLG   = 1;
   output;
   * Date Type with date() input;
   PARAM_ENV   = "ALL";
   PARAM_NAME  = "X_TODAY_DATE";
   PARAM_VALUE = "date()";
   PARAM_TYPE  = "DATE";
   PARAM_TEXT  = "Represents today in date format";
   MACRO_FLG   = 1;
   output;
   * Date Type with 31dec2016 input;
   PARAM_ENV   = "ALL";
   PARAM_NAME  = "X_DAY_DATE";
   PARAM_VALUE = "31dec2016";
   PARAM_TYPE  = "DATE";
   PARAM_TEXT  = "Represents today in date format";
   MACRO_FLG   = 1;
   output;
   * List Character Type;
   PARAM_ENV   = "ALL";
   PARAM_NAME  = "X_WEEKEND_LIST";
   PARAM_VALUE = "Saturday";
   PARAM_TYPE  = "CHAR";
   PARAM_TEXT  = "Represents the weekend day names";
   MACRO_FLG   = 1;
   output;
   PARAM_ENV   = "ALL";
   PARAM_NAME  = "X_WEEKEND_LIST";
   PARAM_VALUE = "Sunday";
   PARAM_TYPE  = "CHAR";
   PARAM_TEXT  = "Represents the weekend day names";
   MACRO_FLG   = 1;
   output;
run;
 
%* Example 2 - Step 2: Register macro variables from params table: ;
%m_utl_set_parameter(
   infile = WORK.params
 , intype = TBL
 , inhost =
 , prmenv = PARAM_ENV
 , prmvar = PARAM_NAME
 , prmval = PARAM_VALUE
 , prmtyp = PARAM_TYPE
 , prmtxt = PARAM_TEXT
 , prmflg = MACRO_FLG
 , debug  = N
   );
 
%* Example 2 - Step 3: Check registered macro variables in log: ;
%put &=X_TODAY_FUNC.;
%put &=X_TODAY_DATE.;
%put &=X_DAY_DATE.;
%put &=X_WEEKEND_LIST.;
 
