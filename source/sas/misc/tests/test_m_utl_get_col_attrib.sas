/*!
 ******************************************************************************
 * \file       test_m_utl_get_col_attrib.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-26 15:37:24
 * \version    20.1.12
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_get_col_attrib.sas
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
%m_utl_get_col_attrib(?)
 
%* Example 2: Data step style - Add some column labels and formats to the attribute info: ;
proc print data=SASHELP.class(obs=1) noobs label;
run;

data WORK.class;
   attrib
      %m_utl_get_col_attrib(table=SASHELP.class,col_name=Name,debug=Y) label='Student'
      %m_utl_get_col_attrib(table=SASHELP.class,col_name=Sex,debug=Y) label='Gender'
      %m_utl_get_col_attrib(table=SASHELP.class,col_name=Age,debug=Y) label='Age'
      %m_utl_get_col_attrib(table=SASHELP.class,col_name=Height,debug=Y) format=8.2
      %m_utl_get_col_attrib(table=SASHELP.class,col_name=Weight,debug=Y) format=8.2
      ;
   set SASHELP.class;
run;

proc print data=WORK.class(obs=1) noobs label;
run;

 
%* Example 3: Proc SQL style - Add some column labels and formats to the attribute info: ;
proc print data=SASHELP.class(obs=1) noobs label;
run;

proc sql noprint;
   create table WORK.class as
   select %m_utl_get_col_attrib(table=SASHELP.class,type=SQL,col_name=Name,debug=Y) label='Student'
        , %m_utl_get_col_attrib(table=SASHELP.class,type=SQL,col_name=Sex,debug=Y) label='Gender'
        , %m_utl_get_col_attrib(table=SASHELP.class,type=SQL,col_name=Age,debug=Y) label='Age'
        , %m_utl_get_col_attrib(table=SASHELP.class,type=SQL,col_name=Height,debug=Y) format=8.2
        , %m_utl_get_col_attrib(table=SASHELP.class,type=SQL,col_name=Weight,debug=Y) format=8.2
    from SASHELP.class
   ;
quit;

proc print data=WORK.class(obs=1) noobs label;
run;

 
