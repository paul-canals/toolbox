/*!
 ******************************************************************************
 * \file       test_m_utl_chk_table_exist.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-01-09 00:00:00
 * \version    21.1.01
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_table_exist.sas
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
%m_utl_chk_table_exist(?)
 
%* Example 2: Table exists and can be opened (RESULT=1): ;
%let tableExist =
   %m_utl_chk_table_exist(
      intable  = SASHELP.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

 
%* Example 3: Table does not exist (RESULT=0): ;
%let tableExist =
   %m_utl_chk_table_exist(
      intable  = WORK.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

 
%* Example 4: Table exists, but can not be opened (RESULT=-1): ;
lock SASHELP.class;

%let tableExist =
   %m_utl_chk_table_exist(
      intable  = SASHELP.class
    , show_err = Y
    , debug    = Y
      );

%put &=tableExist.;

lock SASHELP.class clear;

 
