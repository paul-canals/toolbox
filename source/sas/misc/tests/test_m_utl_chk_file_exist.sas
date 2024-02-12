/*!
 ******************************************************************************
 * \file       test_m_utl_chk_file_exist.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-07 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_file_exist.sas
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
%m_utl_chk_file_exist(?)
 
%* Example 2: File exists and can be opened (RESULT=1): ;
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(pathname(sasroot))/sasv9.cfg
    , show_err = Y
    , debug    = Y
      );

%put &=fileExist.;

 
%* Example 3: File does not exist (RESULT=0): ;
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(pathname(sasroot))/sasv8.cfg
    , show_err = N
    , debug    = Y
      );

%put &=fileExist.;

 
%* Example 4: File exists, but can not be opened (RESULT=-1): ;
%let fileExist =
   %m_utl_chk_file_exist(
      infile   = %sysfunc(getoption(WORK))/sasgopt.sas7bcat
    , show_err = N
    , debug    = Y
      );

%put &=fileExist.;

 
