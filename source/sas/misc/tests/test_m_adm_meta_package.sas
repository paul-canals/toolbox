/*!
 ******************************************************************************
 * \file       test_m_adm_meta_package.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-01 00:00:00
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_meta_package.sas
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
%m_adm_meta_package(?)
 
%* Create export parameter table and make package WIN batch file: ;
data WORK.makepkg_prm;
   order = 1;
   object='/Shared Data/';
   output;
   order = 2;
   object='/Shared Data/SASApp - SASDATA(Library)';
   output;
run;

%m_adm_meta_package(
   parm_tbl  = WORK.makepkg_prm
 , platform  = WIN
 , profile   = %str(pact@hermes.pact.sas.com)
 , packname  = shared_data.spk
 , packpath  = %str(&APPL_PRGM./source/sas/misc/meta)
 , outscript = %str(&USER_HOME./makepkg.bat)
 , debug     = N
   );
 
