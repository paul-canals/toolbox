/*!
 ******************************************************************************
 * \file       test_m_utl_reg_table_meta.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-11-21 00:00:00
 * \version    23.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_reg_table_meta.sas
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
%m_utl_reg_table_meta(?)
 
%* For the next examples create a view in library SASApp - SASDATA: ;
data SASDATA.class /view=SASDATA.class;
   set SASHELP.class;
run;
 
%* Example 2: Check if the SAS view CLASS is registered in metadata: ;
%m_utl_reg_table_meta(
   libnm = SASApp - SASDATA
 , tblnm = class
 , match = Y
 , check = Y
 , debug = Y
   )
 
%* Example 3: Register the SAS view CLASS into user metadata folder: ;
%m_utl_reg_table_meta(
   libnm  = SASApp - SASDATA
 , tblnm  = class
 , folder = /User Folders/&sysuserid./&M_MYFOLDER.
 , print  = Y
 , debug  = Y
   )

libname TMP meta liburi="SASLibrary?@name='SASAPP - SASDATA'";

proc print data=TMP.class label noobs;
run;

libname TMP clear;
 
