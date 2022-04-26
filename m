Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E408C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Apr 2022 13:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344549AbiDZNRC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Apr 2022 09:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234803AbiDZNQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 09:16:59 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BE306D381
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 06:13:51 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Knj4X1RnfzhYlG;
        Tue, 26 Apr 2022 21:13:32 +0800 (CST)
Received: from dggpemm500007.china.huawei.com (7.185.36.183) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 26 Apr 2022 21:13:49 +0800
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 26 Apr
 2022 21:13:48 +0800
From:   Yang Yingliang <yangyingliang@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <sound-open-firmware@alsa-project.org>
CC:     <broonie@kernel.org>, <rander.wang@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <ranjani.sridharan@linux.intel.com>,
        <peter.ujfalusi@linux.intel.com>, <yung-chuan.liao@linux.intel.com>
Subject: [PATCH -next] ASoC: SOF: sof-pci-dev: fix missing pci_release_regions() on error in sof_pci_probe()
Date:   Tue, 26 Apr 2022 21:25:39 +0800
Message-ID: <20220426132539.416676-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the missing pci_release_regions() before return
from sof_pci_probe() in the error handling case.

Fixes: 4bfbbb76e82e ("ASOC: SOF: pci: add ipc_type override for Intel IPC4 tests")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 sound/soc/sof/sof-pci-dev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/sof-pci-dev.c b/sound/soc/sof/sof-pci-dev.c
index cd90da7c92c2..3b0978b02f9f 100644
--- a/sound/soc/sof/sof-pci-dev.c
+++ b/sound/soc/sof/sof-pci-dev.c
@@ -217,12 +217,14 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 			 desc->ipc_default, sof_pci_ipc_type);
 		if (sof_pci_ipc_type >= SOF_IPC_TYPE_COUNT) {
 			dev_err(dev, "invalid request value %d\n", sof_pci_ipc_type);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		if (!(BIT(sof_pci_ipc_type) & desc->ipc_supported_mask)) {
 			dev_err(dev, "invalid request value %d, supported mask is %#x\n",
 				sof_pci_ipc_type, desc->ipc_supported_mask);
-			return -EINVAL;
+			ret = -EINVAL;
+			goto out;
 		}
 		sof_pdata->ipc_type = sof_pci_ipc_type;
 	}
@@ -291,6 +293,8 @@ int sof_pci_probe(struct pci_dev *pci, const struct pci_device_id *pci_id)
 
 	/* call sof helper for DSP hardware probe */
 	ret = snd_sof_device_probe(dev, sof_pdata);
+
+out:
 	if (ret)
 		pci_release_regions(pci);
 
-- 
2.25.1

