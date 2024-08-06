/*!
 ******************************************************************************
 * \file       test_m_utl_fmtinfo.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-05-05 00:00:00
 * \version    24.1.05
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_fmtinfo.sas
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
%m_utl_fmtinfo(?)
 
%* Example 2: Check the format category type value for DATE9.: ;
%let fmtcat =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = CAT
    , debug  = Y
      );

%put &=fmtcat.;

 
%* Example 3: Check the given format value is valid for DATE9.: ;
%let fmtcat =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = CHK
      );

%put &=fmtcat.;

 
%* Example 4: Check the format or informat type value for DATE9.: ;
%let fmttype =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = TYPE
      );

%put &=fmttype.;

 
%* Example 5: Check the format or informat description for DATE9.: ;
%let fmtdesc =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DESC
      );

%put &=fmtdesc.;

 
%* Example 6: Check the default width information for DATE9.: ;
%let fmtdefw =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DEFW
      );

%put &=fmtdefw.;

 
%* Example 7: Check the default decimal information for DATE9.: ;
%let fmtdefd =
   %m_utl_fmtinfo(
      format = DATE9.
    , type   = DEFD
      );

%put &=fmtdefd.;

 
