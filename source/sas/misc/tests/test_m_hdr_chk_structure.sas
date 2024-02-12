/*!
 ******************************************************************************
 * \file       test_m_hdr_chk_structure.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \date        
 * \version     
 * \author      
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_hdr_chk_structure.sas
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
%m_hdr_chk_structure(?)
 
%* Example 2: Check header syntax and print a result summary report in html: ;
%m_hdr_chk_structure(
   in_file = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , print   = Y
 , debug   = N
   );
 
%* Example 3: Check header syntax and mail a result summary report in pdf format: ;
%m_hdr_chk_structure(
   in_file  = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
 
%* Example 4: Check header syntax and save the result summary in library WORK: ;
%m_hdr_chk_structure(
   in_file = %str(&APPL_PRGM./m_hdr_chk_structure.sas)
 , out_tbl = WORK.header_result
 , print   = N
 , debug   = N
   );
 
