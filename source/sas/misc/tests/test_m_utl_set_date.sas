/*!
 ******************************************************************************
 * \file       test_m_utl_set_date.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-30 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_set_date.sas
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
 
%* Example 1: Show help information ;
%m_utl_set_date(?)
 
%* Example 2: Get end-of-month day date for given date 14.09.2019: ;
%m_utl_set_date(
   in_date  = 14.02.2019
 , date_pnt = end
 , global   = Y
 , mvar_dt2 = end_of_this_month
 , debug    = N
   )
%put &=end_of_this_month.;
 
%* Example 3: Get beginning-of-month day date for given date 14.09.2019: ;
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = begin
 , global   = Y
 , mvar_dt2 = begin_of_this_month
 , debug    = N
   )
%put &=begin_of_this_month.;
 
%* Example 4: Get last month day date for given date 14.09.2019: ;
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = end
 , list_pnt = last
 , global   = Y
 , mvar_dt2 = end_of_last_month
 , debug    = N
   )
%put &=end_of_last_month.;
 
%* Example 5: Get next month day date for given date 14.09.2019: ;
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = sameday
 , list_pnt = next
 , global   = Y
 , mvar_dt2 = same_day_next_month
 , debug    = N
   )
%put &=same_day_next_month.;
 
%* Example 6: Get ultimo day date results for given date 14.09.2019: ;
%m_utl_set_date(
   in_date  = 14.09.2019
 , date_pnt = end
 , global   = Y
 , mvar_dt1 = input_day_date
 , mvar_dt2 = end_of_this_month
 , mvar_dt3 = end_of_this_quarter
 , mvar_dt4 = end_of_this_year
 , debug    = N
   )
%put &=input_day_date.;
%put &=end_of_this_month.;
%put &=end_of_this_quarter.;
%put &=end_of_this_year.;
 
%* Example 7: Convert date format for given date 14.09.2019: ;
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = date9
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
 
%* Example 8: Convert date format for given date 14.09.2019: ;
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = yymmddn8
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
 
%* Example 9: Convert date format and set day for given date 14.09.2019: ;
%let formatted_date=
   %m_utl_set_date(
      dat    = 14.09.2019
    , fmt    = date9
    , pnt    = E
    , inline = Y
    , debug  = N
      );
%put &=formatted_date.;
 
