/*!
 ******************************************************************************
 * \file       test_m_utl_save_hist_data.sas
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
 *             + m_utl_save_hist_data.sas
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
%m_utl_save_hist_data(?)
 
%* Example 2: Load data from SASHELP.classfit into a historised table (no LOAD_CD): ;
%* Initialize classfit table ;
proc datasets lib=WORK nolist nowarn memtype=(data view);
   delete classfit;
quit;

%m_utl_save_hist_data(
   in_tbl   = SASHELP.classfit (drop=Sex rename=(Name=Student))
 , out_tbl  = WORK.classfit
 , where    = %str(Sex = 'F' and Age > 13)
 , valid_dt = 30.09.2017
 , debug    = Y
   );

%m_utl_save_hist_data(
   intable  = SASHELP.classfit (drop=Sex rename=(Name=Student))
 , outtable = WORK.classfit
 , where    = %str(Sex = 'M' and Age > 13)
 , valid_dt = 30.09.2017
 , debug    = N
   );

proc print data=WORK.classfit;
   title 'Example 2: SASHELP.CLASSFIT (Filtered)';
   footnote "Date: 30.09.2017 | Filter: Sex in ('F','M') and Age > 13";
run; title; footnote;
 
%* Example 3: Load data from SASHELP.class into a historised table (with LOAD_CD): ;
%* Initialize class table ;
proc datasets lib=WORK nolist nowarn memtype=(data view);
   delete class;
quit;

%m_utl_save_hist_data(
   in_tbl   = SASHELP.class
 , out_tbl  = WORK.class
 , where    = %str(Sex = 'F' and Age > 13)
 , valid_dt = 30.09.2017
 , verscol  = version
 , type_cd  = GIRLS
 , debug    = N
   );

%m_utl_save_hist_data(
   intable  = SASHELP.class
 , outtable = WORK.class
 , where    = %str(Sex = 'M' and Age > 13)
 , valid_dt = 30.09.2017
 , verscol  = version
 , type_cd  = BOYS
 , debug    = N
   );

proc print data=WORK.class;
   title 'Example 2: SASHELP.CLASS (Filtered)';
   footnote "Date: 30.09.2017 | Filter: Sex in ('F','M') and Age > 13";
run; title; footnote;
 
