/*!
 ******************************************************************************
 * \file       run_macro_compilation.sas
 * \ingroup    Scripts
 * \brief      Script to compile the toolbox macros into a SAS macro catalog.
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
%macro run_macro_compilation(
   sas_path = _NONE_
 , cat_path = _NONE_
 , prefix   = %str()
 , contains = %str()
 , print    = Y
 , sendmail = N
 , mailaddr = %str()
 , debug    = N 
   );

   %* If debug mode, start macro trace: ;
   %if %upcase(&debug.) eq Y %then %do;
      %m_utl_print_mtrace(start)
   %end;

   options fullstimer;

   %* Include macro compilation macros: ;
   %include "&sas_path./m_adm_compile_macros.sas";
   %include "&sas_path./m_utl_mstore_add.sas";
   %include "&sas_path./m_utl_mstore_view.sas";

   %m_adm_compile_macros(
      indir    = &sas_path.
    , outdir   = &cat_path.
    , prefix   = &prefix.
    , contains = &contains.
    , print    = &print.
    , sendmail = &sendmail.
    , mailaddr = &mailaddr.
    , debug    = &debug.
      );

   options nofullstimer;

   %put _global_;

   %* If debug mode, finish macro trace: ;
   %if %upcase(&debug.) eq Y %then %do;
      %m_utl_print_mtrace(end)
   %end;

%mend run_macro_compilation;

%run_macro_compilation(
   sas_path = &APPL_PRGM.
 , cat_path = &APPL_MCAT. 
 , prefix   = %str(m_utl_)
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
