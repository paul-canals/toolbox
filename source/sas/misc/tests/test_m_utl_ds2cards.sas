/*!
 ******************************************************************************
 * \file       test_m_utl_ds2cards.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:30
 * \version    22.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ds2cards.sas
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
%m_utl_ds2cards(?)
 
%* Example 2: Create cards statement for table SASHELP.class: ;
%m_utl_ds2cards(
   base_ds    = SASHELP.class
 , cards_file = %str(%sysfunc(getoption(WORK))/class.sas)
 , print      = Y
 , debug      = Y
   );
 
%* Example 3: Create cards statement for table WORK.class: ;
%m_utl_ds2cards(
   base_ds    = SASHELP.class
 , out_lib    = WORK
 , cards_file = %str(%sysfunc(getoption(WORK))/class.sas)
 , print      = Y
 , debug      = Y
   );
 
