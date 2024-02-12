/*!
 ******************************************************************************
 * \file       test_m_utl_join_setkey.sas
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
 *             + m_utl_join_setkey.sas
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
%m_utl_join_setkey(?)
 
%* Example 2: Step 1 - Create a Master Table and three Lookup Tables: ;
data
   WORK.master(keep=mkey1 mkey2 mkey3 master_id master_txt ranuni)
   WORK.trans1(keep=tkey1 trans1_txt)
   WORK.trans2(keep=tkey2 trans2_txt trans2_txt2)
   WORK.trans3(keep=tkey3 trans3_txt trans3_txt2)
   ;
   * add a few rows that do not match ;
   do mkey1 = 111219 to 111221;
      master_id = mkey1;
      master_txt='nothing in trans tables' || put(master_id,z4.);
      output WORK.master;
   end;
   retain tkey1-tkey3 master_id;
   master_id = 0;
   tkey1 = 0;
   tkey2 = 0;
   tkey3 = 0;
   do loopi = 1 to 100000;
      do itrankey1 = 1 to 5;
         tkey1 = tkey1 + 1;
         trans1_txt = put(tkey1, z3.);
         output WORK.trans1;
         mkey1 = tkey1;
         do itrankey2 = 1 to 5;
            tkey2 = tkey2 + 1;
            if tkey2 > 10000 then tkey2 = 1;
            trans2_txt = '1'||put(tkey2, z3.);
            trans2_txt2 = '2'||put(tkey2, z3.);
            output WORK.trans2;
            mkey2 = tkey2;
            do itrankey3 = 1 to 5;
               tkey3 = tkey3 + 1;
               if tkey3 > 20000 then tkey3 = 1;
               trans3_txt = '1'||put(tkey3, z3.);
               trans3_txt2 = '2'||put(tkey3, z3.);
               output WORK.trans3;
               mkey3 = tkey3;
               master_id = master_id + 1;
               master_txt='mast ' || put(master_id,z4.);
               ranuni = ranuni(123);
               output WORK.master;
            end;
         end;
      end;
   end;
   * add a few rows that wont match to trans2 and trans3;
   do mkey1 = 999111997 to 999111998;
      master_id = mkey1;
      tkey1 = master_id;
      master_txt='nothing in trans tabs' || put(master_id,z4.);
      output WORK.master;
      output WORK.trans1;
   end;
run;
 
%* Example 2: Step 2 - Create a sorted and unsorted Master Table: ;
proc sort data=WORK.master out=WORK.master_unsort;
   by ranuni;
run;

proc sort data=WORK.master out=WORK.master_sorted;
   by mkey1 mkey2 mkey3;
run;
 
%* Example 2: Step 3 - Sort lookup tables and create simple indexes: ;
proc sort data=WORK.trans1 nodupkey
   out=WORK.trans1(index=(tkey1));
   by descending tkey1;
run;

proc sort data=WORK.trans2 nodupkey
   out=WORK.trans2(index=(tkey2));
   by descending tkey2;
run;

proc sort data=WORK.trans3 nodupkey
   out=WORK.trans3(index=(tkey3));
   by descending tkey3;
run;
 
%* Example 2: Step 4 - Join Master and Lookup tables by data step set key=: ;
%let _start = %sysfunc(datetime());

data WORK.master_keyjoin;
   set WORK.master_sorted;
   %m_utl_join_setkey(
      master_key  = mkey1
    , table       = WORK.trans1
    , key         = tkey1
    , key_num     = 1
    , default_key = 0
    , debug       = Y
      )
   %m_utl_join_setkey(
      master_key  = mkey2
    , table       = WORK.trans2
    , key         = tkey2
    , key_num     = 2
    , exclude     = trans2_txt
    , default_key = 0
    , debug       = Y
      )
   %m_utl_join_setkey(
      master_key  = mkey3
    , table       = WORK.trans3
    , key         = tkey3
    , key_num     = 3
    , rename_from = trans3_txt2
    , rename_to   = trans3_num
    , default_key = 0
    , debug       = Y
      )
   output;
run;

%let _stop = %sysfunc(datetime());
%let _time = %sysfunc(intck(SECOND, &_start., &_stop.), time10.);

data WORK.result;
   RunType="KEY Join";
   Message="Total Processing time for KEY join: &_time. (hh:mm:ss)";
run;

proc print data=WORK.result noobs;
run;
 
%* Example 2: Step 5 - Join Master and Lookup tables by proc sql join: ;
%let _start = %sysfunc(datetime());

proc sql noprint;
   create table WORK.mtemp_1 as
   select m.*
        , t.*
     from WORK.master m
          left join WORK.trans1 t
       on m.mkey1 = t.tkey1
          ;
   create table WORK.mtemp_2 as
   select m.*
        , t.*
     from WORK.mtemp_1 m
          left join WORK.trans2(drop=trans2_txt) t
       on m.mkey2 = t.tkey2
          ;
   create table WORK.master_sqljoin as
   select m.*
        , t.*
     from WORK.mtemp_2 m
          left join WORK.trans3(rename=(trans3_txt2=trans3_num)) t
       on m.mkey3 = t.tkey3
          ;
quit;

%let _stop = %sysfunc(datetime());
%let _time = %sysfunc(intck(SECOND, &_start., &_stop.), time10.);

data WORK.result;
   RunType="SQL Join";
   Message="Total Processing time for KEY join: &_time. (hh:mm:ss)";
run;

proc print data=WORK.result noobs;
run;
 
