/*!
 ******************************************************************************
 * \file       test_m_cst_get_file_list.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-19 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_cst_get_file_list.sas
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
%m_cst_get_file_list(?)
 
%* Example 2: List files and dirs in current WORK directory: ;
%m_cst_get_file_list(
   rootdir = %sysfunc(getoption(WORK))
 , level   = 0
 , prefix  = src_
 , subdirs = Y
 , finfo   = Y
 , print   = Y
 , debug   = Y
   );
 
%* Example 3: List files and dirs in sasroot/maps directory: ;
%m_cst_get_file_list(
   rootdir = %sysget(SASROOT)/maps
 , prefix  = src_
 , subdirs = N
 , finfo   = Y
 , print   = Y
 , debug   = Y
   );
 
