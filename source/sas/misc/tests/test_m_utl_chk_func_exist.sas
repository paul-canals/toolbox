/*!
 ******************************************************************************
 * \file       test_m_utl_chk_func_exist.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:36:58
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_func_exist.sas
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
%m_utl_chk_func_exist(?)
 
%* For the next examples create a function library and functions: ;
options cmplib=WORK.functs;

proc fcmp outlib=WORK.functs.examples;
   function year_of_birth(age);
      birth_year = year(date())-age;
      return(birth_year);
   endsub;
quit;
 
%* Example 2: check if the function Day_of_Birth exists (Result=0): ;
%let function_exist =
   %m_utl_chk_func_exist(
      fname = Day_of_Birth
    , flib  = WORK.functs
    , debug = Y
      );

%put &=function_exist.;

 
%* Example 3: check if the function Month_of_Birth exists (Result=0): ;
%m_utl_chk_func_exist(
   fname      = Month_of_birth
 , flib       = WORK.functs
 , global_flg = Y
 , mvar_match = func_exist
 , debug      = Y
   );

%put &=func_exist.;

 
%* Example 4: check if the function Year_of_Birth exists (Result=1): ;
%m_utl_chk_func_exist(
   function   = Year_of_birth
 , library    = WORK.functs
 , global_flg = Y
 , mvar_match = func_exist
 , debug      = Y
   );

%put &=func_exist.;

 
