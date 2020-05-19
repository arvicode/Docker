FROM node:14.2.0-stretch-slim

ARG user=app_user
ARG group=app_user

#Update repository list
RUN apt-get update

# installing sudo, git, unzip and build-essential
RUN apt-get -y install sudo git unzip build-essential 

#Create app_user user to run the app and give it sudo privileges
RUN addgroup app_user; adduser --disabled-password --gecos "App User" --home /home/app_user -ingroup ${group} --shell /bin/bash ${user}
RUN chmod 700 /etc/sudoers; printf "\n#Allow passwordless execution for AppUser\napp_user ALL=(ALL) NOPASSWD:ALL\n" >> /etc/sudoers; chmod 400 /etc/sudoers

#Create directory for the app and set owner to app_user
RUN mkdir -p /app
WORKDIR /app

####Insert your Node JS App Building instructions here######

	COPY . /app
	RUN npm install
	EXPOSE 8000


##############Ends######################################
RUN sudo chown -R app_user:app_user /app


#Set User to app_user
USER ${user}
EXPOSE 8000

CMD npm start
