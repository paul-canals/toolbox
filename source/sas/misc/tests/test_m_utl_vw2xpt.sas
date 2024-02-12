/*!
 ******************************************************************************
 * \file       test_m_utl_vw2xpt.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-09-07 00:00:00
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_vw2xpt.sas
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
%m_utl_vw2xpt(?)
 
%* Example 2: Create a XPT transport file from a SAS data step view: ;
data WORK._dsvview / view=WORK._dsvview;
   set SASHELP.class;
   where Sex eq "F";
run;

%m_utl_vw2xpt(
   base_vw  = WORK._dsvview
 , xpt_file = %str(%sysfunc(getoption(WORK))/dsvview.xpt)
 , format   = AUTO
 , debug    = Y
   );

filename class "%sysfunc(getoption(WORK))/dsvview.xpt";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
%* Example 3: Create a XPT transport file from a SAS SQL view: ;
proc sql noprint;
   create view WORK._sqlview as
   select *
     from SASHELP.class
    where Sex eq "M"
   ;
quit;

%m_utl_vw2xpt(
   base_vw  = WORK._sqlview
 , xpt_file = %str(%sysfunc(getoption(WORK))/sqlview.xpt)
 , format   = AUTO
 , debug    = Y
   );

filename class "%sysfunc(getoption(WORK))/sqlview.xpt";

data _null_;
   infile class;
   input;
   put _infile_;
run;

filename class clear;
 
