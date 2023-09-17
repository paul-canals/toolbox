/*!
 ******************************************************************************
 * \file       test_m_utl_nlobs.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:19
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_nlobs.sas
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
%m_utl_nlobs(?)
 
%* Example 2: Get number of records from an encrypted SAS dataset: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
   where Sex='F';
run;

%let numobs=
   %m_utl_nlobs(
      dataset = WORK.class(where=(Sex='F'))
    , creds   = %str(encryptkey=aespasskey)
    , debug   = Y
      );

%put NUMOBS=&numobs.;

data WORK.nlobs;
   table='WORK.class';
   sex='F';
   nlobs=&numobs.;
run;

proc print data=WORK.nlobs noobs;
run;
 
%* Example 3: Get number of records from dataset with where statement: ;
data WORK.nlobs;
   table='SASHELP.class';
   age_over_13=
      %m_utl_nlobs(
         dataset = SASHELP.class(where=(Age > 13))
       , debug   = Y
         );
run;

proc print data=WORK.nlobs noobs;
run;
 
%* Example 4: Get number of records from a SAPBW table: ;
%let numobs=
   %m_utl_nlobs(
      table = SAPBW.T000
    , debug = Y
      );

%put NUMOBS=&numobs.;
 
