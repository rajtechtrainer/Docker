#Base image
FROM ubuntu
LABEL version="latest" maintainer="dsaravanan <doraiswamy.saravanan@gmail.com>"
#update the image
RUN apt-get update --fix-missing

#install python
RUN apt install python3-pip -y --fix-missing
RUN pip3 install robotframework
RUN pip3 install robotframework-seleniumlibrary

RUN export DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/America/New_York /etc/localtime
RUN apt-get install -y tzdata
RUN dpkg-reconfigure --frontend noninteractive tzdata

#The following are needed for Chrome and Chromedriver installation
RUN apt-get install -y xvfb 
RUN apt-get install -y zip 
RUN apt-get install -y wget 
RUN apt-get install ca-certificates 
RUN apt-get install -y libnss3-dev libasound2 libxss1 libappindicator3-1 libindicator7 gconf-service libgconf-2-4 libpango1.0-0 xdg-utils fonts-liberation
RUN apt install -y curl
RUN apt install -y libcurl4
RUN wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
RUN apt install -y ./google-chrome-stable_current_amd64.deb 
RUN apt-get install -y -f
RUN rm google-chrome*.deb
RUN wget https://chromedriver.storage.googleapis.com/93.0.4577.63/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN chmod 777 chromedriver
RUN cp ./chromedriver /usr/local/bin
RUN rm chromedriver_linux64.zip
RUN chmod 777 /usr/local/bin/chromedriver
#Robot Specific
RUN mkdir /robot
RUN mkdir /results

#echo setup values
# RUN robot --version
RUN echo $PATH
RUN google-chrome --version
RUN chromedriver -v

ENTRYPOINT ["robot"]
