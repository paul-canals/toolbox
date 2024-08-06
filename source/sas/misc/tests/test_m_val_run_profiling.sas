/*!
 ******************************************************************************
 * \file       test_m_val_run_profiling.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2024-08-03 00:00:00
 * \version    24.1.08
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_val_run_profiling.sas
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
%m_val_run_profiling(?)
 
%* Example 2: Run data profiling checks on SASHELP.baseball table: ;
%m_val_run_profiling(
   src_tbl = SASHELP.baseball
 , out_lib = WORK
 , replace = Y
 , print   = Y
 , debug   = N
   );
 
%* Example 3: Run data profiling checks on SASHELP.classfit table: ;
%m_val_run_profiling(
   src_tbl = SASHELP.classfit
 , out_lib = WORK
 , replace = Y
 , print   = Y
 , debug   = N
   );
 
%* Example 4: Step 1 - Create and prepare a large table with index: ;
%macro doloop();
   %local i;
   %do i=1 %to 44;
      %if &i. eq 1 %then %do;
         data WORK.prdsale (label='Product Sales');
            set SASHELP.prdsal2;
            if country eq 'Canada' then country = '  Canada';
            if state eq 'British Columbia' then state = 'British Columbiaüöä';
            if state eq 'North Carolina' then state = 'North  Carolina';
            if year eq 1997 then year = 11997;
         run;
      %end;
      %else %do;
         data WORK.prdsal2;
            set SASHELP.prdsal2;
            actual = actual + &i.;
            predict = predict + &i.;
         run;
         proc append base=WORK.prdsale data=WORK.prdsal2;
         quit;
      %end;
   %end;
   proc datasets library=WORK noprint;
      modify prdsale;
      index create region=(country state) / nomiss;
   quit;
%mend doloop;
%doloop;
 
%* Example 4: Step 2 - Run data profiling on the indexed table: ;
%m_val_run_profiling(
   src_tbl = WORK.prdsale
 , print   = Y
 , debug   = N
   );
 
%* Example 4: Step 3 - Since we are done delete indexed table: ;
proc datasets lib=WORK nodetails nolist;
   delete prdsal: ;
quit;
 
%* Example 5: Step 1 - Create and prepare an indexed table: ;
data WORK.class (label='Indexed');
   set SASHELP.class;
run;

proc datasets library=WORK noprint;
   modify class;
   index create name / nomiss;
quit;
 
%* Example 5: Step 2 - Run data profiling checks on indexed table: ;
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = Y
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
 
%* Example 5: Step 3 - Since we are done delete indexxed table: ;
proc datasets lib=WORK nodetails nolist;
   delete class ;
quit;
 
%* Example 6: Step 1 - Create and prepare a table with constraint: ;
data WORK.class (label='Constraint');
   set SASHELP.class;
run;

proc datasets library=WORK noprint;
   modify class;
   ic create key = primary key(name);
quit;
 
%* Example 6: Step 2 - Run data profiling checks on constrained table: ;
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
 
%* Example 6: Step 3 - Since we are done delete constrained table: ;
proc datasets lib=WORK nodetails nolist;
   delete class ;
quit;
 
%* Example 7: Step 1 - Create and prepare a password protected table: ;
data WORK.class (pw=mypasswd label='Protected');
   set SASHELP.class;
run;
 
%* Example 7: Step 2 - Run data profiling checks on protected table: ;
%m_val_run_profiling(
   src_tbl = WORK.class (pw=mypasswd)
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
 
%* Example 7: Step 3 - Since we are done delete protected table: ;
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
quit;
 
%* Example 8: Step 1 - Create and prepare a password encrypted table: ;
data WORK.class (encrypt=aes encryptkey=mypasswd label='Encrypted');
   set SASHELP.class;
run;
 
%* Example 8: Step 2 - Run data profiling checks on encrypted table: ;
%m_val_run_profiling(
   src_tbl = WORK.class (encryptkey=mypasswd)
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
 
%* Example 8: Step 3 - Since we are done delete encrypted table: ;
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
quit;
 
%* Example 9: Step 1 - Create and prepare an audited table: ;
data WORK.class (alter=mypasswd label='Audited' compress=no);
   set SASHELP.class;
run;

proc datasets library=WORK nodetails nolist;
   audit class (alter=mypasswd);
   initiate;
run;
 
%* Example 9: Step 2 - Run data profiling checks on audited table: ;
%m_val_run_profiling(
   src_tbl = WORK.class
 , out_lib = WORK
 , replace = N
 , print   = N
 , debug   = N
   );

proc print data=WORK.summary label;
run;
 
%* Example 9: Step 3 - Since we are done delete audited table: ;
proc datasets lib=WORK nodetails noprint;
   delete class (alter=mypasswd);
quit;
 
