/*!
 ******************************************************************************
 * \file       test_m_utl_ods_output.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-30 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ods_output.sas
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
%m_utl_ods_output(?)
 
%* Example 2: Simple example of supressing PROC PRINT output to SAS ODS: ;
%m_utl_ods_output(mode=OFF);

proc print data=SASHELP.class label;
run;

%m_utl_ods_output(mode=SET);
 
%* Example 3: Supress PROC REG output to SAS ODS but allow data output: ;
%m_utl_ods_output(mode=OFF);

ods trace on;

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
   ods output close;
quit;

ods trace off;

%m_utl_ods_output(mode=SET);
 
%* Example 4: Supress and reset nested ODS output using tokens: ;
%m_utl_ods_output(mode=VIEW);

ods html;
ods pdf;

%m_utl_ods_output(mode=OFF);

%m_utl_ods_output(mode=VIEW);

ods html close;
ods pdf close;

%m_utl_ods_output(mode=OFF);

%m_utl_ods_output(mode=VIEW);

proc means data=SASHELP.class;
run;

%m_utl_ods_output(mode=SET);

%m_utl_ods_output(mode=RESET);

proc means data=SASHELP.class;
run;

%m_utl_ods_output(mode=VIEW);
 
