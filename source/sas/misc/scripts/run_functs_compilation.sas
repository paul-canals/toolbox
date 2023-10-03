/*!
 ******************************************************************************
 * \file       run_functs_compilation.sas
 * \ingroup    Scripts
 * \brief      Script to compile the toolbox functions into a function catalog.
 * \details    This script can be run in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-01 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha.
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
%macro run_functs_compilation(
   sas_path = _NONE_
 , cmp_path = _NONE_
 , cmp_lib  = _NONE_
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

   %m_adm_compile_functs(
      indir    = &sas_path.
    , outdir   = &cmp_path.
    , outlib   = &cmp_lib.
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

%mend run_functs_compilation;

%run_functs_compilation(
   sas_path = &APPL_FUNC.
 , cmp_path = &APPL_MCAT. 
 , cmp_lib  = WORK.functs.demo
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
