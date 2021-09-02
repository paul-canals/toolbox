/*!
 ******************************************************************************
 * \file       m_uc_create_zip.sas
 * \ingroup    Custom
 * \brief      Custom macro to copy files and directory tree into a ZIP file.
 * \details    This program copies all files from a given directory including
 *             sub directories preserving the directory structure or it copies 
 *             a single selected file defined by the INDIR into a ZIP archive. 
 *             The macro uses the ODS package function or a fileref to create 
 *             the archive. The ODS package archiving is restricted to a single 
 *             source file size maximum of 4GB. This means that if a file has
 *             an uncompressed size larger than 4 GB, an error is returned.
 *             The ZIP fileref function comes without this restriction and is 
 *             available since SAS 9.4. However when archiving a large number 
 *             of files the ZIP fileref function can be much slower than with 
 *             using ODS package ZIP archiving function. Therefore the program
 *             has a third and default runmode that combines both ODS archiving 
 *             and ZIP fileref to overcome both the ODS 4GB restriction and the 
 *             ZIP fileref problem. The zip file creation ignores locked files,
 *             which are excluded gracefully from the zip archiving routine.
 * 
 * \note       This program is able to work in system environments where 
 *             x-command or unix pipes are not allowed or cannot be used. 
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-09-01 00:00:00
 * \version    21.1.09
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  indir       Full qualified path to the source directory, 
 *                         or full path and file name to a single file.
 * \param[in]  infile      Alias of the INDIR= parameter when selecting
 *                         an input file instead of an input directory.
 * \param[in]  outdir      Full qualified path to the target directory 
 *                         where the ZIP file is to be created.
 * \param[in]  zipname     Name of the archive file to be created including
 *                         the .ZIP extention.
 * \param[in]  runmode     Indicator [A|F|O] specify whether the macro uses 
 *                         the (O)DS package function, the (F)ileref or the
 *                         default (A)uto mode for which a combination of
 *                         ODS archiving and Fileref is selected to create
 *                         the archive. The default value is: A.
 * \param[in]  overwrite   Boolean [Y|N] parameter to specify wether to
 *                         overwrite or appended to an existing archive. 
 *                         The default value is: Y.
 * \param[in]  subdirs     Boolean [Y|N] parameter to decide if the file 
 *                         list is to include files in sub directories
 *                         under ROOTDIR. The default value is: N.
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by a proc print step. The default value is N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     The program returns a ZIP archive 
 * 
 * \calls
 *             + None (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_create_zip(?)
 * \endcode
 * 
 * \example    Example 2: Copy SAS core samples into a ZIP file using Auto mode:
 * \code
 *             %m_uc_create_zip(
 *                indir   = %sysget(SASROOT)/core/sample
 *              , outdir  = %sysfunc(getoption(WORK))/backup
 *              , zipname = &sysuserid._samples.zip
 *              , runmode = AUTO
 *              , print   = Y
 *              , debug   = Y
 *                );
 * \endcode
 *
 * \example    Example 3: Copy SAS core samples into a ZIP file using ODS package (fast):
 * \code
 *             %m_uc_create_zip(
 *                indir     = %sysget(SASROOT)/core/sasmisc
 *              , outdir    = %sysfunc(getoption(WORK))/backup
 *              , zipname   = &sysuserid._sasmisc_ods.zip
 *              , runmode   = ODS
 *              , overwrite = Y
 *              , subdirs   = Y
 *              , print     = Y
 *              , debug     = Y
 *                );
 * \endcode
 * 
 * \example    Example 4: Copy SAS core samples into a ZIP file using ZIP fileref (slow):
 * \code
 *             %m_uc_create_zip(
 *                indir     = %sysget(SASROOT)/core/sasmisc
 *              , outdir    = %sysfunc(getoption(WORK))/backup
 *              , zipname   = &sysuserid._sasmisc_ref.zip
 *              , runmode   = FILEREF
 *              , overwrite = Y
 *              , subdirs   = Y
 *              , print     = Y
 *              , debug     = Y
 *                );
 * \endcode
 * 
 * \example    Example 5: Copy a single file into a ZIP archive using Auto mode:
 * \code
 *             %m_uc_create_zip(
 *                infile    = %sysget(SASROOT)/core/sashelp/class.sas7bdat
 *              , outdir    = %sysfunc(getoption(WORK))/backup
 *              , runmode   = AUTO
 *              , print     = Y
 *              , debug     = Y
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
%macro m_uc_create_zip(
   help
 , vers      = 21.1.09
 , indir     = _NONE_
 , infile    = 
 , outdir    = _NONE_
 , zipname   = 
 , runmode   = AUTO
 , overwrite = Y
 , subdirs   = N
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
      %put %nrstr(Help for macro definition %m_uc_create_zip.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_create_zip%( );
      %put %nrstr(   indir     = [<full source data path>|<full source data path and file name>] );
      %put %nrstr( , infile    = [<Alias for indir argument>] );
      %put %nrstr( , outdir    = <full target data path> );
      %put %nrstr( , zipname   = <name>.zip );
      %put %nrstr( , runmode   = [AUTO|FILEREF|ODS] );
      %put %nrstr( , overwrite = [Y|N] );
      %put %nrstr( , subdirs   = [Y|N] );
      %put %nrstr( , print     = [Y|N] );
      %put %nrstr( , debug     = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to copy files and directory tree into a ZIP file. );
      %put ;
      %put %nrstr(This program copies all files from a given directory including );
      %put %nrstr(sub directories preserving the directory structure or it copies );
      %put %nrstr(a single selected file defined by the INDIR into a ZIP archive. );
      %put %nrstr(The macro uses the ODS package function or a fileref to create );
      %put %nrstr(the archive. The ODS package archiving is restricted to a single );
      %put %nrstr(source file size maximum of 4GB. This means that if a file has );
      %put %nrstr(an uncompressed size larger than 4 GB, an error is returned. );
      %put %nrstr(The ZIP fileref function comes without this restriction and is );
      %put %nrstr(available since SAS 9.4. However when archiving a large number );
      %put %nrstr(of files the ZIP fileref function can be much slower than with );
      %put %nrstr(using ODS package ZIP archiving function. Therefore the program );
      %put %nrstr(has a third and default runmode that combines both ODS archiving );
      %put %nrstr(and ZIP fileref to overcome both the ODS 4GB restriction and the );
      %put %nrstr(ZIP fileref problem. The program also checks checks for locked );
      %put %nrstr(files, which are excluded gracefully from the archiving routine. );
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
      did
      dirfnum
      dirsize
      dsid
      fetch
      fexist
      finfo
      fname
      fpath
      fref
      ftype
      levels
      member
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
      rc
      rpath
      start
      status
      stop
      time
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1  = %nrstr(Parameter INDIR is not given (_NONE_) but mandatory!); 
   %let msg2  = %nrstr(Input directory INDIR is set to: %bquote(&indir.));
   %let msg3  = %nrstr(Unable to open input directory: %bquote(&indir.)!);
   %let msg4  = %nrstr(Parameter OUTDIR is not given (_NONE_) but mandatory!); 
   %let msg5  = %nrstr(Output directory OUTDIR is set to: &outdir.);
   %let msg6  = %nrstr(Parameter ZIPNAME is set to: &zipname.);
   %let msg7  = %nrstr(Parameter RUNMODE is not given but is mandatory!); 
   %let msg8  = %nrstr(Invalid RUNMODE value: &runmode.!);
   %let msg9  = %nrstr(Input directory INDIR %bquote(&indir.) is empty!);
   %let msg10 = %nrstr(Try to add %bquote(&fname.) to archive..);

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
   %* Submacro: delete a given external file using FDELETE function:          ;
   %*-------------------------------------------------------------------------;

   %macro delete_file(
      file  = _NONE_
      );

      %* Set local macro variables and initialize environment: ;
      %local fid fnsme rc;

      %* Set fileref (FNAME) for file (FILE): ;
      %let rc = %sysfunc(filename(fname, &file.));

      %if &rc. eq 0 %then %do;

         %* Open file (FID): ;
         %let fid = %sysfunc(dopen(&fname.));

         %if &rc. eq 0 %then %do;

            %* Delete file (FNAME): ;
            %let rc = %sysfunc(fdelete(&fname.));

            %* CLose file (FID): ;
            %let rc = %sysfunc(dclose(&fid.));

         %end;

         %* Clear fileref (FNAME): ;
         %let rc = %sysfunc(filename(fname));

      %end;

   %mend delete_file;

   %*-------------------------------------------------------------------------;
   %* Sub-macro to obtain a file list from a given directory:                 ;
   %*-------------------------------------------------------------------------;

   %macro dir_list(
      rootdir = _NONE_
    , prefix  = src
    , subdirs = N
    , finfo   = N
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
            output;

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
                     %if %upcase(&debug.) eq Y %then %do;
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
                     %* Align relpath to path in zip archives: ;
                     relpath  = ifc(level gt 0,cats(tranwrd(substrn(relpath,2),"&delim.",'/'),"/"),'');

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
               %* Align relpath to path in zip archives: ;
               relpath  = ifc(level gt 0,cats(tranwrd(substrn(relpath,2),"&delim.",'/'),"/"),'');

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
               %if %upcase(&debug.) eq Y %then %do;
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
   %let indir = %bquote(%sysfunc(tranwrd(&indir.,%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.)));
   %let infile = %bquote(%sysfunc(tranwrd(&infile.,%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.)));
   %let outdir = %bquote(%sysfunc(tranwrd(%bquote(&outdir.),%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.)));

   %*-------------------------------------------------------------------------;
   %* Check if INDIR has been given a value:                                  ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&infile.)) gt 0 %then %let indir = %bquote(&infile.);

   %if %length(%nrbquote(&indir.)) le 1 or %nrbquote(&indir.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
         )
      %goto exit;

   %end;

   %* If exist, remove trailing (back)slash delimiter: ;
   %let indir = %sysfunc(ifc(%substr(&indir.,%length(&indir.),1) eq &delim.,%substr(&indir.,1,%length(&indir.)-1),&indir.));

   %*-------------------------------------------------------------------------;
   %* Verify that INDIR input path exists:                                    ;
   %*-------------------------------------------------------------------------;

   %let dexist = %eval(%sysfunc(fileexist(&indir.)));

   %if &dexist. %then %do;

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
   %* Check if INDIR is a directory or a file:                                ;
   %*-------------------------------------------------------------------------;

   %let rc = %sysfunc(filename(fref,&indir.));
   %let did = %sysfunc(dopen(&fref.));

   %* Check if INDIR is a file: ;
   %if &did. eq 0 %then %do;

      %* If file, set file path and name: ;
      %let fname = %bquote(%scan(&indir.,-1,&delim.));
      %let indir = %bquote(%sysfunc(tranwrd(&indir.,&delim.&fname.,%str())));

      %* Check if ZIPNAME is given: ;
      %if %length(&zipname.) eq 0 %then %do;

         %* If not given, set to ZIPNAME to file name: ;
         %let zipname = %bquote(%sysfunc(tranwrd(&fname.,%scan(&fname.,-1),zip)));

      %end;

   %end;

   %let rc = %sysfunc(dclose(&did.));

   %*-------------------------------------------------------------------------;
   %* Check if OUTDIR has been given a value:                                 ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&outdir.)) le 1 or %nrbquote(&outdir.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg4.)
         )
      %goto exit;

   %end;
   %else %do;

      %let dexist = %eval(%sysfunc(fileexist(&outdir.)));

      %if not &dexist. %then %do;

         %create_dir(
            path  = &outdir.
            );

      %end;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg5.)
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if ZIPNAME input has been given a value:                          ;
   %*-------------------------------------------------------------------------;

   %if %length(&zipname.) eq 0 %then %do;
      %let zipname = %bquote(%scan(&indir.,-1,&delim.)).zip;
   %end;

   %print_message(
      program = &prgm.
    , status  = OK
    , message = %unquote(&msg6.)
      )

   %*-------------------------------------------------------------------------;
   %* Check if RUNMODE input has been given a value:                          ;
   %*-------------------------------------------------------------------------;

   %if %length(&runmode.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg7.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Check if RUNMODE has been given a valid value:                          ;
   %*-------------------------------------------------------------------------;

   %let runmode = %upcase(%substr(&runmode.,1,1));
   %let runmode = %scan(Exit Auto Fileref ODS,%eval(1+%index(AFO,&runmode.)));

   %if &runmode. eq Exit %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg8.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* If OVERWRITE=Y then check and delete existing ZIP archive:              ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&overwrite.) eq Y %then %do;

      %if %sysfunc(fileexist(&outdir.&delim.&zipname.)) %then %do;

         %delete_file(
            file  = %bquote(&outdir.&delim.&zipname.)
            );

      %end;

   %end;

   %*-------------------------------------------------------------------------;
   %* Get all files from the INDIR directory. If the SUBDIRS parameter        ;
   %* is set to Y, include the main directory and all subdirectories:         ;
   %*-------------------------------------------------------------------------;

   %dir_list(
      rootdir = &indir.
    , prefix  = src
    , subdirs = &subdirs.
    , finfo   = Y
      );

   %*-------------------------------------------------------------------------;
   %* If file copy to zip, keep only indir file in source file list:          ;
   %*-------------------------------------------------------------------------;

   data WORK.src_file_list;
      set WORK.src_dir_list;
      %if %length(&fname.) gt 0 %then %do;
         where filename eq "&fname.";
      %end;
   run;

   %*-------------------------------------------------------------------------;
   %* Get number of files and total file size from source file list:          ;
   %*-------------------------------------------------------------------------;

   proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

      select count (*), sum(filesize) format=16., max(level)
        into :dirfnum, :dirsize, :levels
        from WORK.src_file_list
      ;

   quit;

   %*-------------------------------------------------------------------------;
   %* Check source file list, and abort gracefully if list is empty,:         ;
   %*-------------------------------------------------------------------------;

   %if %eval(&dirfnum.) eq 0 %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg9.)
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Prepare source file list tables for processing:                         ;
   %*-------------------------------------------------------------------------;

   %if &runmode. eq Auto %then %do;

      data WORK.src_file_list_ods WORK.src_file_list_ref;
         set WORK.src_file_list;
         %* Check for byte size ;
         if filesize gt 4000000000
         then output WORK.src_file_list_ref;
         else output WORK.src_file_list_ods;
      run;

   %end;
   %else %if &runmode. eq ODS %then %do;

      data WORK.src_file_list_ods;
         set WORK.src_file_list;
      run;

   %end;
   %else %do;

      data WORK.src_file_list_ref;
         set WORK.src_file_list;
      run;

   %end;

   %*-------------------------------------------------------------------------;
   %* IF RUNMODE is equal to Auto or ODS, then use ODS package archiving:     ;
   %*-------------------------------------------------------------------------;

   %if &runmode. in (Auto ODS) %then %do;

      %* Open ODS Package: ;
      ods package open nopf;

      %*----------------------------------------------------------------------;
      %* Open SRC_FILE_LIST_ODS table for reading:                            ;
      %*----------------------------------------------------------------------;

      %let dsid = %sysfunc(open(WORK.src_file_list_ods));

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
         %* Loop through all entries in FILE_LIST until end of file reached:  ;
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
               %* Verify if INFILE exists, and try to copy it to OUTPATH dir: ;
               %*-------------------------------------------------------------;

               %let fexist = %eval(%sysfunc(fileexist(&fpath.&delim.&fname.)));

               %if (&fexist.) %then %do;

                  %print_message(
                     program = &prgm.
                   , status  = OK
                   , message = %unquote(&msg10.)
                     )

                  %let member = %nrbquote(&rpath.&delim.&fname.);

                  %* Check member value before output to zip: ; 
                  %if %nrbquote(&member.) ne &delim. %then %do;

                     ods package add file="&fpath.&delim.&fname." path="&rpath." mimetype="application/x-compress";

                  %end;

               %end;  %* if exist ;

            %end;  %* record was fetched ;

         %end;  %* do loop ;

         %*-------------------------------------------------------------------;
         %* Since we are finished lets close the FILE_LIST dataset:           ;
         %*-------------------------------------------------------------------;

         %let dsid = %sysfunc(close(&dsid.));

      %end;

      %*----------------------------------------------------------------------;
      %* Since we have add all files to the archive, we can publish it:       ;
      %*----------------------------------------------------------------------;

      ods package publish archive properties(archive_name="&zipname." archive_path="&outdir.");

      %* Close ODS Package: ;
      ods package close;

   %end; %* runmode in (Auto ODS) ;

   %*-------------------------------------------------------------------------;
   %* IF RUNMODE is equal to Auto or Fileref, then use fileref archiving:     ;
   %*-------------------------------------------------------------------------;

   %if &runmode. in (Auto Fileref) %then %do;

      %*----------------------------------------------------------------------;
      %* Open SRC_FILE_LIST_REF table for reading:                            ;
      %*----------------------------------------------------------------------;

      %let dsid = %sysfunc(open(WORK.src_file_list_ref));

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
         %* Loop through all entries in FILE_LIST until end of file reached:  ;
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
               %* Get the fileTYpe attribute value:                           ;
               %*-------------------------------------------------------------;

               %let ftype = %bquote(%cmpres(%sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filetype))))));

               %*-------------------------------------------------------------;
               %* Get the filePath attribute value:                           ;
               %*-------------------------------------------------------------;

               %let fpath = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filepath))));

               %*-------------------------------------------------------------;
               %* Get the relative path (subdirs taken from INDIR):           ;
               %*-------------------------------------------------------------;

               %let rpath = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., relpath))));

               %*-------------------------------------------------------------;
               %* Verify if INFILE exists, and try to copy it to OUTPATH dir: ;
               %*-------------------------------------------------------------;

               %let fexist = %eval(%sysfunc(fileexist(&fpath.&delim.&fname.)));

               %if (&fexist.) %then %do;

                  %print_message(
                     program = &prgm.
                   , status  = OK
                   , message = %unquote(&msg10.)
                     )

                  %let member = %bquote(&rpath.&fname.);

                  %if %index(%substr(%bquote(&member.),1,1),%bquote(&delim.)) gt 0 %then %do;
                     %let member = %bquote(%sysfunc(substrn(%unquote(&member.),2)));
                  %end;

                  %* Check member value before output to zip: ; 
                  %if %length(%nrbquote(&member.)) gt 0 %then %do;

                     %* Output file to zip archive: ;
                     %if %upcase(&ftype.) ne FOLDER %then %do;

                        filename tmpfile "&fpath.&delim.&fname.";
                        filename zipfile zip "&outdir.&delim.&zipname." member="&member.";

                        %* byte-by-byte copy ;
                        data _null_;
                           infile tmpfile recfm=n;
                           file zipfile recfm=n;
                           input byte $char1. @;
                           put byte $char1. @;
                        run;

                     %end;
                     %* Output folder to zip archive: ;
                     %else %do;

                        filename zipfile zip "&outdir.&delim.&zipname." member="&member.";

                        %* byte-by-byte copy ;
                        data _null_;
                           file zipfile recfm=n;
                           put byte $char1. @;
                        run;

                     %end;

                     %if %sysfunc(fileref(tmpfile)) eq 0 %then %do;
                        filename tmpfile clear;
                     %end;

                     %if %sysfunc(fileref(zipfile)) eq 0 %then %do;
                        filename zipfile clear;
                     %end;

                  %end;  %* if length member gt 0 ; 

               %end;  %* if exist ;

            %end;  %* record was fetched ;

         %end;  %* do loop ;
         %*-------------------------------------------------------------------;
         %* Since we are finished lets close the FILE_LIST dataset:           ;
         %*-------------------------------------------------------------------;

         %let dsid = %sysfunc(close(&dsid.));

      %end;

   %end; %* runmode in (Auto Fileref) ;

   %*-------------------------------------------------------------------------;
   %* To verify that all files were loaded in the zip correctly, lets go      ;
   %* through the zip archive and create a table containing all files:        ;
   %*-------------------------------------------------------------------------;

   %zip_list(
      zipfile = &outdir.&delim.&zipname.
    , prefix  = trg
    , finfo   = %sysfunc(ifc(&dirfnum. eq 1,Y,N))
      );

   %*-------------------------------------------------------------------------;
   %* If creating a zip from a directory, create a summary report table:      ;
   %*-------------------------------------------------------------------------;

   %if &dirfnum. gt 1 %then %do;

      %dir_list(
         rootdir = &outdir.
       , prefix  = trg
       , subdirs = N
       , finfo   = Y
         );

      proc sql noprint %if %upcase(&debug.) eq Y %then %do; feedback %end; ;

         create table WORK.trg_zip_sum as
         select "&outdir.&delim.&zipname." as zipfile label='ZipFile'
              , &dirfnum. as files label='Files'
              , created
              , modified
              , &dirsize. as size label='Size' format=sizekmg12.1
              , case when (sum(filesize)/&dirsize.) le 1
                   then 1-(sum(filesize)/&dirsize.) 
                   else 0
                end as ratio label='Ratio' format=percent8.0
              , filesize as packed label='Packed' format=sizekmg12.1
              , &levels. as levels label='Levels'
           from WORK.trg_dir_list
          where filename eq "&zipname."
         ;

      quit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Since we are now done, generate the report summaries:                   ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      title "%upcase(&syshostname.) - Zip File Generation Summary for %upcase(&zipname.)";

      %* If zip from dir, print zip summary Info: ; 
      %if &dirfnum. gt 1 %then %do;

         title2 "Report Summary";

         proc print data=WORK.trg_zip_sum noobs label;
         run;

         title;

      %end;

      title2 "Report Details";
      footnote "Generated on %sysfunc(date(), ddmmyyp10.) at %substr(%sysfunc(time(), time10.),1,5)";
      footnote2 "Copyright 2008-%scan(%sysfunc(date(), ddmmyyp10.),-1) Paul Alexander Canals y Trocha";

      proc sort data=WORK.trg_zip_list;
         by filepath relpath filename;
      run;

      proc print data=WORK.trg_zip_list 
         %sysfunc(ifc( &dirfnum. eq 1,(drop=relpath level) noobs,%str())) label;
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

%mend m_uc_create_zip;
