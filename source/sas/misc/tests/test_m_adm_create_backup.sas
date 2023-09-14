/*!
 ******************************************************************************
 * \file       test_m_adm_create_backup.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:48:24
 * \version    20.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_create_backup.sas
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
%m_adm_create_backup(?)
 
%* Example 2 - Step 1: Create a backup in sources.zip archive: ;
%m_adm_create_backup(
   src_path = C:/SAS/Data/toolbox/sasautos
 , tgt_path = C:/SAS/Data/toolbox/backup
 , tgt_file = sources
 , debug    = N
   );
 
%* Example 2 - Step 2: Add to an existing backup archive: ;
%m_adm_create_backup(
   src_path  = C:/SAS/Data/toolbox/misc/scripts
 , tgt_path  = C:/SAS/Data/toolbox/backup
 , tgt_file  = sources
 , new_file  = N
 , debug     = N
   );
 
%* Example 3: Create a new backup and send it by email: ;
%m_adm_create_backup(
   src_path = C:/SAS/Data/toolbox/sasautos
 , tgt_path = C:/SAS/Data/toolbox/backup
 , tgt_file = sasautos
 , add_dttm = Y
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = N
   );
 
