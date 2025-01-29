/*!
 ******************************************************************************
 * \file       test_m_hdr_crt_rtf_file.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \author     Dr. Simone Kossmann (simone.kossmann@web.de)
 * \date       2024-08-03 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_hdr_crt_rtf_file.sas
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
%m_hdr_crt_rtf_file(?)
 
%* Example 2: Create macro RTF documentation including optional commands: ;
%m_hdr_crt_rtf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_rtf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/m_hdr_crt_rtf_file.rtf)
 , opt_lst  = %str(\note \todo \warning)
 , debug    = N
   )
 
%* Example 3: Create macro RTF documentation with optional information: ;
%m_hdr_crt_rtf_file(
   in_file     = %str(&APPL_PRGM./m_hdr_crt_rtf_file.sas)
 , out_file    = %str(%sysfunc(getoption(WORK))/m_hdr_crt_rtf_file.rtf)
 , doc_title   = RTF Toolbox Document
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS RTF documentation
 , debug       = N
   )
 
%* Example 4: Create a concatenated macro RTF documentation file: ;
ods escapechar='~';
ods rtf file = "%sysfunc(getoption(WORK))/toolbox.rtf"
   title     = "Paul's SAS Macro Utility Toolbox Documentation"
   author    = "Paul Alexander Canals y Trocha"
   operator  = "Generated SAS macro RTF documentation"
   style     = styles.htmlblue
   startpage = never
   ;

%m_hdr_crt_rtf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_gen_pdf_doc.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.rtf)
 , append   = Y
 , debug    = N
   )

%m_hdr_crt_rtf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_rtf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.rtf)
 , append   = Y
 , debug    = N
   )

ods rtf close;
 
