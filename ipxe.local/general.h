#undef NET_PROTO_STP            /* Spanning Tree protocol */
/* #undef NET_PROTO_LACP */           /* Link Aggregation control protocol */

#define PXE_STACK               /* PXE stack in iPXE - you want this! */
#define PXE_MENU                /* PXE menu booting */

#define DOWNLOAD_PROTO_HTTPS    /* Secure Hypertext Transfer Protocol */
#define DOWNLOAD_PROTO_NFS      /* Network File System Protocol */

#undef CRYPTO_80211_WEP         /* WEP encryption (deprecated and insecure!) */
#undef CRYPTO_80211_WPA         /* WPA Personal, authenticating with passphrase */
#undef CRYPTO_80211_WPA2        /* Add support for stronger WPA cryptography */

#define IMAGE_PXE               /* PXE image support */
#define IMAGE_SCRIPT            /* iPXE script image support */
#define IMAGE_BZIMAGE           /* Linux bzImage image support */

//#define       IMAGE_PNM               /* PNM image support */

#define AUTOBOOT_CMD            /* Automatic booting */
#define NVO_CMD                 /* Non-volatile option storage commands */
#define CONFIG_CMD              /* Option configuration console */
#define IFMGMT_CMD              /* Interface management commands */
#undef  IWMGMT_CMD              /* Wireless interface management commands */
#define IBMGMT_CMD              /* Infiniband management commands */
#undef  FCMGMT_CMD              /* Fibre Channel management commands */
#define ROUTE_CMD               /* Routing table management commands */
#define IMAGE_CMD               /* Image management commands */
#define DHCP_CMD                /* DHCP management commands */
#define SANBOOT_CMD             /* SAN boot commands */
#define MENU_CMD                /* Menu commands */
#define LOGIN_CMD               /* Login command */
#define SYNC_CMD                /* Sync command */
#define NSLOOKUP_CMD            /* DNS resolving command */
#define TIME_CMD                /* Time commands */
#define DIGEST_CMD              /* Image crypto digest commands */
#define LOTEST_CMD              /* Loopback testing commands */
#define VLAN_CMD                /* VLAN commands */
#define PXE_CMD         /* PXE commands */
#define REBOOT_CMD              /* Reboot command */
#define POWEROFF_CMD            /* Power off command */
#define IMAGE_TRUST_CMD /* Image trust management commands */
#define PCI_CMD         /* PCI commands */
#define PARAM_CMD               /* Form parameter commands */
#define NEIGHBOUR_CMD           /* Neighbour management commands */
#define PING_CMD                /* Ping command */
#define CONSOLE_CMD             /* Console command */
#define IPSTAT_CMD              /* IP statistics commands */
