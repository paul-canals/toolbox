/*!
 ******************************************************************************
 * \file       test_m_hdr_gen_documents.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-30 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_hdr_gen_documents.sas
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
%m_hdr_gen_documents(?)
 
%* Example 2: Generate MD documentation into temporary folder in WORK: ;
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = MD
 , doc_image   = %str(../../misc/images/doc_banner.png)
 , print       = Y
 , debug       = N
   );
 
%* Example 3: Generate PDF documentation into temporary folder in WORK: ;
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = PDF
 , doc_title   = SAS PDF Documentation Reference
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS Documentation
 , print       = Y
 , debug       = N
   );
 
%* Example 4: Generate consolidated RTF documentation with cover in WORK: ;
%m_hdr_gen_documents(
   in_dir      = %str(&APPL_PRGM.)
 , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
 , doc_type    = RTF
 , doc_image   = %str(&APPL_BASE./misc/images/toolbox.jpg)
 , doc_name    = %str(Reference Manual)
 , doc_title   = %str(Paul%'s SAS Macro Utility Toolbox)
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS Documentation
 , append      = Y
 , print       = Y
 , debug       = N
   );
 
%* Example 5: Generate consolidated RTF documentation and output report by email: ;
*%m_hdr_gen_documents(
*   in_dir      = %str(&APPL_PRGM.)
* , out_dir     = %str(%sysfunc(getoption(WORK))/misc/docs)
* , doc_type    = RTF
* , doc_title   = SAS RTF Documentation Reference
* , doc_author  = Paul Alexander Canals y Trocha
* , doc_subject = Generated SAS Documentation
* , sendmail    = Y
* , mailaddr    = %str(pact@hermes.local)
* , debug       = N
*   );
 
