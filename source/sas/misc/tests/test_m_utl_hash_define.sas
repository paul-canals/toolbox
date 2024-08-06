/*!
 ******************************************************************************
 * \file       test_m_utl_hash_define.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-06-29 00:00:00
 * \version    24.1.06
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_hash_define.sas
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
%m_utl_hash_define(?)
 
%* Example 2: Create a hash object from an encrypted SAS dataset: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

data _null_;
   %m_utl_hash_define(
      table = WORK.class
    , creds = %str(encryptkey=aespasskey)
    , name  = class
    , keys  = Name
    , cols  = _ALL_
    , debug = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.result noobs;
   title 'Example 2: Create a hash object from an encrypted SAS dataset';
run; title ;
 
%* Example 3: Create an ordered hash object (ordered=Y): ;
data _null_;
   %m_utl_hash_define(
      table   = SASHELP.class
    , name    = class
    , keys    = Name
    , cols    = _ALL_
    , ordered = Y
    , debug   = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.result noobs;
   title 'Example 3: Create an ordered hash object (ordered=Y)';
run; title ;
 
%* Example 4: Create an (A)scending ordered hash object (ordered=A): ;
data _null_;
   %m_utl_hash_define(
      table   = SASHELP.class
    , name    = class
    , keys    = Name
    , cols    = _ALL_
    , ordered = A
    , debug   = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.result noobs;
   title 'Example 4: Create an (A)scending ordered hash object (ordered=A)';
run; title ;
 
%* Example 5: Create an (D)escending ordered hash object (ordered=D): ;
data _null_;
   %m_utl_hash_define(
      table   = SASHELP.class
    , name    = class
    , keys    = Name
    , cols    = _ALL_
    , ordered = D
    , debug   = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.result noobs;
   title 'Example 5: Create an (D)escending ordered hash object (ordered=D)';
run; title ;
 
%* Example 6: Create a hash object with a selection of columns (keep=): ;
data WORK.result;
   %m_utl_hash_define(
      table = SASHELP.class(keep=Name Sex Age)
    , name  = class
    , keys  = Name
    , cols  = Sex Age
    , debug = Y
      );
   set SASHELP.class(keep=Name);
   rc = class.find();
   drop rc;
run;

proc print data=WORK.result noobs;
   title 'Example 6: Create a hash object with a selection of columns (keep=)';
run; title ;
 
%* Example 7: Create a hash object with a selection of columns (drop=): ;
data WORK.result;
   %m_utl_hash_define(
      table = SASHELP.class(drop=Height Weight)
    , name  = class
    , keys  = Name
    , cols  = _ALL_
    , debug = Y
      );
   set SASHELP.class(keep=Name);
   rc = class.find();
   drop rc;
run;

proc print data=WORK.result noobs;
   title 'Example 7: Create a hash object with a selection of columns (drop=)';
run; title ;
 
%* Example 8: Create a hash object with a selection and renaming of columns: ;
data WORK.result;
   %m_utl_hash_define(
      table     = SASHELP.class
    , name      = class
    , keys      = Name
    , cols      = Gender Age
    , cols_orig = Sex Age
    , debug     = Y
      );
   set SASHELP.class(keep=Name);
   rc = class.find();
   drop rc;
run;

proc print data=WORK.result noobs;
   title 'Example 8: Create a hash object with a selection and renaming of columns';
run; title ;
 
%* Example 9: When loading duplicate key data items, only the last known value is saved: ;
data WORK.class;
   set SASHELP.class;
   if Name eq 'Alice' then do;
      output; Age=16; output;
   end;
run;

data _null_;
   %m_utl_hash_define(
      table = WORK.class
    , name  = class
    , keys  = Name
    , cols  = _ALL_
    , debug = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.class;
   title 'Example 9: When loading duplicate key data items, only the last known value is saved';
run;

proc print data=WORK.result;
   title ;
run;
 
%* Example 10: Step 1 - Load duplicate key data item pairs into the hash object (multidata): ;
data WORK.class;
   set SASHELP.class;
   if Name eq 'Alice' then do;
      output; Age=16; output;
   end;
run;

proc print data=WORK.class;
   title 'Example 10: Step 1 - Load duplicate key data item pairs into the hash object (multidata)';
run; title ;
 
%* Example 10: Step 2 - Use FIND with key to get data items from hash object (returns first key): ;
data Work.result;
   %m_utl_hash_define(
      table     = WORK.class
    , name      = class
    , keys      = Name
    , cols      = _ALL_
    , multidata = Y
    , debug     = Y
      );
   rc = class.find(key: 'Alice');
run;

proc print data=WORK.result;
   title 'Example 10: Step 2 - Use FIND with key to get data items from hash object (returns first key)';
run; title ;
 
%* Example 10: Step 3 - Use OUTPUT to get all data items from hash object (returns all keys): ;
data _null_;
   %m_utl_hash_define(
      table     = WORK.class
    , name      = class
    , keys      = Name
    , cols      = _ALL_
    , multidata = Y
    , debug     = Y
      );
   rc = class.output(dataset: 'WORK.result');
run;

proc print data=WORK.result;
   title 'Example 10: Step 3 - Use OUTPUT to get all data items from hash object (returns all keys)';
run; title ;
 
%* Example 11: Create hash iterative object using the FIRST and NEXT methods to obtain data items: ;
data Work.result;
   %m_utl_hash_define(
      table     = SASHELP.class
    , name      = class
    , hiter_flg = Y
    , hitername = hclass
    , keys      = Name
    , ordered   = Y
    , debug     = Y
      );
   %m_utl_hash_define(
      table     = SASHELP.classfit
    , name      = classfit
    , keys      = Name
    , ordered   = Y
    , debug     = Y
      );
   rc = hclass.first();
   do while (rc eq 0);
      if Sex eq 'F' then do;
         rc = classfit.find();
         output;
      end;
      rc = hclass.next();
   end;
run;

proc print data=WORK.result;
   title 'Example 11: Create hash iterative object using the FIRST and NEXT methods to obtain data items';
run; title ;
 
