/*!
 ******************************************************************************
 * \file       m_uc_create_ddl.sas
 * \ingroup    Custom
 * \brief      Custom macro to create a Data Definition Language DDL script.
 * \details    This macro obtains all column, index and constraint information
 *             from a given table to be used to generate a Data Definition 
 *             Language (DDL) file. The DDL file contains a SAS proc sql step 
 *             to create a new instance of the given source table.
 * 
 * \note       This macro is able to generate DDL files to create tables for
 *             engine type of SAS or Oracle. Other engine types may be added
 *             in the future. 
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-04-11 00:00:00
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  libnm       Parameter to specify the SAS library reference. 
 *                         The default value for LIBNM is: _NONE.
 * \param[in]  tblnm       Parameter to specify the SAS dataset or table. 
 *                         The default value for TBLNM is: _NONE_.
 * \param[in]  creds       String containing the Oracle database credentials
 *                         information. The following order of parameters is 
 *                         to be respected for the macro to work properly:
 *                         + user=, password=, path=
 * \param[in]  ddl_file    Specifies the full path and name of the DDL 
 *                         file where the formatted output is written to. 
 *                         If the file that you specify does not exist, 
 *                         then it will be created for you. 
 *                         The default value for DDL_FILE is: _NONE_.
 * \param[in]  prm_flg     Boolean [Y|N] parameter to specify wether the
 *                         output DDL contains the identical libref, table
 *                         name, and credentials as the input source table
 *                         or to parameterize this information by using
 *                         SAS macro variables instead. If PRM_FLG=Y, the
 *                         libref, table name and optional credentials 
 *                         are replaced by the PRM_LIB, PRM_TBL, and
 *                         PRM_CREDS values. The default value is: N.
 * \param[in]  prm_lib     Optional. Parameter to specify the output DDL 
 *                         SAS library reference name or the SAS macro 
 *                         variable name value (e.g. &libref.). 
 * \param[in]  prm_tbl     Optional. Parameter to specify the output DDL
 *                         SAS dataset or table name or the SAS macro 
 *                         variable name value (e.g. &table.).
 * \param[in]  prm_creds   Optional. String containing the output DDL 
 *                         database credentials or SAS encryption key 
 *                         information. The following list of arguments
 *                         is to be respected to work properly:
 *                         + Engine = ORA: user=, password=, path=
 *                         + Engine = SAS: encrypt=aes encryptkey= 
 *                         + Alternatively a SAS macro variable name
 *                         value can be used (e.g. &creds.).
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by using proc report steps with style HtmlBlue. 
 *                         The default value for PRINT is: N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     Returns all column index information on a given table.
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_create_ddl(?)
 * \endcode
 * 
 * \example    For the next examples create a table with a couple of indexes:
 * \code
 *             proc sql noprint feedback stimer;
 *                CREATE TABLE WORK.BANKKONTO (
 *                   MANDANT_ID           VARCHAR(8)     label='Mandant Identifier'
 *                 , PARTNER_ID           NUMERIC(8)     label='Geschäftspartner Identifier'
 *                 , KONTO_ID             NUMERIC(8)     label='Konto Identifier'
 *                 , KONTO_WAEHRUNG_CD    VARCHAR(3)     label='Geschäftswährung'
 *                 , KONTO_TYPE_CD        VARCHAR(32)    label='Konto Type Code'
 *                 , SALDO_AMT            NUMERIC(8)     format=19.2 label='Saldo Betrag'
 *                 , LOAD_DTTM            NUMERIC(20)    format=datetime20. label='Ladezeitstempel'
 *                 , CONSTRAINT PRIM_KEY PRIMARY KEY (MANDANT_ID, KONTO_ID, LOAD_DTTM)
 *                   );
 *                CREATE UNIQUE INDEX PARTNER_ID ON WORK.BANKKONTO (PARTNER_ID);
 *                CREATE INDEX IDX_BANKKONTO ON WORK.BANKKONTO (KONTO_ID, LOAD_DTTM);
 *             quit;
 * \endcode
 * 
 * \example    Example 2: Create a Data Definition Language file for table bankkonto:
 * \code
 *             %m_uc_create_ddl(
 *                libnm    = WORK
 *              , tblnm    = bankkonto
 *              , ddl_file = %sysfunc(getoption(WORK))/bankkonto_work.sas
 *              , print    = Y
 *              , debug    = Y
 *                );
 * \endcode
 * 
 * \example    Example 3: Create a DDL file for table bankkonto with libref parameter:
 * \code
 *             %m_uc_create_ddl(
 *                libnm   = WORK
 *              , tblnm   = bankkonto
 *              , ddl_file = %sysfunc(getoption(WORK))/bankkonto_libref.sas
 *              , prm_flg = Y
 *              , prm_lib = %nrstr(&libref.)
 *              , print   = Y
 *              , debug   = Y
 *                );
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
%macro m_uc_create_ddl(
   help
 , vers      = 21.1.04
 , libnm     = _NONE_
 , tblnm     = _NONE_
 , creds     = %str()
 , ddl_file  = _NONE_
 , prm_flg   = N
 , prm_lib   = %nrstr()
 , prm_tbl   = %nrstr()
 , prm_creds = %nrstr()
 , print     = N
 , debug     = N
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
      %put %nrstr(Help for macro definition %m_uc_create_ddl.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_create_ddl%( );
      %put %nrstr(   libnm     = <libname> );
      %put %nrstr( , tblnm     = <tablename> );
      %put %nrstr( , creds     = %str([user= password= [path=|dsn=]|encryptkey=| ]) );
      %put %nrstr( , ddl_file  = <full path>/<file name>.sas );
      %put %nrstr( , prm_flg   = [Y|N] );
      %put %nrstr( , prm_lib   = [ |[<output libname>|%nrstr(<macro variable>.)]] );
      %put %nrstr( , prm_tbl   = [ |[<output tablename>|%nrstr(<macro variable>.)]] );
      %put %nrstr( , prm_creds = [ |[%str([user= password= [path=|dsn=]| ])|%nrstr(<macro variable>.)]] );
      %put %nrstr( , print     = [Y|N] );
      %put %nrstr( , debug     = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to create a Data Definition Language DDL script.);
      %put ;
      %put %nrstr(This macro obtains all column, index and constraint information );
      %put %nrstr(from a given table to be used to generate a Data Definition );
      %put %nrstr(Language (DDL) file. The DDL file contains a SAS proc sql step ); 
      %put %nrstr(to create a new instance of the given source table. );
      %put ;
      %put %nrstr(This macro is able to generate DDL files to create tables for );
      %put %nrstr(engine type of SAS or Oracle. Other engine types may be added );
      %put %nrstr(in the future. );
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
      cols
      cons
      ddl_con
      ddl_enc
      ddl_lib
      ddl_tbl
      ddl_type
      date
      delim
      encrypted
      engine
      fname
      fpath
      idxs
      isview
      list
      msg1
      msg2
      msg3
      msg4
      msg5
      msg6
      msg7
      msg8
      msg9
      prgm
      start
      stop
      time
      usrnm
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1 = %nrstr(Parameter LIBNM is not given but is mandatory!);
   %let msg2 = %nrstr(Libref %upcase(&libnm.) does not exist. Exiting!);
   %let msg3 = %nrstr(Parameter TBLNM is not given but is mandatory!);
   %let msg4 = %nrstr(Table %upcase(&libnm..&tblnm.) is not a table. Exiting!);
   %let msg5 = %nrstr(Table %upcase(&libnm..&tblnm.) does not exist. Exiting!);
   %let msg6 = %nrstr(Parameter DDL_FILE is not given but is mandatory!);
   %let msg7 = %nrstr(SAS engine: encrypted datasets are not allowed!);
   %let msg8 = %nrstr(Oracle engine: connection credentials are missing!);
   %let msg9 = %nrstr(This macro only works for ORACLE or SAS tables!);

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
   %* Check if the LIBNM parameter has been given a value:                    ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&libnm.)) eq 0 or %nrbquote(&libnm.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if LIBNM library reference exists and is assigned:                ;
   %*-------------------------------------------------------------------------;

   %if %sysfunc(libref(&libnm.)) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg2.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if the TBLNM parameter has been given a value:                    ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&tblnm.)) eq 0 or %nrbquote(&tblnm.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg3.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if LIBNM.TBLNM is a table (and not a view), otherwise exit:       ;
   %*-------------------------------------------------------------------------;

   proc sql feedback stimer noprint;
      select count(memname)
        into :isview
        from SASHELP.vsview
       where upcase(libname) eq "%upcase(&libnm.)" and upcase(memname) eq "%upcase(&tblnm.)"
      ;
   quit;

   %if &isview. %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg4.)
       , print   = &print.
         )
      %goto exit;

   %end;


   %*-------------------------------------------------------------------------;
   %* Check if the LIBNM.TBLNM table exists and can be opened:                ;
   %*-------------------------------------------------------------------------;

   %if not %sysfunc(exist(&libnm..&tblnm.)) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg5.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if DDL_FILE has been given a value:                               ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&ddl_file.)) le 1 or %nrbquote(&ddl_file.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg6.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Detect and set the proper delimiter for UNIX versus Windows:            ;
   %*-------------------------------------------------------------------------;

   %let delim = %sysfunc(ifc(%eval(&sysscp. eq WIN),\,/));
   %let ddl_file = %sysfunc(tranwrd(&ddl_file.,%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.));

   %*-------------------------------------------------------------------------;
   %* Obtain engine information for libref LIBNM and table TBLNM:             ;
   %*-------------------------------------------------------------------------;

   proc sql feedback stimer noprint;
      select engine into :engine
        from SASHELP.vlibnam
       where upcase(libname) eq "%upcase(&libnm.)" 
      ;
   quit;

   %if %upcase(&engine.) in (V9 BASE) %then %let engine = SAS;

   %*-------------------------------------------------------------------------;
   %* IF ENGINE = SAS, collect info from SAS dictionary tables:               ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&engine.) eq SAS %then %do;

      %*----------------------------------------------------------------------;
      %* Check if the source dataset LIBNM.TBLNM is encrypted:                ;
      %*----------------------------------------------------------------------;

      data _null_;
         dsid=open("&libnm..&tblnm.");
         sysmsg=sysmsg();
         if dsid eq 0 then do;
            if count(sysmsg,'encryptkey','i') eq 1 then do;
               call symput('encrypted', 1);
            end;
         end;
         else do;
            rc=close(dsid);
         end;
      run;

      %*----------------------------------------------------------------------;
      %* If source dataset is encrypted, throw error in log and exit:         ;
      %*----------------------------------------------------------------------;

      %if &encrypted. eq 1 %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg7.)
          , print   = &print.
          , debug   = &debug.
            )
         %goto exit;

      %end;

      %*----------------------------------------------------------------------;
      %* Obtain column information from source table into T_COLUMNS:          ;
      %*----------------------------------------------------------------------;

      %* Get info from VINDEX dictionary table: ;

      proc sql feedback stimer noprint;
         create table WORK.t_vcolumn as
         select *
           from SASHELP.vcolumn
          where upcase(libname) eq "%upcase(&libnm.)" and upcase(memname) eq "%upcase(&tblnm.)"
          order by libname, memname, varnum
         ;
      quit;

      %* Create index information result table: ;

      data WORK.t_column;

         attrib
            engine      length=$8    label='Engine'
            lib_name    length=$8    label='Library'
            tbl_name    length=$32   label='Table'
            col_name    length=$32   label='Column'
            col_pos     length=8     label='Position'
            col_type    length=$20   label='Type'
            col_length  length=8     label='Length'
            col_format  length=$49   label='Format'
            col_infrmt  length=$49   label='Informat'
            col_label   length=$256  label='Label'
            nullable    length=$4    label='Nullable'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            col_pos
            col_type
            col_length
            col_format
            col_infrmt
            col_label
            nullable
            ;

         set WORK.t_vcolumn;

         engine     = "%upcase(&engine.)";
         lib_name   = libname;
         tbl_name   = memname;
         col_name   = name;
         col_pos    = varnum;

         if upcase(type) eq 'CHAR' then do;
            col_type = 'VARCHAR';
         end;
         else if index(format,'DATETIME') then do;
            col_type = 'NUMERIC';
         end;
         else if index(format,'DATE')
              or index(format,'JULDAY')
              or index(format,'JULIAN')
              or index(format,'WEEK')
              or index(format,'YY')
              or (
                 index(format,'8601')and (index(format,'DA') or index(format,'DX'))
                 ) 
            then col_type = 'DATE';
         else do;
            col_type = 'NUMERIC';
         end;

         col_length = length;
         col_format = format;
         col_infrmt = informat;
         col_label  = label;

         nullable   = ifc(substr(upcase(notnull),1,1) eq 'N','Y','N');

      run;

      %*----------------------------------------------------------------------;
      %* Obtain constraint information from source table into T_CONSTRAINTS:  ;
      %*----------------------------------------------------------------------;

      %* Get info from VTABCON dictionary table: ;

      proc sql feedback stimer noprint;
         create table WORK.t_vtabcon as
         select table_catalog
              , table_name 
              , constraint_name 
              , constraint_type
           from SASHELP.vtabcon
          where table_catalog eq "%upcase(&libnm.)" and table_name eq "%upcase(&tblnm.)"
         ;
      quit;

      %* Get info from VCNCOLU dictionary table: ;

      proc sql feedback stimer noprint;
         create table WORK.t_vcncolu as
         select table_catalog 
              , table_name 
              , column_name 
              , constraint_name
           from SASHELP.vcncolu
          where table_catalog eq "%upcase(&libnm.)" and table_name eq "%upcase(&tblnm.)"
         ;
      quit;

      %* Add column position number column: ;
      data WORK.t_vcncolu;
         set WORK.t_vcncolu; by constraint_name;
         if first.constraint_name then con_pos = 0;
         con_pos + 1;
      run;

      %* Combine dictionary constraint information: ;

      proc sql noprint feedback stimer;
         create table WORK.t_vtabcols as
         select a.*
              , b.constraint_type
           from WORK.t_vcncolu as a
                left join WORK.t_vtabcon as b
             on a.table_catalog eq b.table_catalog
                and a.table_name eq b.table_name
                and a.constraint_name eq b.constraint_name
          order by table_catalog, table_name, constraint_name
         ;
      quit;

      %* Create constraint information result table: ;

      data WORK.t_constraints;

         attrib
            engine     length=$8    label='Engine'
            lib_name   length=$8    label='Library'
            tbl_name   length=$32   label='Table'
            col_name   length=$32   label='Column'
            con_pos    length=8     label='Position'
            con_name   length=$32   label='Constraint Name'
            con_type   length=$12   label='Constraint Type'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            con_pos
            con_name
            con_type
            ;

         retain 
            col_pos 0
            ;

         set WORK.t_vtabcols; by constraint_name;

         engine   = "%upcase(&engine.)";
         lib_name = table_catalog;
         tbl_name = table_name;
         col_name = column_name;
         con_name = constraint_name;
         con_type = constraint_type;

      run;

      %*----------------------------------------------------------------------;
      %* Obtain index information from source table into T_INDEXES:           ;
      %*----------------------------------------------------------------------;

      %* Get info from VINDEX dictionary table: ;

      proc sql feedback stimer noprint;
         create table WORK.t_vindex as
         select *
           from SASHELP.vindex
          where upcase(libname) eq "%upcase(&libnm.)" and upcase(memname) eq "%upcase(&tblnm.)"
          order by libname, memname, indxname, indxpos
         ;
      quit;

      %* Create index information result table: ;

      data WORK.t_index;

         attrib
            engine     length=$8    label='Engine'
            lib_name   length=$8    label='Library'
            tbl_name   length=$32   label='Table'
            col_name   length=$32   label='Column'
            idx_pos    length=8     label='Position'
            idx_name   length=$40   label='Index Name'
            idx_type   length=$20   label='Index Type'
            nomiss     length=$3    label='Nomiss'
            unique     length=$3    label='Unique'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            idx_pos
            idx_name
            idx_type
            nomiss
            unique
            ;

         retain 
            idx_pos 0
            ;

         set WORK.t_vindex; by indxname;

         engine   = "%upcase(&engine.)";
         lib_name = libname;
         tbl_name = memname;
         col_name = name;

         if first.indxname then idx_pos = 0;
         idx_pos + 1;

         idx_name = indxname;
         idx_type = idxusage;
         nomiss   = ifc(upcase(substr(nomiss,1,1)) eq 'N','N','Y');
         unique   = ifc(upcase(substr(unique,1,1)) eq 'N','N','Y');

      run;

      %*----------------------------------------------------------------------;
      %* Enrich column information from source table:                         ;
      %*----------------------------------------------------------------------;

      proc sql noprint feedback stimer;
         create table WORK.t_columns as
         select a.*
              , coalescec(b.nomiss,'N') as nomiss length=3 label='Nomiss'
              , coalescec(b.unique,'N') as unique length=3 label='Unique'
           from WORK.t_column as a
                left join WORK.t_index as b
             on a.engine eq b.engine
                and a.lib_name eq b.lib_name
                and a.tbl_name eq b.tbl_name
                and a.col_name eq b.col_name
         ;
      quit;

      %*----------------------------------------------------------------------;
      %* Sort source data by column position:                                 ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_columns out=WORK.s_columns nodupkeys;
         by tbl_name col_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the COLUMNS statement:                                         ;
      %*----------------------------------------------------------------------;

      data _null_ ;

         set WORK.s_columns end=lastobs;

         by tbl_name;

         retain 
            column_statement 
            ;
         length 
            column_statement $32767 
            ;

         if upcase(col_type) eq 'DATE' then do;
            type2 = compress(col_type);
         end;
         else do;
            type2 = cats(compress(col_type),'(',compress(put(col_length,8.)),')');
         end;

         if strip(col_format) ne '' then format2 = cats('format=',col_format);
         if strip(col_infrmt) ne '' then infrmt2 = cats('informat=',col_infrmt);
         if strip(col_label) ne '' then label2 = cats('label=',"'",col_label,"'");

         colstr = catx(' ',(put(col_name,$33.)||put(type2,$15.)||put(format2,$22.)||put(infrmt2,$24.)||label2));

         if first.tbl_name then do;
            column_statement=cat(trim(column_statement),'"      ',trim(colstr),'" / ');
         end;
         else do;
            if last.tbl_name then do;
               column_statement=cat(trim(column_statement),'"    , ',trim(colstr),'"');
            end;
            else do;
               column_statement=cat(trim(column_statement),'"    , ',trim(colstr),'" / ');
            end;
         end;

         if lastobs then do;
            call symputx('COLS', column_statement, 'L');
         end;

      run;

      %*----------------------------------------------------------------------;
      %* Sort the source data by constraint position:                         ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_constraints (where=(upcase(con_type) eq 'PRIMARY')) 
         out=WORK.s_constraints;
         by con_name con_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the CONSTRAINT statement:                                      ;
      %*----------------------------------------------------------------------;

      data _null_ ;
         set WORK.s_constraints end=lastobs;

         retain  
            constr_statement
            ;
         length 
            constr_statement $32767 
            ;

         if con_pos eq 1 then do;
            constr_statement=cat('"    , ','CONSTRAINT ',compress(con_name),' PRIMARY KEY (',compress(col_name));
         end;
         else do;
            constr_statement=cat(trim(constr_statement),', ',compress(col_name));
         end;
         if lastobs then do;
            if length(constr_statement) gt 0 then constr_statement = cat(trim(constr_statement),')"');
            call symputx('CONS', constr_statement, 'L');
         end;

      run;

      %*----------------------------------------------------------------------;
      %* Enrich index information from source table:                          ;
      %*----------------------------------------------------------------------;

      proc sql noprint feedback stimer;
         create table WORK.t_indexes as
         select a.*
              , b.con_type
           from WORK.t_index as a
                left join WORK.t_constraints as b
             on a.engine eq b.engine
            and a.lib_name eq b.lib_name
            and a.tbl_name eq b.tbl_name
            and a.col_name eq b.col_name
            and a.idx_pos eq b.con_pos
            and a.idx_name eq b.con_name
         ;
      quit;

      %*----------------------------------------------------------------------;
      %* Sort the source data by index position:                              ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_indexes (where=(upcase(con_type) ne 'PRIMARY')) 
         out=WORK.s_indexes (drop=con_type);
         by idx_name idx_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the INDEXES statement:                                         ;
      %*----------------------------------------------------------------------;

      data _null_ ;
         set WORK.s_indexes end=lastobs;

         by idx_name;

         retain  
            index_statement
            ;
         length 
            index_statement $32767 
            ;

         if first.idx_name then do;
            if upcase(unique) eq 'Y' then do;
               index_statement=cat(trim(index_statement),'"   CREATE UNIQUE INDEX ',compress(idx_name),' ON ',compress(lib_name||'.'||tbl_name),' (',compress(col_name));
            end;
            else do;
               index_statement=cat(trim(index_statement),'"   CREATE INDEX ',compress(idx_name),' ON ',compress(lib_name||'.'||tbl_name),' (',compress(col_name));
            end;
         end;
         else do;
            index_statement=cat(trim(index_statement),', ',compress(col_name));
         end;
         if last.idx_name then do;
            index_statement=cat(trim(index_statement),');" / ');
         end;

         if lastobs then do;
            call symputx('IDXS', index_statement, 'L');
         end;

      run;

   %end; %* engine = SAS ;

   %*-------------------------------------------------------------------------;
   %* IF ENGINE = ORACLE, collect info from Oracle system tables:             ;
   %*-------------------------------------------------------------------------;

   %else %if %upcase(&engine.) eq ORACLE %then %do;

      %*----------------------------------------------------------------------;
      %* Check if database credentials are provided, otherwise exit:          ;
      %*----------------------------------------------------------------------;

      %if %length(&creds.) eq 0 or %index(&creds.,path=) eq 0 %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg8.)
          , print   = &print.
            )
         %goto exit;

      %end;

      %*----------------------------------------------------------------------;
      %* Obtain column information from source table into T_COLUMNS:          ;
      %*----------------------------------------------------------------------;

      %* Get TABLE_OWNER info from VLIBNAM dictionary table: ;

      proc sql feedback stimer noprint;
         create table WORK.t_vlibnam as
         select libname
              , sysvalue
           from SASHELP.vlibnam
          where upcase(libname) eq "%upcase(&libnm.)" and lowcase(substr(sysname,1,6)) eq 'schema'
          order by libname, sysvalue
         ;
      quit;

      %* Get user name value: ;
      proc sql feedback stimer noprint;
         select sysvalue into :usrnm
           from WORK.t_vlibnam
         ;
      quit;

      %* Get table column information from Oracle system tables: ;

      proc sql feedback stimer noprint;
         connect to oracle (&creds.);
            create table WORK.t_all_tabcols as
            select * from connection to oracle
            (
             select *
               from ALL_TAB_COLUMNS
              where OWNER = %unquote(%bquote('%upcase(&usrnm.)'))
                and TABLE_NAME = %unquote(%bquote('%upcase(&tblnm.)'))
            )
            order by table_name, column_id;
         disconnect from oracle;
      quit;

      %* Create column information result table: ;

      data WORK.t_column;

         attrib
            engine      length=$8    label='Engine'
            lib_name    length=$8    label='Library'
            tbl_name    length=$32   label='Table'
            col_name    length=$32   label='Column'
            col_pos     length=8     label='Position'
            col_type    length=$20   label='Type'
            col_length  length=8     label='Length'
            col_format  length=$49   label='Format'
            col_infrmt  length=$49   label='Informat'
            col_label   length=$256  label='Label'
            nullable    length=$4    label='Nullable'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            col_pos
            col_type
            col_length
            col_format
            col_infrmt
            col_label
            nullable
            ;

         set WORK.t_all_tabcols;

         engine     = "%upcase(&engine.)";
         lib_name   = "%upcase(&libnm.)";
         tbl_name   = substr(table_name,1,32);
         col_name   = substr(column_name,1,32);
         col_pos    = column_id;
         col_type   = substr(data_type,1,20);
         col_length = data_length;

         if data_precision ne . then do;
            if data_scale gt 0 then do;
               col_format = compress(put(data_precision,8.) || ',' || put(data_scale,8.));
            end;
            else do;
               col_format = compress(put(data_precision,8.));
            end;
         end;
         else do;
            col_format = '';
         end;

         col_infrmt = '';
         col_label  = substr(column_name,1,32);

         nullable   = nullable;

      run;

      %*----------------------------------------------------------------------;
      %* Obtain constraint information from source table into T_CONSTRAINTS:  ;
      %*----------------------------------------------------------------------;

      %* Get constraint information from Oracle system tables: ;

      proc sql feedback stimer noprint;
         connect to oracle (&creds.);
            create table WORK.t_all_constraints as
            select * from connection to oracle
            (
             select *
               from ALL_CONSTRAINTS
              where OWNER = %unquote(%bquote('%upcase(&usrnm.)'))
                and TABLE_NAME = %unquote(%bquote('%upcase(&tblnm.)'))
                and CONSTRAINT_TYPE in ('P','R','U')
            );
         disconnect from oracle;
      quit;

      %* Get index column information from Oracle system tables: ;
 
      proc sql feedback stimer noprint;
         connect to oracle (&creds.);
            create table WORK.t_all_ind_columns as
            select * from connection to oracle
            (
             select *
               from ALL_IND_COLUMNS
              where TABLE_OWNER = %unquote(%bquote('%upcase(&usrnm.)'))
                and TABLE_NAME = %unquote(%bquote('%upcase(&tblnm.)'))
            );
         disconnect from oracle;
      quit;

      %* Combine the constraint information tables: ;

      proc sql noprint feedback stimer;
         create table WORK.t_all_concols as
         select a.*
              , b.constraint_name 
              , b.constraint_type
           from WORK.t_all_ind_columns as a
                left join WORK.t_all_constraints as b
             on a.index_name eq b.index_name
                and a.table_name eq b.table_name
         ;
      quit;

      %* Create constraint information result table: ;

      data WORK.t_constraints;

         attrib
            engine     length=$8    label='Engine'
            lib_name   length=$8    label='Library'
            tbl_name   length=$32   label='Table'
            col_name   length=$32   label='Column'
            con_pos    length=8     label='Position'
            con_name   length=$32   label='Constraint Name'
            con_type   length=$12   label='Constraint Type'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            con_pos
            con_name
            con_type
            ;

         retain 
            col_pos 0
            ;

         set WORK.t_all_concols;

         engine   = "%upcase(&engine.)";
         lib_name = "%upcase(&libnm.)";
         tbl_name = substr(table_name,1,32);
         col_name = substr(column_name,1,32);
         con_pos  = column_position;
         con_name = substr(constraint_name,1,32);

         if constraint_type eq 'P' then con_type = 'PRIMARY';
         else if constraint_type eq 'R' then con_type = 'REFERENTIAL';
         else if constraint_type eq 'U' then con_type = 'UNIQUE';
         else con_type = '';

         if constraint_name ne '' then output;

      run;

      %*----------------------------------------------------------------------;
      %* Obtain index information from source table into T_INDEXES:           ;
      %*----------------------------------------------------------------------;

      %* Get index type information from Oracle system tables: ;

      proc sql feedback stimer noprint;
         connect to oracle (&creds.);
            create table WORK.t_all_indexes as
            select * from connection to oracle
            (
             select *
               from ALL_INDEXES
              where TABLE_OWNER = %unquote(%bquote('%upcase(&usrnm.)'))
                and TABLE_NAME = %unquote(%bquote('%upcase(&tblnm.)'))
            );
         disconnect from oracle;
      quit;

      %* Combine the index information tables: ;

      proc sql noprint feedback stimer;
         create table WORK.t_all_indcols as
         select a.*
              , b.index_type 
              , b.uniqueness 
           from WORK.t_all_ind_columns as a
                left join WORK.t_all_indexes as b
             on a.index_name eq b.index_name
                and a.table_name eq b.table_name
         ;
      quit;

      %* Create index information result table: ;

      data WORK.t_index;

         attrib
            engine     length=$8    label='Engine'
            lib_name   length=$8    label='Library'
            tbl_name   length=$32   label='Table'
            col_name   length=$32   label='Column'
            idx_pos    length=8     label='Position'
            idx_name   length=$40   label='Index Name'
            idx_type   length=$20   label='Index Type'
            nomiss     length=$3    label='Nomiss'
            unique     length=$3    label='Unique'
            ;

         keep
            engine
            lib_name
            tbl_name
            col_name
            idx_pos
            idx_name
            idx_type
            nomiss
            unique
            ;

         retain 
            idx_pos 0
            ;

         set WORK.t_all_indcols;

         engine   = "%upcase(&engine.)";
         lib_name = "%upcase(&libnm.)";
         tbl_name = substr(table_name,1,32);
         col_name = substr(column_name,1,32);
         idx_pos  = column_position;
         idx_name = substr(index_name,1,40);
         idx_type = substr(index_type,1,20);
         nomiss   = 'N';
         unique   = ifc(substr(uniqueness,1,1) eq 'U','Y','N');

      run;

      %*----------------------------------------------------------------------;
      %* Enrich column information from source table:                         ;
      %*----------------------------------------------------------------------;

      proc sql noprint feedback stimer;
         create table WORK.t_columns as
         select a.* 
              , b.unique
              , c.con_type
           from WORK.t_column as a
                left join WORK.t_index as b
                on a.engine eq b.engine
                   and a.lib_name eq b.lib_name
                   and a.tbl_name eq b.tbl_name
                   and a.col_name eq b.col_name
                left join WORK.t_constraints as c
                on b.engine eq c.engine
                   and b.lib_name eq c.lib_name
                   and b.tbl_name eq c.tbl_name
                   and b.col_name eq c.col_name
                   and b.idx_pos eq c.con_pos
                   and b.idx_name eq c.con_name
         ;
      quit;

      %*----------------------------------------------------------------------;
      %* Sort source data by column position:                                 ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_columns out=WORK.s_columns nodupkeys;
         by tbl_name col_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the COLUMNS statement:                                         ;
      %*----------------------------------------------------------------------;

      data _null_ ;

         set WORK.s_columns end=lastobs;

         by tbl_name;

         retain 
            column_statement 
            ;
         length 
            column_statement $32767 
            ;

         if upcase(col_type) eq 'DATE' or index(upcase(col_type),'TIMESTAMP') gt 0 then do;
            type2 = compress(col_type);
         end;
         else do;
            if index(upcase(col_type),'VARCHAR') gt 0 then do;
               %* Type is VARCHAR or VARCHAR2 ;
               type2 = cats(compress(col_type),'(',compress(put(col_length,8.)),')');
            end;
            else do;
               %* Type is NUMBER, DECIMAL, etc ;
               type2 = cats(compress(col_type),'(',compress(col_format),')');
            end;
         end;

         null2 = ifc(upcase(nullable) eq 'Y','NULL','NOT NULL');
         unique2 = ifc(upcase(unique) eq 'Y' and upcase(con_type) eq 'UNIQUE','UNIQUE','');

         colstr = catx(' ',(put(col_name,$33.)||put(type2,$15.)||put(null2,$11.)||put(unique2,$8.)));

         if first.tbl_name then do;
            column_statement=cat(trim(column_statement),'"      ',trim(colstr),'" / ');
         end;
         else do;
            if last.tbl_name then do;
               column_statement=cat(trim(column_statement),'"    , ',trim(colstr),'"');
            end;
            else do;
               column_statement=cat(trim(column_statement),'"    , ',trim(colstr),'" / ');
            end;
         end;

         if lastobs then do;
            call symputx('COLS', column_statement, 'L');
         end;

      run;

      %*----------------------------------------------------------------------;
      %* Sort the source data by constraint position:                         ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_constraints (where=(upcase(con_type) eq 'PRIMARY')) 
         out=WORK.s_constraints;
         by con_name con_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the CONSTRAINT statement:                                      ;
      %*----------------------------------------------------------------------;

      data _null_ ;

         set WORK.s_constraints end=lastobs;

         retain  
            constr_statement
            ;
         length 
            constr_statement $32767 
            ;

         if con_pos eq 1 then do;
            constr_statement=cat('"    , ','PRIMARY KEY (',compress(col_name));
         end;
         else do;
            constr_statement=cat(trim(constr_statement),', ',compress(col_name));
         end;

         if lastobs then do;
            if length(constr_statement) gt 0 then constr_statement = cat(trim(constr_statement),')"');
            call symputx('CONS', constr_statement, 'L');
         end;

      run;

      %*----------------------------------------------------------------------;
      %* Enrich index information from source table:                          ;
      %*----------------------------------------------------------------------;

      proc sql noprint feedback stimer;
         create table WORK.t_indexes as
         select a.*
              , b.con_type
           from WORK.t_index as a
                left join WORK.t_constraints as b
             on a.engine eq b.engine
                and a.lib_name eq b.lib_name
                and a.tbl_name eq b.tbl_name
                and a.col_name eq b.col_name
                and a.idx_pos eq b.con_pos
                and a.idx_name eq b.con_name
         ;
      quit;

      %*----------------------------------------------------------------------;
      %* Sort the source data by index position:                              ;
      %*----------------------------------------------------------------------;

      proc sort data=WORK.t_indexes (where=(con_type not in ('PRIMARY','UNIQUE'))) 
         out=WORK.s_indexes;
         by idx_name idx_pos;
      run;

      %*----------------------------------------------------------------------;
      %* Build the INDEXES statement:                                         ;
      %*----------------------------------------------------------------------;

      data _null_ ;
         set WORK.s_indexes end=lastobs;

         by idx_name;

         retain  
            index_statement
            ;
         length 
            index_statement $32767 
            ;

         if first.idx_name then do;
            if index(idx_name,'SYS_') gt 0 then do;
               index_statement=cat(trim(index_statement),'"   execute( CREATE INDEX ON ',compress(tbl_name),' (',compress(col_name));
            end;
            else do;
               index_statement=cat(trim(index_statement),'"   execute( CREATE INDEX ',compress(idx_name),' ON ',compress(tbl_name),' (',compress(col_name));
            end;
         end;
         else do;
            index_statement=cat(trim(index_statement),', ',compress(col_name));
         end;
         if last.idx_name then do;
            index_statement=cat(trim(index_statement),')" / ');
            index_statement=cat(trim(index_statement),'"   ) by oracle;" / ');
         end;

         if lastobs then do;
            call symputx('IDXS', index_statement, 'L');
         end;

      run;

   %end; %* engine = ORACLE ;

   %*-------------------------------------------------------------------------;
   %* IF ENGINE value is not SAS or Oracle, exit and throw error message:     ;
   %*-------------------------------------------------------------------------;

   %else %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg9.)
       , print   = &print.
         )
      %goto exit;

   %end; %* engine = INVALID ;

   %*----------------------------------------------------------------------;
   %* Prepare the output DDL file:                                         ;
   %*----------------------------------------------------------------------;

   %* Get file name ;
   %let fname = %scan(&ddl_file.,-1,\/);

   %* Get path name ;
   %let fpath = %sysfunc(tranwrd(&ddl_file.,&fname.,));

   %* Strip last slash from path ;
   %let fpath = %substr(&fpath.,1,%length(&fpath.)-1);

   %* Create output file path ;
   options dlcreatedir;
   libname tmp "&fpath.";
   libname tmp clear;
   options nodlcreatedir;

   %* Check if .sas extention is given ;
   %if %index(&fname.,.sas) eq 0 %then %do;
      %let ddl_file = &fpath.&delim.&fname..sas;
   %end;

   %*----------------------------------------------------------------------;
   %* Prepare the output DDL content:                                      ;
   %*----------------------------------------------------------------------;

   %* Set DDL type creation: ;
   %if %upcase(&engine.) eq SAS %then %let ddl_type = SAS dataset;
   %if %upcase(&engine.) eq ORACLE %then %let ddl_type = Oracle table;

   %* Set DDL libref name: ;
   %if %upcase(&prm_flg.) eq Y and %length(%nrbquote(&prm_lib.)) gt 0 %then %do;
      %let ddl_lib = &prm_lib.;
   %end;
   %else %do;
      %let ddl_lib = %upcase(&libnm.);
   %end;

   %* Set DDL table name: ;
   %if %upcase(&prm_flg.) eq Y and %length(%nrbquote(&prm_tbl.)) gt 0 %then %do;
      %let ddl_tbl = &prm_tbl.;
   %end;
   %else %do;
      %let ddl_tbl = %upcase(&tblnm.);
   %end;
 
   %* Set Index table info: ;
   %if %upcase(&prm_flg.) eq Y %then %do;
      %if %length(%nrbquote(&prm_lib.)) gt 0 %then %do;
         %let idxs = %sysfunc(tranwrd(&idxs.,%upcase(&libnm.),%nrstr(&prm_lib.)));
      %end;
      %if %length(%nrbquote(&prm_tbl.)) gt 0 %then %do;
         %let idxs = %sysfunc(tranwrd(&idxs.,%upcase(&tblnm.),%nrstr(&prm_tbl.)));
      %end;
   %end;

   %* Set DDL encryption (SAS only): ;
   %if %upcase(&engine.) eq SAS %then %do;
      %if %upcase(&prm_flg.) eq Y and %length(%nrbquote(&prm_creds.)) gt 0 %then %do;
         %let ddl_enc = %str((&prm_creds));
         %* Remove indexes due to incompatibility of encryption with proc sql: ;
         %let idxs = ;
      %end;
   %end;

   %* Set DDL connection (Oracle only): ;
   %if %upcase(&engine.) eq ORACLE %then %do;
      %if %upcase(&prm_flg.) eq Y and %length(%nrbquote(&prm_creds.)) gt 0 %then %do;
         %let ddl_con = %str(&prm_creds);
      %end;
      %else %do;
         %let ddl_con = %sysfunc(ifc(%length(&creds.) gt 0,%str(&creds.),%str()));
      %end;
   %end;

   %*----------------------------------------------------------------------;
   %* Prepare the LOG output destination (goto nirvana):                   ;
   %*----------------------------------------------------------------------;

   proc printto log="%str(%sysfunc(getoption(WORK))&delim.ddl.log)" new;
   run;

   %*----------------------------------------------------------------------;
   %* Now lets build the output SAS engine PROC SQL DDL file:              ;
   %*----------------------------------------------------------------------;

   data _null_;
      file "&ddl_file." lrecl=32767 termstr=nl;
      put '/*!';
      put ' ******************************************************************************';
      put " * \file       %scan(&ddl_file.,-1,/\)";
      put " * \ingroup    DDL";
      put " * \brief      %upcase(&engine.) engine DDL script for table: %upcase(&ddl_tbl.).";
      put " * \details    The macro contains a data definition language (DDL) statement";
      put " *             to create a SAS dataset or Oracle database table including";
      put " *             constraints and/or index information.";
      put " *             Run this program in your SAS editor or batch script.";
      put " * ";
      put " * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)";
      put " * \date       %sysfunc(date(), yymmdd10.) %sysfunc(time(), tod8.)";
      put " * \version    20.1.01";
      put " * \sa         https://github.com/paul-canals/toolbox";
      put " * ";
      put " * \copyright  Copyright 2008-%scan(&date.,-1) Paul Alexander Canals y Trocha";
      put " * ";
      put " *     This program is free software: you can redistribute it and/or modify";
      put " *     it under the terms of the GNU General Public License as published by";
      put " *     the Free Software Foundation, either version 3 of the License, or";
      put " *     (at your option) any later version.";
      put " * ";
      put " *     This program is distributed in the hope that it will be useful,";
      put " *     but WITHOUT ANY WARRANTY; without even the implied warranty of";
      put " *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the";
      put " *     GNU General Public License for more details.";
      put " * ";
      put " *     You should have received a copy of the GNU General Public License";
      put " *     along with this program. If not, see <https://www.gnu.org/licenses/>.";
      put " * ";
      put " ******************************************************************************";
      put " */";
      put "proc sql noprint feedback stimer;";
      put " ";
   %if %upcase(&engine.) eq ORACLE %then %do;
      put "   connect to oracle (&ddl_con.);";
      put " ";
      put "   execute ( CREATE TABLE &ddl_tbl. (";
   %end;
   %else %do;
      put "   CREATE TABLE &ddl_lib..&ddl_tbl. &ddl_enc. (";
   %end;
      put &cols.;
      put &cons.;
   %if %upcase(&engine.) eq ORACLE %then %do;
      put "      )";
      put "   ) by oracle;"/;
   %end;
   %else %do;
      put "      );"/;
   %end;
      put &idxs.;
   %if %upcase(&engine.) eq ORACLE %then %do;
      put"   disconnect from oracle;";
      put " ";
   %end;
      put "quit;";
   run;

   %*----------------------------------------------------------------------;
   %* Restore the LOG output destination (from nirvana):                   ;
   %*----------------------------------------------------------------------;

   proc printto log=log;
   run;

   %*-------------------------------------------------------------------------;
   %* IF PRINT = Y, print information to SAS default result output:           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      %* Read DDL into SAS table: ;
      data WORK.t_content;
         infile "&ddl_file." dsd truncover;
         input @ 1 DDL $char1000. @;
         label ddl = 'DDL:';
         ddl = put(_N_,z6.) || ' ' || _infile_;
         put ddl;
      run; 

      title "%upcase(&syshostname.) - Table DDL Code Generation Summary for %upcase(&libnm..&tblnm.)";
      footnote "Generated on %sysfunc(date(), ddmmyyp10.) at %substr(%sysfunc(time(), time10.),1,5)";
      footnote2 "Copyright 2008-%scan(%sysfunc(date(), ddmmyyp10.),-1) Paul Alexander Canals y Trocha";

      proc print data=WORK.t_content label noobs;
         var ddl / style(data)=[font_face=courier];
      run;

      title;
      footnote;
      footnote2;

   %end;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      proc datasets lib = WORK nolist nowarn memtype = (data view);
         delete s_: t_: ;
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

%mend m_uc_create_ddl;
