/*!
 ******************************************************************************
 * \file       test_m_utl_ds2txt.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-04-24 00:00:00
 * \version    24.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ds2txt.sas
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
%m_utl_ds2txt(?)
 
%* Example 2: Create a new TXT file from SASHELP.class: ;
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , engine   = DLM
 , debug    = Y
   );
 
%* Example 3: Create a TXT file from SASHELP.class with variable selection: ;
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , replace  = Y
 , labels   = Y
 , varlist  = %str(Name Sex Age)
 , debug    = Y
   );
 
%* Example 4: Create a TXT file with a tab as delimiter from SASHELP.class: ;
%m_utl_ds2txt(
   base_ds  = SASHELP.class
 , txt_file = %str(%sysfunc(getoption(WORK))/class.txt)
 , newfile  = Y
 , engine   = TAB
 , debug    = Y
   );
 
