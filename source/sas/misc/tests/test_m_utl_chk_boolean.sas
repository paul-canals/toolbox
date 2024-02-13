/*!
 ******************************************************************************
 * \file       test_m_utl_chk_boolean.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-02-11 00:00:00
 * \version    24.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_boolean.sas
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
%m_utl_chk_boolean(?)
 
%* Example 2: Check boolean value for DEBUG=Y (German "J"): ;
%let debug =
   %m_utl_chk_boolean(
      bool  = %str(Ja)
    , debug = Y
      );

%put &=debug.;

 
%* Example 3: Check boolean value for DEBUG=N (Turkish "Hadir"): ;
%let debug =
   %m_utl_chk_boolean(
      bool  = %str(H)
    , debug = Y
      );

%put &=debug.;

 
%* Example 4: Convert true/false boolean value 1 to BOOL=Y: ;
%let bool =
   %m_utl_chk_boolean(
      bool  = 1
    , debug = Y
      );

%put &=bool.;

 
%* Example 5: Convert true/false boolean value 1 to BOOL=true: ;
%let bool =
   %m_utl_chk_boolean(
      bool    = 1
    , b_true  = true
    , b_false = false
    , debug   = Y
      );

%put &=bool.;

 
%* Example 6: Convert true/false boolean value true to BOOL=1: ;
%let debug = J;

%let bool =
   %m_utl_chk_boolean(
      bool    = true
    , b_true  = 1
    , b_false = 0
    , debug   = %m_utl_chk_bool(bool=&debug.)
      );

%put &=bool.;

 
