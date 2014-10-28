Title: Linux磁盘管理
Date: 2014-05-16 13:14
Tags: disk
category: Linux

一、磁盘基本知识
磁盘的基本结构如图
150923923.jpg
150927395.png
二、什么是磁盘分区、格式化以及磁盘挂载
   磁盘分区：一个完整的磁盘不便于管理，牵一发而动全身，稍有操作不慎，全盘挂掉。所以我们把磁盘划分成小块，每一块都是独立的，我可以在每一个单独的块上任意操作，这个区块就是所谓的分区(partition).
   
   格式化：在磁盘上存储数据，不能任意堆放，需要按一定的规则来存放，就行图书馆的图书一样。所谓这个规则就是文件系统，用于管理数据的存储方式。那么什么是格式化呢，很简单，格式化就是在磁盘上创建文件系统。
   
  挂载：在linux系统中，对任何文件的访问都是从根目录(/)开始，根目录是唯一的入口。那么我们想访问别的磁盘怎么办，唯一的办法就是进入根目录之后去找一个适当的地方“凿一个洞”，通过这个“地道”进入对应的磁盘。那么这个这个“凿洞”的过程就是挂载。
三、实际操作
   第0步，在开始一切工作之前，看看你的电脑上的磁盘情况：
   fdisk -l [设备路径] 查看磁盘情况，如果不加设备路径则是查看电脑中所有硬盘情况。

```bash
[root@localhost ~]# fdisk -l /dev/sdb
Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xccb363d8
   Device Boot      Start         End      Blocks   Id  System
[root@localhost ~]#
```
   这就是我刚刚虚拟的一块新磁盘，用于我们本次试验
   上面返回了这块磁盘的相关信息，比如大小，磁道总数，扇区大小等等。
   最后一行显示磁盘的分区情况，如上图，无内容说明这块磁盘还没有分区。
   第一步：分区，常用的分区工具是 fdisk，这是一个交互式命令。
   fdisk用法：fdisk [option] DEVICE
   在我们平常使用中一般不需要任何选项，直接fdisk + 磁盘
```bash
[root@localhost ~]# fdisk /dev/sdb
WARNING: DOS-compatible mode is deprecated. It's strongly recommended to
         switch off the mode (command 'c') and change display units to
         sectors (command 'u').
Command (m for help):
```
   上面说到了这个命令是一个交互式的，这里我输入m 然后回车

```bash
Command (m for help): m
Command action
   a   toggle a bootable flag
   b   edit bsd disklabel
   c   toggle the dos compatibility flag
   d   delete a partition
   l   list known partition types
   m   print this menu
   n   add a new partition
   o   create a new empty DOS partition table
   p   print the partition table
   q   quit without saving changes
   s   create a new empty Sun disklabel
   t   change a partition's system id
   u   change display/entry units
   v   verify the partition table
   w   write table to disk and exit
   x   extra functionality (experts only)
Command (m for help):
```

   好了，fdisk的所有操作都在这里了，我们说说几个常用的命令项
   m:获取帮助，上面已经用过了，就是用于输出当前这个页面
   n:新建一个分区
   p:显示当前磁盘上有的分区表
   q:直接退出，不保存之前的任何操作，所以你可以对这个命令任意折腾，如果有任何失误可以直接退出，无任何损失
  s:更改分区的系统支持类型
  w:保存之前的操作然后退出，所以这个命令小心使用。
   好，我们来完整创建一个分区
   输入n，
```bash
Command (m for help): n
Command action
   e   extended
   p   primary partition (1-4)
```
   这里选择主分区(p)还逻辑分区(e),我们选择主分区(9),选择什么分区根据自己情况而定
```bash
p
Partition number (1-4):
```
   这时提示我们输入分区编号，这个编号在1~4之间，视自己情况而定
   我们输入1，然后就是要求输入柱面，这个我们可以 之间回车就好，因为默认就好。然后就要求输入结束柱面，这里注意的是，由于我们对柱面的大小没有概念，所以提供了之间输入分区大小就好，格式：
```bash
+size，如+10G
Partition number (1-4): 1
First cylinder (1-6527, default 1):
Using default value 1
Last cylinder, +cylinders or +size{K,M,G} (1-6527, default 6527): +10G
Command (m for help):
```
   这时候分区就差不多了，就差保存退出了，在保存退出之前我可以输入p查看分区表
```bash
Command (m for help): p
Disk /dev/sdb: 53.7 GB, 53687091200 bytes
255 heads, 63 sectors/track, 6527 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xccb363d8
   Device Boot      Start         End      Blocks   Id  System
/dev/sdb1               1        1306    10490413+  83  Linux
Command (m for help):
```

   是不是有一种似曾相识，对，这就是刚刚我fdisk -l看见的内容，在最后一行有我们刚刚建立的分区，但是需要明白的是，这里看见的分区表并不代表分区已经完成了，如果我们这是输入q，之前的操作都是无效的
   好了，我们就直接输入w保存退出
```bash
Command (m for help): w
The partition table has been altered!
Calling ioctl() to re-read partition table.
Syncing disks.
[root@localhost ~]#
```
   提示文字显示分区表已经更改，分区已经成功创建。
   分区创建完成之后还需要注意一些事项：
   分区分区已经创建成功，但是内核并不一定知道，我们需要告诉内核刚刚创建了一个分区

   查看内核识别的分区信息：

```bash
   cat /proc/partitions
```
   
   RHEL5让内核重新读取硬盘分区表：
   partprobe [DEVICE]
   RHEL6让内核重新读取硬盘分区表：
   partx -a [PARTITION] DEVICE

   有些系统创建完分区就能别内核识别，有的不能，而且有的用上面的方法内核还是不能识别分区，需要重启系统。

第二部：格式化
   分区建立好了，但是还不能使用，还得创建文件系统，也就是格式化。
   常用的格式化工具有mkfs,mke2fs
   mkfs可以格式化大多数文件系统，自然也就包含我们常用的ext系列
   mkfs [-V] [-t fstype] [fs-options] filesys [blocks]
   常用选项有两个：
   -t fstype :指定文件系统类型
   -c :在创建文件系统之前先检查分区是否有坏块

```bash
[root@localhost ~]# mkfs -t ext4 /dev/sdb1
mke2fs 1.41.12 (17-May-2010)
文件系统标签=
操作系统:Linux
块大小=4096 (log=2)
分块大小=4096 (log=2)
Stride=0 blocks, Stripe width=0 blocks
655776 inodes, 2622603 blocks
131130 blocks (5.00%) reserved for the super user
第一个数据块=0
Maximum filesystem blocks=2688548864
81 block groups
32768 blocks per group, 32768 fragments per group
8096 inodes per group
Superblock backups stored on blocks:
32768, 98304, 163840, 229376, 294912, 819200, 884736, 1605632
正在写入inode表: 完成                          
Creating journal (32768 blocks): 完成
Writing superblocks and filesystem accounting information: 完成
This filesystem will be automatically checked every 21 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
[root@localhost ~]#
```
   有linux中常用的这些命令：
   mkfs.ext2  mkfs.ext3  mkfs.ext4  mkfs.msdos  mkfs.vfat
   这些命令就省去了mkfs的-t选项
   mkfs -t ext2 = mkfs.ext2
   mkfs -t ext3 = mkfs.ext3
   mkfs -t ext4 = mkfs.ext4
   
   mkfs这个命令比较简单实用，但功能不是很丰富，我们来看看mke2fs命令
   我们先来看一下mke2fs的手册
```bash
NAME
               mke2fs - create an ext2/ext3/ext4 filesystem
SYNOPSIS
       mke2fs  [  -c | -l filename ] [ -b block-size ] [ -f fragment-size ] [ -g blocks-per-
       group ] [ -G number-of-groups ] [ -i bytes-per-inode ] [ -I inode-size ] [ -j ] [  -J
       journal-options ] [ -K ] [ -N number-of-inodes ] [ -n ] [ -m reserved-blocks-percent-
       age ] [ -o creator-os ] [ -O feature[,...]  ] [ -q ] [ -r fs-revision-level  ]  [  -E
       extended-options  ] [ -v ] [ -F ] [ -L volume-label ] [ -M last-mounted-directory ] [
       -S ] [ -t fs-type ] [ -T usage-type ] [ -U UUID ] [ -V ] device [ blocks-count ]
       mke2fs -O journal_dev [ -b block-size ] [ -L volume-label ] [ -n ] [  -q  ]  [  -v  ]
       external-journal [ blocks-count ]
```

   这个命令就很强大了，主要用于创建ext系列的文件系统，分别看看它的常用选项
  -b ：指定磁盘块大小，可选数值：1024，2048，4096
   块大小取决CPU对内存页框大小的支持，x86系统默认页框大小为4K；
  -L label: 设定卷标
  -m :指定预留给管理使用的块所占据总体空间的比例；
   -r :指定预留给管理使用的块的个数；
  -E :设定文件系统的扩展属性；
   举个列子，创建一个ext4文件系统，卷标为myLabel,块大小为2048，给管理员的空间是3%
```bash
[root@localhost ~]# mke2fs -t ext4 -b 2048 -L myLabel -m 3 /dev/sdb1
mke2fs 1.41.12 (17-May-2010)
文件系统标签=myLabel
操作系统:Linux
块大小=2048 (log=1)
分块大小=2048 (log=1)
Stride=0 blocks, Stripe width=0 blocks
657408 inodes, 5245206 blocks
157356 blocks (3.00%) reserved for the super user
第一个数据块=0
Maximum filesystem blocks=543162368
321 block groups
16384 blocks per group, 16384 fragments per group
2048 inodes per group
Superblock backups stored on blocks:
16384, 49152, 81920, 114688, 147456, 409600, 442368, 802816, 1327104,
2048000, 3981312
正在写入inode表: 完成                          
Creating journal (32768 blocks): 完成
Writing superblocks and filesystem accounting information: 完成
This filesystem will be automatically checked every 34 mounts or
180 days, whichever comes first.  Use tune2fs -c or -i to override.
[root@localhost ~]#
```
   和mke2fs相关的还有一个命令就是tune2fs
   这两个命令用法基本相同，一个是用于设置，一个用于修改
   比如mke2fs -m 5:设置给管理员预留5%的空间
   tune2fs -m 3:修改为给管理员3%的空间
  tune2fs 有一个常用的选项是-l,查看文件系统属性

```bash
[root@localhost ~]# tune2fs -l /dev/sdb1
tune2fs 1.41.12 (17-May-2010)
Filesystem volume name:   myLabel
Last mounted on:          <not available>
Filesystem UUID:          043a1cd6-1067-4243-9063-205d97172860
Filesystem magic number:  0xEF53
Filesystem revision #:    1 (dynamic)
Filesystem features:      has_journal ext_attr resize_inode dir_index filetype extent flex_bg sparse_super huge_file uninit_bg dir_nlink extra_isize
Filesystem flags:         signed_directory_hash
Default mount options:    (none)
Filesystem state:         clean
Errors behavior:          Continue
Filesystem OS type:       Linux
Inode count:              657408
Block count:              5245206
Reserved block count:     157356
Free blocks:              5123382
Free inodes:              657397
First block:              0
Block size:               2048
Fragment size:            2048
Reserved GDT blocks:      512
Blocks per group:         16384
Fragments per group:      16384
Inodes per group:         2048
Inode blocks per group:   256
Flex block group size:    16
Filesystem created:       Sat Dec 21 14:21:21 2013
Last mount time:          n/a
Last write time:          Sat Dec 21 14:21:23 2013
Mount count:              0
Maximum mount count:      34
Last checked:             Sat Dec 21 14:21:21 2013
Check interval:           15552000 (6 months)
Next check after:         Thu Jun 19 14:21:21 2014
Lifetime writes:          226 MB
Reserved blocks uid:      0 (user root)
Reserved blocks gid:      0 (group root)
First inode:              11
Inode size:          256
Required extra isize:     28
Desired extra isize:      28
Journal inode:            8
Default directory hash:   half_md4
Directory Hash Seed:      d7afa41a-cfa8-40e7-8d39-316ef80c40d0
Journal backup:           inode blocks
[root@localhost ~]#
```

   格式化就搞定了，接下来就是挂载了
   第三步：挂载
   挂载就太简单了，一切都准备好，‘挂’上去就搞定
   挂载使用mount命令
   mount命令有两个用处，一个挂载分区，另一个是查看已经挂载的分区
   首先我看看已经挂载的分区，mount不加任何选项就是查看已经挂载的分区

```bash
[root@localhost ~]# mount
/dev/mapper/vg_centos6464-lv_root on / type ext4 (rw)
proc on /proc type proc (rw)
sysfs on /sys type sysfs (rw)
devpts on /dev/pts type devpts (rw,gid=5,mode=620)
tmpfs on /dev/shm type tmpfs (rw,rootcontext="system_u:object_r:tmpfs_t:s0")
/dev/sda1 on /boot type ext4 (rw)
none on /proc/sys/fs/binfmt_misc type binfmt_misc (rw)
sunrpc on /var/lib/nfs/rpc_pipefs type rpc_pipefs (rw)
[root@localhost ~]#
```
   第二个就是将刚刚的分区挂载到我们的系统上
   mount [option] DEVICE MOUNT_POINT
   一般情况不需要指定选项，直接将指定设备挂到挂载点上

```bash
[root@localhost ~]# mount /dev/sdb1 /data
[root@localhost ~]# ls /data
lost+found
[root@localhost ~]#
```
   挂载完毕，现在就可以正常使用这个分区了
   但是这样的挂载是临时的，当我们重启系统后，这个分区有‘丢’
   如果要让系统每次重启自动挂载就需要编辑/etc/fstab文件
   153020355.png
   这个文件的编辑规则如下
   1：指定设备，可以是路径，也可以是UUID
   2：指定挂载点
   3：指定文件系统类型
   4：指定挂载属性，如果不需要添加额外的属性就是default，有额外的属性就在default后写属性，用逗号分隔
   5：转储频率：
       0: 从不备份；
       1：每日备份；
   
   6：自检次序：
       0：不检测；
       1：第一个检测；一般只有根文件系统被第一个检测；
       2：第二个自检
          ......

   说完挂载，再来说说卸载，卸载比挂载还简单
   umount + 设备 或者 umount + 挂载点
   需要注意的是，不管当前是否已经占用挂载点，都可以挂载
   但是，如果当前已经占用挂载目录，就不能卸载该分区

   好了，关于磁盘的分区、格式化和挂载就简单说到这来，mke2fs和tune2fs还有很多选项没有想象阐述，请仔细查看man手册。
