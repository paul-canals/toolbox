/*!
 ******************************************************************************
 * \file       test_m_utl_table_size.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:36
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_table_size.sas
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
%m_utl_table_size(?)
 
%* Example 2: Calculate the table size from an encrypted SAS dataset: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
   where Sex='F';
run;

%let table_size=
   %m_utl_table_size(
      table = WORK.class(where=(Sex='F'))
    , creds = %str(encryptkey=aespasskey)
    , debug = Y
      );

%put Table size of WORK.class is: &table_size. bytes;

data WORK.size;
   table='WORK.class';
   sex='F';
   size=&table_size.;
run;

proc print data=WORK.size noobs;
run;

 
%* Example 3: Calculate the table size from a SAS dataset with where statement: ;
data WORK.size;
   attrib table length=$32. label='Table';
   attrib size length=8 format=sizekmg12.1;
   table='SASHELP.class';
   size=%m_utl_table_size(
           table = SASHELP.class(where=(Age > 13))
         , debug = Y
           );
run;

proc print data=WORK.size noobs;
run;

 
%* Example 4: Calculate the formattted table size from a SAS dataset with where statement: ;
data WORK.size;
   table='SASHELP.class';
   size="%m_utl_table_size(
           table  = SASHELP.class(where=(Age > 13))
         , format = Y
         , debug  = Y
           )";
run;

proc print data=WORK.size noobs;
run;

 
%* Example 5: Calculate the table size for a table with 5.000.000 records: ;
%let table_size=
   %m_utl_table_size(
      data   = SASHELP.class
    , nrecs  = 5000000
    , format = Y
    , debug  = Y
      );

%put Table size for SASHELP.class with 5M records is: &table_size.;

 
