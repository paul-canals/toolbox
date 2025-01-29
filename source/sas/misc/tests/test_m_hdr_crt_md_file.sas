/*!
 ******************************************************************************
 * \file       test_m_hdr_crt_md_file.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-31 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_hdr_crt_md_file.sas
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
%m_hdr_crt_md_file(?)
 
%* Example 2: Create a macro Markdown documentation with default settings: ;
%m_hdr_crt_md_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_md_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/m_hdr_crt_md_file.md)
 , debug    = N
   )
 
%* Example 3: Create a macro Markdown documentation with optional settings: ;
%m_hdr_crt_md_file(
   in_file   = %str(&APPL_PRGM./m_hdr_crt_md_file.sas)
 , out_file  = %str(%sysfunc(getoption(WORK))/m_hdr_crt_md_file.md)
 , opt_lst   = %str(\note \todo \warning)
 , doc_image = %str(../misc/images/doc_banner.png)
 , debug     = N
   )
 
