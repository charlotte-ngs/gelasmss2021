
RSTPORT=10187
pass=VmIBCgfx
COURSEHOME=/home/quagadmin/courses/gelasmss2021/home
user=vrohrp
docker run -d -p $RSTPORT:8787 -e PASSWORD=$pass -v $COURSEHOME/${user}:/home/rstudio --name ${user}_rstudio rocker/verse
