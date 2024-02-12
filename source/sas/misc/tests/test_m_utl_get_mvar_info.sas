/*!
 ******************************************************************************
 * \file       test_m_utl_get_mvar_info.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-10-21 00:00:00
 * \version    21.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_mvar_info.sas
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
%m_utl_get_mvar_info(?)
 
%* Example 2: Get the global SAS macro list containing all variables: ;
%m_utl_get_mvar_info(
   outlib = WORK
 , debug  = Y
   );
 
%* Example 3: Get the global SAS macro list containing only system variables: ;
%m_utl_get_mvar_info(
   scope  = AUTOMATIC
 , outlib = WORK
 , debug  = Y
   );
 
%* Example 4: Get the global SAS macro list containing only global variables: ;
%m_utl_get_mvar_info(
   scope  = GLOBAL
 , outlib = WORK
 , debug  = Y
   );
 
%* Example 5: Get the global SAS macro list with variable name prefix SYS: ;
%m_utl_get_mvar_info(
   prefix = SYS
 , outlib = WORK
 , debug  = Y
   );
 
%* Example 6: Get the global SAS macro list with mcro variables ending with NAME:: ;
%m_utl_get_mvar_info(
   contains = NAME
 , position = END
 , outlib   = WORK
 , debug    = Y
   );
 
