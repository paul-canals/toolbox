/*!
 ******************************************************************************
 * \file       test_m_utl_create_ddl.sas
 * \ingroup    Testing
 * \brief      Testing script to execute the programs usage example code.
 * \details    This testing script was automatically generated 
 *             by the m_test_generate_scripts.sas macro program.
 *             Run this program in a SAS editor or batch script.
 * 
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-21 09:13:08
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \calls
 *             + m_utl_create_ddl.sas
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
%m_utl_create_ddl(?)
 
%* For the next examples create a table with a couple of indexes: ;
proc sql noprint feedback stimer;
   CREATE TABLE WORK.BANKKONTO (
      MANDANT_ID           VARCHAR(8)     label='Mandant Identifier'
    , PARTNER_ID           NUMERIC(8)     label='Geschäftspartner Identifier'
    , KONTO_ID             NUMERIC(8)     label='Konto Identifier'
    , KONTO_WAEHRUNG_CD    VARCHAR(3)     label='Geschäftswährung'
    , KONTO_TYPE_CD        VARCHAR(32)    label='Konto Type Code'
    , SALDO_AMT            NUMERIC(8)     format=19.2 label='Saldo Betrag'
    , LOAD_DTTM            NUMERIC(20)    format=datetime20. label='Ladezeitstempel'
    , CONSTRAINT PRIM_KEY PRIMARY KEY (MANDANT_ID, KONTO_ID, LOAD_DTTM)
      );
   CREATE UNIQUE INDEX PARTNER_ID ON WORK.BANKKONTO (PARTNER_ID);
   CREATE INDEX IDX_BANKKONTO ON WORK.BANKKONTO (KONTO_ID, LOAD_DTTM);
quit;
 
%* Example 2: Create a Data Definition Language file for table bankkonto: ;
%m_utl_create_ddl(
   libnm    = WORK
 , tblnm    = bankkonto
 , ddl_file = %sysfunc(getoption(WORK))/bankkonto_work.sas
 , print    = Y
 , debug    = Y
   );
 
%* Example 3: Create a DDL file for table bankkonto with libref parameter: ;
%m_utl_create_ddl(
   libnm    = WORK
 , tblnm    = bankkonto
 , ddl_file = %sysfunc(getoption(WORK))/bankkonto_libref.sas
 , prm_flg  = Y
 , prm_lib  = %nrstr(&libref.)
 , print    = Y
 , debug    = Y
   );
 
%* Example 4: Create a DDL file for table bankkonto with creds parameter: ;
%m_utl_create_ddl(
   libnm     = WORK
 , tblnm     = bankkonto
 , ddl_file  = %sysfunc(getoption(WORK))/bankkonto_creds.sas
 , prm_flg   = Y
 , prm_lib   = %nrstr(&libref.)
 , prm_creds = %nrstr(&creds.)
 , print     = Y
 , debug     = Y
   );
 
