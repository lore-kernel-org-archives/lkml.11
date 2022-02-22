Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4905C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 09:10:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiBVJLI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 04:11:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiBVJLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 04:11:07 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9272F158EAC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 01:10:41 -0800 (PST)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K2tf92Mkwz67nFV;
        Tue, 22 Feb 2022 17:09:37 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Feb 2022 10:10:38 +0100
Received: from [10.47.92.123] (10.47.92.123) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 22 Feb
 2022 09:10:37 +0000
Message-ID: <59b538b7-b4c5-8111-d2bf-7fb353ecb19b@huawei.com>
Date:   Tue, 22 Feb 2022 09:10:37 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [mkp-scsi:for-next 93/154] hisi_sas_main.c:undefined reference to
 `sas_execute_ata_cmd'
To:     kernel test robot <lkp@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     <kbuild-all@lists.01.org>, <linux-kernel@vger.kernel.org>,
        "Christoph Hellwig" <hch@lst.de>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>
References: <202202221427.OvZeGfzt-lkp@intel.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <202202221427.OvZeGfzt-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.92.123]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2022 06:52, kernel test robot wrote:

Hi Martin,

Sorry about this. I'm missing a stub function. It is straightforward to fix.

Shall I just resend based on 5.18/scsi-queue?

I'm not sure where that leaves Damien's series.. it just seems easier to 
try to take mine again first as Damien's would need to be rebased again 
(if not based on mine).

Thanks,
John

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git for-next
> head:   2988062985d598d6871f47cb8eb70318af5b5b2d
> commit: 13685dfbad9831580335dc6e2f7a3be14b769686 [93/154] scsi: libsas: Add sas_execute_ata_cmd()
> config: ia64-buildonly-randconfig-r002-20220221 (https://download.01.org/0day-ci/archive/20220222/202202221427.OvZeGfzt-lkp@intel.com/config)
> compiler: ia64-linux-gcc (GCC) 11.2.0
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git/commit/?id=13685dfbad9831580335dc6e2f7a3be14b769686
>          git remote add mkp-scsi https://git.kernel.org/pub/scm/linux/kernel/git/mkp/scsi.git
>          git fetch --no-tags mkp-scsi for-next
>          git checkout 13685dfbad9831580335dc6e2f7a3be14b769686
>          # save the config file to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>     ia64-linux-ld: drivers/scsi/hisi_sas/hisi_sas_main.o: in function `hisi_sas_softreset_ata_disk':
>>> hisi_sas_main.c:(.text+0x42f2): undefined reference to `sas_execute_ata_cmd'
>>> ia64-linux-ld: hisi_sas_main.c:(.text+0x44a2): undefined reference to `sas_execute_ata_cmd'
>     ia64-linux-ld: hisi_sas_main.c:(.text+0x45e2): undefined reference to `sas_execute_ata_cmd'
>     ia64-linux-ld: hisi_sas_main.c:(.text+0x4732): undefined reference to `sas_execute_ata_cmd'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> .

