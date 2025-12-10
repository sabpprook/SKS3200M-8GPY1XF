# XikeStor SKS3200M-8GPY1XF

### FM25Q16A 損壞，無法載入韌體進行開機

<img width="900" src="https://github.com/user-attachments/assets/474480fe-5633-4dd3-8b91-4f41528bd8de" />


### 使用 CH341A Mini Programmer 備份 Firmware

<img width="900" src="https://github.com/user-attachments/assets/4e8be4df-6253-418e-b0e0-58074a11a22e" />
<img alt="螢幕擷取畫面 2025-12-10 215937" src="https://github.com/user-attachments/assets/477736f4-348a-4a3f-8b65-759dfcec7cf1" />


### 根據 datasheet 撰寫讀取指令

<img width="600" alt="螢幕擷取畫面 2025-12-10 221919" src="https://github.com/user-attachments/assets/f0b1e84b-32c6-4c8c-81e4-92ac509ecb41" />
<img width="600" alt="螢幕擷取畫面 2025-12-10 221850" src="https://github.com/user-attachments/assets/4c8799d9-fa5a-4179-b0af-8a8bc8b57d27" />


### 備份  UID / Security Sector

<img alt="螢幕擷取畫面 2025-12-10 221252" src="https://github.com/user-attachments/assets/3a0654fd-f127-4c7c-a9dc-892b179fdc9e" />
<img alt="螢幕擷取畫面 2025-12-10 221605" src="https://github.com/user-attachments/assets/a2c26bfa-6919-4cdc-82e3-b9ec94907369" />


### 更換 Winbond W25Q16JVSIQ

<img width="900" src="https://github.com/user-attachments/assets/3051ae4f-a2eb-4220-901a-c2396fae2a0a" />


### 燒錄 Firmware 但無法正常開機

<img alt="螢幕擷取畫面 2025-12-10 214837" src="https://github.com/user-attachments/assets/799bc7dc-df1b-4431-973f-144e322c4ac8" />
<img alt="螢幕擷取畫面 2025-12-10 215037" src="https://github.com/user-attachments/assets/52bac0c7-b69c-4fc5-bfb5-fa9edbf35410" />


<details>
  <summary>TTL Logging</summary>
  <pre>

==========Loader start===========
Press any key to start the normal procedure.
To run SPI flash viewer, press [v]
To enforce the download of the runtime kernel, press [ESC] .....
  cmd -1
    Check Runtime Image.....
    Chksum Correct!
    RunTime Kernel Starting....
Ver8224: C
Ver8373_72: C



===========================Config Area pre-check Starts.=====================.
Pre-Check the config size structure is equal or not.
(sizeof(configCache)) a42.
(FLSH_ADDR_END-FLSH_CONFIG_ADDR_START) a42.
(FLSH_CONFIG_ADDR_START) 1fe000.
(FLSH_ADDR_END) 1fea42.
It seems no risk!..................
==============================Config Area pre-check ends.===================.



SalFlshCopyFlshToCache()
sal_sys_config_restore()
Restore dhcp state is: 0

Restore ip is: 192.168.10.12

...OK
sal_mirror_config_restore()...OK
sal_qos_config_restore()...OK
sal_vlan_config_restore()...OK
sal_rate_config_restore()...OK
sal_trunk_config_restore()...OK
sal_l2_config_restore()...OK
sal_loop_config_restore()...OK
sal_eee_config_restore()...OK
sal_stp_config_restore()...OK
sal_igmp_config_restore()...OK
sal_port_config_restore()...OK



#############According to the flash setting to set the WEB/DUMB mode

#############Read the web/dumb mode.....!!!###

#############web_dumb_cfg.vld_flag=-1, web_dumb_cfg.mode=-1
#############Begin to set the web mode




==========Loader start===========
Press any key to start the normal procedure.
To run SPI flash viewer, press [v]
To enforce the download of the runtime kernel, press [ESC] .....
  cmd -1
    Check Runtime Image.....
    Chksum Correct!
    RunTime Kernel Starting....
</pre>
</details>


### 參照下列教學得知需算出 UID 加密內容
Refer: https://github.com/up-n-atom/SWTG118AS/tree/main?tab=readme-ov-file#firmware-versions-prior-and-up-to-19x


### W25Q16JV Unique ID

<img alt="螢幕擷取畫面 2025-12-11 000613" src="https://github.com/user-attachments/assets/839962bc-1dc0-4a56-bc59-94398a3cf20c" />
<img width="900" alt="螢幕擷取畫面 2025-12-11 000821" src="https://github.com/user-attachments/assets/4259adcf-2874-48d6-8964-d352ba40e73e" />

加密 UID: ```37623064623863393736346233616366```


### W25Q16JV 與 FM25Q16A 差異

> [!CAUTION]
> <pre>根據 W25Q16JV datasheet 說明
> Secuirty Register Page 數量為 1-3，與 FM25Q16A 不同
> RTL837X 韌體讀取到的是 W25Q16JV SFDP Register</pre>

<img alt="螢幕擷取畫面 2025-12-11 004428" src="https://github.com/user-attachments/assets/2efe0775-226d-464c-8238-48eb9173e749" />


### Security Register / SFDP Register

```
SPIWrite(0, 5, $48, 0,0,0,0);
SPIReadToEditor(1, 256);

SPIWrite(0, 5, $5A, 0,0,0,0);
SPIReadToEditor(1, 256);
```
<img alt="螢幕擷取畫面 2025-12-11 002109" src="https://github.com/user-attachments/assets/4822c726-d1a7-4307-b336-066287beed7e" />


### 將加密 UID 寫入 SFDP Register

<img alt="螢幕擷取畫面 2025-12-11 002107" src="https://github.com/user-attachments/assets/229d7e22-be54-4b3b-abbe-26a3fc082191" />
<img alt="螢幕擷取畫面 2025-12-11 002216" src="https://github.com/user-attachments/assets/92042b05-98d9-4f7a-9db4-035abf859623" />


### 開機 TTL Logging

<img alt="螢幕擷取畫面 2025-12-11 002410" src="https://github.com/user-attachments/assets/24e513ec-ba63-457c-9c89-fab3b31ee28e" />


### 正常啟動

<img width="900" alt="螢幕擷取畫面 2025-12-11 002542" src="https://github.com/user-attachments/assets/d0ea8451-1f16-461e-9e63-744be2657322" />
