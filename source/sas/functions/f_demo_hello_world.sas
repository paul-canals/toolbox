/*!
 ******************************************************************************
 * \file       f_demo_hello_world.sas
 * \ingroup    Functions
 * \brief      Custom function to demonstrate how user defined functions work.
 * \details    The function can be called in a datastep, and has one argument
 *             called TEXT. When the function is called with the text HELLO?,
 *             then the function returns HELLO-WORLD!. 
 * 
 * \note       To use this function and others, either the PROC FCMP procedure
 *             statement must be included when running this script, or called
 *             by the run_functs_compilation.sas script to create the function
 *             container under: /toolbox/source/sas/misc/scripts/.
 *             
 * \author     Paul Alexander Canals y Trocha (paul.canals@gmail.com)
 * \date       2023-10-01 hh:mm:ss
 * \version    23.1.10
 * \sa         https://github.com/paul-canals/toolbox
 * 
 * \param[in]  text      Textual string to call the function.
 *                       The default value is: Hello?
 * 
 * \return     The functions answer to the question who is there.
 * 
 * \calls
 *             + none
 * 
 * \usage
 * 
 * \example    Example 1: Show Hello reaction function
 * \code
 * 
 *             proc fcmp outlib=WORK.functs.demo;
 *                function f_demo_hello_world(text $) $ 100;
 *                   if lowcase(text) eq 'hello?' then do;
 *                      return(cat(compress(text,'?'),'-','World!'));
 *                   end;
 *                   else do;
 *                      return('Who are you?');
 *                   end;
 *                endsub;
 *             quit;
 * 
 *             options cmplib=WORK.functs;
 * 
 *             data _null_;
 *                rc = f_demo_hello_world('Hello?');
 *                put rc=;
 *             run;
 * 
 * \endcode
 * 
 * \copyright  Copyright 2008-2023 Paul Alexander Canals y Trocha.
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
/*
proc fcmp outlib=WORK.functs.demo;
*/

   function f_demo_hello_world(text $) $ 100;

      if lowcase(text) eq 'hello?' then do;
         return (cat(compress(text,'?'),'-','World!'));
      end;
      else do;
         return ('Who are you?');
      end;

   endsub;

/*
quit;
*/
