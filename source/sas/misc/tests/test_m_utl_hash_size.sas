/*!
 ******************************************************************************
 * \file       test_m_utl_hash_size.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:10
 * \version    20.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_hash_size.sas
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
%m_utl_hash_size(?)
 
%* Example 2: Calculate the hash table size from an encrypted SAS dataset: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
   where Sex='F';
run;

%let hash_size=;

%m_utl_hash_size(
   data   = WORK.class(where=(Sex='F'))
 , creds  = %str(encryptkey=aespasskey)
 , result = hash_size
 , debug  = Y
   );

%put Hash table size of WORK.class is: &hash_size. bytes;

data WORK.size;
   table = 'WORK.class';
   sex   = 'F';
   size  = &hash_size.;
run;

proc print data=WORK.size noobs;
run;

 
%* Example 3: Calculate the hash table size from a SAS dataset with where statement: ;
proc print data=SASHELP.class(drop=Sex);
   where Age > 13;
run;

%let hash_size=;

%m_utl_hash_size(
   data   = SASHELP.class(where=(Age > 13))
 , kcols  = Name
 , dcols  = Age Weight Height
 , result = hash_size
 , debug  = Y
   );

%put Hash table size of SASHELP.class is: &hash_size. bytes;

data WORK.size;
   table = 'SASHELP.class';
   size  = &hash_size.;
run;

proc print data=WORK.size noobs;
run;
 
%* Example 4: Calculate the formattted hash table size from a SAS dataset with where statement: ;
proc print data=SASHELP.class;
   where Age > 13;
run;

%let hash_size=;

%m_utl_hash_size(
   data   = SASHELP.class(where=(Age > 13))
 , format = Y
 , result = hash_size
 , debug  = Y
   );

%put Hash table size of SASHELP.class is: &hash_size.;

data WORK.size;
   table = 'SASHELP.class';
   size = "&hash_size.";
run;

proc print data=WORK.size noobs;
run;
 
%* Example 5: Calculate the table size for a table with 5.000.000 records: ;
%let hash_size=;

%m_utl_hash_size(
   data   = SASHELP.class
 , nrecs  = 5000000
 , format = Y
 , result = hash_size
 , debug  = Y
   );

%put Hash table size for SASHELP.class with 5M records is: &hash_size.;
 
