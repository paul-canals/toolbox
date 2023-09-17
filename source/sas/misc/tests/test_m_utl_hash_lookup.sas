/*!
 ******************************************************************************
 * \file       test_m_utl_hash_lookup.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:50:08
 * \version    20.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_hash_lookup.sas
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
%m_utl_hash_lookup(?)
 
%* Example 2: Create a new hash object and perform lookup for all columns: ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name
    , cols      = _ALL_
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 3: Create a new hash object and perform lookup for some columns: ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , cols      = Predict Lowermean Uppermean
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 4: Create new hash objects and perform lookups (will fail): ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , cols      = Predict
    , list_mvar = _LIST_
    , debug     = Y
      );
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , cols      = Lowermean Uppermean
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 5: Create new hash objects and perform lookups (successful): ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class1
    , keys      = Name Sex Age
    , cols      = Predict
    , list_mvar = _LIST_
    , debug     = Y
      );
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class2
    , keys      = Name Sex Age
    , cols      = Lowermean Uppermean
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 6: Create a hash object and perform lookups with changed key names: ;
%let _LIST_=;

data WORK.class(rename=(Sex=Gender));
   set SASHELP.class;
run;

data WORK.result;
   set WORK.class;
   %m_utl_hash_lookup(
      table      = SASHELP.classfit
    , context    = class
    , keys       = Name Sex Age
    , keys_orig  = Name Gender Age
    , cols       = _ALL_
    , list_mvar  = _LIST_
    , debug      = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 7: Create a hash object, perform lookups with changed column and key names: ;
%let _LIST_=;

data WORK.class(rename=(Sex=Gender));
   set SASHELP.class;
run;

data WORK.result;
   set WORK.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , keys_orig = Name Gender Age
    , cols      = Predicted Lower Upper
    , cols_orig = predict lowermean uppermean
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 8: Create a hash object, perform lookups with added prefix to all data columns: ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , cols      = _ALL_
    , prefix    = fit_
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 9: Create a hash object, perform lookups with added attribute Predicted_Weight format: ;
%let _LIST_=;

data WORK.result;
   set SASHELP.class;
   attrib Predicted_Weight length=8 format=8.3 label='blaat';
   %m_utl_hash_lookup(
      table     = SASHELP.classfit
    , context   = class
    , keys      = Name Sex Age
    , cols      = Predicted_Weight
    , cols_orig = predict
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 10: Create a hash object, perform lookups on an encrypted SAS dataset: ;
%let _LIST_=;

data WORK.classfit(encrypt=aes encryptkey=aespasskey);
   set SASHELP.classfit;
run;

data WORK.result;
   set SASHELP.class;
   %m_utl_hash_lookup(
      table     = WORK.classfit
    , creds     = %str(encryptkey=aespasskey)
    , context   = class
    , keys      = Name Sex Age
    , cols      = _ALL_
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
%* Example 11: Create a hash object, and perform lookups using SAS invalid names: ;
%let _LIST_=;

data WORK.class;
   set SASHELP.class;
   rename
      name = '/bic/Name'n
      sex  = '/bic/Sex'n
      age  = '/bic/Age'n
      ;
run;

data WORK.classfit;
   set SASHELP.classfit;
   rename
      name    = '/bic/Name'n
      sex     = '/bic/Sex'n
      age     = '/bic/Age'n
      predict = '/bic/Predict'n
      upper   = '/bic/Upper'n
      ;
run;

data WORK.result;
   set WORK.class;
   %m_utl_hash_lookup(
      table     = WORK.classfit
    , context   = class
    , keys      = '/bic/Name'n '/bic/Sex'n '/bic/Age'n
    , cols      = '/bic/Predict'n '/bic/Upper'n
    , quoted    = Y
    , list_mvar = _LIST_
    , debug     = Y
      );
run;

%put &=_LIST_.;

proc print data=WORK.result;
run;

 
