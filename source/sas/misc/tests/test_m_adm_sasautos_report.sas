/*!
 ******************************************************************************
 * \file       test_m_adm_sasautos_report.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:48:32
 * \version    23.1.07
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_sasautos_report.sas
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
%m_adm_sasautos_report(?);
 
%* Example 2: Select all macros and create report list: ;
%m_adm_sasautos_report(
   work_flg    = Y
 , print       = Y
 , debug       = Y
   );
 
%* Example 3: Select compiled macros and create report: ;
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = COMP
 , print       = Y
   );
 
%* Example 4: Select duplicate macros and create report: ;
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = DUP
 , print       = Y
   );
 
%* Example 5: Select unique macros and send report by email: ;
%m_adm_sasautos_report(
   work_flg    = Y
 , select      = NODUP
 , sendmail    = Y
 , mailaddr    = %str(pact@hermes.local)
   );
 
