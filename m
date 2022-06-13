Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B9CC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jun 2022 15:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355683AbiFMPMT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jun 2022 11:12:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351297AbiFMPMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 11:12:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E4F113A0B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 05:26:37 -0700 (PDT)
Received: from kwepemi500016.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LM9l02wydzjXZw;
        Mon, 13 Jun 2022 20:25:32 +0800 (CST)
Received: from [10.40.193.166] (10.40.193.166) by
 kwepemi500016.china.huawei.com (7.221.188.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 13 Jun 2022 20:26:35 +0800
From:   "chenxiang (M)" <chenxiang66@hisilicon.com>
Subject: [Bug] Take more 150s to boot qemu on ARM64
To:     <paulmck@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <qemu-devel@nongnu.org>,
        <linuxarm@huawei.com>
Message-ID: <36a0c658-ee5d-3a1c-416c-c041dc344bff@hisilicon.com>
Date:   Mon, 13 Jun 2022 20:26:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.193.166]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500016.china.huawei.com (7.221.188.220)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I encounter a issue with kernel 5.19-rc1 on a ARM64 board:  it takes 
about 150s between beginning to run qemu command and beginng to boot 
Linux kernel ("EFI stub: Booting Linux Kernel...").

But in kernel 5.18-rc4, it only takes about 5s. I git bisect the kernel 
code and it finds c2445d387850 ("srcu: Add contention check to 
call_srcu() srcu_data ->lock acquisition").

The qemu (qemu version is 6.2.92) command i run is :

./qemu-system-aarch64 -m 4G,slots=4,maxmem=8g \
--trace "kvm*" \
-cpu host \
-machine virt,accel=kvm,gic-version=3  \
-machine smp.cpus=2,smp.sockets=2 \
-no-reboot \
-nographic \
-monitor unix:/home/cx/qmp-test,server,nowait \
-bios /home/cx/boot/QEMU_EFI.fd \
-kernel /home/cx/boot/Image  \
-device 
pcie-root-port,port=0x8,chassis=1,id=net1,bus=pcie.0,multifunction=on,addr=0x1 
\
-device vfio-pci,host=7d:01.3,id=net0 \
-device virtio-blk-pci,drive=drive0,id=virtblk0,num-queues=4  \
-drive file=/home/cx/boot/boot_ubuntu.img,if=none,id=drive0 \
-append "rdinit=init console=ttyAMA0 root=/dev/vda rootfstype=ext4 rw " \
-net none \
-D /home/cx/qemu_log.txt

I am not familiar with rcu code, and don't know how it causes the issue. 
Do you have any idea about this issue?


Best Regard,

Xiang Chen


