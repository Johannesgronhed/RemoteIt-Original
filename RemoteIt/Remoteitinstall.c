#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <unistd.h>

int vnc_install() {
	
	int status;
	printf("Instaling Tightvncserver for Ubuntu\n");
	int update = system("sudo apt-get update");
	int install = system("sudo apt-get install xfce4 xfce4-goodies tightvncserver");
	int startVnc = system("vncserver");
	int exitVnc = system("vncserver -kill :1");
	int unClutter = system("sudo apt-get install unclutter");
	int runInBackground = system("unclutter -idle 0.01 -root &");
	int installSSH = system("sudo apt-get install openssh-server");	
	
	int createBak = system("mv /home/${USER}/.vnc/xstartup /home/${USER}/.vnc/xstartup.bak");
	int createNew = system("touch /home/${USER}/.vnc/xstartup");
	int chmodSU = system ("chmod 755 /home/${USER}/.vnc/xstartup ");

	int createThis = system("sudo touch /etc/init.d/vncserver");
	
	

	const char *bashCode = "#!/bin/bash\n"
			"xrdb $HOME/.Xresources\n"
			"startxfce4 &\n";


	const char *bashGround = "#!/bin/bash\n"
			 "PATH='$PATH:/usr/bin'\n"
			 "export USER='netadmin'\n"
			 "DISPLAY='1'\n"
			 "DEPTH='16'\n"
			 "GEOMETRY='1024x768'\n"
			 "OPTIONS='-depth ${DEPTH} -geometry ${GEOMETRY} :${DISPLAY} -localhost'\n"
			 ". /lib/lsb/init-functions\n"
			 "case '$1' in\n"
			 "start)\n"
			 "log_action_begin_msg 'Startin vncserver'\n"
			 "su ${USER} -c '/usr/bin/vncserver ${OPTIONS}'\n"
			 ";;\n"
			 "esac\n"
			 "exit 0\n";

	int chmodThis = system("sudo chmod +x /etc/init.d/vncserver");
	int chgFix = system("sudo chown ${USER}:${USER} /etc/init.d/vncserver");

	FILE *fp = fopen("/home/netadmin/.vnc/xstartup", "w");
	if (fp == NULL)
	{
		printf("Can't open file for writing!\n");
	}

	fprintf(fp, "%s", bashCode);
	fclose(fp);

	FILE *SUfp = fopen("/etc/init.d/vncserver", "w");
	if (SUfp == NULL)
	{
		printf("Can't open file for writing\n");
		printf("Use sudo command.\n");
	}

	fprintf(SUfp, "%s", bashGround);
	fclose(SUfp);

	int chgIt = system("sudo chown root:root /etc/init.d/vncserver");

	const char *cronUsr = "*/2 * * * * /home/netadmin/checkStart.sh 2> /home/netadmin/checkStart_Error.logi\n";

	int createTmp = system("touch cron-file.txt");
	FILE *cron = fopen("cron-file.txt", "w");

	fprintf(cron, "%s", cronUsr);
	fclose(cron);

	const char *SUcron = "00 06 * * * /sbin/shutdown -r now 2> /dev/null\n"
			     "*/2 * * * * /home/netadmin/checkNetwork.sh\n";	

	int createSuCRON = system("touch cronSU-file.txt");
	FILE *cronSU = fopen("cronSU-file.txt", "w");

	fprintf(cronSU, "%s", SUcron);
	fclose(cronSU);

	int updateCronUSR = system("crontab cron-file.txt");
	int updateCronSU = system("sudo crontab cronSU-file.txt");

	int rightsSH = system("chmod +x /home/netadmin/*.sh");
	int rightsPY = system("chmod +x /home/netadmin/*.py");

	printf("I have some cleaning to do!\n");
	int clean = system("rm *.sh *.py *.txt");

	printf("cleaning done!\n");

 
	int statusen = WEXITSTATUS(status);
	printf("exiting with code %d\n", statusen);
	
	int rebOOt = system("sudo init 6");

	return 0;
}

int file_exists (char *filename)
{
	struct stat buffer;
	return (stat (filename, &buffer) == 0);
}

int gecko_exists (char *filename)
{
	struct stat buffer;
	return (stat (filename, &buffer) == 0);
}


int main() {

	printf("Downloadeing files for RemoteIt\n");

	int dwnLoad1 = system("wget https://github.com/alxr91/RemoteIt/blob/master/checkNetwork.sh");
	int dwnLoad2 = system("wget https://github.com/alxr91/RemoteIt/blob/master/checkStart.sh");
	int dwnLoad3 = system("wget https://github.com/alxr91/RemoteIt/blob/master/rebootit.sh");
	int dwnLoad4 = system("wget https://github.com/alxr91/RemoteIt/blob/master/showWebsites.py");
	
	printf("Moving files for RemoteIt\n");
	int createIt = system("mkdir -p /home/${USER}/showWebsites");
	int moveIt = system("cp *.sh /home/${USER}");
	int moveSpec = system("cp *.py /home/${USER}");

	if ( gecko_exists ("/usr/bin/geckodriver")){
		printf("geckodriver is installed\n");
	} else {
		
		printf("Downloading Geckodriver for RemoteIt\n");
		int load = system("wget https://github.com/mozilla/geckodriver/releases/download/v0.11.1/geckodriver-v0.11.1-linux32.tar.gz ");
		int unGecko = system("tar xvfz geckodriver-v0.11.1-linux32.tar.gz");
		int moveGecko = system("sudo cp geckodriver /usr/bin/");
		printf("Geckodriver is in place\n");
	}
	
	if ( file_exists ("/usr/bin/pip")){
		printf("python-pip is installed\n");
	} else {
		printf("Installing python-pip\n");
		int instPip = system("sudo apt-get install python-pip");		

	}
	printf("Installing Selenium\n");

	int instSel = system("sudo -H pip install selenium");
	vnc_install();
}
