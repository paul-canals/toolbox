/*!
 ******************************************************************************
 * \file       test_m_utl_delta_extract.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:28
 * \version    20.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_delta_extract.sas
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
%m_utl_delta_extract(?)
 
%* Example 2: Step 1 - Initialize global macro variable output parameters: ;
* Initialize macro vars;
%let _target_recs_=;
%let _delta_recs_=;
%let _full_extract_=;

 
%* Example 2: Step 2 - Perform an initial full load extraction of SASHELP.class (18 records): ;
%m_utl_delta_extract(
   table      = SASHELP.class(obs=18)
 , key        = Name
 , tgt_table  = WORK.class
 , include    = Name Age Sex Weight
 , trecs_mvar = _target_recs_
 , drecs_mvar = _delta_recs_
 , full_mvar  = _full_extract_
 , debug      = Y
   );

data WORK.result;
   TargetRecs = &_target_recs_.;
   DeltaLoad  = &_delta_recs_.;
   FullLoad   = &_full_extract_.;
run;

proc print data=WORK.class;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 2: Step 3 - Perform an update delta load extraction of SASHELP.class (1 record): ;
%m_utl_delta_extract(
   table      = SASHELP.class
 , key        = Name
 , key_sort   = Y
 , tgt_table  = WORK.class
 , include    = Name Age Sex Weight
 , trecs_mvar = _target_recs_
 , drecs_mvar = _delta_recs_
 , full_mvar  = _full_extract_
 , debug      = Y
   );

data WORK.result;
   TargetRecs = &_target_recs_.;
   DeltaLoad  = &_delta_recs_.;
   FullLoad   = &_full_extract_.;
run;

proc print data=WORK.class;
run;

proc print data=WORK.result noobs;
run;

 
%* Example 2: Step 4 - Perform an update delta load extraction of SASHELP.class (0 records): ;
%m_utl_delta_extract(
   table      = SASHELP.class
 , key        = Name
 , key_sort   = Y
 , tgt_table  = WORK.class
 , include    = Name Age Sex Weight
 , trecs_mvar = _target_recs_
 , drecs_mvar = _delta_recs_
 , full_mvar  = _full_extract_
 , debug      = Y
   );

data WORK.result;
   TargetRecs = &_target_recs_.;
   DeltaLoad  = &_delta_recs_.;
   FullLoad   = &_full_extract_.;
run;

proc print data=WORK.class;
run;

proc print data=WORK.result noobs;
run;

 
