/*!
 ******************************************************************************
 * \file       run_test_script_generation.sas
 * \ingroup    Scripts
 * \brief      Script to generate the toolbox SAS macro test scripts.
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
%macro run_test_script_generation(
   src_path = _NONE_
 , tgt_path = _NONE_
 , prefix   = %str()
 , print    = Y
 , sendmail = N
 , mailaddr = %str()
 , debug    = N 
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

   %m_test_generate_scripts(
      src_path = %str(&src_path.)
    , tgt_path = %str(&tgt_path.)
    , prefix   = &prefix.
    , print    = &print.
    , sendmail = &sendmail.
    , mailaddr = &mailaddr.
    , debug    = &debug.
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

%mend run_test_script_generation;

%* Create function test scripts: ;
%run_test_script_generation(
   src_path = &APPL_FUNC.
 , tgt_path = &APPL_TEST.
 , prefix   = %str(f_)
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );

%* Create macro test scripts: ;
%run_test_script_generation(
   src_path = &APPL_PRGM.
 , tgt_path = &APPL_TEST.
 , prefix   = %str(m_utl_)
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
