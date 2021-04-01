/*!
 ******************************************************************************
 * \file       m_uc_get_file_list.sas
 * \ingroup    Custom
 * \brief      Custom macro to obtain file and sub directory tree information.
 * \details    This is a standalone macro program to list all files in a given
 *             root directory, and sub-directories. The rsult of this macro
 *             are two tables containing the file and directory structure 
 *             information, including level to identify the number of sub 
 *             directories below the root directory. If a file is locked,
 *             the macro still produces a record into the FILE_LIST dataset
 *             and column LOCKED gets a value Y, but no file size, creation
 *             time or last modified date is set. 
 * 
 * \note       This program is able to work in system environments where 
 *             x-command or unix pipes are not allowed or cannot be used. 
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-04-01 00:00:00
 * \version    21.1.04
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  help        Parameter, if set (Help or ?) to print the Help 
 *                         information in the log. In all other cases this
 *                         parameter should be left out from the macro call.
 * \param[in]  rootdir     Full path to the root directory for the file list.
 *                         The default value for ROOTDIR is: _NONE_;
 * \param[in]  level       The level of the current directory to the ROOTDIR.
 *                         The default value for LEVEL is: 0.
 * \param[in]  prefix      The prefix added to the names of the output tables.
 *                         The default value for PREFIX is: _SRC.
 * \param[in]  subdirs     Boolean [Y|N] parameter to specify if the file
 *                         list includes files in sub folders under ROOTDIR. 
 *                         The default value for SUBDIRS is: N.
 * \param[in]  finfo       Boolean [Y|N] parameter to specify additional 
 *                         information to be added to the file list. 
 *                         This information includes the file size, 
 *                         the creation date and time, and the last
 *                         modification date and time. 
 *                         The default value for FINFO  is: N.
 * \param[in]  print       Boolean [Y|N] parameter to generate the output
 *                         by a SAS proc report step with style HtmlBlue.
 *                         The default value for PRINT is: N.
 * \param[in]  debug       Boolean [Y|N] parameter to provide verbose
 *                         mode information. The default value is: N.
 * 
 * \return     Returns tables containing the rootdir directory and file list.
 * 
 * \calls 
 *             + None. (Standalone Version)
 * 
 * \usage
 * 
 * \example    Example 1: Show help information:
 * \code
 *             %m_uc_get_file_list(?)
 * \endcode
 * 
 * \example    Example 2: List files and dirs in current WORK directory:
 * \code
 *             %m_uc_get_file_list(
 *                rootdir = %sysfunc(getoption(WORK))
 *              , level   = 0
 *              , prefix  = src_
 *              , subdirs = Y
 *              , finfo   = Y
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
%macro m_uc_get_file_list(
   help
 , vers    = 21.1.04
 , rootdir = _NONE_
 , level   = 0
 , prefix  = src_
 , subdirs = N
 , finfo   = N
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
      %put %nrstr(Help for macro definition %m_uc_get_file_list.sas) (v&vers.);
      %put ;
      %put %nrstr(%m_uc_get_file_list%( );
      %put %nrstr(   rootdir = <full path> );
      %put %nrstr( , level   = 0 );
      %put %nrstr( , prefix  = src_ );
      %put %nrstr( , subdirs = [Y|N] );
      %put %nrstr( , finfo   = [Y|N] );
      %put %nrstr( , print   = [Y|N] );
      %put %nrstr( , debug   = [Y|N] );
      %put %nrstr(   %); );
      %put ;
      %put %nrstr(Custom macro to obtain file and sub directory tree information. );
      %put ;
      %put %nrstr(This program creates two tables containing file and directory );
      %put %nrstr(structure information, including level to identify the number );
      %put %nrstr(of sub directories below the root directory. );
      %put %nrstr(If a file is write-locked the macro still produces a record  );
      %put %nrstr(into the FILE_LIST dataset and column LOCKED gets a value Y, );
      %put %nrstr(but no file size, creation time or last modified date is set. );
      %put ;
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
      begin
      created
      date
      delim
      dexist
      dsid
      encrypted
      fetch_rc
      filename
      filepath
      filesize
      filetype
      level
      locked
      modified
      msg1
      msg2
      msg3
      msg4
      nobs
      num
      prgm
      protected
      relpath
      savemauto
      savemode
      savemlogic
      savenest
      savemprint
      savenotes
      savesource
      savesource2
      savestimer
      savesymbols
      start
      status
      stop
      time
      tmpdir
      token
      ;

   %let start = %sysfunc(datetime());
   %let date  = %sysfunc(date(), ddmmyyp10.);
   %let time  = %substr(%sysfunc(time(), time10.),1,5);
   %let prgm  = %sysfunc(compress(&sysmacroname.));

   %let tmpdir = %sysfunc(getoption(work));

   %*-------------------------------------------------------------------------;
   %* Info, Error and Warning Messages:                                       ;
   %*-------------------------------------------------------------------------;

   %let msg1 = %nrstr(Parameter ROOTDIR is not given but is mandatory!);
   %let msg2 = %nrstr(Unable to open directory: &rootdir.!);
   %let msg3 = %nrstr(Rootdir is set to: &rootdir..);
   %let msg4 = %nrstr(Fetched file: &filepath.&delim.&filename.);

   %*-------------------------------------------------------------------------;
   %* Submacro: delete a given external file using FDELETE function:          ;
   %*-------------------------------------------------------------------------;

   %macro delete_file(
      file  = _NONE_
      );

      %*----------------------------------------------------------------------;
      %* Set local macro variables and initialize environment:                ;
      %*----------------------------------------------------------------------;

      %local
         fid
         fnsme
         rc
         ;

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
   %* Sub-macro to scan retrieved file information using FINFO routine:       ;
   %*-------------------------------------------------------------------------;

   %macro file_info(
      file = _NONE_
    , fref = MyFile
      );

      %* Set local macro variables and initialize environment: ;

      %local 
         c_str_1 
         c_str_2
         fid  
         f_str_1
         f_str_2
         i 
         m_str_1 
         m_str_2 
         name 
         num 
         rc 
         s_str_1 
         s_str_2 
         ;

      %* Set English language specific search strings: ;

      %let c_str_1 = CREATE;
      %let f_str_1 = FILE;
      %let m_str_1 = MODIFIED;
      %let s_str_1 = BYTE;

      %* Set German language specific search strings: ;

      %let c_str_2 = ERSTELL;
      %let f_str_2 = DATEI;
      %let m_str_2 = ZULETZT;
      %let s_str_2 = BYTE;

      %* Set file reference to input FILE: ;

      %let rc = %sysfunc(filename(fref,&file.));

      %* Open file reference and get number of file info entries: ;

      %let fid = %sysfunc(fopen(&fref.));
      %let num = %sysfunc(foptnum(&fid.));

      %* Loop through the file info entries to find file information: ;

      %do i=1 %to &num.;

         %* Get option name: ;

         %let name = %upcase(%sysfunc(foptname(&fid.,&i.)));

         %* Check debug options: ;

         %if %upcase(&debug.) eq Y %then %do;
            %put &=name.;
         %end;

         %do j=1 %to 2;

            %* Get created datetime: ;

            %if %index(&name.,&&c_str_&j.) gt 0 %then %do;

               %let created = %sysfunc(finfo(&fid.,&name.));
               %* Determine timestamp using anydtdtm format: ;
               %let created = %sysfunc(inputn(%quote(&created.),anydtdtm20.));

            %end;

            %* Get modified datetime: ;

            %else %if %index(&name.,&&m_str_&j.) gt 0 %then %do;

               %let modified = %sysfunc(finfo(&fid.,&name.));
               %* Determine timestamp using anydtdtm format: ;
               %let modified = %sysfunc(inputn(%quote(&modified.),anydtdtm20.));

            %end;

            %* Get file size in bytes: ;

            %else %if %index(&name.,&&s_str_&j.) gt 0 %then %do;

               %let filesize = %scan(%sysfunc(finfo(&fid.,&name.)),-1);

            %end;

         %end;

         %* Set values to missing if not found: ;
         %if %length(&created.)  eq 0 %then %let created = .;
         %if %length(&modified.) eq 0 %then %let modified = .;
         %if %length(&filesize.) eq 0 %then %let filesize = 0;

      %end;

      %* Check debug options: ;

      %if %upcase(&debug.) eq Y %then %do;
         %put &=created.;
         %put &=modified.;
         %put &=filesize.;
      %end;

      %* Since we are done, close and clear file reference: ;

      %let rc = %sysfunc(fclose(&fid.));
      %let rc = %sysfunc(filename(fref));

   %mend file_info;

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
   %* Save current SAS system logging options:                                ;
   %*-------------------------------------------------------------------------;

   %let savemauto   = %lowcase(%sysfunc(getoption(mautolocdisplay)));
   %let savemlogic  = %lowcase(%sysfunc(getoption(mlogic)));
   %let savenest    = %lowcase(%sysfunc(getoption(mlogicnest)));
   %let savemprint  = %lowcase(%sysfunc(getoption(mprint)));
   %let savenotes   = %lowcase(%sysfunc(getoption(notes)));
   %let savesource  = %lowcase(%sysfunc(getoption(source)));
   %let savesource2 = %lowcase(%sysfunc(getoption(source2)));
   %let savestimer  = %lowcase(%sysfunc(getoption(fullstimer)));
   %let savesymbols = %lowcase(%sysfunc(getoption(symbolgen)));

   %*-------------------------------------------------------------------------;
   %* Detect and set the proper delimiter for UNIX versus Windows:            ;
   %*-------------------------------------------------------------------------;

   %let delim = %sysfunc(ifc(%eval(&sysscp. eq WIN),\,/));
   %let rootdir = %sysfunc(tranwrd(&rootdir.,%sysfunc(ifc(%eval(&sysscp. ne WIN),\,/)),&delim.));

   %*-------------------------------------------------------------------------;
   %* Check if the ROOTDIR parameter has been given a value:                  ;
   %*-------------------------------------------------------------------------;

   %if %length(%nrbquote(&rootdir.)) eq 0 or %nrbquote(&rootdir.) eq _NONE_ %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg1.)
       , print   = &print.
         )
      %goto exit;

   %end;

   %*-------------------------------------------------------------------------;
   %* Before we start lets verify that ROOTDIR really exists:                 ;
   %*-------------------------------------------------------------------------;

   %if not %eval(%sysfunc(fileexist(&rootdir.))) %then %do;

      %print_message(
         program = &prgm.
       , status  = ERR
       , message = %unquote(&msg2.)
       , print   = &print.
         )
      %goto exit;

   %end;
   %else %do;

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(&msg3.)
       , print   = N
         )

   %end;

   %*-------------------------------------------------------------------------;
   %* Divert log destination to temporary file:                               ;
   %*-------------------------------------------------------------------------;

   proc printto log="&tmpdir./tmp_&prgm..log" new;
   run;

   %let begin = %sysfunc(datetime());

   %*-------------------------------------------------------------------------;
   %* Set log options depending on debug mode setting:                        ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      options  
         nomautolocdisplay
         nomlogic 
         nomlogicnest
         nomprint 
         notes
         nosource 
         nosource2 
         nofullstimer
         nosymbolgen 
         ;

   %end;

   %*-------------------------------------------------------------------------;
   %* Dataset DIR_LIST starts out with the names of the root folders you      ;
   %* want to analyze. After the second data step has finished, it will       ;
   %* contain the names of all the directories that were found. The first     ;
   %* root name must contain a slash or backslash. Make sure that all         ;
   %* directories exist and are readable. Also use complete path names.       ;
   %*-------------------------------------------------------------------------;

   data WORK.&prefix.dir_list;
      length 
         root $1024.
         level 8.
         ;
      label 
         root = 'Dirpath'
         level = 'Level'
         ;
      root = "&rootdir.";
      level = &level.;
      output;
   run;

   %*-------------------------------------------------------------------------;
   %* Make a list of files in the ROOTDIR and its sub directories:            ;
   %*-------------------------------------------------------------------------;

   data WORK.&prefix.dir_list WORK.&prefix.file_list;

      keep 
         filename 
         filetype 
         filepath 
         relpath 
         level
         locked
         encrypted
         protected
         ;

      length
         filename  $200
         filetype  $16
         filepath  $1024
         fref      $8
         msg       $200 
         relpath   $256
         level     8
         locked    $1
         encrypted $1
         protected $1
         ;

      label 
         filename  = 'FileName'
         filetype  = 'FileType'
         filepath  = 'FilePath'
         relpath   = 'Relpath'
         level     = 'Level'
         locked    = 'Locked'
         encrypted = 'Encrypted'
         protected = 'Protected' 
         ;

      %*----------------------------------------------------------------------;
      %* First step is to read the name of the directory to search in:        ;
      %*----------------------------------------------------------------------;

      modify WORK.&prefix.dir_list;

      %*----------------------------------------------------------------------;
      %* Set the filePath attribute to the current root location:             ;
      %*----------------------------------------------------------------------;

      filepath = root;

      %*----------------------------------------------------------------------;
      %* Try to open the FILEPATH directory, otherwise throw error:           ;
      %*----------------------------------------------------------------------;

      rc = filename(fref, filepath);
      if rc eq 0 then do;
         did = dopen(fref);
         rc = filename(fref);
      end;
      else do; 
         msg = sysmsg(); 
         put msg=; 
         did = .; 
      end;
      if did le 0 then do;
         putlog "ERR" "OR: &prgm. Unable to open directory: " filepath;
         return;
      end;

      %*----------------------------------------------------------------------;
      %* Now read all files listed in the FILEPATH directory:                 ;
      %*----------------------------------------------------------------------;

      dnum = dnum(did);

      do i = 1 to dnum;

         filename = dread(did, i);

         fid = mopen(did, filename, 'i');

         %*-------------------------------------------------------------------;
         %* Check if the MOPEN function returns a directory or a file..       ;
         %* (If FID value greater than 0 its a file, otherwise directory)     ;
         %*-------------------------------------------------------------------;

         if fid gt 0 then do;

            %*----------------------------------------------------------------;
            %* FileType is everything after the last dot '.'                  ;
            %* If no dot found, then there is no extension:                   ;
            %*----------------------------------------------------------------;

            filetype = prxchange('s/.*\.{1,1}(.*)/$1/',1,filename);
            if filename eq filetype then filetype = ' ';

            %*----------------------------------------------------------------;
            %* Load relPath attribute which containes the relative path:      ;
            %*----------------------------------------------------------------;

            relpath = strip(tranwrd(filepath,"&rootdir.",""));
            level = countc(relpath,"&delim.");

            %*----------------------------------------------------------------;
            %* Since file could be opened, it is not locked:                  ;
            %*----------------------------------------------------------------;

            locked = 'N';

            %*----------------------------------------------------------------;
            %* Check if file is encrypted or protected:                       ;
            %*----------------------------------------------------------------;

            if count(filetype,'sas7bdat','i') eq 1 then do;

               %* Initialize values: ;
               encrypted = 'N';
               protected = 'N';

               %* Set temporary libref: ;
               rc = libname('_tmp',filepath);

               %* Open source dataset: ;
               dsid = open(strip(filepath)||'/'||strip(filename),,,'f');

               %* Obtain systm message: ;
               sysmsg = sysmsg();

               %* If dataset could not be opened: ;
               if dsid eq 0 then do;
                  if count(sysmsg,'encryptkey','i') eq 1 then do;
                     encrypted = 'Y';
                     protected = 'Y';
                  end;
                  else if count(sysmsg,'password','i') eq 1 then do;
                     encrypted = 'N';
                     protected = 'Y';
                  end;
               end;

               %* Close source dataset: ;
               else do;
                  rc = close(dsid);
               end;

               %* Clear libref: ;
               rc = libname('_tmp');

            end;
            else do;

               encrypted = '-';
               protected = '-';

            end;

            %*----------------------------------------------------------------;
            %* Add file record to result output list:                         ;
            %*----------------------------------------------------------------;

            output WORK.&prefix.file_list;

         end;

         %*-------------------------------------------------------------------;
         %* Check if the item is a directory or just a locked file..          ;
         %* (FID value equal to 0 can be a file, otherwise directory)         ;
         %*-------------------------------------------------------------------;

         else do;

            %* Set fileref ;
            rc = filename('mydir',catt(filepath,"&delim.",filename));

            %* Open dir ;
            fid = dopen('mydir');

            %* Count files ;
            num = dnum(fid);

            %*----------------------------------------------------------------;
            %* If NUM is not missing, output as a directory:                  ;
            %*----------------------------------------------------------------;

            if num ge 0 then do; 

            %*----------------------------------------------------------------;
            %* Only if the INCL_SUBDIRS parameter value is set to Y:          ;
            %* If a directory name is found get the full path, and            ;
            %* add it to the DIR_LIST dataset. This new entry will            ;
            %* be read during the next iteration of this data step.           ;
            %*----------------------------------------------------------------;

            %if %upcase(&subdirs.) eq Y %then %do;

               root = catt(filepath,"&delim.",filename);
               level = countc(tranwrd(root,"&rootdir.",""),"&delim.");

               output WORK.&prefix.dir_list;

            %end;

            end;

            %*----------------------------------------------------------------;
            %* Else if NUM is missing, output as a locked file:               ;
            %*----------------------------------------------------------------;

            else do;

               %*-------------------------------------------------------------;
               %* FileType is everything after the last dot '.'               ;
               %* If no dot found, then there is no extension:                ;
               %*-------------------------------------------------------------;

               filetype = prxchange('s/.*\.{1,1}(.*)/$1/',1,filename);
               if filename eq filetype then filetype = ' ';

               %*-------------------------------------------------------------;
               %* Load relPath attribute containing relative path:            ;
               %*-------------------------------------------------------------;

               relpath = strip(tranwrd(filepath,"&rootdir.",""));
               level = countc(relpath,"&delim.");

               %*-------------------------------------------------------------;
               %* Since file could not be opened, it is locked:               ;
               %*-------------------------------------------------------------;

               locked = 'Y';

               %*-------------------------------------------------------------;
               %* The file is locked, so we do not know if it protected:      ;
               %*-------------------------------------------------------------;

               encrypted = '-';
               protected = '-';

               %*-------------------------------------------------------------;
               %* Add file record to result output list:                      ;
               %*-------------------------------------------------------------;

               output WORK.&prefix.file_list;

            end;

            %* Close dir ;
            rc=dclose(fid);

         end;

      end;

      %*----------------------------------------------------------------------;
      %* Since we are finished lets close the FILEPATH directory:             ;
      %*----------------------------------------------------------------------;

      rc = dclose(did);

   run;

   %*-------------------------------------------------------------------------;
   %* Revert log options back to their original settings:                     ;
   %*-------------------------------------------------------------------------;

   options 
      &savemauto.
      &savemlogic.
      &savenest.
      &savemprint.
      &savenotes.
      &savesource.
      &savesource2.
      &savestimer.
      &savesymbols.
      ;

   %*-------------------------------------------------------------------------;
   %* Revert log destination back to its original destination:                ;
   %*-------------------------------------------------------------------------;

   proc printto log=log;
   run;

   %*-------------------------------------------------------------------------;
   %* Calculate data step processing time:                                    ;
   %*-------------------------------------------------------------------------;

   %let stop = %sysfunc(datetime());
   %let time = %sysfunc(intck(SECOND, &begin., &stop.), time10.);

   %print_message(
      program = &prgm.
    , status  = OK
    , message = %unquote(Data Step Processing Time &time. (hh:mm:ss))
    , print   = N
      );

   %*-------------------------------------------------------------------------;
   %* To be sure turn off syntaxcheck (result of error occurance):            ;
   %*-------------------------------------------------------------------------;

   %if %sysfunc(getoption(syntaxcheck)) eq SYNTAXCHECK %then %do;

      options nosyntaxcheck obs=max;

   %end;

   %*-------------------------------------------------------------------------;
   %* Sort DIR and FILE list entries by (file) path:                          ;
   %*-------------------------------------------------------------------------;

   proc sort data=WORK.&prefix.dir_list;
      by root;
   run;

   proc sort data=WORK.&prefix.file_list;
      by filepath filename;
   run;

   %*-------------------------------------------------------------------------;
   %* Determine the number of FILE list entries:                              ;
   %*-------------------------------------------------------------------------;

   proc sql noprint feedback stimer;
      select count(*) into :nobs
        from WORK.&prefix.file_list
      ;
   quit;

   %if &nobs. eq %str() %then %let nobs = 0;

   %*-------------------------------------------------------------------------;
   %* If FILE_LIST has any records and FINFO equals Y, add file size,         ;
   %* creation time and last modified date to the FILE_LIST output:           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&finfo.) eq Y and &nobs. gt 0 %then %do;

      %*----------------------------------------------------------------------;
      %* Divert log destination to temporary file:                            ;
      %*----------------------------------------------------------------------;

      proc printto log="&tmpdir./tmp_&prgm..log";
      run;

      %let begin = %sysfunc(datetime());

      %*----------------------------------------------------------------------;
      %* Set log options depending on debug mode setting:                     ;
      %*----------------------------------------------------------------------;

      %if %upcase(&debug.) ne Y %then %do;

         options  
            nomautolocdisplay
            nomlogic 
            nomlogicnest
            nomprint 
            notes
            nosource 
            nosource2 
            nofullstimer
            nosymbolgen 
            ;

      %end;

      %*----------------------------------------------------------------------;
      %* Create special format for creation and modified date inputs:         ;
      %*----------------------------------------------------------------------;

      proc format;
         picture timestamp .='n/a' other='%0d.%0m.%0Y:%0H:%0M:%0S' (datatype=datetime);
      run;

      %*----------------------------------------------------------------------;
      %* Recreate output FILE_LIST dataset:                                   ;
      %*----------------------------------------------------------------------;

      data WORK.&prefix.file_list (compress=no);

         attrib 
            filename  length=$200  label='FileName'
            filetype  length=$16   label='FileType'
            filesize  length=8     label='FileSize'      format=sizekmg12.1
            created   length=8     label='Created'       format=timestamp.
            modified  length=8     label='Modified'      format=timestamp.
            filepath  length=$1024 label='FilePath'
            relpath   length=$256  label='RelPath'
            level     length=8     label='Level'
            locked    length=$1    label='Locked'
            encrypted length=$1    label='Encrypted'
            protected length=$1    label='Protected'
            ;

      %*----------------------------------------------------------------------;
      %* Open FILE_LIST for reading. If not successfull return with an        ;
      %* error message. Otherwise loop through all entries in the table.      ;
      %*----------------------------------------------------------------------;

      %let dsid = %sysfunc(open(WORK.&prefix.file_list));

      %if &dsid. eq 0 %then %do;

         %let status = %sysfunc(ifc(%eval(&syscc. eq 4),WNG,ERR));
         %let sysmsg = %sysfunc(sysmsg());

         %print_message(
            program = &prgm.
          , status  = &status.
          , message = %quote(&sysmsg.)
          , print   = &print.
            )
         %goto exit;

      %end;

      %*----------------------------------------------------------------------;
      %* Loop through table until end of file is reached:                     ;
      %*----------------------------------------------------------------------;

      %else %do;

         %do %until (&fetch_rc. ne 0);

            %let fetch_rc = %sysfunc(fetch(&dsid.));

            %if &fetch_rc. eq 0 %then %do;

               %* record was fetched: ;
               %let filename  = %bquote(%sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filename)))));
               %let filetype  = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filetype))));
               %let filepath  = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., filepath))));
               %let relpath   = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., relpath))));
               %let level     = %sysfunc(getvarn(&dsid., %sysfunc(varnum(&dsid., level))));
               %let locked    = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., locked))));
               %let encrypted = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., encrypted))));
               %let protected = %sysfunc(getvarc(&dsid., %sysfunc(varnum(&dsid., protected))));

               %print_message(
                  program = &prgm.
                , status  = OK
                , message = %unquote(&msg4.)
                , print   = N
                  );

               %* Initialize values: ;
               %let filesize = 0;
               %let created  = .;
               %let modified = .;

               %if %upcase(&locked.) ne Y %then %do;

                  %file_info(
                     file = %bquote(&filepath.&delim.&filename.)
                     );

               %end;

               %* Record to output: ;
               filename  = "&filename.";
               filetype  = "&filetype.";
               filesize  = &filesize.;
               created   = &created.;
               modified  = &modified.;
               filepath  = "&filepath.";
               relpath   = "&relpath.";
               level     = &level.;
               locked    = "&locked.";
               encrypted = "&encrypted.";
               protected = "&protected.";
               output;

            %end;  %* record was fetched ;

         %end;  %* do loopi ;

         %let dsid = %sysfunc(close(&dsid.));

      %end;

      run;

      %*----------------------------------------------------------------------;
      %* Revert log options back to their original settings:                  ;
      %*----------------------------------------------------------------------;

      options 
         &savemauto.
         &savemlogic.
         &savenest.
         &savemprint.
         &savenotes.
         &savesource.
         &savesource2.
         &savestimer.
         &savesymbols.
         ;

      %*----------------------------------------------------------------------;
      %* Revert log destination back to its original destination:             ;
      %*----------------------------------------------------------------------;

      proc printto log=log;
      run;

      %*----------------------------------------------------------------------;
      %* Calculate data step processing time:                                 ;
      %*----------------------------------------------------------------------;

      %let stop = %sysfunc(datetime());
      %let time = %sysfunc(intck(SECOND, &begin., &stop.), time10.);

      %print_message(
         program = &prgm.
       , status  = OK
       , message = %unquote(Data Step Processing Time &time. (hh:mm:ss))
       , print   = N
         );

   %end; %* finfo=Y ;

   %*-------------------------------------------------------------------------;
   %* IF PRINT = Y, print information to SAS default result output:           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&print.) eq Y %then %do;

      title "%upcase(&syshostname.) - Source Directory List Result Summary";
      footnote "Rootdir: &rootdir.";
      footnote2;

      proc print data=WORK.&prefix.dir_list label;
      run;

      title "%upcase(&syshostname.) - Source File List Result Summary";
      footnote "Generated on %sysfunc(date(), ddmmyyp10.) at %substr(%sysfunc(time(), time10.),1,5)";
      footnote2 "Copyright 2008-%scan(%sysfunc(date(), ddmmyyp10.),-1) Paul Alexander Canals y Trocha";

      proc print data=WORK.&prefix.file_list label; 
      run;

      %* Reset report values ;
      title;
      footnote;
      footnote2;

   %end;

   %*-------------------------------------------------------------------------;
   %* Now clean up before we leave:                                           ;
   %*-------------------------------------------------------------------------;

   %if %upcase(&debug.) ne Y %then %do;

      %if %sysfunc(fileexist(&tmpdir./tmp_&prgm..log)) %then %do;

         %delete_file(
            file  = %str(&tmpdir./tmp_&prgm..log)
            );

      %end;

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

%mend m_uc_get_file_list;
