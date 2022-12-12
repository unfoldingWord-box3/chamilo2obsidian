# chamilo2obsidian

Move training course info among: chamilo, obsidian, dcs and clickup.

Enter <cmd> -h for specific help for program

- c2md - convert clickup cards to markdown
- c2o - Chamilo to Obsidian vault via api
- cvt  -  convert various file formats from stdin to stdout
- dcs2md - get repo from dcs and convert files to markdown
- declude  -  undo any included files in this html file
- etl - Extract markdown files, convert to html then package SCO
- helper - grep first comment block from script
- inc - expand included files inline
- md2tsv - convert markdown table to tsv
- o2c.sh - exercise Chamilo API
- unpk - unpack an SCO or Backup package for import into Obsidian

Use the following procedure to use these scripts on your local machine

  1. enable wsl
    1.1. start powershell as admin
      wsl -install
    1.2. set uid passwd
    1.3. install windows terminal 
      from app store
  2. configure ubuntu
    sudo apt install -y jq miller pandoc tidy zip
    2.1. copy c2o.zip to desktop
    2.2. run "terminal" from windows
      click down arrow select ubuntu
      mkdir bin
      cd bin
      explorer.exe .
    2.3. drag zipfile from desktop file to here
      cd
    2.4. using one of vi notepad.exe
      <editor> .bashrc
    2.5. scroll to bottom and add
      PATH=$PATH:~/bin
      <editor> .c2o.config
    2.6. paste the following entering your chamilo userid and password:
---
# credentials for chamilo
user  ?
pswd  ?
      
# chamilo instance and api
host  https://academia.idiomaspuentes.org
api   plugin/courseway/api/v1
          
# obsidian vault with training content
vault /mnt/c/Users/bruce/Sync/Catalog
template basic.html
     
# local environment
editor notepad.exe
---     
    3. install and set up resilio
      3.1. edit vault in .c2o.config to point to your vault
        c2o edit-config

    4. Test course transfer
      c2o get-course-complete Training "Practice Course"
      4.1. cd to <vault>/Majors/Training/Courses
        mv Practice-Course Simple-Course
        c2o add-course-comp Training "Simple Course"

