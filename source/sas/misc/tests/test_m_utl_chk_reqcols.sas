/*!
 ******************************************************************************
 * \file       test_m_utl_chk_reqcols.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-11-13 00:00:00
 * \version    23.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_reqcols.sas
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
%m_utl_chk_reqcols(?)
 
%* Example 2: Check required columns "Name Sex Age" against Class dataset: ;
%let found=
   %m_utl_chk_reqcols(
      table    = SASHELP.class
    , rcols    = Name Sex Age
    , msg_text = PID:&sysjobid.
    , msg_type = WNG
    , debug    = Y
      );

%put &=found.;

 
%* Example 3: Check required columns "Name School" against Class dataset: ;
%let found=
   %m_utl_chk_reqcols(
      table    = SASHELP.class
    , rcols    = Name School
    , msg_text = PID:&sysjobid.
    , msg_type = OK
    , debug    = Y
      );

%put &=found.;

 
