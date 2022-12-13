# chamilo2obsidian

## Introduction
This repo contains a POC and quidance related to transferring training content. 
Move training course info among: chamilo, obsidian, dcs and clickup.

Enter <cmd> -h for specific help for program

Command | Description
---     | ---
c2md    | convert clickup cards to markdown
c2o     | Chamilo to Obsidian vault via api
cvt     |  convert various file formats from stdin to stdout
dcs2md  | get repo from dcs and convert files to markdown
declude |  undo any included files in this html file
etl     | Extract markdown files, convert to html then package SCO
helper  | grep first comment block from script
inc     | expand included files inline
md2tsv  | convert markdown table to tsv
o2c.sh  | exercise Chamilo API
unpk    | unpack an SCO or Backup package for import into Obsidian

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
### Obtain user credentials for chamilo
user  ?
pswd  ?
      
### chamilo instance and api
host  https://academia.idiomaspuentes.org
api   plugin/courseway/api/v1
          
### obsidian vault with training content
vault /mnt/c/Users/bruce/Sync/Catalog
template basic.html
     
### local environment
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

# Proof of Concept
The purpose of this POC is to determine if a tool can be built to move training 
information among different repositories including:
Chamilo, Obsidian, DCS, Clickup and Github

# Status:
It was demonstrated that data can be extracted from each of the above sources and 
injected into each of the others.
The extractions were not perfect but perhaps 98% so.
Loading into alternate destinations was similarly successful.

# End to End Test Case Scenerios
- Extract cards from clickup and create Obsidian files
- Extract course from Chamilo and create Obsidian file system
- Extract repo from DCS and create Obsidian file system

# Environment
Two courses were developed in Chamilo as separate POCs.
Each course exercised disjoint subsets of chamilo supported features

# Observations
- A training team should consider carefully the range of question types to be used in a variety of training courses.
While Chamilo supports over 25 types of questions, it is not trivial to model the questions and answers external to the tool
A general format was chosen to model at least 10 types of questions, 
but it is not easy for test designers to think in this manner.

- The original intention was to use Chamilo's ability to read and write SCORM files to extract the data, unpack it from the XML files for modification, then rebuild a SCORM file to reimport the extracted data.
It was determined that the SCORM packages as exported by Chamilo are not complete. It was found that a backup of a course did seem to be comprehensive but required an API to put the modified data back into Chamilo.
 
- An API was developed to import to and export from Chamilo using the first course as a model "Practice Course".
The API extracted 100% of the training related content from Chamilo.

- Exported data was stripped of much of its inline style information which is not easily supported in Markdown (md) format.
The lesson here is that care should be taken to not try to make training content that is highly stylized as this information does not easily transfer.

- The extracted content was partially modeled in a Chamilo file system. 
The structure of this data was not retained in the exported Obsidian vault. 
As such, embedded links were left unmodified to be reconciled in a subsequent development effort.

- The API was extended to Import the exported data back into chamilo
All of the training content was able to be reimported back into Chamilo from Obsidan.
However, not all test types were faithfully reimported.

- When the second course was exported "Just-in-Time Module: Metaphors", 
the API was found to be quite deficient and had to be expanded to several more end points.
In the end, the API never completely exported all the data modeled in Chamilo.

- The API was extended to support the import of some of the newly used features only to finally be 
found to not be able to link all the exported data back into chamilo. The most notable 
exception was the use of learning path objective titles. 
These while exported appropriatly, were not able to be reimported with the current API.

# Guidence

When building or evaluating an API, each instructional element should be 
- identified in the LMS UI, 
- identified as to where it is modeled in the LMS database,
- determined how it will be extracted via API and 
- determined what portions and how they will be represented in an LMS agnostic format. 
- Note that any LMS will export identification information that is not relevant to an external representation 
nor will it be utilized in a different LMS. 
- The types of questions should be held to a minimum as transfer across LMSs will be problematic.
- The use of labeled images should be avoided as the text will not be easily translated nor subsequently located.
- The use of punctuation in document titles should be avoided. Document titles should match or be derivable from their file names. 
To allow them to diverge increases the complexity of storage and transfer.


