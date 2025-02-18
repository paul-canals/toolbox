/*!
 ******************************************************************************
 * \file       test_m_utl_get_col_format.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-23 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_col_format.sas
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha
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
%m_utl_get_col_format(?)
 
%* Example 2: Obtain column format information for Actual column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=2;
   Table="SASHELP.prdsale";
   Column='Actual';
   Format="%m_utl_get_col_format(table=SASHELP.prdsale,col=Actual,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 3: Obtain column format information for Prodtype column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=3;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Format="%m_utl_get_col_format(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 4: Obtain column format information for Invioce column of the SASHELP.cars table: ;
data WORK.result;
   Example=4;
   Table="SASHELP.cars";
   Column='Invoice';
   Format="%m_utl_get_col_format(table=SASHELP.cars,col=Invoice,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 5: Obtain column format information for Age column of the SASHELP.class table: ;
data WORK.result;
   Example=5;
   Table="SASHELP.class";
   Column='Age';
   Default='N';
   Decimals=0;
   Format="%m_utl_get_col_format(table=SASHELP.class,col=Age,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 6: Obtain column format information for Age column of the SASHELP.class table: ;
data WORK.result;
   Example=6;
   Table="SASHELP.class";
   Column='Age';
   Default='Y';
   Decimals=0;
   Format="%m_utl_get_col_format(table=SASHELP.class,col=Age,def=Y,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 7: Obtain column format information for Age column of the SASHELP.class table: ;
data WORK.result;
   Example=7;
   Table="SASHELP.class";
   Column='Age';
   Default='Y';
   Decimals=1;
   Format="%m_utl_get_col_format(table=SASHELP.class,col=Age,def=Y,dec=1,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
