/*!
 ******************************************************************************
 * \file       test_m_utl_mstore_drop.sas
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
 *             + m_utl_mstore_drop.sas
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
%m_utl_mstore_drop(?)
 
%* Example 2: Step 1 - Copy the contents of SASHELP core macro catalog: ;
libname TMP "%sysfunc(pathname(SASROOT))/core/sashelp";

proc catalog cat=TMP.sasmacr force;
   copy out=WORK.sasmacr;
   run;
   contents;
   run;
quit;
 
%* Example 2: Step 2 - Delete a member from the copied macro catalog: ;
%m_utl_mstore_drop(
   indir = %sysfunc(getoption(WORK))
 , entry = AARFM_EXEC
 , print = Y
 , debug = Y
   );
 
