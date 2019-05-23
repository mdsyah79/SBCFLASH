
   Ranish Partition Manager        Version 2.40.00         February 08, 2001

 -----------------------------------------------------------------------------

      CONTENTS
 
   I. RELEASE NOTES

  II. KEYS AND FUNCTIONS REFERENCE

	- Keys reference
  	- Installing boot manager
  	- Installing patch fot booting NT, DOS, etc. from partitions above 2G
  	- Resizing partitions (Please, READ this section - it is important!!!)

 III. WARRANTY, COPYRIGHTS, AND REGISTRATION

 -----------------------------------------------------------------------------

 I. RELEASE NOTES
 
    First of all, I suggest this version only to the EXPERIENCED users.
    
    Version (2.40) is the same as version 2.38 beta 1.91. I simply had
 renamed the program since it was working without any problems or bugs 
 for almost a year and appears to be very stable.
 
    This version is the latest version of Partition Manager. There is
 no other "full" version in exsistance (I wish there was). This version is
 a fully functional shareware. Even if you don't register it you still get
 all the functionality of the program. However, if you have found part.exe
 to be a handy tool and would like to register, please, send me a postcard
 of your town (or even better - your college, if you are a student).
             
    This version supports disks of any size and up to 4 primary partitions.
 Unfortunately, it does not support 30 primary partitions as it was in the
 previous version. You can download 16-bit version 2.37 from my web site,
 but it works only on the first 8G of your disk. I am planning to add support
 for more than 4 primary partitions in the 32-bit version, but it is taking
 longer than I hoped.
                     
    If you need a better boot manager than one that comes with part.exe,
 please, check out XOSL at http://www.xosl.org. If you haven't seen it before
 you will be impressed when you do.
                                     
    If you have any questions regarding disk partitioning and installing
 various operating system, please, post them to the partition manager mailing
 list: 
        http://groups.yahoo.com/groups/partman
      
        or to the newsgroup for the appropriate operating system
                                     
    Only if you have confirmed bug reports concerning part.exe program itself,
 send the to me, othervise I urge you to seek help at one of the newsgroups
 or partition manager mailing list. I couldn't possibly answer everybody who 
 needs help with partitioning. Your messages would pile up for months until
 I could get to them them. Therefore, please,
 
  - Read Partition Manager Primer, Help and FAQs and this README file !!! -

 The newest version of the program and its documentation could be found at:

    http://www.ranish.com/part/

 ------------------------------------------------------------------------------
   Note: If you are using a memory manager (like emm386.exe or qemm386.sys)
   and you don't have any DPMI host running (for instance Windows 3.x or Win95
   provide DPMI services, or 32rtm.exe that comes with Borland is a DPMI host)
   then upon running Partition Manager you will get the following message:

	"CPU is running in protected mode, but DPMI is not available."

   In this case you will need to run CWSDPMI.EXE before the Partition Manager.
 ------------------------------------------------------------------------------

 II. KEYS AND FUNCTIONS REFERENCE
 
 Run "part" without options to start GUI.
 Run "part -p" to print partition table.
 Run "part -p -r" to print detailed information about all partitions.
 Run "part -d 2 -p" to print information about the second hard drive.
 
 When you get into the GUI the following keys are functional now:
 
   Use Arrow keys, End, Home, PgUp, PgDn, and Tab to move around the table.
   
   B - toggles Boot flag on/off - selects active partition (marked with '>')

   H - Hide / Unhide - changes file system type for FAT partitions and NTFS.
   
   C - Copy partition
   
   D - Duplicate entire disk

   S and L - Save and Load MBR - do not work yet. To save information about 
             partitions, please, run "part -p -r" and then print the output.

   INS - Changes file system type. When you press it the list of all known
         partitions appears. You can use first characters of file system
         name for quich search or hit INS again to enter hexadecimal code
         of the file system.
         
            To create a new partition you simply have to move the cursor to
         the unused space, press INS and select partition type (i.e. FAT-32).
         Then, if you don't want to give it all free space, you may change its
         starting and ending cylinders. You don't have to worry about heads
         and sectors, because partition manager will take care of it.
         
            After you created a new partition you will have to save partition
         table (F2), format this partition and then reboot computer from a
         setup floppy to install a new OS, or use command sys.com to install
         system files manually.
   
   DEL - Clears record in the table, but doesn't delete partition on the disk.
         All changes that you are doing are in memory and will not be saved to
         the disk until you press F2.
         
   F2 - Saves partition table to the disk. By writing new partition information
        to MBR and all Extended partition records (EMBRs). If some of the
        records are invalid additional dialog box will popup and warn you.
        You can press ESC and fix all errors before saving.
   
   F3 - Undo. This key simply rereads all partition information from the disk.
   
   F4 - Change display modes between Cylinder Head Sector (CHS) mode and
        Logical Block Addressing (LBA) mode.
   
   F5 - Switches to the next disk. Alternatively, you can start program with
        the option "-d 2" then it will go directly to the second disk.

   V  - Verifies partition or unused space for bad sectors. If there are bad
        sectors on the partition the function will display list of the first
        nine bad sectors and exit. If you verified entire  disk and there is
        no bad sectors you can use Quick Format option when you format
        partitions, which will save you a lot of time.

   F - Formats FAT-16 and FAT-32 partitions. Currently there are no options
       for this function, but I will add more in the future ( volume_label,
       fat_size, root_size, cluster_size, etc... )

   X - Toggles Primary/Logical flag on the partition
   
   A - Install Partition Manager on floppy such that you could boot it without
       any operating system and go directly into Partition Manager. Optionally,
       you could have DOS/Windows installed on a floppy and boot it by default,
       and load Partition Manager (bypassing OS) only if 'Ctrl' key is pressed.

       For instance, I put Partition Manager on the first NT 4.0 setup floppy,
       so that by default it boots NT Setup, and if I press and hold 'Ctrl'
       while booting it goes directly to Partition Manager screen.
       
       (Note that if you use this feature you should not compress PART.EXE by
        any executable file compressor, such as PKLITE).

   ENTER - invokes specific setup functions for each file system. Currently
           there are two setup modules. One for Initial Program Loader (IPL),
           which resides in MBR, and the other for FAT-16 and FAT-32 file
           systems.

 ------------------------------------------------------------------------------

 Setup options for IPL (Initial Program Loader - executable code in the MBR)

   First option tells which IPL currently resides in MBR. The choices are:

        - Standard IPL - this one comes with MS-DOS 6.22 fdisk.exe, selecting
                         this IPL is equivalent to running "fdisk /mbr"

        - Unknown IPL  - your current IPL, which Partition Manager cannot
                         recognize. It could be IPL that comes with Win95,
                         LILO that comes with Linux, or even some older
                         version of one that comes with Partition Manager.

        - Boot Manager - once Boot Manager is selected you have to set which
                         of the interfaces you want to use:
                         
             - Compact - this choice will install only IPL: Initial Program
                         Loader - executable code that resides in MBR along
                         with the partition table.
                           This little program (446 bytes) that is smaller
                         than one sector (512 bytes) fits into MBR. It doesn't
                         have as much functions as the GUI version of Boot
                         Manager, but it still has more of them than some of
                         the existing boot managers (see description below).

          - Text 25x80 - this version of boot manager has text mode menu driven
                         interface. It doesn't have mouse support and cool 
                         video effects, but it has all advanced functinality
                         of the boot manager. And it is definitely faster than
                         the GUI version.

         - GUI 640x480 - same as previous one, but it has graphics and mouse
                         support and takes several seconds to load.
                         (this one is not finished yet)
                         
      If you want to use "Text 25x80" or "GUI" boot menu you have to create a
   small (couple of megs) partition for the Boot Manager (type 0xF0).

      That partition could be located anywhere on the disk and could be either
   primary partition or a logical disk inside extended partition.

 ------------------------------------------------------------------------------

 Options for Compact Boot Manager:

    Check for boot viruses - when enabled it instructs boot manager to
              check interrupt vectors 0 to 1Ch (Keyboard, Timer, Disk, ... )
              and 4Ah and 70h (Alarm and Real-Time Clock) for the valid
              adddress pinting to BIOS. If any of them point below BIOS
              memory to the conventional RAM the IPL will show warning

                   " Virus! _"

              and wait until you press Enter. This gives you a chance to
              turn off the computer and run antivirus program from a clean
              floppy disk. However, not only viruses hook onto the interrupt
              vectors. For example, some old SCSI adapters place their code
              on top of conventional memory and point disk interrupt vector
              to it. In this case you have to disable virus check.

    Boot Manager's timeout - this option specifies how much time boot manager
              will wait before it gives control to operating system. When
              BIOS loads boot manager from the first sector on disk (MBR)
              and gives control to it, boot manager displays the prompt
              similar to this:

                   "Booting HD1/3 ..."

                It means that boot manager is about to load operating system
              from Partition 3 on Hard Disk 1. At this prompt you can either
              wait timeout's second or press ESC to load OS immediately. If
              you hit keys '1-4' or 'A', instead of booting Partition 3 it
              will boot from another partition or from the 'A' drive.

                After you make your choice boot manager will save your
              selection back to MBR, so that it will use it next time.
              However it will not save it if you choose 'A'.

                Note that if you install boot manager's IPL you can change
              boot sequence in BIOS to "C:,A:" so that your computer will
              always start to boot from C: and it will not start from the
              infected floppy by accident. If YOU want to boot from floppy
              you would simply press 'A' at the boot manager's prompt.

                If your BIOS has boot sector write protection it might give
              you warning, that somebody is trying to write to MBR. Obviously
              if you want to use boot manager you have to disable that write
              protection.

                Also, you can press TAB to boot from the second hard drive
              or SPACE to stop and wait for your choice.

                All other keys will cause boot manager to load OS and let it
              interpret that key. For example, you can press F8 or F4 when
              booting Windows 95 to have it display its boot menu (F8) or load
              previous version of MS-DOS (F4).
              
               If you pressed SPACE or there was an error loading boot sector
              for some OS boot manager will stop with the following prompt and
              wait for your input:

                   "Booting HD1/_"
              
                The choices you make here are similar to those on the running
              dots' prompt: 
                              1-4 - boot from another partition
                                A - boot from the floppy drive A:
                              TAB - boot from the next hard drive

                However, if you keep entering wrong keys for 1960 times at a
              row IPL will get tired of you and will boot last valid choice.
              Just kidding, it won't get tired, but it will boot your system
              even if a book lies on the keyboard and nobody is in the office
              to take it off. Very usefull thing for the servers, and delay is
              only a minute.

    Default boot choice - this option lets you specify the partition that you
              want boot manager to boot by default no matter what the user
              have selected last time. For example, if your kids play on your
              computer you may set it to Windows 95, then if you are not home
              it will always boot Windows 95, even though last time you chose
              to boot from the Linux partition.

 ------------------------------------------------------------------------------
 
     If you choose "Text 25x80" boot manager interface then you could use the
   following keys:
                               Space - stop and wait for the user's input
                                 ESC - boot highlighted choice without delay
                                  A  - boot from the floppy disk
                                  0  - run partition manager
                                 1-9 - select another menu choice 
                               Enter - boot highlighted choice without delay

   All other keys will be passed to the booting OS.

 ------------------------------------------------------------------------------

   Settings for FAT file systems. There are three values that you can set in
 FAT-16/FAT-32 boot sector.

      Starting sector - its value should correspond to starting sector (hit F4)
            of the partition for the primary partitions and is 63 for logical
            drives. If you want to turn logical drive into a bootable primary
            partition among other things you will need to change this value.

      Drive number - you need to edit this option if you want to boot DOS
             or Windows from the second hard drive. This number must be set
             to 128 (80h) for the first hard drive and 129 (81h) for the
             second. Also, note that you have to hide all primary FAT
             partitions on the first hard drive in order to boot DOS or
             Windows 95 from the second.

      Partition size - this one is the most interesting number for us. It
            tells us how many sectors there is in the partition. If we make
            it smaller DOS (or Windows 95) will think that the partition is
            smaller, thus we can shrink partitions (see below).

      Hint: if you press 'X' all three, starting sector, drive number, and 
            the partition size, will be set to their expected values.

      The final FAT-16 option is a patch for DOS boot sector - it resolves
           the problem when DOS cannot boot from the partitions over 2G from
           the beginning of the disk. In addition to this, it allows you to
           dual boot MS-DOS and OSR2, which was not possible before, since
           OSR2's FAT-16 boot sector has bugs. Press "F6" to install the patch,
           then choose OS that you wish to run and press F2 to save changes
           to the boot sector.
           
           The patch was tested with MS-DOS 6.22, PC-DOS 7.00, DR-DOS 7.02
           Windows 95 OSR2, Windows 98 (Aug98), and Windows NT 4.0 (SP0-5).
     

 ------------------------------------------------------------------------------

  Installing NT to partitions above 2G from the beginning of disk.

	1. Prepare empty space or primary FAT-16 partition for NT.
	2. Hide any other primary FAT-12 / FAT-16 partitions.
	3. Boot from the NT Setup Floppy Disk #1
	4. When NT asks whether you want FAT or NTFS file system choose FAT.
	5. Let NT copy all the files from the CD-ROM.

	6. Upon the reboot run Partition Manager and install special patch for
	   Windows NT into FAT-16's boot sector. To do that first select NT's
	   partition and press Enter, then press F6 to install patch, then,
	   in the dialog box choose "Windows NT" and finally press F2 to save
	   changes to the boot sector.

	7. For the first time reboot from NT partition while holding down
	   'Ctrl' key. (This will load alternative NT loader "$LDR$").
	   Let NT finish the setup procedure and ask you to reboot.
   
	8. Reboot computer. Everything should work now.
	
   If you need to install NT 4.0 above 4G then you must either have SP5
   or get at least files "NTDETECT.COM" and "NTLDR" from SP5 and update
   them on the hard drive after the first reboot.
   
 ------------------------------------------------------------------------------

  In order to RESIZE (shrink) FAT partition you have to do the following steps:

     1. Defragment the partition. This will bring all the files to the
        beginning of partition. If you use DEFRAG.EXE under Windows 95
        you have to select option "Advanced / Consolidate free space."
        Under Windows 98 uncheck "Settings / Rearrange files ... "

     2. You have to change partition size in TWO places: in the partition
        table on top and in the boot sector on the bottom. (In the later
        versions resize will be, obviously, done automatically). Anyhow,
        first you have to change partition size in the partition table. Then
        press ENTER to go into boot sector screen. Change the size, but make
        sure it does not drop below the minimum partition size.

           There are several other numbers. Green number is the total space
           occupied by files in the partition. Minumum size calculated from
           the location of the last cluster on the disk - you may not make
           partition smaller than this number, because if you do that file
           is going to be outside of the partition and windows is going to
           crush. The third number, maximum partition size, is calculated
           from the size of FAT tables - the larger is FAT the more clusters
           you can have on the disk. Since we cannot change size of the FAT
           nor cluster size with this version of the program, we have to
           accept that limitation. However, there is an option to format
           which lets you create large FAT in advance so that you can enlarge
           the partition later.

     3. Save all the changes you've made and reboot computer. Then run some
        sort of diagnistic utility, such as SCANDISK or NDD to check that
        everything is ok before it is too late :). On FAT-32 it will always
        report incorrect amount of free space, but this is normal, since we
        did change that number.

    That's all. I hope to get the real resize procedure soon - then it will
 be much easier to do this sort of things.

 -----------------------------------------------------------------------------

 III. WARRANTY, COPYRIGHTS, AND SHAREWARE REGISTRATION

   WARRANTY: There is absolutely NO WARRANTY attached to this program. You
 should use it only at your own risk. However, there is an open source code
 that is available on my home page, so you can look at it to know what it
 does and compile it yourself if you don't trust the executable.
   
   DISTRIBUTION: You can redistribute this program free of charge as long as
 you do not modify any of the files included in the package, and do not charge
 additional fees, other than to cover costs of physical distribution. You may
 use parts of the source code free of charge in the other open source or
 non-commercial project, with the condition that you clearly indicate from
 where it was taken. If you want to use whole program or its parts in the
 commercial product you must get my permission for that.

   REGISTRATION: Ranish Partition Manager version 2.38 is distributed as the
 shareware. You may evaluate the program for the period of time and then you
 pay for it if you like it.

   Private users, educational and non-profit organizations may evaluate the
 program for the period of 10 years, then they must pay registration fee of
 $10 per household/classroom/department or stop using the program. If you
 cannot afford $10, you may send me a postcard with a nice view of your city,
 and I will count you as a registered user. If you are a poor student,
 than the postcard with a view of your university is definetely the best way
 to register the program.

   Commercial organizations, governments, and military units may evaluate
 the program for 30 days. Then they must pay registration fee of $20 per
 each department or technical unit, that uses it, or stop using the program.
   If Boot Manager, that comes with this program, is installed on more than
 three workstations then $3 must be added for the workstations 1-20, $2 - for
 workstations 31-60, $1 - for 61-90, and 10 cents for each one over 90.

   Once the program is registerd the registation is valid for all subsequent
 versions of the program.

 To register Partition Manager send US checks, money orders, or postcards to

 Mikhail Ranish
 P.O.Box 140404
 Brooklyn, NY 11214  USA

 Partition Manager Home Page:  http://www.ranish.com/part/
 Partition Manager User Group: http://groups.yahoo.com/groups/partman/
 
