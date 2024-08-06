/*!
 ******************************************************************************
 * \file       test_m_utl_get_attrc.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-04-13 00:00:00
 * \version    24.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_attrc.sas
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
%m_utl_get_attrc(?)
 
%* Example 2: Get the library name of a SAS dataset: ;
%let libref =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = LIB
    , debug   = Y
      );

%put &=libref.;

 
%* Example 3: Get the data type of a SAS dataset: ;
%let datatype =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = TYPE
    , debug   = Y
      );

%put &=datatype.;

 
%* Example 4: Check if the SAS dataset is encrypted: ;
%let encrypted =
   %m_utl_get_attrc(
      table   = SASHELP.class
    , attr_nm = ENCRYPT
    , debug   = Y
      );

%put &=encrypted.;

data WORK.class (encrypt=aes encryptkey=passkey);
   set SASHELP.class;
run;

%let encrypted =
   %m_utl_get_attrc(
      table   = WORK.class (encryptkey=passkey)
    , attr_nm = ENCRYPT
    , debug   = Y
      );

%put &=encrypted.;

proc datasets lib=WORK nolist nowarn;
   delete class;
quit;

 
