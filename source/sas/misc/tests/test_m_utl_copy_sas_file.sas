/*!
 ******************************************************************************
 * \file       test_m_utl_copy_sas_file.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-09-14 07:49:15
 * \version    20.1.03
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_copy_sas_file.sas
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
%m_utl_copy_sas_file(?)
 
%* Example 2: Copy SASHELP.class to an output directory: ;
%m_utl_copy_sas_file(
   inlib  = SASHELP
 , outdir = %sysfunc(getoption(WORK))
 , select = class
 , debug  = Y
   );
 
%* Example 3: Copy a SAS catalog to an output directory: ;
options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/backup";
options nodlcreatedir;

%m_utl_copy_sas_file(
   indir  = %sysfunc(pathname(SASHOME))/SASFoundation/9.4//core/cmacros
 , outlib = TEMP
 , select = sasmacr.sas7bcat
 , debug  = Y
   );

proc catalog cat=TEMP.sasmacr;
   contents;
   run;
quit;

libname TEMP clear;
 
%* Example 4: Copy a dataset and its index to another library: ;
data WORK.class;
   set SASHELP.class;
run;

proc datasets lib=WORK nodetails nolist;
   modify class;
   index create name /unique;
   run;
quit;

proc contents data=WORK.class;
run;

options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/backup";
options nodlcreatedir;

%m_utl_copy_sas_file(
   inlib  = WORK
 , outlib = TEMP
 , select = class
 , debug  = Y
   );

proc contents data=TEMP.class;
run;

libname TEMP clear;
 
%* Example 5: Copy an encrypted dataset to another library: ;
data WORK.class(encrypt=aes encryptkey=aespasskey);
   set SASHELP.class;
run;

proc print data=WORK.class(encryptkey=aespasskey);
run;

options dlcreatedir;
libname TEMP "%sysfunc(getoption(WORK))/backup";
options nodlcreatedir;

%m_utl_copy_sas_file(
   inlib  = WORK
 , outlib = TEMP
 , select = class
 , enckey = aespasskey
 , debug  = Y
   );

proc contents data=TEMP.class(encryptkey=aespasskey);
run;

proc print data=TEMP.class(encryptkey=aespasskey);
run;

libname TEMP clear;
 
