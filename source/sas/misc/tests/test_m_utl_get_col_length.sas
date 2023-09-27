/*!
 ******************************************************************************
 * \file       test_m_utl_get_col_length.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:26
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_col_length.sas
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
%m_utl_get_col_length(?)
 
%* Example 2: Obtain column length information for Actual column of the SASHELP.prdsale table: ;
data WORK.result;
   Table="SASHELP.prdsale";
   Column='Actual';
   Length="%m_utl_get_col_length(table=SASHELP.prdsale,col=Actual,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 3: Obtain column length information for Prodtype column of the SASHELP.prdsale table: ;
data WORK.result;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Length="%m_utl_get_col_length(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 4: Obtain column length information for Invioce column of the SASHELP.cars table: ;
data WORK.result;
   Table="SASHELP.cars";
   Column='Invoice';
   Length="%m_utl_get_col_length(table=SASHELP.cars,col=Invoice,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
