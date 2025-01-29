/*!
 ******************************************************************************
 * \file       test_f_demo_sum_array.sas
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
 *             + f_demo_sum_array.sas
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
 
%* Example 1: Summarise all of 'ac' array item values ;
proc fcmp outlib=WORK.functs.demo;
   function f_demo_sum_array(s[*]) varargs;
       sum_ = 0;
       do i = 1 to dim(s);
          sum_ = sum_ + s[i];
       end;
       return(sum_);
   endsub;
quit;

options cmplib=WORK.functs;

data _null_;
  array ac[3] a b c;
  array dh[5] d e f g h;
  a = 1;
  b = 2;
  c = 3;
  d = 4;
  e = 5;
  f = 6;
  g = 7;
  h = 8;
  sum_ac = f_demo_sum_array(ac);
  sum_dh = f_demo_sum_array(dh);
  put sum_ac=;
  put sum_dh=;
run;

 
