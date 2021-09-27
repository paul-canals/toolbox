/*!
 ******************************************************************************
 * \file       m_uc_unpack_zip.sas
 * \ingroup    Custom
 * \brief      Custom macro to extract files and directories from a ZIP file.
 * \details    This program extracts all files from a given ZIP archive to a
 *             given target directory preserving the directory structure that
 *             is contained in the ZIP archive. The macro uses byte-by-byte
 *             including dynamic chunksize copying to extract files from the
 *             given ZIP archive, delivering high performance ZIP extraction.
 * 
 *             The finfo option for Zip archive members is based on the blog
 *             article "Using FILENAME ZIP and FINFO to list the details in 
 *             your ZIP files" by Chris Hemedinger (chris.hemedinger@sas.com).
 * 
 *             The chunksize option that is used in this macro is based on 
 *             the binaryfilecopy by Bruno Mueller (bruno.mueller@sas.com).
 * 
 * \note       This program is able to work in system environments where 
 *             x-command or unix pipes are not allowed or cannot be used. 
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-09-27 00:00:00
 * \version    21.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  infile      Full qualified path and file name of the archive
 *                         to be unpacked. The default value is: _NONE_.
 * \param[in]  outdir      Full qualified path to the target directory where
 *                         the files and directory structure from the archive
 *                         are to be unpacked. The default value is: _NONE_.
 * \param[in]  runmode     Indicator [E|V] to specify whether the macro uses 
 *                         the (E)xtract or the (V)iew function mode. The
 *                         view mode does only list all files and directory
 *                         structure contained by the ZIP archive, where as
 *                         the extract mode unpacks all the ZIP contents.
 *                         The default value for RUNMODE is: E (extract).
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by a proc print step. The default value is N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     The program returns unpacked files from a ZIP archive 
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_unpack_zip(?)
 * \endcode
 * 
 * \example    Example 2: View all files listed in a ZIP archive (mode: View):
 * \code
 *             %* Create ZIP archive: ;
 *             filename tmpfile "%sysget(SASROOT)/core/sashelp/cars.sas7bdat";
 *             filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="cars.sas7bdat";
 * 
 *             %* byte-by-byte copy ;
 *             data _null_;
 *                infile tmpfile recfm=n;
 *                file zipfile recfm=n;
 *                input byte $char1. @;
 *                put byte $char1. @;
 *             run;
 * 
 *             filename tmpfile "%sysget(SASROOT)/core/sashelp/class.sas7bdat";
 *             filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="class.sas7bdat";
 * 
 *             %* byte-by-byte copy ;
 *             data _null_;
 *                infile tmpfile recfm=n;
 *                file zipfile recfm=n;
 *                input byte $char1. @;
 *                put byte $char1. @;
 *             run;
 * 
 *             filename tmpfile clear;
 *             filename zipfile clear;
 * 
 *             %* view ZIP contents ; 
 *             %m_uc_unpack_zip(
 *                infile  = %sysfunc(getoption(WORK))/sashelp.zip
 *              , runmode = VIEW
 *              , print   = Y
 *              , debug   = Y
 *                );
 * \endcode
 * 
 * \example    Example 3: Extract all files listed in a ZIP archive (mode: Extract):
 * \code
 *             %* Create ZIP archive: ;
 *             filename tmpfile "%sysget(SASROOT)/core/sashelp/cars.sas7bdat";
 *             filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="cars.sas7bdat";
 * 
 *             %* byte-by-byte copy ;
 *             data _null_;
 *                infile tmpfile recfm=n;
 *                file zipfile recfm=n;
 *                input byte $char1. @;
 *                put byte $char1. @;
 *             run;
 * 
 *             filename tmpfile "%sysget(SASROOT)/core/sashelp/class.sas7bdat";
 *             filename zipfile zip "%sysfunc(getoption(WORK))/sashelp.zip" member="class.sas7bdat";
 * 
 *             %* byte-by-byte copy ;
 *             data _null_;
 *                infile tmpfile recfm=n;
 *                file zipfile recfm=n;
 *                input byte $char1. @;
 *                put byte $char1. @;
 *             run;
 * 
 *             filename tmpfile clear;
 *             filename zipfile clear;
 * 
 *             %* extract ZIP contents ; 
 *             %m_uc_unpack_zip(
 *                infile  = %sysfunc(getoption(WORK))/sashelp.zip
 *              , outdir  = %sysfunc(getoption(WORK))/sashelp
 *              , runmode = EXTRACT
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
%macro m_uc_unpack_zip(
   help
 , vers      = 21.1.09
 , infile    = _NONE_
 , outdir    = _NONE_
 , runmode   = EXTRACT
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
      %put %nrstr(Help for macro definition %m_uc_unpack_zip.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_unpack_zip%( );
      %put %nrstr(   infile    = <full source data path and ZIP file name> );
      %put %nrstr( , outdir    = [<full target data path>] );
      %put %nrstr( , runmode   = [EXTRACT|VIEW] );
      %put %nrstr( , print     = [Y|N] );
      %put %nrstr( , debug     = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to extract files and directories from a ZIP file. );
      %put ;
      %put %nrstr(This program extracts all files from a given ZIP archive to a );
      %put %nrstr(given target directory preserving the directory structure that );
      %put %nrstr(is contained in the ZIP archive. The macro uses byte-by-byte );
      %put %nrstr(including dynamic chunksize copying to extract files from the );
      %put %nrstr(given ZIP archive, delivering high performance ZIP extraction. );
      %put ;
      %put %nrstr(The finfo option for Zip archive members is based on the blog );
      %put %nrstr(article "Using FILENAME ZIP and FINFO to list the details in );
      %put %nrstr(your ZIP files" by Chris Hemedinger (chris.hemedinger@sas.com). );
      %put ;
      %put %nrstr(The chunksize option that is used in this macro is based on );
      %put %nrstr(the binaryfilecopy by Bruno Mueller (bruno.mueller@sas.com). );
      %put;
      %put %nrstr(This program is able to work in system environments where );
      %put %nrstr(x-command or unix pipes are not allowed or cannot be used. );
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
      date
      delim
      dexist
      dsid
      fetch
      fexist
      flvls
      fname
      fnum
      fpath
      fsize
      mode
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
      rpath
      start
      status
      stop
      time
      zcdat
      zmdat
      zsize
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1 = %nrstr(Parameter INFILE is not given (_NONE_) but mandatory!); 
   %let msg2 = %nrstr(Input INFILE file is set to: %bquote(&infile.));
   %let msg3 = %nrstr(Unable to open INFILE file: %bquote(&infile.)!);
   %let msg4 = %nrstr(Parameter OUTDIR is not given (_NONE_) but mandatory!); 
   %let msg5 = %nrstr(Output directory OUTDIR is set to: &outdir.);
   %let msg6 = %nrstr(Parameter RUNMODE is not given but is mandatory!); 
   %let msg7 = %nrstr(Invalid RUNMODE value: %bquote(&runmode.)!);
   %let msg8 = %nrstr(Input file INFILE %bquote(&infile.) is empty!);
   %let msg9 = %nrstr(Try to extract %bquote(&fname.) from archive..);

   %*-------------------------------------------------------------------------;
   %* Submacro: create a new directory using DLCREATEDIR system option:       ;
   %*-------------------------------------------------------------------------;

   %macro create_dir(
      path = _NONE_
      );

      %* Set local macro variables and initialize environment: ;
      %local saveopt;

      %* Save current SAS system logging options: ;
      %let saveopt = %lowcase(%sysfunc(getoption(dlcreatedir)));

      %* Set dlcreatedir option active: ;
      option dlcreatedir;

      %* Set a library reference to PATH to create directory: ;
      libname TMP "&path.";

      %* Clear the library reference since we are done: ;
      %if not %sysfunc(libref(TMP)) %then %do;
         libname TMP clear;
      %end;

      %* Revert log options back to their original settings: ;
      options &saveopt.;

   %mend create_dir;

   %*-------------------------------------------------------------------------;
   %* Sub-macro to obtain a file list from a given directory:                 ;
   %*-------------------------------------------------------------------------;

   %macro dir_list(
      rootdir = _NONE_
    , prefix  = src
    , subdirs = N
    , finfo   = N
    , select  = 
    , level   = 0
      );

      %* Set local macro variables and initialize environment: ;
      %local 
         created
         did 
         dsid 
         fetch
         fid 
         file
         filename
         filepath
         filesize
         fref 
         i 
         modified
         num
         rc
         relpath
         ;

      %* Set DIR file reference: ;
      %let rc = %sysfunc(filename(fref,&rootdir.));

      %* Open DIR for reading: ;
      %let did = %sysfunc(dopen(&fref.));

      %if &did. eq 0 %then %do;
         %put NOTE: &sysmacroname. Unable to open: &rootdir.;
         %return;
      %end;

      %if &level. eq 0 %then %do;
         data WORK._t_dir_list;
            attrib
               filepath  length=$1024 label='FilePath'
               filename  length=$200  label='FileName'
               level     length=8     label='Level'
               ;
      %end;

      %* Loop through all files and directories: ;
      %do i = 1 %to %sysfunc(dnum(&did.));   

         %let file = %qsysfunc(dread(&did.,&i.));

         %let fid = %sysfunc(mopen(&did., &file., i));

         %if &fid. gt 0 %then %do;

            %put NOTE: &sysmacroname. Adding file: &rootdir.&delim.&file.;

            filepath = "&rootdir.";
            filename = "&file.";
            level    = &level.;

            %if %length(&select.) gt 0 %then %do;
               if upcase(filename) eq "%upcase(&select.)" then output;
            %end;
            %else %do;
               output;
            %end;

            %let rc = %sysfunc(fclose(&fid.));

         %end;

         %* If subdirs, go to next level: ;
         %else %if %upcase(&subdirs.) eq Y %then %do;
            %dir_list(
               rootdir = &rootdir.&delim.&file.
             , subdirs = &subdirs.
             , level   = %eval(&level.+1)
               )
         %end;

      %end;

      %if &level. eq 0 %then %do;
         run;
      %end;

      %* Close and clear references: ;
      %let rc = %sysfunc(dclose(&did));
      %let rc = %sysfunc(filename(fref));

      %* If path is root (level=0): ;
      %if &level. eq 0 %then %do; 

         %* Sort result data and exclude empty rows: ;
         proc sort data=WORK._t_dir_list(where=(level ne .));
            by filepath filename;
         run;

         %* %* Create special format for creation and modified date inputs: ;
         proc format;
            picture timestamp .='n/a' other='%0d.%0m.%0Y:%0H:%0M:%0S' (datatype=datetime);
         run;

         %* Create output result table: ;
         data WORK.&prefix._dir_list;
            attrib 
               filename  length=$200  label='FileName'
               filetype  length=$16   label='FileType'
               filesize  length=8     label='FileSize'      format=sizekmg12.1
               created   length=8     label='Created'       format=timestamp.
               modified  length=8     label='Modified'      format=timestamp.
               filepath  length=$1024 label='FilePath'
               relpath   length=$256  label='RelPath'
               level     length=8     label='Level'
               ;

            %* Use FINFO to get file information: ;
            %if %upcase(&finfo.) eq Y %then %do;

               %* Open FILE_LIST table for reading: ;
               %let dsid = %sysfunc(open(WORK._t_dir_list));

               %do %until (&fetch. ne 0);

                  %let fetch = %sysfunc(fetch(&dsid.));

                  %if &fetch. eq 0 %then %do;

                     %* record was fetched: ;
                     %let filename  = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filename))));
                     %let filepath  = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filepath))));
                     %let level     = %sysfunc(getvarn(&dsid., %sysfunc(varnum(&dsid., level))));

                     %* Set input file reference: ;
                     %let rc = %sysfunc(filename(fref,&filepath.&delim.&filename));

                     %* Open file reference for reading: ;
                     %let fid = %sysfunc(fopen(&fref.));
                     %let num = %sysfunc(foptnum(&fid.));

                     %* Loop through FINFO options: ;
                     %do i=1 %to &num.;

                        %* Get option name: ;
                        %let name = %upcase(%sysfunc(foptname(&fid.,&i.)));

                        %* Check debug options: ;
                        %if %upcase(&debug.) eq Y %then %do;
                           %put &=name.;
                        %end;

                        %* Get file size in bytes: ;
                        %if %index(&name.,BYTE) gt 0 %then %do;
                           %let filesize = %scan(%sysfunc(finfo(&fid.,&name.)),-1);
                        %end;

                        %* Get last modified datetime: ;
                        %else %if %index(&name.,MODIFIED) gt 0 %then %do;
                           %let modified = %sysfunc(inputn(%quote(%sysfunc(finfo(&fid.,&name.))),anydtdtm20.));
                        %end;

                        %* Get created datetime: ;
                        %if %index(&name.,CREATE) gt 0 %then %do;
                           %let created = %sysfunc(inputn(%quote(%sysfunc(finfo(&fid.,&name.))),anydtdtm20.));
                        %end;

                     %end;  %* end loop ;

                     %* Check debug options: ;
                     %if %upcase(&debug.) eq V %then %do;
                        %put FILENAME=&=filename.;
                        %put RECFM=;
                        %put LRECL=;
                        %put FILE SIZE (BYTES)=&=filesize.;
                        %put LAST MODIFIED=&=modified.;
                        %put CREATE TIME=&=created.;
                     %end;

                     %* Since we are done, close member: ;
                     %let rc = %sysfunc(fclose(&fid.));

                     filename = strip("&filename.");
                     filetype = ifc(scan(filename,-1,'.') eq filename,' ',scan(filename,-1,'.'));
                     created  = &created.;
                     modified = &modified.;
                     filesize = &filesize.;
                     filepath = "&filepath.";
                     level    = &level.;
                     relpath  = ifc(level gt 0,strip(tranwrd(filepath,"&rootdir.",'')),'');

                     %* Output record: ;
                     output;

                  %end;  %* record was fetched ;

               %end;  %* do until ;

               %* Close FILE_LIST since we are done: ;
               %let dsid = %sysfunc(close(&dsid.));

            %end;  %* finfo eq Y ;

            %else %do;

               set WORK._t_dir_list;

               filetype = ifc(scan(filename,-1,'.') eq filename,' ',scan(filename,-1,'.'));
               relpath = ifc(level gt 0,strip(tranwrd(filepath,"&rootdir.",'')),'');

               keep
                  filepath
                  filename 
                  filetype
                  relpath 
                  level   
                  ;

            %end;  %* finfo eq N ;

         run;

         %* Sort result data and exclude empty rows: ;
         proc sort data=WORK.&prefix._dir_list(where=(level ne .));
            by filepath filename;
         run;

         %* Clean up before we leave: ;
         proc datasets lib=WORK nolist nodetails memtype=(data view);
            delete _t_: ;
         quit;

      %end;

   %mend dir_list;

   %*-------------------------------------------------------------------------;
   %* Submacro: print a message to the log and/or result output:              ;
   %*-------------------------------------------------------------------------;

   %macro print_message(
      program = &sysmacroname.
    , status  = OK
    , message = %quote()
    , print   = N
      );

      %* Set local macro variables and initialize environment: ;
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
   %* Sub-macro to obtain a file list from a given zip archive file:          ;
   %*-------------------------------------------------------------------------;

   %macro zip_list(
      zipfile = _NONE_
    , prefix  = src
    , finfo   = N
    , level   = 0
    , fref    = myzip
      );

      %local 
         crc32
         delim 
         did
         dsid 
         fid 
         file
         filename
         filenum
         filesize
         filetype
         i 
         j
         member
         modified
         num
         packed
         ratio
         relpath
         rc
         ;

      %let delim = %sysfunc(ifc(%eval(&sysscp. eq WIN),\,/));

      %* Set ZIPFILE filename reference: ; 
      filename &fref. ZIP "&zipfile.";

      %* Open ZIPFILE for reading: ;
      %let did = %sysfunc(dopen(&fref.));

      %if &did. eq 0 %then %do;
         %put NOTE: &sysmacroname. Unable to open: &zipfile.;
         %return;
      %end;

      %* Get number of ZIPFILE members: ;
      %let filenum = %sysfunc(dnum(&did.));

      data WORK._t_zip_list;
         attrib
            filepath  length=$1024 label='ZipFile'
            filename  length=$200  label='Name'
            filetype  length=$16   label='Type'
            relpath   length=$200  label='Path'
            level     length=8     label='Level'
            ;

      %* Loop through all files in the archive: ;
      %do i = 1 %to &filenum.;  

         %let file = %qsysfunc(dread(&did.,&i.));

         %put NOTE: &sysmacroname. Adding file: &file.;

         filename = scan("&file.",-1,'/\');
         filetype = ifc(scan(filename,-1,'.') eq filename,' ',scan(filename,-1,'.'));
         filepath = "&zipfile.";
         level    = countc("&file.",'/\');
         relpath  = ifc(level gt 0,substrn("&file.",1,length("&file.")-length(filename)),'');
         %* Output record: ;
         output;

         %* Generate filename ZIP member create statements: ; 
         %if %upcase(&finfo.) eq Y %then %do;
            file "%sysfunc(getoption(WORK))&delim.set_filenames";
            put "filename f&i. zip '&zipfile.' member='&file.';";
         %end;

         %* Generate filename ZIP member clear statements: ; 
         %if %upcase(&finfo.) eq Y %then %do;
            file "%sysfunc(getoption(WORK))&delim.clr_filenames";
            put "filename f&i. clear;";
         %end;

      %end;

      run;

      %* Close and clear ZIPFILE reference: ;
      %let rc = %sysfunc(dclose(&did));
      %let rc = %sysfunc(libname(&fref.));

      %* Create ZIP filename member references: ;
      %if %upcase(&finfo.) eq Y %then %do;
         %include "%sysfunc(getoption(WORK))&delim.set_filenames";
      %end;

      %* %* Create special format for creation and modified date inputs: ;
      proc format;
         picture timestamp .='n/a' other='%0d.%0m.%0Y:%0H:%0M:%0S' (datatype=datetime);
      run;

      %* Create output result table: ;
      data WORK.&prefix._zip_list;
         attrib 
            filepath  length=$1024 label='ZipFile'
            filename  length=$200  label='Name'
            filetype  length=$16   label='Type'
            modified  length=8     label='Modified'   format=timestamp.
            filesize  length=8     label='Size'       format=sizekmg12.1
            ratio     length=8     label='Ratio'      format=percent8.0
            packed    length=8     label='Packed'     format=sizekmg12.1
            crc32     length=$8    label='CRC'
            relpath   length=$256  label='Path'
            level     length=8     label='Level'
            ;

         %* Use FINFO to get file information: ;
         %if %upcase(&finfo.) eq Y %then %do;

            %do i=1 %to &filenum.;

               %* Open zip member for sequential reading: ;
               %let fid = %sysfunc(fopen(f&i.,s));
               %let num = %sysfunc(foptnum(&fid.));

               %* Loop through FINFO options: ;
               %do j=1 %to &num.;

                  %* Get option name: ;
                  %let name = %upcase(%sysfunc(foptname(&fid.,&j.)));

                  %* Check debug options: ;
                  %if %upcase(&debug.) eq Y %then %do;
                     %put &=name.;
                  %end;

                  %* Get member name info: ;
                  %if %index(&name.,MEMBER) gt 0 %then %do;
                     %let member = %sysfunc(finfo(&fid.,&name.));
                  %end;

                  %* Get Date/Time info: ;
                  %else %if %index(&name.,DATE) gt 0 %then %do;
                     %* Determine timestamp using anydtdtm format: ;
                     %let modified = %sysfunc(inputn(%quote(%sysfunc(finfo(&fid.,&name.))),anydtdtm20.));
                  %end;

                  %* Get file size in bytes: ;
                  %else %if %index(&name.,SIZE) gt 0 %then %do;
                     %if %index(&name.,COMP) gt 0 %then %do;
                        %* Get compressed size in bytes: ;
                        %let packed = %sysfunc(inputn(%sysfunc(finfo(&fid.,&name.)),16.));
                     %end;
                     %else %do;
                        %* Get original file size in bytes: ;
                        %let filesize = %sysfunc(inputn(%sysfunc(finfo(&fid.,&name.)),16.));
                     %end;
                  %end;

                  %* Get crc information: ;
                  %else %if %index(&name.,CRC) gt 0 %then %do;
                     %let crc32 = %scan(%sysfunc(finfo(&fid.,&name.)),-1);
                  %end;

               %end;  %* end loop ;

               %* Check debug options: ;
               %if %upcase(&debug.) eq V %then %do;
                  %put FILENAME=&=zipfile.;
                  %put MEMBER NAME=&=member.;
                  %put SIZE=&=filesize.;
                  %put COMPRESSED SIZE=&=packed.;
                  %put CRC-32=&=crc32.;
                  %put DATE/TIME=&=modified.;
               %end;

               %* Since we are done, close member: ;
               %let rc = %sysfunc(fclose(&fid.));

               filepath = "&zipfile.";
               filename = scan("&member.",-1,'/\');
               filetype = ifc(scan(filename,-1,'.') eq filename,' ',scan(filename,-1,'.'));
               modified = &modified.;
               filesize = &filesize.;
               packed   = &packed.;
               ratio    = ifc(packed/filesize gt 1,0,1-(packed/filesize));
               crc32    = lowcase("&crc32.");
               level    = countc("&member.",'/\');
               relpath  = ifc(level gt 0,substrn("&member.",1,length("&member.")-length(filename)),'');

               %* Output record: ;
               output;

            %end;  %* do until ;

         %end;  %* finfo eq Y ;

         %else %do;

            set WORK._t_zip_list;

            keep
               filepath
               filename 
               filetype
               relpath 
               level   
               ;

         %end;  %* finfo eq N ;

      run;

      %* Clear ZIP filename member references: ;
      %if %upcase(&finfo.) eq Y %then %do;
         %include "%sysfunc(getoption(WORK))&delim.clr_filenames";
      %end;

      %* Clean up before we leave: ;
      proc datasets lib=WORK nolist nodetails memtype=(data view);
         delete _t_: ;
      quit;

   %mend zip_list;

   %*-------------------------------------------------------------------------;
   %* IF DEBUG = Y, set SAS verbose logging / debugging options:              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) eq Y %then %do;
      options fullstimer msglevel=i;
   %end;

   %*-------------------------------------------------------------------------;
   %* Detect and set the proper delimiter for UNIX versus Windows:            ;
   %*-------------------------------------------------------------------------;
   %let delim = %sysfunc(ifc(%eval(&sysscp. eq WIN),\,/));
   %let infile = %bquote(%sysfunc(tranwrd(%bquote(&infile.),%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.)));
   %let outdir = %bquote(%sysfunc(tranwrd(%bquote(&outdir.),%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.)));

   %*-------------------------------------------------------------------------;
   %* Check if INFILE has been given a value:                                 ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&infile.)) le 1 or %nrbquote(&infile.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Verify that INFILE input file exists:                                   ;
   %*-------------------------------------------------------------------------;

   %let fexist = %eval(%sysfunc(fileexist(&infile.)));

   %if &fexist. %then %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg2.)
         )

   %end;
   %else %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg3.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if OUTDIR has been given a value:                                 ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&outdir.)) le 1 or %nrbquote(&outdir.) eq _NONE_ %then %do;

      %* Only Continue if runmode is View: ;
      %if %upcase(%substr(&runmode.,1,1)) ne V %then %do;

         %print_message(
            program = &prgm.
          , status  = ERR
          , message = %unquote(&msg4.)
            )
         %goto exit;

      %end;

   %end;
   %else %do;

      %let dexist = %eval(%sysfunc(fileexist(&outdir.)));

      %if not &dexist. %then %do;

         %create_dir(
            path = &outdir.
            );

      %end;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg5.)
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if RUNMODE input has been given a value:                          ;
   %*-------------------------------------------------------------------------;

   %if %length(&runmode.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg6.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if RUNMODE has been given a valid value:                          ;
   %*-------------------------------------------------------------------------;

   %let runmode = %upcase(%substr(&runmode.,1,1));
   %let runmode = %scan(Abort Extract View,%eval(1+%index(EV,&runmode.)));

   %if &runmode. eq Abort %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg7.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Get a list of all the files from the INFILE file ZIP archive:           ;
   %*-------------------------------------------------------------------------;

   %zip_list(
      zipfile = &infile.
    , prefix  = src
    , finfo   = %sysfunc(ifc(&runmode. eq View,Y,N))
      );

   %*-------------------------------------------------------------------------;
   %* Get number of files and total file size from source file list:          ;
   %*-------------------------------------------------------------------------;

   proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

      %if &runmode. eq View %then %do;
         select count (*), max(level), sum(filesize) format=16.
           into :fnum, :flvls, :fsize
           from WORK.src_zip_list
         ;
      %end;
      %else %do;
         select count (*), max(level)
           into :fnum, :flvls
           from WORK.src_zip_list
         ;
      %end;

   quit;

   %*-------------------------------------------------------------------------;
   %* Check source file list, and abort gracefully if list is empty:          ;
   %*-------------------------------------------------------------------------;

   %if %eval(&fnum.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg8.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* IF RUNMODE is equal to Extract, then start unpacking teh ZIP archive:   ;
   %*-------------------------------------------------------------------------;

   %if &runmode. eq Extract %then %do;

      %*----------------------------------------------------------------------;
      %* Open SRC_ZIP_LIST table for reading:                                 ;
      %*----------------------------------------------------------------------;

      %let dsid = %sysfunc(open(WORK.src_zip_list));

      %if &dsid. eq 0 %then %do;

         %let status = %sysfunc(ifc(%eval(&syscc. eq 4),WNG,ERR));
         %let sysmsg = %sysfunc(sysmsg());

         %print_message(
            program = &prgm.
          , status  = &status.
          , message = %quote(&sysmsg.)
            )
         %goto exit;

      %end;

      %else %do;

         %*-------------------------------------------------------------------;
         %* Loop through all entries in ZIP_LIST until end of file reached:   ;
         %*-------------------------------------------------------------------;

         %let fetch=;

         %do %until (&fetch. ne 0);

            %let fetch = %sysfunc(fetch(&dsid.));

            %if &fetch. eq 0 %then %do;

               %*-------------------------------------------------------------;
               %* Get the fileName attribute value:                           ;
               %*-------------------------------------------------------------;

               %let fname = %bquote(%cmpres(%sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filename))))));

               %*-------------------------------------------------------------;
               %* Get the filePath attribute value:                           ;
               %*-------------------------------------------------------------;

               %let fpath = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filepath))));

               %*-------------------------------------------------------------;
               %* Get the relative path (subdirs taken from INDIR):           ;
               %*-------------------------------------------------------------;

               %let rpath = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., relpath))));

               %*-------------------------------------------------------------;
               %* Check if OUTDIR/RPATH directory already exist:              ;
               %*-------------------------------------------------------------;

               %let dexist = %eval(%sysfunc(fileexist(&outdir.&delim.&rpath.)));

               %if not &dexist. %then %do;

                  %create_dir(
                     path = &outdir.&delim.&rpath.
                     );

               %end;

               %*-------------------------------------------------------------;
               %* Copy FNAME file from ZIP archive to OUTDIR directory:       ;
               %*-------------------------------------------------------------;

               filename in zip "&fpath." member="&rpath.&fname.";
               filename out "&outdir.&delim.&rpath.&fname.";

               data _null_;

                  length 
                     ifile  8 
                     ofile  8
                     fmtlen 8
                     bytes  8
                     outfmt $ 32
                     rec    $ 32767
                     ;

                  ifile = fopen('in','S',32767,'B');
                  ofile = fopen('out','O',32767,'B');
                  bytes = 0;
                  rec   = '20'x;

                  do while(fread(ifile) eq 0);

                     call missing(outfmt, rec);
                     rc = fget(ifile,rec,32767);

                     fcolin = fcol(ifile);
                     if (fcolin - 32767) eq 1 then do;
                       fmtlen = 32767;
                     end;
                     else do;
                       fmtlen = fcolin - 1;
                     end;
                     outfmt = cats("$char", fmtlen, ".");

                     bytes + fmtlen;

                     rc = fput(ofile,putc(rec,outfmt));
                     rc = fwrite(ofile);

                  end;

                  rc = fclose(ifile);
                  rc = fclose(ofile);

               run;

               filename in clear;
               filename out clear;

            %end;  %* record was fetched ;

         %end;  %* do loop ;

         %*-------------------------------------------------------------------;
         %* Since we are finished lets close the FILE_LIST dataset:           ;
         %*-------------------------------------------------------------------;

         %let dsid = %sysfunc(close(&dsid.));

      %end;

      %*----------------------------------------------------------------------;
      %* To verify that all files were extracted correctly, lets go through   ;
      %* OUTDIR directory and create a table containing a list of all files:  ;
      %*----------------------------------------------------------------------;

      %dir_list(
         rootdir = &outdir.
       , prefix  = trg
       , subdirs = Y
       , finfo   = Y
         );

      %*----------------------------------------------------------------------;
      %* Get the total file size of all files from target file list:          ;
      %*----------------------------------------------------------------------;

      proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

         select sum(filesize) format=16.
           into :fsize
           from WORK.trg_dir_list
         ;

      quit;

   %end; %* runmode eq Extract ;

   %*-------------------------------------------------------------------------;
   %* Get ZIP archive file summary information:                               ;
   %*-------------------------------------------------------------------------;

   %if &fnum. gt 1 %then %do;

      %* Get ZIP archive FINFO file information: ;

      %dir_list(
         rootdir = %bquote(%sysfunc(tranwrd(&infile.,&delim.%scan(&infile.,-1,&delim.),%str())))
       , prefix  = zip
       , finfo   = Y
       , select  = %bquote(%scan(&infile.,-1,&delim.))
         );

      %* Create summary information table: ;

      proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

         create table WORK.src_zip_sum as
         select "&infile." as zipfile label='ZipFile'
              , &fnum. as files label='Files'
              , created
              , modified
              , &fsize. as size label='Size' format=sizekmg12.1
              , case when (sum(filesize)/&fsize.) le 1
                   then 1-(sum(filesize)/&fsize.) 
                   else 0
                end as ratio label='Ratio' format=percent8.0
              , filesize as packed label='Packed' format=sizekmg12.1
              , &flvls. as levels label='Levels'
           from WORK.zip_dir_list
         ;

      quit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Since we are now done, generate the report summaries:                   ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      %let mode = %sysfunc(ifc(&runmode. eq View,Contents,Extraction));

      title "%upcase(&syshostname.) - Zip File &mode. Report for: %upcase(%scan(&infile.,-1,&delim.))";

      %* If zip from dir, print zip summary Info: ; 
      %if &fnum. gt 1 %then %do;

         title2 "Report Summary";

         proc print data=WORK.src_zip_sum noobs label;
         run;

         title;

      %end;

      title2 "Report Details";
      footnote "Generated on %sysfunc(date(), ddmmyyp10.) at %substr(%sysfunc(time(), time10.),1,5)";
      footnote2 "Copyright 2008-%scan(%sysfunc(date(), ddmmyyp10.),-1) Paul Alexander Canals y Trocha";

      proc sort data=WORK.%sysfunc(ifc(&runmode. eq View,src_zip,trg_dir))_list;
         by filepath relpath filename;
      run;

      proc print data=WORK.%sysfunc(ifc(&runmode. eq View,src_zip,trg_dir))_list
         %sysfunc(ifc(&fnum. eq 1,(drop=relpath level) noobs,%str())) label;
      run;

      %* Reset report values ;
      title;
      title2;
      footnote;
      footnote2;

   %end;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      proc datasets lib=WORK nolist nodetails memtype=(data view);
         delete src_: trg_: ;
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

%mend m_uc_unpack_zip;
