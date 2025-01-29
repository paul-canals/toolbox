/*!
 ******************************************************************************
 * \file       test_m_utl_chk_table_index.sas
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
 *             + m_utl_chk_table_index.sas
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
%m_utl_chk_table_index(?)
 
%* For the next examples create a table with several SIMPLE and COMPOSITE indexes: ;
data WORK.class;
   set SASHELP.class;
run;

proc datasets library=WORK nolist;
   modify class;
   index create Name;
   index create comp_1 = (Name Sex);
   index create comp_2 = (Name Age);
   index create comp_3 = (Sex Age Name);
quit;
 
%* Example 2: check if a SIMPLE index exists (Result=1): ;
%let index_exist =
   %m_utl_chk_table_index(
      table      = WORK.class
    , index_name = Name
    , debug      = Y
      );
%put &=index_exist.;
 
%* Example 3: check if a SIMPLE index exists (Result=0): ;
%m_utl_chk_table_index(
   table      = WORK.class
 , index_cols = Sex
 , global_flg = Y
 , mvar_match = index_exist
 , debug      = Y
   );
%put &=index_exist.;
 
%* Example 4: check if a COMPOSITE index exists (Result=1): ;
%m_utl_chk_table_index(
   table      = WORK.class
 , index_cols = Name Sex
 , global_flg = Y
 , mvar_match = idx_match
 , mvar_name  = idx_name
 , debug      = Y
   );
%put &=idx_match.;
%put &=idx_name.;
 
%* Example 5: check if a COMPOSITE index exists (Result=1): ;
%m_utl_chk_table_index(
   table      = WORK.class
 , index_name = comp_2
 , global_flg = Y
 , mvar_match = idx_match
 , mvar_name  = idx_name
 , debug      = Y
   );
%put &=idx_match.;
%put &=idx_name.;
 
%* Example 6: check if a COMPOSITE index exists (Result=1): ;
%m_utl_chk_table_index(
   table      = WORK.class
 , index_cols = Name Age
 , global_flg = Y
 , mvar_match = idx_match
 , mvar_name  = idx_name
 , debug      = Y
   );
%put &=idx_match.;
%put &=idx_name.;
 
%* Example 7: check if a COMPOSITE index exists (Result=0): ;
%let index_match =
   %m_utl_chk_table_index(
      table      = WORK.class
    , index_cols = Name Sex Age
    , debug      = Y
      );
%put &=index_match.;
 
