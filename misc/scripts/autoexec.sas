/*!
 ******************************************************************************
 * \file       autoexec.sas
 * \ingroup    Scripts
 * \brief      Configuration script to add toolbox macros to SASAUTO library.
 * \details    The script registers the toolbox macros into the SASAUTO call
 *             library using the m_utl_set_sasauto.sas utility macro program.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2025-02-04 00:00:00
 * \version    25.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \return     Registered toolbox functions, macros and library references.
 * 
 * \calls
 *             + m_utl_create_dir.sas
 *             + m_utl_get_auto_info.sas
 *             + m_utl_get_data_info.sas
 *             + m_utl_get_fcat_info.sas
 *             + m_utl_get_func_info.sas
 *             + m_utl_get_java_info.sas
 *             + m_utl_get_mcat_info.sas
 *             + m_utl_get_meta_info.sas
 *             + m_utl_get_mvar_info.sas
 *             + m_utl_get_prod_info.sas
 *             + m_utl_get_sys_info.sas
 *             + m_utl_get_userid.sas
 *             + m_utl_set_parameter.sas
 *             + m_utl_set_usermods.sas
 * 
 * \usage
 * 
 * \example    Example 1: Executing the autoexec script:
 * \code
 *             %include '/pub/toolbox/misc/scripts/autoexec.sas';
 * \endcode
 * 
 * \copyright  Copyright 2008-2025 Paul Alexander Canals y Trocha.
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
 %*---------------------------------------------------------------------------;
 %* SAS system options settings:                                              ;
 %*---------------------------------------------------------------------------;

 options nosource nosource2 notes nomprint minoperator noimplmac compress=yes;

 %*---------------------------------------------------------------------------;
 %* Custom entries: main application paths + environment macro variables:     ;
 %*---------------------------------------------------------------------------;

 %global 
    APPL_BASE
    APPL_BSCR
    APPL_CONF
    APPL_DOCS
    APPL_FUNC
    APPL_HOST
    APPL_LOGS
    APPL_MCAT
    APPL_META
    APPL_MISC
    APPL_NAME
    APPL_PRGM
    APPL_TEST
    APPL_TMPL
    APPL_UCMR
    APPL_VERS
    USER_BASE
    USER_DATA
    USER_HOME
    USER_INFO
    USER_WORK
    ;

 %*---------------------------------------------------------------------------;
 %* !!!!!!!!!!!!!! NOTE: ENTER SITE CUSTOM SETTINGS HERE BELOW !!!!!!!!!!!!!! ;
 %*---------------------------------------------------------------------------;
 %let APPL_HOST = DEV /* [DEV|TST|PRD] or %sysget(SYS_ENV) */                 ;
 %let APPL_META = GRP                                                         ;
 %let APPL_BASE = /pub/toolbox                                                ;
 %let USER_BASE = /pub/toolbox/userdata                                       ;
 %*---------------------------------------------------------------------------;
 %* !!!!!!!!!!!!!! NOTE: ENTER SITE CUSTOM SETTINGS HERE ABOVE !!!!!!!!!!!!!! ;
 %*---------------------------------------------------------------------------;
    
 %let APPL_NAME = Toolbox;
 %let APPL_VERS = 25.1.02;
 %let APPL_CONF = &APPL_BASE./config;
 %let APPL_DOCS = &APPL_BASE./docs;
 %let APPL_LOGS = &APPL_BASE./misc/logs;
 %let APPL_MCAT = &APPL_BASE./source/sas/catalogs;
 %let APPL_FUNC = &APPL_BASE./source/sas/functions;
 %let APPL_MISC = &APPL_BASE./source/sas/misc;
 %let APPL_BSCR = &APPL_BASE./source/sas/misc/scripts;
 %let APPL_TMPL = &APPL_BASE./source/sas/misc/templates;
 %let APPL_TEST = &APPL_BASE./source/sas/misc/tests;
 %let APPL_PRGM = &APPL_BASE./source/sas/sasautos;
 %let APPL_UCMR = &APPL_BASE./source/sas/ucmacros;
 
 %*---------------------------------------------------------------------------;
 %* Include utility and custom macros to the SASAUTO macro library:           ;
 %*---------------------------------------------------------------------------;

 options sasautos=("&APPL_UCMR." %sysfunc(getoption(SASAUTOS)));
 options sasautos=("&APPL_PRGM." %sysfunc(getoption(SASAUTOS)));

 %*---------------------------------------------------------------------------;
 %* Include toolbox macro catalog to the user own macro catalog in WORK:      ;
 %*---------------------------------------------------------------------------;

 %* !!!!!! NOTE: NO MACRO FUNCTION CALLS ARE ALLOWED ABOVE THIS LINE !!!!!!!! ;

 %macro setCatalog;
    %local sys; %let sys = %sysfunc(ifc(%lowcase(&sysscp.) eq win,win,lnx));
    %if %sysfunc(fileexist(&APPL_MCAT./sasmacr_&sys..sas7bcat)) %then %do;
       %if %bquote(%sysfunc(getoption(SASMSTORE))) ne %bquote() %then %do;
          %sysmstoreclear;
       %end;
       libname TMP_MCAT "&APPL_MCAT." access=readonly;
       libname USR_WORK "%sysfunc(getoption(WORK))";
       proc catalog cat = TMP_MCAT.sasmacr_&sys. force;
          copy out = USR_WORK.sasmacr;
       quit;
       libname TMP_MCAT clear;
       options mstored sasmstore = USR_WORK /*nomreplace*/;
    %end;
 %mend; %setCatalog;

 %*---------------------------------------------------------------------------;
 %* Include toolbox functions to the user own functions catalog in WORK:      ;
 %*---------------------------------------------------------------------------;

 %macro setFunctions;
    %if %sysfunc(fileexist(&APPL_MCAT./functs.sas7bdat)) %then %do;
       libname TMP_MCAT "&APPL_MCAT." access=readonly;
       libname USR_WORK "%sysfunc(pathname(work))"; 
       proc datasets lib=TMP_MCAT nolist nodetails;
          copy out=USR_WORK memtype=(data); 
          select functs; 
       quit;
       libname TMP_MCAT clear;
       options cmplib = USR_WORK.functs;
    %end;
 %mend; %setFunctions;

 %*---------------------------------------------------------------------------;
 %* Load main SAS global macro parameters from delimited file:                ;
 %*---------------------------------------------------------------------------;

 %m_utl_set_parameter(
    infile=&APPL_CONF./run_parameter_ctrl.csv
  , intype=CSV
  , inhost=&APPL_HOST.
  , prmenv=PARAM_ENV
  , prmvar=PARAM_NAME
  , prmval=PARAM_VALUE
  , prmtyp=PARAM_TYPE
  , prmtxt=PARAM_DESC
  , prmflg=MACRO_FLG
  , debug=N
    );

 %*---------------------------------------------------------------------------;
 %* Set consistent user ID global system macro variable:                      ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_userid(global_flg=Y,mvar_name=USER_NAME,debug=N);

 %*---------------------------------------------------------------------------;
 %* Set consistent user directories and user session libraries:               ;
 %*---------------------------------------------------------------------------;

 %let USER_HOME = &USER_BASE./%lowcase(&USER_NAME.);
 %m_utl_create_dir(path=&USER_HOME.,debug=N);
 libname USR_HOME "&USER_HOME.";

 %let USER_WORK = %sysfunc(pathname(work));
 %macro setWork;
    %if %sysfunc(libref(USR_WORK)) %then %do;
       libname USR_WORK "&USER_WORK.";
    %end;
 %mend; %setWork;

 %let USER_DATA = &USER_HOME./data;
 %m_utl_create_dir(path=&USER_DATA.,debug=N);
 libname USR_DATA "&USER_DATA.";

 %let USER_INFO = &USER_WORK./user_info;
 %m_utl_create_dir(path=&USER_INFO.,debug=N);
 libname USR_INFO "&USER_INFO.";

 %*---------------------------------------------------------------------------;
 %* Create and set user specific autoexec entries:                            ;
 %*---------------------------------------------------------------------------;

 %m_utl_set_usermods(file=&USER_HOME./autoexec_usermods.sas,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current SAS autocall library macro information:                       ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_auto_info(outlib=USR_INFO,debug=N);
 
 %*---------------------------------------------------------------------------;
 %* Get current data library information from SAS Data Dictionary:            ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_data_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user session SAS format catalog information:                  ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_fcat_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user session SAS user compiled function information:          ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_func_info(outlib=USR_INFO,prefix=F_,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current Java system environment information:                          ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_java_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user session SAS macro catalog information:                   ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_mcat_info(outlib=USR_INFO,prefix=M_,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user information from SAS Metadata Server:                    ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_meta_info(userid=&USER_NAME.,outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user session SAS macro variables information:                 ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_mvar_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current SAS licenced product information:                             ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_prod_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current SAS and operating system environment information:             ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_sys_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Set SAS system options for current user session:                          ;
 %*---------------------------------------------------------------------------;

 options source source2 notes mprint minoperator noimplmac compress=yes;
