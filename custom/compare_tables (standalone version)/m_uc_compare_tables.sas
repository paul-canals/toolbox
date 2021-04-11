/*!
 ******************************************************************************
 * \file       m_uc_compare_tables.sas
 * \ingroup    CUSTOM
 * \brief      Custom macro to determine the differences between two datasets.
 * \details    The macro compares two tables or SAS datasets, the base dataset
 *             TABLE1 and the comparison dataset TABLE2. The macro procedure 
 *             determines both matching variables and records or observations. 
 *             Matching variables are those having the same name and type.
 *             Matching observations are those having identical values for all
 *             specified IDCOLS variables or if IDCOLS parameter is not set,
 *             those columns that occur in the same position in the datasets. 
 *             If matched observations by IDCOLS variables is set, then both
 *             SAS datasets or tables must be sorted by all IDCOLS variables.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-04-11 00:00:00
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  table1      Full LIBNAME.TABLENAME name of the input base
 *                         table. The default value for TABLE1 is: _NONE_.
 * \param[in]  where1      Optional. Specifies a valid WHERE clause that
 *                         selects observations from the TABLE1 SAS dataset.
 *                         Using this argument subsets your data based on
 *                         the criteria that you supply for the expression.
 * \param[in]  base        Alias of the TABLE1= parameter.
 * \param[in]  table2      Full LIBNAME.TABLENAME name of the comparison
 *                         table. The default value for TABLE2 is: _NONE_.
 * \param[in]  where2      Optional. Specifies a valid WHERE clause that
 *                         selects observations from the TABLE2 SAS dataset.
 *                         Using this argument subsets your data based on
 *                         the criteria that you supply for the expression.
 * \param[in]  comp        Alias of the TABLE2= parameter.
 * \param[in]  outtbl      Full LIBNAME.TABLENAME name of the output diff
 *                         table. The default value for OUTTBL is: _NONE_.
 * \param[in]  diff        Alias of the OUTTBL= parameter.
 * \param[in]  idcols      A blank separated list of column names to be 
 *                         used to match observations between the base 
 *                         and comparison tables. If no id columns are 
 *                         given, both base and compare tables must have
 *                         identical record entries (only column values
 *                         are checked for differences).
 * \param[in]  exclude     Optional. A blank separated list of columns to
 *                         be excluded from the table comparison routine.
 * \param[in]  stats       Boolean [Y|N] parameter to specify if an output
 *                         table containing the comparison statistics is
 *                         to be created. The default value is: N. 
 * \param[in]  nodups      Boolean [Y|N] parameter to specify if duplicate
 *                         observations are ignored from the comparison.
 *                         The default value for NODUPS is: Y.
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by using proc report steps with style HtmlBlue. 
 *                         The default value for PRINT is: N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     Table comparison summary table.
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_compare_tables(?)
 * \endcode
 * 
 * \example    Example 2: Step 1 - Create a new comparison table WORK.class:
 * \code
 *             data WORK.class;
 *                set SASHELP.class;
 *                if name eq 'John'
 *                   then Sex = 'F';
 *                if name eq 'Janet' then do;
 *                   Height = 57.3;
 *                   Weight = 99;
 *                end;
 *                if _n_ lt 18 then do;
 *                   output;
 *                   if name eq 'Henry' then do;
 *                      name = 'Paul';
 *                      output;
 *                   end;
 *                   if name eq 'Philip' then do;
 *                      output;
 *                   end;
 *                end;
 *             run;
 * \endcode
 * 
 * \example    Example 2: Step 2 - Compare SASHELP.class against WORK.class:
 * \code
 *             %m_uc_compare_tables(
 *                base   = SASHELP.class (drop=Height)
 *              , comp   = WORK.class (drop=Height)
 *              , idcols = Name Age
 *              , stats  = N
 *              , print  = Y
 *              , debug  = Y
 *                );
 * \endcode
 * 
 * \example    Example 3: Compare SASHELP.class against SASHELP.classfit:
 * \code
 *             %m_uc_compare_tables(
 *                base   = SASHELP.class
 *              , comp   = SASHELP.classfit
 *              , diff   = WORK.diff
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 4: Compare SASHELP.classfit against SASHELP.class:
 * \code
 *             %m_uc_compare_tables(
 *                base   = SASHELP.classfit
 *              , comp   = SASHELP.class
 *              , diff   = WORK.diff
 *              , idcols = Name
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 5: Compare SASHELP.class against WORK.class without IDCOLS=:
 * \code
 *             data WORK.class;
 *                set SASHELP.class;
 *                if name eq 'John' then do;
 *                   Name = 'Joan';
 *                   Sex = 'F';
 *                end;
 *                if name eq 'Janet' then do;
 *                   height = 57.3;
 *                   weight = 99;
 *                end;
 *             run;
 * 
 *             %m_uc_compare_tables(
 *                base   = SASHELP.class
 *              , comp   = WORK.class
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 6: Compare SASHELP.class against WORK.class with IDCOLS value change:
 * \code
 *             data WORK.class;
 *                set SASHELP.class;
 *                if name eq 'John' then Age = 19;
 *             run;
 * 
 *             %m_uc_compare_tables(
 *                base   = SASHELP.class (drop=Height)
 *              , comp   = WORK.class (drop=Height)
 *              , idcols = Name Age
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 7: Summarize and compare SASHELP.prdsal3 against SASHELP.prdsal2:
 * \code
 *             proc sql noprint;
 *                create table WORK.prdsal2 as
 *                select country, state, county, prodtype, product, year, quarter
 *                     , sum(actual) as actual, sum(predict) as predict
 *                  from SASHELP.prdsal2 (drop=month monyr)
 *                 group by country, state, county, prodtype
 *                     , product, year, quarter
 *                 order by year, quarter
 *                ;
 *             quit;
 * 
 *             proc sql noprint;
 *                create table WORK.prdsal3 as
 *                select country, state, county, prodtype, product, year, quarter
 *                     , sum(actual) as actual, sum(predict) as predict
 *                  from SASHELP.prdsal3 (drop=month date)
 *                 group by country, state, county, prodtype
 *                     , product, year, quarter
 *                 order by year, quarter
 *                ;
 *             quit;
 * 
 *             %m_uc_compare_tables(
 *                base   = WORK.prdsal3
 *              , comp   = WORK.prdsal2
 *              , diff   = WORK.prdsal_grp_diff
 *              , idcols = Country State County Prodtype Product Year Quarter
 *              , print  = Y
 *              , debug  = N
 *                );
 * \endcode
 * 
 * \example    Example 8: Compare SASHELP.prdsal3 against SASHELP.prdsal2 directly:
 * \code
 *             %m_uc_compare_tables(
 *                base   = SASHELP.prdsal3 (drop=date)
 *              , comp   = SASHELP.prdsal2 (drop=monyr)
 *              , diff   = WORK.prdsal_diff
 *              , idcols = Country State County Prodtype Product Year Quarter
 *              , print  = N
 *              , debug  = N
 *                );
 * 
 *             title "Attribute Summary (Differences) between SASHELP.prdsal3 and SASHELP.prdsal2";
 *             proc print data=WORK.prdsal_diff (drop=_key_) label;
 *             run;
 *             title;
 * \endcode
 * 
 * \copyright  Copyright 2008-2021 Paul Alexander Canals y Trocha.
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
%macro m_uc_compare_tables(
   help
 , vers    = 21.1.04
 , table1  = _NONE_
 , where1  = 
 , base    = 
 , table2  = _NONE_
 , where2  = 
 , comp    = 
 , outtbl  = _NONE_
 , diff    = 
 , idcols  = 
 , exclude = 
 , stats   = N
 , nodups  = Y
 , print   = N
 , debug   = N
   );

   %if %upcase(&debug.) eq Y or &help. eq ? %then %do;

   %put INFO: ================================================================;
   %put INFO: Autocall SAS Macro "&sysmacroname." is starting..               ;
   %put INFO: ================================================================;

   %end;

   %*-------------------------------------------------------------------------;
   %* If macro called with "HELP" or "?" show info in log:                    ;
   %*-------------------------------------------------------------------------;

   %if &help. eq ? or %upcase(&help.) eq HELP %then %do;

      %put ;
      %put %nrstr(Help for macro definition %m_uc_compare_tables.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_compare_tables%( );
      %put %nrstr(   table1    = <libref.tablename of the base table> );
      %put %nrstr( , where1    = [<where statements for filtering table1 >] );
      %put %nrstr( , base      = [<Alias for table1 argument>] );
      %put %nrstr( , table2    = <libref.tablename of the comp table> );
      %put %nrstr( , where2    = [<where statements for filtering table2 >] );
      %put %nrstr( , comp      = [<Alias for table2 argument>] );
      %put %nrstr( , outtbl    = <libref.tablename of the diff table> );
      %put %nrstr( , diff      = [<Alias for outtbl argument>] );
      %put %nrstr( , idcols    = <list of id columns> );
      %put %nrstr( , exclude   = [<list of columns to exclude>] );
      %put %nrstr( , stats     = [Y|N] );
      %put %nrstr( , nodups    = [Y|N] );
      %put %nrstr( , print     = [Y|N] );
      %put %nrstr( , debug     = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to determine the differences between two datasets. );
      %put ;
      %put %nrstr(The macro compares two tables or SAS datasets, the base dataset );
      %put %nrstr(TABLE1 and the comparison dataset TABLE2. The macro procedure );
      %put %nrstr(determines both matching variables and records or observations. );
      %put %nrstr(Matching variables are those having the same name and type. );
      %put %nrstr(Matching observations are those having identical values for all );
      %put %nrstr(specified IDCOLS variables or if IDCOLS parameter is not set, );
      %put %nrstr(those columns that occur in the same position in the datasets. );
      %put %nrstr(If matched observations by IDCOLS variables is set, then both );
      %put %nrstr(SAS datasets or tables must be sorted by all IDCOLS variables. );
      %put ;
      %put %str(Copyright 2008-%sysfunc(today(),year4.) Paul Alexander Canals y Trocha );
      %put ;
      %put %str(This program is free software: you can redistribute it and/or modify );
      %put %str(it under the terms of the GNU General Public License as published by );
      %put %str(the Free Software Foundation, either version 3 of the License, or );
      %put %str((at your option) any later version. );
      %put ;
      %put %str(This program is distributed in the hope that it will be useful, );
      %put %str(but WITHOUT ANY WARRANTY; without even the implied warranty of );
      %put %str(MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the );
      %put %str(GNU General Public License for more details. );
      %put ;
      %put %str(You should have received a copy of the GNU General Public License );
      %put %str(along with this program. If not, see <https://www.gnu.org/licenses/>. );
      %put ;

      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Set local macro variables and initialize environment:                   ;
   %*-------------------------------------------------------------------------;

   %local
      attrib
      base_fmt
      cols
      comp_fmt
      date
      dcols1
      dcols2
      del_d
      diffcols
      dsopt1
      dsopt2
      i
      item
      key_lst
      key_num
      msg1
      msg2
      msg3
      msg4
      msg5
      msg6
      msg7
      msg8
      msg9
      msg10
      msg11
      msg12
      msg13
      msg14
      msg15
      n_base
      n_bdup
      n_cdup
      n_comp
      n_diff
      n_list
      ncols1
      ncols2
      prgm
      samecols
      saveopts
      sortcols
      start
      status
      stop
      table
      time
      version
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1  = %nrstr(Required parameter value TABLE1 is missing but mandatory!);
   %let msg2  = %nrstr(Libref for %upcase(&table1.) not given. Changed libref to: WORK!);
   %let msg3  = %nrstr(Required TABLE1 (%upcase(&table1.)) does not exist!);
   %let msg4  = %nrstr(%upcase(&table1.) column list is: &dcols1.);
   %let msg5  = %nrstr(Required parameter value TABLE2 is missing but mandatory!);
   %let msg6  = %nrstr(Libref for %upcase(&table2.) not given. Changed libref to: WORK!);
   %let msg7  = %nrstr(Required TABLE2 (%upcase(&table2.)) does not exist!);
   %let msg8  = %nrstr(%upcase(&table2.) column list is: &dcols2.);
   %let msg9  = %nrstr(Parameter value OUTTBL is not given. Changed to: %upcase(&outtbl.)!);
   %let msg10 = %nrstr(Libref for %upcase(&outtbl.) not given. Changed libref to: WORK!);
   %let msg11 = %nrstr(The list of columns between TABLE1 and TABLE2 are identical.);
   %let msg12 = %nrstr(The following columns are missing in %upcase(&table.): &diffcols.);
   %let msg13 = %nrstr(&n_bdup. duplicate observation(s) removed from %upcase(&table1.).);
   %let msg14 = %nrstr(&n_cdup. duplicate observation(s) removed from %upcase(&table2.).);
   %let msg15 = %nrstr(No unequal values were found. All values compared are exactly equal.);

   %*-------------------------------------------------------------------------;
   %* Submacro: get the table column attrib information (data step style):    ;
   %*-------------------------------------------------------------------------;

   %macro get_col_code(
      table   = 
    , include = 
      );

      %local
         attrib
         code
         dsid 
         nvars
         lentyp
         varfmt
         varifm
         varlbl
         varlen
         varnam
         varnum
         vartyp
         ;

      %* Open the table: ;
      %let dsid = %sysfunc(open(&table.));

      %if &dsid. %then %do;

         %* Get number of columns: ;
         %let nvars = %sysfunc(attrn(&dsid., NVARS));

         %* Initialize return code string: ;
         %let code = ; 

         %* Loop to obtain column attribute information: ;
         %do varnum=1 %to &nvars.;

            %* Get column attribute information: ;
            %let varnam = %sysfunc(varname(&dsid,&varnum.));
            %let vartyp = %sysfunc(vartype(&dsid.,&varnum.));
            %let varlen = %sysfunc(varlen(&dsid.,&varnum.)); 
            %let varfmt = %sysfunc(varfmt(&dsid.,&varnum.));
            %let varifm = %sysfunc(varinfmt(&dsid.,&varnum.));
            %let varlbl = %sysfunc(varlabel(&dsid.,&varnum.));

            %* Build column attribute information list: ;
            %if %upcase(&vartyp.) eq C %then %let lentyp = $;
            %else %let lentyp = %str();
            %let attrib = &varnam. length=&lentyp.&varlen. ;
            %if &varfmt. ne %str() %then %let attrib = &attrib. format=&varfmt.;
            %if &varifm. ne %str() %then %let attrib = &attrib. informat=&varifm.;
            %if %length(&varlbl.) ne 0 %then %let attrib = &attrib. label="&varlbl.";
            %else %let attrib = &attrib. label="&varnam.";

            %* Create final RESULT column attribute list: ;
            %if %length(%nrbquote(&include.)) gt 0 %then %do;
               %if %index(%nrbquote(%upcase(&include.)),%upcase(&varnam.)) gt 0 %then %do;
                  %if %length(&code.) eq 0 %then %let code = %sysfunc(strip(&attrib.));
                  %else %let code = %sysfunc(strip(&code.)) %sysfunc(strip(&attrib.));
               %end;
            %end;
            %else %do;
               %if %length(&code.) eq 0 %then %let code = %sysfunc(strip(&attrib.));
               %else %let code = %sysfunc(strip(&code.)) %sysfunc(strip(&attrib.));
            %end;

         %end;

         %* Close the table: ;
         %let rc = %sysfunc(close(&dsid.));

      %end;
      %else %do;

         %let code = %sysfunc(sysmsg());

      %end;

      &code.

   %mend get_col_code;

   %*-------------------------------------------------------------------------;
   %* Submacro: get the table column format information:                      ;
   %*-------------------------------------------------------------------------;

   %macro get_col_format(
      table  = 
    , column = 
      );

      %local
         dsid 
         format
         varfmt
         varlen
         varnum
         vartyp
         ;

      %* Open the table: ;
      %let dsid = %sysfunc(open(&table.));

      %if &dsid. %then %do;

         %* Get column attribute information: ;
         %let varnum = %sysfunc(varnum(&dsid.,&column.));
         %let vartyp = %sysfunc(vartype(&dsid.,&varnum.));
         %let varlen = %sysfunc(varlen(&dsid.,&varnum.)); 
         %let varfmt = %sysfunc(varfmt(&dsid.,&varnum.));

         %* Determine the table column format: ;
         %if &varfmt. eq %str() %then %do;
            %if %upcase(&vartyp.) eq N %then %let format = %cmpres(8.);
            %else %if %upcase(&vartyp.) eq C %then %let format = %cmpres($&varlen..);
         %end;
         %else %do;
            %let format = &varfmt.;
         %end;

         %* Close the table: ;
         %let rc = %sysfunc(close(&dsid.));

      %end;
      %else %do;

         %let format = %sysfunc(sysmsg());

      %end;

      &format.

   %mend get_col_format;

   %*-------------------------------------------------------------------------;
   %* Submacro: get the table column type information:                        ;
   %*-------------------------------------------------------------------------;

   %macro get_col_type(
      table  = 
    , column = 
      );

      %local
         dsid 
         type
         varfmt
         varlen
         varnum
         vartyp
         ;

      %* Open the table: ;
      %let dsid = %sysfunc(open(&table.));

      %if &dsid. %then %do;

         %* Get column attribute information: ;
         %let varnum = %sysfunc(varnum(&dsid.,&column.));
         %let vartyp = %sysfunc(vartype(&dsid.,&varnum.));
         %let varlen = %sysfunc(varlen(&dsid.,&varnum.)); 
         %let varfmt = %sysfunc(varfmt(&dsid.,&varnum.));

         %* Evaluate CHAR type: ;
         %if &vartyp. eq C %then %let type = CHAR;

         %* Evaluate NUM, DATE, DATETIME and TIME types: ;
         %else %if &vartyp. eq N and &varlen. eq 8 %then %do;

            %* Check for DATETIME format type: ;
            %if %index(&varfmt.,DATETIME)
               or %index(&varfmt.,AMPM)
               or %index(&varfmt.,DTDATE)
               or (%index(&varfmt.,NLDAT) 
                   and not %index(&varfmt.,NLDATE)
                  )
               or (%index(&varfmt.,8601)
                   and (%index(&varfmt.,DN)
                    or %index(&varfmt.,DT)
                    or %index(&varfmt.,DZ)  
                  )
               )
               %then %let type = DATETIME;

            %* Check for DATE format type: ;
            %else %if %index(&varfmt.,DATE)
             or %index(&varfmt.,JULDAY)
             or %index(&varfmt.,JULIAN)
             or %index(&varfmt.,WEEK)
             or %index(&varfmt.,YY)
             or (%index(&varfmt.,8601)
                 and (%index(&varfmt.,DA)
                  or %index(&varfmt.,DX) 
                )
             )
             %then %let type = DATE;

            %* Check for TIME format type: ;
            %else %if %index(&varfmt.,TIME)
               or %index(&varfmt.,TOD)
               or (%index(&varfmt.,8601)
                   and (%index(&varfmt.,LX)
                    or %index(&varfmt.,TX)
                    or %index(&varfmt.,TZ) 
                  )
               )
               %then %let type = TIME;

            %* Any other numeric format type: ;
            %else %let type = NUM;

         %end;

         %* Close the table: ;
         %let rc = %sysfunc(close(&dsid.));

      %end;
      %else %do;

         %let type = %sysfunc(sysmsg());

      %end;

      &type.

   %mend get_col_type;

   %*-------------------------------------------------------------------------;
   %* Submacro: get the number of records from a SAS dataset or table:        ;
   %*-------------------------------------------------------------------------;

   %macro get_nlobs(
      table =
      );

      %local
         dsid
         nobs
         ;

      %* Open the table: ;
      %let dsid = %sysfunc(open(&table.));

      %if &dsid. %then %do;

         %* Get the number of records: ;
         %let nobs = %sysfunc(attrn(&dsid.,NLOBS));

         %* Close the table: ;
         %let rc = %sysfunc(close(&dsid.));

      %end;
      %else %do;

         %let nobs = 0;

      %end;

      &nobs.

   %mend get_nlobs;

   %*-------------------------------------------------------------------------;
   %* Submacro: get the table column columns list information:                ;
   %*-------------------------------------------------------------------------;

   %macro get_varlist(
      table   = 
    , exclude = 
      );

      %local
         dsid 
         list
         nvars
         varnam
         varnum
         ;

      %* Open the table: ;
      %let dsid = %sysfunc(open(&table.));

      %if &dsid. %then %do;

         %* Get number of columns: ;
         %let nvars = %sysfunc(attrn(&dsid., NVARS));

         %* Initialize return code string: ;
         %let list = ; 

         %* Loop to obtain column attribute information: ;
         %do varnum=1 %to &nvars.;

            %* Get column name information: ;
            %let varnam = %sysfunc(varname(&dsid,&varnum.));

            %* Create final RESULT column name list: ;
            %if %length(%nrbquote(&exclude.)) gt 0 %then %do;
               %if %index(%nrbquote(%upcase(&exclude.)),%upcase(&varnam.)) eq 0 %then %do;
                  %if %length(&list.) eq 0 %then %let list = %sysfunc(strip(&varnam.));
                  %else %let list = %sysfunc(strip(&list.)) %sysfunc(strip(&varnam.));
               %end;
            %end;
            %else %do;
               %if %length(&list.) eq 0 %then %let list= %sysfunc(strip(&varnam.));
               %else %let list = %sysfunc(strip(&list.)) %sysfunc(strip(&varnam.));
            %end;

         %end;

         %* Close the table: ;
         %let rc = %sysfunc(close(&dsid.));

      %end;
      %else %do;

         %let list = %sysfunc(sysmsg());

      %end;

      &list.

   %mend get_varlist;

   %*-------------------------------------------------------------------------;
   %* Submacro: compare two list of words against each other:                 ;
   %*-------------------------------------------------------------------------;

   %macro list_operation(
      left  = 
    , right =
    , op    =  
      );

      %local
         item
         item_no
         item_upc
         list
         ;

      %* Initialise loop: ;
      %let list =;
      %let item_no = 1;
      %let item = %scan(&left.,1,%str( ));
      %let item_upc = %upcase(&item.);

      %* DIFFERENCE list operation (Left set minus Right set): ;
      %if %upcase(&op.) eq DIFFERENCE %then %do;
         %* Loop over items ;
         %do %while(%length(&item.) gt 0);
            %if %index( %str( )%upcase(&right.)%str( ), %str( )&item_upc.%str( ) ) eq 0 
               and %index( %str( )%upcase(&list.)%str( ), %str( )&item_upc.%str( ) ) eq 0 %then
               %let list = &list. &item.;
            %let item_no = %eval(&item_no.+1);
            %let item = %scan(&left.,&item_no.,%str( ));
            %let item_upc = %upcase(&item.);
         %end;
      %end;

      %* INTERSECTION list operation (In both Left and Right set): ;
      %if %upcase(&op.) eq INTERSECTION %then %do;
         %* Loop over items ;
         %do %while(%length(&item.) gt 0);
            %if %index( %str( )%upcase(&right.)%str( ), %str( )&item_upc.%str( ) ) gt 0 %then %do;
               %if %index( %str( )%upcase(&list.)%str( ), %str( )&item_upc.%str( ) ) eq 0 %then
                  %let list = &list. &item.;
            %end;
            %let item_no = %eval(&item_no.+1);
            %let item = %scan(&left.,&item_no.,%str( ));
            %let item_upc = %upcase(&item.);
         %end;
      %end;

      &list.

   %mend list_operation;

   %*-------------------------------------------------------------------------;
   %* Submacro: print a message to the log and/or result output:              ;
   %*-------------------------------------------------------------------------;

   %macro print_message(
      program = &sysmacroname.
    , status  = OK
    , message = %quote()
    , print   = N
      );

      %local report;

      %* Check if STATUS has been given a valid value: ;
      %let status = %upcase(%substr(&status.,1,1));
      %let status = %scan(Abort Debug Error Info Ok Warning,%eval(1+%index(DEIOW,&status.)));

      %* If status code is invalid, set to default value: ;
      %if &status. eq Abort %then %do;
         %let status = OK;
      %end;

      %* Check STATUS and print the message into the log output: ;
      %if &status. eq Error %then %do;
         %put %str(ERR)OR: &program. &message.;
      %end;
      %else %if &status. eq Info %then %do;
         %put %str(INF)O: &program. &message.;
      %end;
      %else %if &status. eq Warning %then %do;
         %put %str(WAR)NING: &program. &message.;
      %end;
      %else %if &status. eq Debug %then %do;
         %put %str(DEB)UG: &program. &message.;
      %end;
      %else %do;
         %put NOTE: &program. &message.;
      %end;

      %* If PRINT = Y, do a SAS proc report step and output to result tab: ;
      %if %upcase(&print.) eq Y %then %do;

         %* Create a temporary report table, and load the messsage info: ;
         data WORK.report;
            attrib program length=$32  label='Program';
            attrib message length=$200 label='Message';
            attrib status  length=$10  label='Status';
            program = "%upcase(&program.)";
            message = "&message.";
            status  = "%upcase(&status.)";
         run;

         %* Build report content layout: ;
         title "%upcase(&syshostname.) - Status Message for Program: %lowcase(&program.)";
         footnote "Generated on &date. at &time.";
         footnote2 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %let report = %str(%sysfunc(compbl(

            proc report data=WORK.report nowd headline headskip;
               columns 
                  program 
                  message
                  status 
                  ;
               define program / display 'Program' format=$32.;
               define message / display 'Message' format=$200.;
               define status  / display 'Status'  format=$10.;
               compute status;
                  if substr(status,1,1) eq 'D' then call define (_COL_,'style','style=[background=cxac74d9]');
                  if substr(status,1,1) eq 'E' then call define (_COL_,'style','style=[background=verylightred]');
                  if substr(status,1,1) eq 'O' then call define (_COL_,'style','style=[background=lightgreen]');
                  if substr(status,1,1) eq 'W' then call define (_COL_,'style','style=[background=cxffff99]');
               endcomp;
            run;

            )));

         %* Display report list in Result tab: ;
         &report.

         title;
         footnote;
         footnote2;

         %* Clean up before we leave: ;
         %if %upcase(&debug.) ne Y %then %do;
            proc datasets lib=WORK nolist nowarn memtype = (data view);
               delete report;
            quit;
         %end;

      %end; %* print=Y ;

   %mend print_message;

   %*-------------------------------------------------------------------------;
   %* IF DEBUG = Y, set SAS verbose logging / debugging options:              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) eq Y %then %do;
      options fullstimer msglevel=i;
   %end;



   %*-------------------------------------------------------------------------;
   %* Check if any dataset like table options are set (rename, where etc.):   ;
   %*-------------------------------------------------------------------------;

   %* Main base table options: ;
   %if %length(%nrbquote(&base.)) gt 0 %then %let table1 = &base.;

   %if %index(&table1.,%str(%()) gt 0 %then %do;

      %* Set table1 options into macro variable ;
      %let dsopt1 = %substr(&table1.,%index(&table1.,%str(%()));
      %* Remove data step style outer brackets ;
      %if %length(&dsopt1.) eq 2 %then %let dsopt1 = %str();
      %else %let dsopt1 = %substr(&dsopt1,2,%eval(%length(&dsopt1.)-2));

      %* Set table1 value without options ;
      %let table1 = %scan(&table1.,1,%str(%());

   %end;
   %else %do;

      %let dsopt1 = %str();

   %end;

   %* Comparison table options: ;
   %if %length(%nrbquote(&comp.)) gt 0 %then %let table2 = &comp.;

   %if %index(&table2.,%str(%()) gt 0 %then %do;

      %* Set table2 options into macro variable ;
      %let dsopt2 = %substr(&table2.,%index(&table2.,%str(%()));
      %* Remove data step style outer brackets ;
      %if %length(&dsopt2.) eq 2 %then %let dsopt2 = %str();
      %else %let dsopt2 = %substr(&dsopt2,2,%eval(%length(&dsopt2.)-2));

      %* Set table2 value without options ;
      %let table2 = %scan(&table2.,1,%str(%());

   %end;
   %else %do;

      %let dsopt2 = %str();

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if the TABLE1 parameter has been given a value:                   ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&table1.)) eq 0 or %nrbquote(&table1.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* If libname is missing, then set WORK as default library:                ;
   %*-------------------------------------------------------------------------;

   %if %index(&table1.,.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg2.)
       , print   = N
         )
      %let table1 = WORK.&table1.;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if the TABLE1 table exists:                                       ;
   %*-------------------------------------------------------------------------;

   %if not %sysfunc(exist(&table1.)) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg3.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Create a view of TABLE1, and add observation number column:             ;
   %*-------------------------------------------------------------------------;

   data WORK.v_base / view=WORK.v_base;
      attrib OBS length=8 label='Observation';
      set &table1. (&dsopt1.);
      obs = _n_;
   run;

   %*-------------------------------------------------------------------------;
   %* Create a list containing all columns in TABLE1:                         ;
   %*-------------------------------------------------------------------------;

   %let dcols1 = %get_varlist(table=WORK.v_base);
   %let ncols1 = %sysfunc(countw(&dcols1.,%str( )));

   %print_message(
      program = &prgm.
    , status  = OK
    , message = %unquote(&msg4.)
    , print   = N
      )

   %*-------------------------------------------------------------------------;
   %* Check if the TABLE2 parameter has been given a value:                   ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&table2.)) eq 0 or %nrbquote(&table2.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg5.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* If libname is missing, then set WORK as default library:                ;
   %*-------------------------------------------------------------------------;

   %if %index(&table2.,.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg6.)
       , print   = N
         )
      %let table2 = WORK.&table2.;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if the TABLE2 table exists:                                       ;
   %*-------------------------------------------------------------------------;

   %if not %sysfunc(exist(&table2.)) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg7.)
       , print   = &print.
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* Create a view of TABLE2, and add observation number column:             ;
   %*-------------------------------------------------------------------------;

   data WORK.v_comp / view=WORK.v_comp;
      attrib OBS length=8 label='Observation';
      set &table2. (&dsopt2.);
      obs = _n_;
   run;

   %*-------------------------------------------------------------------------;
   %* Create a list containing all columns in TABLE2:                         ;
   %*-------------------------------------------------------------------------;

   %let dcols2 = %get_varlist(table=WORK.v_comp);
   %let ncols2 = %sysfunc(countw(&dcols2.,%str( )));

   %print_message(
      program = &prgm.
    , status  = OK
    , message = %unquote(&msg8.)
    , print   = N
      )

   %*-------------------------------------------------------------------------;
   %* Check if the OUTTBL parameter has been given a value:                   ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&diff.)) gt 0 %then %let outtbl = &diff.;

   %if %length(%nrbquote(&outtbl.)) eq 0 or %nrbquote(&outtbl.) eq _NONE_ %then %do;

      %let outtbl = WORK.d_diff;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg9.)
       , print   = N
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* If OUTTBL parameter is set, delete the comparison result tables:        ;
   %*-------------------------------------------------------------------------;

   %else %do;

      %let del_d = d_:;

   %end;

   %*-------------------------------------------------------------------------;
   %* If libname is missing, then set WORK as default library:                ;
   %*-------------------------------------------------------------------------;

   %if %index(&outtbl.,.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg10.)
       , print   = N
         )
      %let outtbl = WORK.&outtbl.;

   %end;

   %*-------------------------------------------------------------------------;
   %* Compare between the columns of TABLE1 and TABLE2:                       ;
   %*-------------------------------------------------------------------------;

   %if &ncols1. eq &ncols2. %then %do;

      %let diffcols = 
         %get_varlist(
            table   = WORK.v_base
          , exclude = &dcols2.
            );

      %if &diffcols. eq %str() %then %do;

         %print_message(
            program = &prgm.
          , status  = OK
          , message = %unquote(&msg11.)
          , print   = N
            )

      %end;
      %else %do;

         %let table = &table2.;

         %print_message(
            program = &prgm.
          , status  = WNG
          , message = %unquote(&msg12.)
          , print   = &print.
            )  

      %end;

   %end;
   %else %if &ncols1. gt &ncols2. %then %do; 

      %let table = &table2.;

      %let diffcols = 
         %get_varlist(
            table   = WORK.v_base
          , exclude = &dcols2.
            );

      %print_message(
         program = &prgm.
       , status  = WNG
       , message = %unquote(&msg12.)
       , print   = &print.
         )

   %end;
   %else %do;

      %let table = &table1.;

      %let diffcols = 
         %get_varlist(
            table   = WORK.v_comp
          , exclude = &dcols1.
            );

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg12.)
       , print   = N
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* Determine the common columns between TABLE1 and TABLE2:                 ;
   %*-------------------------------------------------------------------------;

   %let samecols = 
      %list_operation(
         left  = &dcols1.
       , right = &dcols2.
       , op    = Intersection
         );

   %put &=samecols.;

   %*-------------------------------------------------------------------------;
   %* Determine the sort columns for TABLE1 and TABLE2:                       ;
   %*-------------------------------------------------------------------------;

   %let sortcols = 
      %list_operation(
         left  = &samecols.
       , right = &idcols. &exclude. obs
       , op    = Difference
         );

   %put &=sortcols.;

   %*-------------------------------------------------------------------------;
   %* If NODUPS=Y then remove duplicate records from TABLE1 and TABLE2:       ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&nodups.) eq Y %then %do;

      %* Remove duplicates from TABLE1 (base) ;
      proc sort data=WORK.v_base out=WORK.t_base (keep=&samecols.) 
         nodupkey dupout=WORK.d_base_dups;
         %if %length(&where1.) ne 0 %then %do; where &where1.; %end;
         by &idcols. %if %length(&idcols.) eq 0 %then %do; &sortcols. %end; ;
      run;

      %let n_bdup = %get_nlobs(table=WORK.d_base_dups);

      %if %eval(&n_bdup.) gt 0 %then %do;

         %print_message(
            program = &prgm.
          , status  = OK
          , message = %unquote(&msg13.)
          , print   = N
            )

      %end;
      %else %do;

         proc datasets library=WORK nolist nowarn memtype=(data view);
            delete d_base_dups ;
         quit;

      %end;

      %* Sort base table by IDCOLS and SORTCOLS columns ;
      proc sort data=WORK.t_base (keep=&samecols.);
         by &idcols. &sortcols.;
      run;

      %* Remove duplicates from TABLE2 (comp) ;
      proc sort data=WORK.v_comp out=WORK.t_comp (keep=&samecols.) 
         nodupkey dupout=WORK.d_comp_dups;
         %if %length(&where2.) ne 0 %then %do; where &where2.; %end;
         by &idcols. %if %length(&idcols.) eq 0 %then %do; &sortcols. %end; ;
      run;

      %let n_cdup = %get_nlobs(table=WORK.d_comp_dups);

      %if %eval(&n_cdup.) gt 0 %then %do;

         %print_message(
            program = &prgm.
          , status  = OK
          , message = %unquote(&msg14.)
          , print   = N
            )

      %end;
      %else %do;

         proc datasets library=WORK nolist nowarn memtype=(data view);
            delete d_comp_dups ;
         quit;

      %end;

      %* Sort compare table by IDCOLS and SORTCOLS columns ;
      proc sort data=WORK.t_comp (keep=&samecols.);
         by &idcols. &sortcols.;
      run;

   %end;

   %*-------------------------------------------------------------------------;
   %* Sort both TABLE1 and TABLE2 by both IDCOLS and SORTCOLS:                ;
   %*-------------------------------------------------------------------------;

   %else %do;

      %* Sort TABLE1 (base) by IDCOLS and SORTCOLS columns ;
      proc sort data=WORK.v_base out=WORK.t_base (keep=&samecols.);
         %if %length(&where1.) ne 0 %then %do; where &where1.; %end;
         by &idcols. &sortcols.;
      run;

      %* Sort TABLE2 (compare) by IDCOLS and SORTCOLS columns ;
      proc sort data=WORK.v_comp out=WORK.t_comp (keep=&samecols.);
         %if %length(&where2.) ne 0 %then %do; where &where2.; %end;
         by &idcols. &sortcols.;
      run;

      %* Initialize variables ;
      %let n_bdup = 0;
      %let n_cdup = 0;

   %end;

   %*-------------------------------------------------------------------------;
   %* Compare TABLE1 and TABLE2 tables by using METHOD=EXACT:                 ;
   %*-------------------------------------------------------------------------;

   proc compare base=WORK.t_base compare=WORK.t_comp out=WORK.t_diff 
      %if %upcase(&stats.) eq Y %then %do; outstats=WORK.d_stats %end;
      method=exact outnoequal outbase outcomp outdiff noprint;
      %if %length(&idcols.) ne 0 %then %do; id &idcols.; %end;
   run;

   %if %get_nlobs(table=WORK.t_diff) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg15.)
       , print   = %sysfunc(ifc(%upcase(&print.) eq Y,Y,N))
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Sort and split the comparison result into BASE, COMP, and DIFF tables:  ;
   %*-------------------------------------------------------------------------;

   %if %length(&idcols.) eq 0 %then %let idcols = _obs_;

   %* Sort by id columns and type: ;
   proc sort data=WORK.t_diff out=WORK.t_sort;
      by &idcols. _type_;
   run;

   %* Add generated id key column: ;
   data WORK.t_sort_key;
      retain _key_ 0;
      set WORK.t_sort;
      if
      %do i=1 %to %sysfunc(countw(&idcols.,%str( )));
         %let item = %scan(&idcols.,&i.,%str( ));
         %if &i. eq 1 %then %do;
            first.&item.
         %end;
         %else %do;
            or first.&item.
         %end;
      %end;
      then _key_ = _key_ + 1;
      by &idcols.;
   run;

   data WORK.d_base WORK.d_comp WORK.t_diff;
      attrib _KEY_ length=8 label='Key Number';
      attrib _OBS_ length=8 label='Observation';
      set WORK.t_sort_key;
      if first._key_ and last._key_ then do;
         if upcase(_type_) eq 'BASE' then do 
            _obs_ = obs;
            output WORK.d_base;
         end;
         if upcase(_type_) eq 'COMPARE' then do;
            _obs_ = obs;
            output WORK.d_comp;
         end;
      end;
      else do;
         %if %upcase(&idcols.) ne _OBS_ %then %do;
            _obs_ = obs;
            if upcase(_type_) eq 'DIF' then do;
               _obs_ = .;
            end;
         %end;
         output WORK.t_diff;
      end;
      drop obs;
      by _key_;
   run;

   %*-------------------------------------------------------------------------;
   %* Prepare final result table conatining the attribute differences :       ;
   %*-------------------------------------------------------------------------;

   %* Set IDCOLS column attribute code: ;
   %if %upcase(&idcols.) eq _OBS_ %then %do; 

      %let attrib = ;
      %let idcols = ;

   %end;
   %else %do;

      %let attrib = 
         %get_col_code(
            table   = WORK.t_diff
          , include = &idcols.
            );

   %end;

   %* Initialize table structure: ;
   %let cols = 
      attrib 
         _KEY_   length=8 label='Key Number' 
         _B_OBS_ length=8 label='Base Observation' 
         _C_OBS_ length=8 label='Compare Observation'
         &attrib.
         _COL_   length=$100 label='Attribute Name' 
         _B_VAL_ length=$256 label='Base Value' 
         _C_VAL_ length=$256 label='Compare Value'
      ; 

   %* Initialize result table: ;
   data &outtbl.;
      &cols.;
      stop;
   run;

   %*-------------------------------------------------------------------------;
   %* Sort and transpose attribute differences, and load result table:        ;
   %*-------------------------------------------------------------------------;

   %if %get_nlobs(table=WORK.t_diff) gt 0 %then %do;
      %* Transpose column base and compare values: ;
      proc transpose data=WORK.t_diff
         out=WORK.t_diff_val (rename=(_name_=_col_))
         label = attribute;
         by _key_ &idcols.;
         id _type_;
         var &sortcols.;
      run;

      %* Transpose observation base and compare values: ;
      proc transpose data=WORK.t_diff
         out=WORK.t_diff_obs (keep=_key_ base compare);
         by _key_ &idcols.;
         id _type_;
         var _obs_;
      run;

      %* Merge column & observation base and compare values: ;
      data WORK.t_diff_trans;
         merge 
            WORK.t_diff_val (rename=(base=_b_val_ compare=_c_val_))
            WORK.t_diff_obs (rename=(base=_b_obs_ compare=_c_obs_))
            ;
         by _key_;
      run; 

      %* Filter where base and compare values are different: ;
      data WORK.t_result;
         keep _key_ _b_obs_ _c_obs_ &idcols. _col_ _b_val_ _c_val_ ;
         &cols.;
      %if %get_col_type(table=WORK.t_diff_trans,column=_b_val_) eq CHAR %then %do;
         set WORK.t_diff_trans;
         _b_val_ = strip(_b_val_);
         _c_val_ = strip(_c_val_);
         if index(dif,'X') or (substr(dif,1,1) ne '.' and strip(dif) ne 'E') then output;
      %end;
      %else %do;
         set WORK.t_diff_trans (rename=(_b_val_=_b_nval_ _c_val_=_c_nval_));
         _b_val_ = put(_b_nval_, %get_col_format(table=WORK.t_diff_trans,column=_b_val_));
         _c_val_ = put(_c_nval_, %get_col_format(table=WORK.t_diff_trans,column=_c_val_));
         drop _b_nval_ _c_nval_;
         if dif*1 ne . then output;
      %end;
      run;

      %* Append base and compare values to output table: ;
      proc append base=&outtbl. nowarn data=WORK.t_result;
      quit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Determine temporary report tables number of observations info:          ;
   %*-------------------------------------------------------------------------;

   %let n_base = %get_nlobs(table=WORK.d_base);
   %let n_comp = %get_nlobs(table=WORK.d_comp);
   %let n_diff = %get_nlobs(table=&outtbl.);

   %*-------------------------------------------------------------------------;
   %* If PRINT = Y, do a SAS proc report step and output to result tab:       ;
   %*-------------------------------------------------------------------------;
 
   %if %upcase(&print.) eq Y %then %do;

      %*----------------------------------------------------------------------;
      %* Build report content layout:                                         ;
      %*----------------------------------------------------------------------;

      title "%upcase(&syshostname.) - Data Comparison Summary for: %upcase(&table1.) and %upcase(&table2.)";

      %if %eval(&n_base.) gt 0 %then %do;

         title2 "Observation Summary (Base)";
         footnote "Observations in %upcase(&table1.) but not in %upcase(&table2.)";

         %if %eval(&n_bdup.) eq 0 and %eval(&n_comp.) eq 0 and %eval(&n_cdup.) eq 0 and %eval(&n_diff.) eq 0 %then %do;

            footnote2 "Generated on &date. at &time.";
            footnote3 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %end;

         proc report data=WORK.d_base(drop=_key_ _type_) nowd headline headskip;
            define _all_ / display;
         run;

         title;
         title2;

      %end;

      %if %eval(&n_bdup.) gt 0 %then %do;

         title2 "Duplicate Summary (Base)";
         footnote "Duplicate Observations in %upcase(&table1.)";

         %if %eval(&n_comp.) eq 0 and %eval(&n_cdup.) eq 0 and %eval(&n_diff.) eq 0 %then %do;

            footnote2 "Generated on &date. at &time.";
            footnote3 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %end;

         proc report data=WORK.d_base_dups nowd headline headskip;
            define _all_ / display;
         run;

         title;
         title2;

      %end;

      %if %eval(&n_comp.) gt 0 %then %do;

         title2 "Observation Summary (Compare)";
         footnote "Observations in %upcase(&table2.) but not in %upcase(&table1.)";

         %if %eval(&n_cdup.) eq 0 and %eval(&n_diff.) eq 0 %then %do;

            footnote2 "Generated on &date. at &time.";
            footnote3 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %end;

         proc report data=WORK.d_comp(drop=_key_ _type_) nowd headline headskip;
            define _all_ / display;
         run;

         title;
         title2;

      %end;

      %if %eval(&n_cdup.) gt 0 %then %do;

         title2 "Duplicate Summary (Compare)";
         footnote "Duplicate Observations in %upcase(&table2.)";

         %if %eval(&n_diff.) eq 0 %then %do;

            footnote2 "Generated on &date. at &time.";
            footnote3 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         %end;

         proc report data=WORK.d_comp_dups nowd headline headskip;
            define _all_ / display;
         run;

         title;
         title2;

      %end;

      %if %eval(&n_diff.) gt 0 %then %do;

         title2 "Attribute Summary (Differences)";
         footnote "Attribute value differences between %upcase(&table1.) and %upcase(&table2.)";
         footnote2 "Generated on &date. at &time.";
         footnote3 "Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";

         proc report data=&outtbl.(drop=_key_) nowd headline headskip;
            define _all_ / display;
         run;

         title;
         title2;

      %end;

      footnote;
      footnote2;
      footnote3;

   %end; %* print=Y ;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      proc datasets library=WORK nolist nowarn memtype=(data view);
         delete &del_d. t_: v_: ;
      quit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Calculate processing time:                                              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) eq Y %then %do;

      %let stop = %sysfunc(datetime());
      %let time = %sysfunc(intck(SECOND, &start., &stop.), time10.);

      %put NOTE: &sysmacroname. Total Processing time &time. (hh:mm:ss);

   %end;

   %exit:

   %if %upcase(&debug.) eq Y or &help. eq ? %then %do;

   %put INFO: ================================================================;
   %put INFO: Autocall SAS Macro "&sysmacroname." has finished.               ;
   %put INFO: ================================================================;

   %end;

%mend m_uc_compare_tables;
