rsync -havP --delete /home/sam/pCloudDrive/ /varmuusvarasto1/salainen/pcloud/


FLAGS:
-h          human-readable
-a          archive
-v          verbose
-P          --progress --partial
--progress  show progress
--partial   By default, rsync will delete any partially transferred file if the transfer is interrupted. In some circumstances it is more desirable to keep partially transferred files. Using the --partial option tells rsync to keep the partial file which should make a subsequent transfer of the rest of the file much faster.
--delete    delete any file or directory at the destination if the source does not have it

