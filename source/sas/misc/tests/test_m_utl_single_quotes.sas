/*!
 ******************************************************************************
 * \file       test_m_utl_single_quotes.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-07 00:00:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_single_quotes.sas
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
%m_utl_single_quotes(?)
 
%* Example 2: Select entry for Alice from Class dataset: ;
%let text=
   %m_utl_single_quotes(
      text  = Alice
    , debug = Y
      );

data WORK.class;
   set SASHELP.class;
   where Name eq &text.;
run;

proc print data=WORK.class;
run;

 
%* Example 3: Select all male names from Class dataset: ;
%let male=%quote(M);

data WORK.class;
   set SASHELP.class;
   where Sex eq %m_utl_single_quotes(text=&male.);
run;

proc print data=WORK.class;
run;

 
