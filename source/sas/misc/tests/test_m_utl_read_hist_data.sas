/*!
 ******************************************************************************
 * \file       test_m_utl_read_hist_data.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2025-01-28 00:00:00
 * \version    25.1.01
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_read_hist_data.sas
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
%m_utl_read_hist_data(?)
 
%* Example 2: Read most actual data from a historised table WORK.class: ;
data WORK.class;
   set SASHELP.class;
   attrib
      LOAD_ID   length=8   format=z8.
      LOAD_CD   length=$32
      VALID_DT  length=8   format=ddmmyyp10.
      VERSION   length=8   format=z5.
      LOAD_DTTM length=8   format=datetime20.
      ;
   load_id   = 1;
   load_cd   = 'SAS';
   valid_dt  = "30sep2017"d;
   version   = 1;
   load_dttm = datetime()-2000;
   output;
   load_id   = 2;
   load_cd   = 'SAS';
   valid_dt  = "30sep2017"d;
   version   = 2;
   load_dttm = datetime()-1000;
   output;
   load_id   = 3;
   load_cd   = 'SAS';
   valid_dt  = date();
   version   = 1;
   load_dttm = datetime();
   output;
run;

proc print data=WORK.class;
   title 'Example 2: WORK.CLASS (Filtered)';
   footnote "Filter: Sex = 'F' and Age > 13";
   where sex eq 'F' and age gt 13;
run; title; footnote;

%m_utl_read_hist_data(
   intable  = WORK.class (drop=Height Weight)
 , out_tbl  = WORK.students
 , where    = %str(Sex = 'F' and Age > 13)
 , valid_dt = 30.09.2017
 , verscol  = version
 , debug    = N
   );

proc print data=WORK.students;
   title 'Example 2: WORK.STUDENTS (Filtered)';
   footnote "Date: 30.09.2017 | Filter: Sex = 'F' and Age > 13";
run; title; footnote;
 
