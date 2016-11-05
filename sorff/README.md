
# System of Record For Fiction

## Definition

A bash shell script that creates a system of record for fiction template from a Unix shell in your current working directory or your home directory.


## Use Case

You need to create a system of record for fiction.


## Arguments

### sorff.sh has three parameters: -h (for home) and -s (for story name) and -p (for pen name or pseudonym).  

The parameter -h is an option that switches output of the system of record from your current working directory to your home directory. 

The parameter -s takes an argument of a quoted story name that names the git repository for the system of record for fiction. 

The parameter -p takes an argument of a quoted pseudonym that names a directory for your FunWork journal and a branch for you to develop your story in the system of record for fiction.

## Requirements

sorff.sh requires a Unix Bash shell that's available on Ubuntu, MacOS X or Cygwin (for Windows), so sorff.sh can execute. sorff.sh has only been tested on Ubuntu and MacOS X.

## Process:
1. Install git: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
2. Execute git to clone source: git clone https://github.com/WordProstitute/tools.git
3. Execute sorff.sh: (for example) bash ./tools/sorff/sorff.sh -p 'Kalab J Oster' -s 'Open'
4. Change Directory: cd Open
5. Read, write, edit and publish...
