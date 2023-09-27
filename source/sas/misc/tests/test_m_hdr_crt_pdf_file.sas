/*!
 ******************************************************************************
 * \file       test_m_hdr_crt_pdf_file.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \author     Dr. Simone Kossmann (simone.kossmann@web.de)
 * \date       2023-09-26 15:36:38
 * \version    21.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_hdr_crt_pdf_file.sas
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
%m_hdr_crt_pdf_file(?)
 
%* Example 2: Create macro PDF documentation including optional commands: ;
%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/m_hdr_crt_pdf_file.pdf)
 , opt_lst  = %str(\note \todo \warning)
 , debug    = N
   )
 
%* Example 3: Create macro PDF documentation with optional information: ;
%m_hdr_crt_pdf_file(
   in_file     = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file    = %str(%sysfunc(getoption(WORK))/m_hdr_crt_pdf_file.pdf)
 , doc_title   = PDF Toolbox Document
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS PDF documentation
 , debug       = N
   )
 
%* Example 4: Create a concatenated macro PDF documentation file: ;
ods escapechar='~';
ods pdf file = "%sysfunc(getoption(WORK))/toolbox.pdf"
   title     = "Paul's SAS Macro Utility Toolbox Documentation"
   author    = "Paul Alexander Canals y Trocha"
   subject   = "Generated SAS macro PDF documentation"
   keywords  = "SAS Macro Program Documentation"
   style     = styles.htmlblue
   startpage = never
   ;

%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_crt_pdf_file.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.pdf)
 , append   = Y
 , debug    = N
   )

%m_hdr_crt_pdf_file(
   in_file  = %str(&APPL_PRGM./m_hdr_gen_rtf_doc.sas)
 , out_file = %str(%sysfunc(getoption(WORK))/toolbox.pdf)
 , append   = Y
 , debug    = N
   )

ods pdf close;
 
