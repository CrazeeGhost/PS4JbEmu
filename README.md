## About
Auto PPPwn jailbreak for Sony PlayStation 4 consoles running software veriosns 9.00 - 11.00 using Raspberry Pi.

## Instructions

### PS4 Setup
- Go to Settings and then Network
- Select Set Up Internet connection and choose Use a LAN Cable
- Choose Custom setup and choose PPPoE for IP Address Settings
- Enter `ps4` for both PPPoE User ID and PPPoE Password
- Choose Automatic for DNS Settings and MTU Settings
- Choose Do Not Use for Proxy Server

### Pi
1. Download and burn image onto a 2GB or larger micro SD card
2. Navigate to the `boot` partition/drive on the SD card and open `ps4config.ini`
3. Change the value of `FW` as follows -  

| Target Firmware  | FW Value |
| ------------- | ------------- |
| 9.00  | `900`  |
| 9.60  | `960`  |
| 10.00  | `1000`  |
| 10.01  | `1001`  |
| 10.50 | `1050` |
| 10.70  | `1070`  |
| 10.71  | `1071`  |
| 11.00  | `1100`  |

4. Change the value of `POSTJB` as follows - 
    - If you want to shutdown the Pi after Jailbreak, change the value to `shutdown`
    - If you want to connect the PS4 to internet using the Pi's WiFi, change the value to `pppoe`
        - You can specify the DNS Server the PS4 should use for the PPPoE connection using the `DNS` option
5. Optional - To update the pppwn binary or stage1/stage2 payloads, replace the files in `/boot/pppwn-cpp/` with newer versions, maintaining the original filenames.
6. Insert the micro SD card into a Raspberry Pi
7. Optional - Connect the Pi to your WiFi (easiest using `sudo raspi-config`). Then power if off.
   
   SSH username: `pi`
   
   SSH password: `pppwn`
   
9. Download and extract [SiSTR0's GoldHEN v2.4b18.3](https://ko-fi.com/s/39f14f8d18)
10. Copy `goldhen.bin` to the root of an exFAT formatted USB drive
11. Plug the USB Drive into a USB port on your PS4
12. Connect the Pi to your PS4 via an Ethernet cable and power on both devices.
13. Wait for notifications confirming GoldHEN was loaded. This should happen within 2-3 minutes depending on how many attempts are required for that instance. If nothing happens within 5 minutes of boot up, I recommend restarting both the Raspberry Pi and the PS4. 

## Notes
- This is the pppwn_cpp Jailbreak for PS4 running software versions in the title of the release only
- Tested on Raspberry Pi 3 Model B and Raspberry Pi 4
- After the first successful load of GoldHEN, you do not need to repeat steps 8 through 10 for subsequent runs on the same PS4
- If  `POSTJB=pppoe` config is set, PS4 can access internet if Pi is connected to WiFi and only after successful Jailbreak. Your PS4 may try updating it's system software in this setup. You have been warned.
- No need to restart Pi if Re-Jailbreaking after PS4 was shutdown/restarted (PS4 must have stayed off for at least 30 seconds)
- Handles exceptions when PS4 crashes during exploit or if the exploit itself halts or hangs

## Credits
- TheFloW - [PPPwn](https://github.com/TheOfficialFloW/PPPwn)
- SiSTR0 - [GoldHEN](https://github.com/GoldHEN/GoldHEN)
- xfangfang - [PPPwn_cpp](https://github.com/xfangfang/PPPwn_cpp)
