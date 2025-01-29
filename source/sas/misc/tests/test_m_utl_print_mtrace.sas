/*!
 ******************************************************************************
 * \file       test_m_utl_print_mtrace.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-07 00:00:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_print_mtrace.sas
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha
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
%m_utl_print_mtrace(?)
 
%* Example 2: Print the macro execution trace with default values: ;
%macro main_macro;

   %macro sub_macro;

      %m_utl_print_mtrace(print=Y);

   %mend sub_macro;
   %sub_macro;

%mend main_macro;
%main_macro;
 
%* Example 3: Print the macro execution trace including all macros: ;
%macro main_macro;

   %m_utl_print_mtrace(
      point = 0
    , depth = 0
    , print = Y
      );

   %macro sub_macro;

      %m_utl_print_mtrace(
         point = 0
       , depth = 0
       , print = Y
         );

   %mend sub_macro;
   %sub_macro;

%mend main_macro;
%main_macro;
 
%* Example 4: Print the macro execution trace with start/end values: ;
%macro main_macro;

   %m_utl_print_mtrace(start)

   %macro sub_macro;

      %m_utl_print_mtrace(start)

      %put this is the submacro;

      %m_utl_print_mtrace(end)

   %mend sub_macro;
   %sub_macro;

   %m_utl_print_mtrace(end)

%mend main_macro;
%main_macro;
 
