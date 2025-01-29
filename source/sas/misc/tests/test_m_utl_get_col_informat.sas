/*!
 ******************************************************************************
 * \file       test_m_utl_get_col_informat.sas
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
 *             + m_utl_get_col_informat.sas
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
%m_utl_get_col_informat(?)
 
%* Example 2: Obtain column informat information for Monyr column of the SASHELP.prdsal2 table: ;
data WORK.result;
   Example=2;
   Table="SASHELP.prdsal2";
   Column='Monyr';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsal2,col=Monyr,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 3: Obtain column informat information for Prodtype column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=3;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Default='N';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Prodtype,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 4: Obtain column informat information for Prodtype column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=4;
   Table="SASHELP.prdsale";
   Column='Prodtype';
   Default='Y';
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Prodtype,def=Y,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 5: Obtain column informat information for Actual column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=5;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='N';
   Decimals=0;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 6: Obtain column informat information for Actual column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=6;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='Y';
   Decimals=0;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,def=Y,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 7: Obtain column informat information for Actual column of the SASHELP.prdsale table: ;
data WORK.result;
   Example=7;
   Table="SASHELP.prdsale";
   Column='Actual';
   Default='Y';
   Decimals=2;
   Informat="%m_utl_get_col_informat(table=SASHELP.prdsale,col=Actual,def=Y,dec=2,debug=Y)";
   output;
run;

proc print data=WORK.result noobs;
run;

 
