/*!
 ******************************************************************************
 * \file       run_test_script_execution.sas
 * \ingroup    Scripts
 * \brief      Script to execute the toolbox SAS macro test scripts.
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
%macro run_test_script_execution(
   src_path = _NONE_
 , log_path = _NONE_
 , prefix   = %str(test_m)
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

   %m_test_execute_scripts(
      src_path = %str(&src_path.)
    , log_path = %str(&log_path.)
    , prefix   = &prefix.
    , print    = &print.
    , sendmail = &sendmail.
    , mailaddr = &mailaddr.
    , debug    = &debug.
      )

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

%mend run_test_script_execution;

%* Run toolbox test scripts: ;
%run_test_script_execution(
   src_path = &APPL_TEST.
 , log_path = &APPL_LOGS.
 , prefix   = test_
 , sendmail = N
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
