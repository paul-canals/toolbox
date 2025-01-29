/*!
 ******************************************************************************
 * \file       test_m_utl_ods_trace.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-21 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_ods_trace.sas
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
%m_utl_ods_trace(?)
 
%* Example 2: Shows the names of the output objects that a procedure creates: ;
%m_utl_ods_trace(mode=ON, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
 
%* Example 3: Shows the names and lables of the output objects that a procedure creates: ;
%m_utl_ods_trace(mode=ON, label=Y, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
 
%* Example 4: Write the names and lables of the output objects to the LISTING output: ;
%m_utl_ods_trace(mode=ON, label=Y, listing=Y, debug=N);

proc reg data=SASHELP.cars plots=none;
   model Horsepower = EngineSize weight;
   ods output ParameterEstimates = WORK.stats;
quit;

%m_utl_ods_trace(mode=OFF);
 
