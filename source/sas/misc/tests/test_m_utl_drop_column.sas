/*!
 ******************************************************************************
 * \file       test_m_utl_drop_column.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:14
 * \version    23.1.07
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_drop_column.sas
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
%m_utl_drop_column(?)
 
%* Example 2: Drop a column from an encrypted SAS dataset: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
run;

%m_utl_drop_column(
   dblib = WORK
 , dbtbl = class
 , dbtyp = SAS
 , colnm = Weight
 , creds = %str(encryptkey=aespasskey)
 , debug = Y
   );

proc print data=WORK.class(encryptkey=aespasskey);
run;

 
%* Example 3: Drop a column from an Oracle table: ;
*libname ORADB oracle user=orademo pwd='ORApw123' path=XE schema=orademo;

*proc datasets lib=ORADB nolist nowarn;
*   delete class;
*quit;

*data ORADB.class;
*   set SASHELP.class;
*run;

*%m_utl_drop_column(
*   dblib = ORADB
* , dbtbl = CLASS
* , dbtyp = ORA
* , colnm = HEIGHT
* , creds = %str(user=orademo pwd=ORApw123 path=XE schema=orademo)
* , debug = Y
*   );

 
