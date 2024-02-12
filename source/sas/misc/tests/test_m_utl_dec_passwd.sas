/*!
 ******************************************************************************
 * \file       test_m_utl_dec_passwd.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-11-23 00:00:00
 * \version    23.1.11
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_dec_passwd.sas
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
%m_utl_dec_passwd(?)
 
%* Example 2: Step 1 - Encrypt a table with AES encryption level encryption key: ;
data WORK.class(encrypt=aes encryptkey="R@ce2018");
   set SASHELP.class;
run;
 
%* Example 2: Step 2 - Decode the given md5hash password for table access inline: ;
proc print data=WORK.class(encryptkey=
   "%m_utl_dec_passwd(passwd=MD5#0883331333033323335363336303432353,debug=Y)");
run;
 
%* Example 2: Step 3 - Decode the given md5hash password for table access: ;
%m_utl_dec_passwd(
   passwd = MD5#0883331333033323335363336303432353
 , global = Y
 , debug  = Y
   );

%put &=_pwdecode.;
 
