/*!
 ******************************************************************************
 * \file       test_m_utl_chk_reserved_words.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2022-10-18 00:00:00
 * \version    22.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_chk_reserved_words.sas
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
%m_utl_chk_reserved_words(?)
 
%* Example 2: Create global macro variable M_RESERVED_WORDS containing the database reserved words list (global): ;
%m_utl_chk_reserved_words(
   global  = Y
 , varname = M_RESERVED_WORDS
 , debug   = Y
   );

%put &=M_RESERVED_WORDS.;

 
%* Example 3: Create a macro variable reserved_words containing the database reserved words list (inline): ;
%let reserved_words =
   %m_utl_chk_reserved_words(
    , debug   = Y
   );

%put &=reserved_words.;

 
