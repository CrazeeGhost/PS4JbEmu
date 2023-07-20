# PS4JbEmu

## Local PS4 Jailbreak Host with USB emulation
This project is aimed at setting up a local web host, with USB emulation, on select Raspberry Pi boards that can be used to exploit and jailbreak PS4 consoles running firmware version 9.00. Raspberry Pi Zero W / Pi Zero 2 W / Pi4 B are eligible boards as they support a USB on-the-go (OTG) gadget mode and eliminate the need to manually insert and remove the USB stick required in the exploit process. This project is implemented on a clean Raspberry Pi OS (Debian) install which makes it easier to repurpose the Pi to run additional applications and services on it.<br>
Developed and Tested on Raspberry Pi 4 B but should work on Pi Zero W / Pi Zero 2 W / Pi4 B

### Benefits
- Clean Raspberry Pi OS install - easy to setup the Pi for other purposes as you desire
- Easily update exploit, GoldHen and payload files from the web interface
- One device for local web server and USB emulation
- One USB cable is sufficient to power the Pi and emulate USB
- You can leave the Pi permanently connected to the PS4. No need not to remove and plug in a USB stick to run explolit

### Setup - Easy Method
1.	Write the image provided in the releases to an SD card (using program like Pi Imager or Rufus)
2.	Insert the SD card into the Raspberry Pi
3.	For Pi Zero W & Pi Zero 2W, connect the USB marked Pi USB port to PS4. Be sure to use a cable that supports data transfer<br>
  ![image](https://user-images.githubusercontent.com/2664857/149229582-18780783-6d47-4d12-89ab-1898da33e1c7.png) <br />
4.	For Pi4 B, connect a USB C cable from Pi to PS4
5.	Power up the PS4. This should also boot up your Pi
6.	On the PS4 go to Browser and visit http://ip.address.of.your.pi
7.	Click on the GoldHen button for the version you want to exploit with  
    a. A popup will be thrown saying USB emulation started and wait for ps4 pop up
    ![image](https://user-images.githubusercontent.com/20742243/151671687-3a16a6db-a56e-45d8-bc13-9ff76598949d.png) <br />
    b. Once the USB message disappears, Click ok  
    c.	Gold Hen will load automatically
8. If you need SSH access, username is `pi` and password is `ps4jb`

### Setup - Advanced Method
1. Install a clean Raspberry Pi OS image to an SD card (Developed and tested on Debian Bullseye)
2. Enable USB Gadget Mode on the Pi <br>
   a. Add `dtoverlay=dwc2,dr_mode=peripheral` to the `[all]` section inside `/boot/config.txt`
3. Install and setup `lighttpd` and `PHP`
4. Configure `/var/www/html/ps4` as the document root directory for the exploit app <br>
   a. Make `www-data:www-data` the owner of this directory and change the permissions on it to `755`
5. Clone or download the source code from this repo <br>
   a. Copy the `900N` directory to `/var/www/html/ps4` <br>
   b. For all files inside the directory make `www-data:www-data` the owner and change permissions to `755`
7. Set `sudo /sbin/modprobe -r g_mass_storage` to run at every boot via `crontab` or `/etc/rc.local`
8. Allow the webserver user to run some commands as root without password <br>
   a. Add `www-data ALL = NOPASSWD: /sbin/modprobe, /sbin/reboot, /sbin/shutdown` to your `sudoers` file using `visudo`

Note: `Update Host` button on the web app will not work to update the host files unless you modify it or comply with the directory structure it's referencing.

### Credits
1.	Sleirsgoevy – Webkit, Offline Activator
2.	Chendochap – KeExploit
3.	Karo Sharifi – Offline Exploit Web Host 
4.	PaulJenkin – Inspiration for USB Emulation
