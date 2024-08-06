/*!
 ******************************************************************************
 * \file       test_m_adm_compile_functs.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-03-07 00:00:00
 * \version    24.1.03
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_adm_compile_functs.sas
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
%m_adm_compile_functs(?)
 
%* Example 2 - Step 1: Create a functions using SAS proc fcmp syntax: ;
options dlcreatedir;
libname mylib "%sysfunc(getoption(WORK))/functions";
filename myfile "%sysfunc(getoption(WORK))/functions/translate_to_spanish.sas";

data _null_;
   file myfile;
   put '* proc fcmp outlib=TEMP.funcs.maths; ;' ;
   put '   function translate_to_spanish(x $) $ 12;' ;
   put '      if x = "yes" then return("si");' ;
   put '      else return("no");' ;
   put '   endsub;' ;
   put '* quit; ;' ;
run;

filename myfile clear;
libname mylib clear;
options nodlcreatedir;
 
%* Example 2 - Step 2: Compile functions to a library container and print report: ;
%m_adm_compile_functs(
   indir    = %sysfunc(getoption(WORK))/functions
 , outdir   = %sysfunc(getoption(WORK))/catalog
 , outlib   = TEMP.functs.samples
 , print    = Y
 , debug    = Y
   );

data WORK.test;
   english='yes';
   spanish=translate_to_spanish('yes');
   put spanish=;
run;

proc print data=WORK.test noobs;
run;
 
%* Example 3 - Step 3: Compile functions to a library container and email report: ;
%m_adm_compile_functs(
   indir    = %sysfunc(getoption(WORK))/functions
 , outdir   = %sysfunc(getoption(WORK))/catalog
 , outlib   = TEMP.functs.samples
 , sendmail = Y
 , mailaddr = %str(pact@hermes.local)
 , debug    = Y
   );
 
