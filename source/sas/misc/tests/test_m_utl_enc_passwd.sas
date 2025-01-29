/*!
 ******************************************************************************
 * \file       test_m_utl_enc_passwd.sas
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
 *             + m_utl_enc_passwd.sas
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
%m_utl_enc_passwd(?)
 
%* Example 2: Encrypt a given plain password: ;
%m_utl_enc_passwd(
   passwd = R@ce2018
 , method = SAS004
 , print  = Y
 , debug  = Y
   );

%put PWENCODE=&_pwencode.;
 
%* Example 3: Encode a given plain password: ;
%m_utl_enc_passwd(
   passwd = R@ce2018
 , mdhash = Y
 , print  = Y
 , debug  = Y
   );

%put MDHASH=&_pwencode.;
 
%* Example 4: Encode a given maximum length password: ;
%m_utl_enc_passwd(
   passwd = K3nnwortMitM@ximumLenGTh
 , mdhash = Y
 , print  = Y
 , debug  = Y
   );

%put MDHASH=&_pwencode.;
 
