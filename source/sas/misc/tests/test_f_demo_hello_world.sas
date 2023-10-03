/*!
 ******************************************************************************
 * \file       test_f_demo_hello_world.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-03 07:45:26
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + f_demo_hello_world.sas
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
 
%* Example 1: Show Hello reaction function ;
proc fcmp outlib=WORK.functs.demo;
   function f_demo_hello_world(text $) $ 100;
      if lowcase(text) eq 'hello?' then do;
         return(cat(compress(text,'?'),'-','World!'));
      end;
      else do;
         return('Who are you?');
      end;
   endsub;
quit;

options cmplib=WORK.functs;

data _null_;
   rc = f_demo_hello_world('Hello?');
   put rc=;
run;

 