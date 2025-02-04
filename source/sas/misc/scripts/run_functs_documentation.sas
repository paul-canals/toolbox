/*!
 ******************************************************************************
 * \file       run_functs_documentation.sas
 * \ingroup    Scripts
 * \brief      Script to generate the toolbox SAS functions documentation.
 * \details    This script can be run in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2025-02-04 00:00:00
 * \version    25.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha.
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
%macro run_functs_documentation(
   sas_path    = _NONE_
 , doc_path    = _NONE_
 , exc_lst     = %str(\note \todo \warning)
 , doc_type    = RTF
 , doc_image   = 
 , doc_name    = reference
 , doc_title   = 
 , doc_author  = 
 , doc_subject = 
 , append      = N
 , prefix      = %str()
 , contains    = %str()
 , print       = Y
 , sendmail    = N
 , mailaddr    = %str()
 , debug       = N 
   );

   %* If debug mode, start macro trace: ;
   %if %upcase(&debug.) eq Y %then %do;
      %m_utl_print_mtrace(start)
   %end;

   %local token;

   %* Generate unique token number: ;
   %let token = %m_utl_unique_number(debug=&debug.);

   %* Set system logging options: ;
   %m_log_set_options(
      mode  = %sysfunc(ifc(%upcase(&debug.) eq Y,DEBUG,NOTES))
    , token = &token.
    , debug = &debug.
      )

   options fullstimer;

   %m_hdr_gen_documents(
      in_dir      = %str(&sas_path.)
    , out_dir     = %str(&doc_path./%lowcase(&doc_type.))
    , exc_lst     = &exc_lst.
    , doc_type    = &doc_type.
    , doc_image   = &doc_image.
    , doc_name    = &doc_name.
    , doc_title   = &doc_title.
    , doc_author  = &doc_author.
    , doc_subject = &doc_subject.
    , append      = &append.
    , prefix      = &prefix.
    , contains    = &contains.
    , print       = &print.
    , sendmail    = &sendmail.
    , mailaddr    = &mailaddr.
    , debug       = &debug.
      );

   options nofullstimer;

   %* Reset system logging options: ;
   %m_log_set_options(
      mode  = RESET
    , token = &token.
    , debug = &debug.
      )

   %put _global_;

   %* If debug mode, finish macro trace: ;
   %if %upcase(&debug.) eq Y %then %do;
      %m_utl_print_mtrace(end)
   %end;

%mend run_functs_documentation;

/* Default Markdown Documentation */
%run_functs_documentation(
   sas_path    = &APPL_FUNC.
 , doc_path    = &APPL_DOCS.
 , exc_lst     = %str(\note \todo \warning)
 , doc_type    = MD
 , doc_image   = ../../misc/images/doc_header.png
 , doc_title   = %str(Paul%'s SAS Macro Utility Toolbox)
 , doc_author  = Paul Alexander Canals y Trocha
 , doc_subject = Generated SAS Documentation
 , prefix      = %str(f_)
 , debug       = N
   );
