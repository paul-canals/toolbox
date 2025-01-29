/*!
 ******************************************************************************
 * \file       test_m_utl_list_operation.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2020-10-22 00:00:00
 * \version    20.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_list_operation.sas
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
%m_utl_list_operation(?)
 
%* Example 2: The Union between Left(A B) and Right(B C) list: ;
%let result=
   %m_utl_list_operation(
      left      = %str(A B)
    , right     = %str(B C)
    , operation = Union
    , in_dlm    = BLANK
    , out_dlm   = COMMA
    , debug     = Y
      );

%put The Union between Left(A B) and Right(B C) list is: (&result.);

 
%* Example 3: The Intersection between Left(A,B) and Right(B,C) list: ;
%let result=
   %m_utl_list_operation(
      left      = %str(A,B)
    , right     = %str(B,C)
    , operation = Intersection
    , in_dlm    = COMMA
    , out_dlm   = BLANK
    , debug     = Y
      );

%put The Intersection between Left(A,B) and Right(B,C) list is: (&result.);

 
%* Example 4: The Difference between Left(A B) and Right(B C) list: ;
%let result=
   %m_utl_list_operation(
      left      = %str(A B)
    , right     = %str(B C)
    , operation = Difference
    , debug     = Y
      );

%put The Difference between left(A B) and right(B C) list is: (&result.);

 
%* Example 5: The Difference between Left(/bic/A /bic/B) and Right(/bic/B) list: ;
%let result=
   %m_utl_list_operation(
      left      = %str('/bic/A'n '/bic/B'n)
    , right     = %str('/bic/B'n)
    , operation = Difference
    , debug     = Y
      );

%put The Difference between left(/bic/A /bic/B) and right(/bic/B) list is: (&result.);

 
