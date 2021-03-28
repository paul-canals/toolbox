/*!
 ******************************************************************************
 * \file       autoexec.sas
 * \ingroup    Scripts
 * \brief      Configuration script to add toolbox macros to SASAUTO library.
 * \details    The script registers the toolbox macros into the SASAUTO call
 *             library using the m_utl_set_sasauto.sas utility macro program.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2021-02-07 00:00:00
 * \version    21.1.02
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \return     Registered toolbox macros.
 * 
 * \calls
 *             + m_sys_set_usermods.sas
 *             + m_utl_create_dir.sas
 *             + m_utl_get_data_info.sas
 *             + m_utl_get_fcat_info.sas
 *             + m_utl_get_java_info.sas
 *             + m_utl_get_mcat_info.sas
 *             + m_utl_get_meta_info.sas
 *             + m_utl_get_prod_info.sas
 *             + m_utl_get_sys_info.sas
 *             + m_utl_get_userid.sas
 *             + m_utl_set_parameter.sas
 * 
 * \usage
 * 
 * \example    Example 1: Executing the autoexec script:
 * \code
 *             %include 'C:/SAS/Toolbox/misc/scripts/autoexec.sas';
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
 %*---------------------------------------------------------------------------;
 %* SAS system options settings:                                              ;
 %*---------------------------------------------------------------------------;

 options source source2 notes mprint minoperator noimplmac compress=yes;

 %*---------------------------------------------------------------------------;
 %* Custom entries: main application paths + environment macro variables:     ;
 %*---------------------------------------------------------------------------;

 %global 
    APPL_BASE 
    APPL_CONF
    APPL_DOCS
    APPL_HOST
    APPL_LOGS
    APPL_META
    APPL_MCAT
    APPL_NAME
    APPL_PRGM
    APPL_VERS
    TEST_BASE
    TEST_DATA
    TEST_DOCS
    TEST_LOGS
    TEST_RUNS
    TEST_SETS
    USER_DATA
    USER_INFO
    USER_ROOT
    USER_WORK
    ;

 %let APPL_NAME = Toolbox;
 %let APPL_VERS = 19.2.09;
 *%let APPL_HOST = %sysget(SYS_ENV);
 %let APPL_HOST = DEV;
 %let APPL_META = GRP;
 %let APPL_BASE = C:/SAS/Toolbox;
 %let APPL_CONF = &APPL_BASE./config;
 %let APPL_DOCS = &APPL_BASE./misc/docs;
 %let APPL_LOGS = &APPL_BASE./misc/logs;
 %let APPL_MCAT = &APPL_BASE./misc/catalog;
 %let APPL_PRGM = &APPL_BASE./sasautos;
 %let TEST_BASE = &APPL_BASE./testing;
 %let TEST_DATA = &TEST_BASE./data;
 %let TEST_DOCS = &TEST_BASE./docs;
 %let TEST_LOGS = &TEST_BASE./logs;
 %let TEST_RUNS = &TEST_BASE./runs;
 %let TEST_SETS = &TEST_BASE./sets;

 %*---------------------------------------------------------------------------;
 %* Include utility macros to the SASAUTO macro library:                      ;
 %*---------------------------------------------------------------------------;

 options sasautos=("&APPL_PRGM." %sysfunc(getoption(SASAUTOS)));

 %*---------------------------------------------------------------------------;
 %* Include utility macros to the SASAUTO macro catalog:                      ;
 %*---------------------------------------------------------------------------;

 %* NOTE: NO MACRO FUNCTION CALLS ARE ALLOWED ABOVE THIS LINE! ;
 /*
 %let USER_WORK = %sysfunc(pathname(work));
 libname USR_WORK "&USER_WORK.";

 libname TMP_MCAT "&APPL_MCAT." access=readonly; 
 proc catalog cat=TMP_MCAT.sasmacr;
   copy out=USR_WORK.sasmacr;
 quit;
 libname TMP_MCAT clear;
 options mstored sasmstore=USR_WORK nomreplace;
 */
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
 %* Set consistent user home directory and USR_HOME library:                  ;
 %*---------------------------------------------------------------------------;

 %let USER_ROOT = &APPL_BASE./userdata/%lowcase(&USER_NAME.);
 %m_utl_create_dir(path=&USER_ROOT.,debug=N);
 libname USR_HOME "&USER_ROOT.";

 %*---------------------------------------------------------------------------;
 %* Create and set user specific autoexec entries:                            ;
 %*---------------------------------------------------------------------------;

 %m_sys_set_usermods(file=&USER_ROOT./autoexec_usermods.sas,debug=N);

 %*---------------------------------------------------------------------------;
 %* Set consistent user data directory and USR_DATA library:                  ;
 %*---------------------------------------------------------------------------;

 %let USER_DATA = &USER_ROOT./data;
 %m_utl_create_dir(path=&USER_DATA.,debug=N);
 libname USR_DATA "&USER_DATA.";

 %*---------------------------------------------------------------------------;
 %* Set consistent user info directory and USR_INFO library:                  ;
 %*---------------------------------------------------------------------------;

 %let USER_INFO = &USER_ROOT./info;
 %m_utl_create_dir(path=&USER_INFO.,debug=N);
 libname USR_INFO "&USER_INFO.";

 %*---------------------------------------------------------------------------;
 %* Get current data library information from SAS Data Dictionary:            ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_data_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current user session SAS format catalog information:                  ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_fcat_info(outlib=USR_INFO,debug=N);

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
 %* Get current SAS licenced product information:                             ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_prod_info(outlib=USR_INFO,debug=N);

 %*---------------------------------------------------------------------------;
 %* Get current SAS and operating system environment information:             ;
 %*---------------------------------------------------------------------------;

 %m_utl_get_sys_info(outlib=USR_INFO,debug=N);
