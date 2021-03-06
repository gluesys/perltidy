# PERLTIDY INSTALLATION NOTES

# Get a distribution file

- Source Files in .tar.gz and .zip format

    This document tells how to install perltidy from the basic source
    distribution files in `.tar.gz` or `.zip` format.  These files are
    identical except for the line endings.  The `.tar.gz` has Unix style
    line endings, and the `.zip` file has Windows style line endings.  The
    standard perl MakeMaker method should work for these in most cases. 

- Source files in RPM and .deb format

    The web site also has links to RPM and Debian .deb Linux packages, which may be
    convenient for some users.

# Quick Test Drive

If you want to do a quick test of perltidy without doing any installation, get
a `.tar.gz` or a `.zip` source file and see the section below "Method 2: Installation
as a single binary script".

# Uninstall older versions

In certain circumstances, it is best to remove an older version
of perltidy before installing the latest version.  These are:

- Uninstall a Version older than 20020225

    You can use perltidy -v to determine the version number.  The first
    version of perltidy to use Makefile.PL for installation was 20020225, so
    if your previous installation is older than this, it is best to remove
    it, because the installation path may now be different.  There were up
    to 3 files these older installations: the script `perltidy` and
    possibly two man pages, `perltidy.1` and `perl2web.1`.  If you saved
    your Makefile, you can probably use `make uninstall`.  Otherwise, you
    can use a `locate` or `find` command to find and remove these files.

- Uninstall older versions when changing installation method

    If you switch from one installation method to another, the paths to the
    components of perltidy may change, so it is probably best to remove the older
    version before installing the new version.  If your older installation method
    had an uninstall option (such as with RPM's and debian packages), use it.
    Otherwise, you can locate and remove the older files by hand.  There are two
    key files: `Tidy.pm` and `perltidy`.  In addition, there may be one or two
    man pages, something like `Perl::Tidy.3pm` and `perltidy.1p`.  You can use a
    `locate` and/or `find` command to find and remove these files.  After
    installation, you can verify that the new version of perltidy is working with
    the `perltidy -v` command.

# Two Installation Methods - Overview

These are generic instructions.  Some system-specific notes and hints
are given in later sections.  

Two separate installation methods are possible.  

- Method 1: Standard Installation Method

    The standard method based on MakeMaker should work in a normal perl
    environment.  This is the recommended installation procedure for
    systems which support it.

            perl Makefile.PL
            make
            make test
            make install

    The `make` command is probably `nmake` under a Windows system.  You
    may need to become root (or administrator) before doing the `make
    install` step.  

- Method 2: Installation as a single binary script

    If you just want to take perltidy for a quick test drive without installing it,
    or are having trouble installing modules, you can bundle it all in one
    independent executable script.  This might also be helpful on a system for
    which the Makefile.PL method does not work, or if you are temporarily a guest
    on some system, or if you want to try hacking a special version of perltidy
    without messing up your regular version.  

    You just need to uncompress the source distribution, cd down into it, and enter
    the command:

            perl pm2pl

    which will combine the pieces of perltidy into a single script named
    `perltidy` in the current directory.  This script should be 
    fully functional.  Try it out on a handy perl script, for example

        perl perltidy Makefile.PL

    This should create `Makefile.PL.tdy`.

- After Installation

    After installation by either method, verify that the installation worked
    and that the correct new version is being by entering:

        perltidy -v

    If the version number disagrees with the version number embedded in the
    distribution file name, search for and remove the old version.
    For example, under a Unix system, the command `which perltidy` might 
    show where it is.  Also, see the above notes on uninstalling older
    versions.

    On a Unix system running the `bash` shell, if you had a previous
    installation of perltidy, you may have to use 

        hash -r

    to get the shell to find the new one.

    After `perltidy` is installed, you can find where it will look for
    configuration files and environment variables on your system with
    the command:

        perltidy -dpro

- How to Uninstall

    Unfortunately, the standard Perl installation method does not seem able
    to do an uninstall.

    But try this:

        make uninstall

    On some systems, it will give you a list of files to remove by hand.  If
    not, you need to find the script `perltidy` and its module file
    `Tidy.pm`, which will be in a subdirectory named `Perl` in the site
    library.

    If you installed perltidy with the alternative method, you should just
    reverse the steps that you used.

## Unix Installation Notes

- Alternative method - Unix

    If the alternative method is used, test the script produced by the
    `pm2pl` perl script:

        perl ./perltidy somefile.pl

    where `somefile.pl` is any convenient test file, such as `Makefile.PL`
    itself.  Then,

    1\. If the script is not executable, use 

        chmod +x perltidy

    2\. Verify that the initial line in perltidy works for your system by
    entering:

        ./perltidy -h

    which should produce the usage text and then exit.  This should usually
    work, but if it does not, you will need to change the first line in
    `perltidy` to reflect the location of perl on your system.  On a Unix
    system, you might find the path to perl with the command 'which perl'.

    3\. A sample `Makefile` for this installation method is `Makefile.npm`.
    Edit it to have the correct paths.

    You will need to become root unless you change the paths to point to
    somewhere in your home directory.  Then issue the command

        make -f Makefile.npm install

    This installs perltidy and the man page perltidy.1. 

    5\. Test the installation using

        perltidy -h

    You should see the usage screen.  Then, if you installed the man pages, 
    try

        man perltidy

    which should bring up the manual page. 

    If you ever want to remove perltidy, you can remove perltidy and its man
    pages by hand or use

        make uninstall

## Windows Installation Notes

On a Windows 9x/Me system you should CLOSE ANY OPEN APPLICATIONS to
avoid losing unsaved data in case of trouble.

- Standard Method - Windows

    After you unzip the distribution file, the procedure is probably this:

            perl Makefile.PL
            nmake
            nmake test
            nmake install

    You may need to download a copy of `unzip` to unzip the `.zip` distribution
    file; you can get this at
    http://www.info-zip.org/pub/infozip/UnZip.html

    If you have ActiveState
    Perl, the installation method is outlined at
    http://aspn.activestate.com//ASPN/Reference/Products/ActivePerl/faq/Windows/ActivePerl-Winfaq9.html#How\_can\_I\_use\_modules\_from\_CPAN\_

    You may need to download a copy of Microsoft's `nmake` program from
    ftp://ftp.microsoft.com/Softlib/MSLFILES/nmake15.exe

    If you are not familiar with installing modules, or have trouble doing
    so, and want to start testing perltidy quickly, you may want to use the
    alternative method instead (next section).

- Alternative Method - Windows

    From the main installation directory, just enter

        perl pm2pl 

    Placing the resulting file `perltidy` and the example batch file
    `perltidy.bat`, located in the `examples` directory, in your path should
    work.  (You can determine your path by issuing the msdos command
    `PATH`).  However, the batch file probably will not support file
    redirection.  So, for example, to pipe the long help message through
    'more', you might have to invoke perltidy with perl directly, like this:

        perl \somepath\perltidy -h | more

    The batch file will not work properly with wildcard filenames, but you may
    use wildcard filenames if you place them in quotes.  For example

        perltidy '*.pl'

## VMS Installation Notes

- Links to VMS Utilities and Documentation

    To install perltidy you will need the following utilities Perl, of
    course, source with VMS goodies available from
    http://www.sidhe.org/vmsperl or binary available from the Compaq OpenVMS
    freeware CD.  To unpack the source either gunzip and vmstar available
    from the Compaq OpenVMS freeware CD or zip available from
    http://www.info-zip.org/

    To build perltidy you can use either **MMS**, Compaq's VMS equivalent of
    make, or **MMK**, an **MMS** clone available from
    http://www.madgoat.com.

    Information on running perl under VMS can be found at:
    http://w4.lns.cornell.edu/~pvhp/perl/VMS.html

- Unpack the source:

        $ unzip -a perl-tidy-yyyymmdd.zip  ! or

        $ unzip /text=auto perl-tidy-yyyymmdd.zip ! or

        $ gunzip perl-tidy-yyyymmdd.tgz
        $ vmstar perl-tidy-yyyymmdd.tar

- Build and install perltidy under VMS:

        $ set default [.perl-tidy-yyymmdd]
        $ perl perltidy.pl
        $ mmk
        $ mmk test
        $ mmk install

- Using Perltidy under VMS

    Create a symbol. This should be put in a logon script, eg sylogin.com

        $ perltidy == "perl perl_root:[utils]perltidy."

    Default parameters can be placed in a `perltidyrc` file.  Perltidy
    looks for one in the following places and uses the first found if the
    logical `PERLTIDY` is a file and the file exists then that is used if the
    logical `PERLTIDY` is a directory then look for a `.perltidyrc` file in the
    directory look for a `.perltidyrc` file in the user's home directory

    To see where the search is done and which `.perltidyrc` is used type

        $ perltidy -dpro

    A system `PERLTIDY` logical can be defined pointing to a file with a
    minimal configuration,  and users can defined their own logical to use a
    personal `.perltidyrc` file.

        $ define /system perltidy perl_root:[utils]perltidy.rc

- The -x Parameter

    If you have one of the magic incantations at the start of perl scripts,
    so that they can be invoked as a .com file, then you will need to use
    the **-x** parameter which causes perltidy to skip all lines until it
    finds a hash bang line eg `#!perl -w`.  Since it is such a common
    option this is probably a good thing to put in a `.perltidyrc` file.

- VMS File Extensions

    VMS file extensions will use an underscore character instead of a dot, 
    when necessary, to create a valid filename.  So 

          perltidy myfile.pl

    will generate the output file `myfile.pl_tdy` instead of
    `myfile.pl.tdy`, and so on. 

# Troubleshooting / Other Operating Systems

If there seems to be a problem locating a configuration file, you can see
what is going on in the config file search with:

    perltidy -dpro

If you want to customize where perltidy looks for configuration files,
look at the routine 'find\_config\_file' in module 'Tidy.pm'.  You should
be able to at least use the '-pro=filename' method under most systems.  

Remember to place quotes (either single or double) around input
parameters which contain spaces, such as file names.  For example:

    perltidy "file name with spaces"

Without the quotes, perltidy would look for four files: `file`,
`name`, `with`, and `spaces`.

If you develop a system-dependent patch that might be of general
interest, please let us know.

# CONFIGURATION FILE

You do not need a configuration file, but you may eventually want to
create one to save typing; the tutorial and man page discuss this.

# SYSTEM TEMPORARY FILES

Perltidy needs to create a system temporary file when it invokes
Pod::Html to format pod text under the -html option.  For Unix systems,
this will normally be a file in /tmp, and for other systems, it will be
a file in the current working directory named `perltidy.TMP`.  This file
will be removed when the run finishes.

# DOCUMENTATION

Documentation is contained in **.pod** format, either in the `docs` directory
or appended to the scripts.  

These documents can also be found at http://perltidy.sourceforge.net

Reading the brief tutorial should help you use perltidy effectively.  
The tutorial can be read interactively with **perldoc**, for
example

    cd docs
    perldoc tutorial.pod

or else an `html` version can be made with **pod2html**:

    pod2html tutorial.pod >tutorial.html

If you use the Makefile.PL installation method on a Unix system, the
**perltidy** and **Perl::Tidy** man pages should automatically be installed.
Otherwise, you can extract the man pages with the **pod2xxxx** utilities, as
follows:

    cd bin
    pod2text perltidy >perltidy.txt
    pod2html perltidy >perltidy.html
    
    cd lib/Perl
    pod2text Tidy.pm >Tidy.txt
    pod2html Tidy.pm >Tidy.html

After installation, the installation directory of files may be deleted. 

Perltidy is still being developed, so please check sourceforge occasionally
for updates if you find that it is useful.  New releases are announced
on freshmeat.net.

# CREDITS

Thanks to the many programmers who have documented problems, made suggestions and sent patches.  

# FEEDBACK / BUG REPORTS

If you see ways to improve these notes, please let us know.

A list of current bugs and issues can be found at the CPAN site [https://rt.cpan.org/Public/Dist/Display.html?Name=Perl-Tidy](https://rt.cpan.org/Public/Dist/Display.html?Name=Perl-Tidy)

To report a new bug or problem, use the link on this page .  
