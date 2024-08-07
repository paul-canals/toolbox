/*!
 ******************************************************************************
 * \file       test_m_test_execute_scripts.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-23 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_test_execute_scripts.sas
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
%m_test_execute_scripts(?)
 
%* Example 2: Execute the Toolbox test scripts: ;
%m_test_execute_scripts(
   src_path = %str(&APPL_TEST.)
 , log_path = %str(%sysfunc(getoption(WORK)))
 , prefix   = test_m_utl
 , print    = Y
 , debug    = N
   );
 
%* Example 3: Execute test scripts and output report by email: ;
%m_test_execute_scripts(
   src_path = %str(&APPL_TEST.)
 , log_path = %str(%sysfunc(getoption(WORK)))
 , contains = run
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
 
