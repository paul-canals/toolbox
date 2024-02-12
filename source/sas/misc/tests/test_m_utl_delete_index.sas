/*!
 ******************************************************************************
 * \file       test_m_utl_delete_index.sas
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
 *             + m_utl_delete_index.sas
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
%m_utl_delete_index(?)
 
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

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
%* Example 2: Delete simple index on Name (Result: index Name deleted): ;
proc datasets lib=WORK nolist;
   %m_utl_delete_index(
      table      = WORK.class
    , index_name = Name
    , inline_flg = Y
    , debug      = Y
      )
quit;

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
%* Example 3: Delete simple index on Name (Result: index not deleted): ;
%m_utl_delete_index(
   table      = WORK.class
 , index_cols = Name
 , inline_flg = N
 , debug      = Y
   )

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
%* Example 4: Delete composite index on Name Age (Result: index COMP_2 deleted): ;
%m_utl_delete_index(
   table      = WORK.class
 , index_cols = Name Age
 , inline_flg = N
 , debug      = Y
   );

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
%* Example 5: Delete composite index on Name Sex (Result: index COMP_1 deleted): ;
%m_utl_delete_index(
   table      = WORK.class
 , index_name = comp_1
 , inline_flg = N
 , debug      = Y
   );

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
%* Example 6: Delete composite index on Sex Age (Result: index not deleted): ;
%m_utl_delete_index(
   table      = WORK.class
 , index_cols = Sex Age
 , inline_flg = N
 , debug      = Y
   );

proc print data=SASHELP.vindex;
   where libname='WORK' and memname='CLASS';
run;
 
