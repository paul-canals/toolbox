/*!
 ******************************************************************************
 * \file       test_m_utl_mail_notification.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:14
 * \version    20.1.12
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_mail_notification.sas
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
%m_utl_mail_notification(?)
 
%* Example 2: Send an email with an attachment: ;
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/tmpdir";
libname TEMP clear;

filename text "%sysfunc(getoption(WORK))/tmpdir/attachment.txt";

data _null_;
   file text;
   put "This is a test file for mail notification testing";
run;

filename text clear;

%m_utl_mail_notification(
   to      = %str(pact@hermes.local)
 , cc      = %str(admin@hermes.local)
 , subject = %str(RACE: Mail notification test)
 , content = "Your RACE support team"
 , attach  = %sysfunc(getoption(WORK))/tmpdir/attachment.txt
 , debug   = N
   );
 
