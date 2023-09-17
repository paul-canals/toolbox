/*!
 ******************************************************************************
 * \file       test_m_adm_usage_report.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:48:35
 * \version    21.1.01
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_usage_report.sas
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
%m_adm_usage_report(?)
 
%* Example 2: Output to result destination: ;
%m_adm_usage_report(
   mslogs   = C:\SAS\Config\Lev1\Logs\MetadataServer
 , wslogs   = C:\SAS\Config\Lev1\Logs\ObjectSpawner
 , print    = Y
 , debug    = N
   );
 
%* Example 3: Output report by email: ;
%m_adm_usage_report(
   mslogs   = C:\SAS\Config\Lev1\Logs\MetadataServer
 , wslogs   = C:\SAS\Config\Lev1\Logs\ObjectSpawner
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
 
