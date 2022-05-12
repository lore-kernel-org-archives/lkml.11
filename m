Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0FC5C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 May 2022 01:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349881AbiELBXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 21:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234242AbiELBXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 21:23:40 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD8EAD38
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 18:23:38 -0700 (PDT)
Received: from kwepemi500015.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KzDXb1pLjzfbH0;
        Thu, 12 May 2022 09:22:23 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemi500015.china.huawei.com
 (7.221.188.92) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 12 May
 2022 09:23:35 +0800
From:   Zheng Bin <zhengbin13@huawei.com>
To:     <pierre-louis.bossart@linux.intel.com>, <lgirdwood@gmail.com>,
        <ranjani.sridharan@linux.intel.com>,
        <kai.vehmanen@linux.intel.com>, <daniel.baluta@nxp.com>,
        <broonie@kernel.org>, <perex@perex.cz>, <tiwai@suse.com>,
        <sound-open-firmware@alsa-project.org>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <zhengbin13@huawei.com>, <gaochao49@huawei.com>
Subject: [PATCH -next] ASoC: SOF: amd: add missing platform_device_unregister in acp_pci_rn_probe
Date:   Thu, 12 May 2022 09:37:28 +0800
Message-ID: <20220512013728.4128903-1-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500015.china.huawei.com (7.221.188.92)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acp_pci_rn_probe misses a call platform_device_unregister in error path,
this patch fixes that.

Signed-off-by: Zheng Bin <zhengbin13@huawei.com>
---
 sound/soc/sof/amd/pci-rn.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/sof/amd/pci-rn.c b/sound/soc/sof/amd/pci-rn.c
index b8910bb7f27c..d5d9bcc2c997 100644
--- a/sound/soc/sof/amd/pci-rn.c
+++ b/sound/soc/sof/amd/pci-rn.c
@@ -101,6 +101,7 @@ static int acp_pci_rn_probe(struct pci_dev *pci, const struct pci_device_id *pci
 	res = devm_kzalloc(&pci->dev, sizeof(struct resource) * ARRAY_SIZE(renoir_res), GFP_KERNEL);
 	if (!res) {
 		sof_pci_remove(pci);
+		platform_device_unregister(dmic_dev);
 		return -ENOMEM;
 	}

--
2.31.1

