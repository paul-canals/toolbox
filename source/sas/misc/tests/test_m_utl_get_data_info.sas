/*!
 ******************************************************************************
 * \file       test_m_utl_get_data_info.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:28
 * \version    21.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_data_info.sas
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
%m_utl_get_data_info(?)
 
%* Example 2: Get the data library list containing all libnames: ;
%m_utl_get_data_info(
   outlib = WORK
 , debug  = Y
   );
 
%* Example 3: Get the data library list containing libnames with HELP: ;
%m_utl_get_data_info(
   contains = HELP
 , position = END
 , outlib   = WORK
 , debug    = Y
   );
 
%* Example 4: Get the data library list containing libnames with SAS or WORK: ;
%m_utl_get_data_info(
   contains = SAS Work
 , outlib   = WORK
 , debug    = Y
   );
 
%* Example 5: Get the data library list containing libnames with prefix SAS: ;
%m_utl_get_data_info(
   prefix = SAS
 , outlib = WORK
 , debug  = Y
   );
 
