/*!
 ******************************************************************************
 * \file       test_m_uc_describe_view.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-04-11 00:00:00
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_uc_describe_view.sas
 * 
 * \copyright  Copyright 2008-2021 Paul Alexander Canals y Trocha
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
%m_uc_describe_view(?)

%* For the next examples create a SAS data step and a proc sql type view: ;
data WORK._dsvview / view=WORK._dsvview;
   set SASHELP.class;
   where Sex eq "F";
run;

proc sql noprint;
   create view WORK._sqlview as
   select *
     from SASHELP.class as a
     left join SASHELP.classfit as b
       on a.name = b.name
    where upcase(a.sex) eq "M"
   ;
quit;

title "Example SAS data step and SQL type view list:";

proc print data=SASHELP.vview 
   (where=(upcase(libname) eq 'WORK')) label noobs;
run;

%* Example 2: Obtain SAS data step view type code description information: ;
%m_uc_describe_view(
   pathnm   = %sysfunc(getoption(WORK))/_dsvview.sas7bvew
 , libref   = TMP
 , outtbl   = WORK.dsv_p_result
 , print    = Y
 , debug    = N
   );

%* Example 3: Obtain SAS proc SQL view type code description information: ;
%m_uc_describe_view(
   pathnm   = %sysfunc(getoption(WORK))/_sqlview.sas7bvew
 , libref   = TMP
 , outtbl   = WORK.sql_p_result
 , print    = Y
 , debug    = N
   );

%* Example 4: Obtain SAS view description information from existing library: ;
%m_uc_describe_view(
   viewnm   = WORK._dsvview
 , libref   = TMP
 , outtbl   = WORK.dsv_l_result
 , print    = Y
 , debug    = N
   );

%* Example 5: Obtain SQL view description information from existing library: ;
%m_uc_describe_view(
   viewnm   = WORK._sqlview
 , libref   = TMP
 , outtbl   = WORK.sql_l_result
 , print    = Y
 , debug    = N
   );
