/*!
 ******************************************************************************
 * \file       test_m_utl_print_message.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:22
 * \version    20.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_print_message.sas
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
%m_utl_print_message(?)
 
%* Example 2: Print a successful message to the result output: ;
%m_utl_print_message(
   program = &sysmacroname.
 , status  = OK
 , message = %quote(Macro &sysmacroname. has run successfully.)
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: Print a warning message to the log: ;
%m_utl_print_message(
   program = &sysmacroname.
 , status  = WNG
 , message = %quote(Macro &sysmacroname. has ended with warnings!)
 , debug   = Y
   );
 
%* Example 4: Print an error message to the result output: ;
%m_utl_print_message(
   program = &sysmacroname.
 , status  = ERR
 , message = %quote(Macro &sysmacroname. has ended with errors!)
 , print   = Y
 , debug   = Y
   );
 