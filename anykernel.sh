# AnyKernel3 Ramdisk Mod Script
# osm0sis @ xda-developers

## AnyKernel setup
# begin properties
properties() { '
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=sweet
device.name2=sweetin
supported.versions=14 - 16
supported.patchlevels=
'; } # end properties

# boot shell variables
BLOCK=auto;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot install
dump_boot; # use split_boot to skip ramdisk unpack, e.g. for devices with init_boot ramdisk
ui_print " "
#  hadeh :)
gladi_resik() {
    patch_cmdline "aghisna.ksu" " "
    patch_cmdline "aghisna.nps" " "
    patch_cmdline "aghisna.su" " "
    patch_cmdline "aghisna.kcal" " "
}
# ho ho hooo looks like you are looking for something '-'
# I guess for sure you find out about what is below, right?  '-'
# call function 10x biar seru
X=10
while [ $X != 0 ];
do
    gladi_resik
    X=$(($X-1))
done
cleanup_n_update() {
    local Yaitu="$1"
    local Isinya="$2"
    local X=10
    while [ $X != 0 ];
    do
        patch_cmdline "$Yaitu" " "
        X=$(($X-1))
    done
    if [ "$Isinya" != "null" ];then
        patch_cmdline "$Yaitu" "$Yaitu=$Isinya"
    fi
}

# magisk detector
if [ -e /data/adb/magisk.db ]; then
    ui_print "Magisk detected!"
    ui_print "switching to NSU..."
    cleanup_n_update "aghisna.su" "0"
    ui_print "done. pls delete /data/adb folder if error"
fi

# hayoh mau ngapain?
###### kernelSU
if [ ! -z "$(cat /data/local/aghisna | grep NSU )" ];then
    cleanup_n_update "aghisna.su" "0"
    ui_print "- Disable kernelSU"
else
    cleanup_n_update "aghisna.su" "1"
    ui_print "- Enable kernelsu"
fi

###### Proxymity virtual shit
if [ ! -z "$(cat /data/local/aghisna | grep NPS )" ];then
    cleanup_n_update "aghisna.nps" "0"
    ui_print "- Disable virtual proximity"
else
    cleanup_n_update "aghisna.nps" "1"
    ui_print "- Enable virtual proxymity"
fi

###### kcal
if [ ! -z "$(cat /data/local/aghisna | grep KCL )" ];then
    cleanup_n_update "aghisna.kcal" "1"
    ui_print "- Enable Kcal/klapse display"
else
    cleanup_n_update "aghisna.kcal" "0"
    ui_print "- Disable Kcal/klapse display"
fi

## pembersih
rm -rf /data/local/aghisna;

write_boot; # use flash_boot to skip ramdisk repack, e.g. for devices with init_boot ramdisk
ui_print "=========================="

## start custom  cmd

ui_print " "

## end boot install

