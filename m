Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D702DC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Mar 2022 02:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbiCRCIr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Mar 2022 22:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231683AbiCRCIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 22:08:46 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14121C64B9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 19:07:27 -0700 (PDT)
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KKS3W2pl3z9sZv;
        Fri, 18 Mar 2022 10:03:35 +0800 (CST)
Received: from dggpeml500003.china.huawei.com (7.185.36.200) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 10:07:25 +0800
Received: from huawei.com (10.175.103.91) by dggpeml500003.china.huawei.com
 (7.185.36.200) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 18 Mar
 2022 10:07:25 +0800
From:   Yu Liao <liaoyu15@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <ranjani.sridharan@linux.intel.com>
CC:     <broonie@kernel.org>, <liaoyu15@huawei.com>, <liwei391@huawei.com>
Subject: [PATCH -next] ASoC: SOF: topology: Fix memory leak in sof_control_load()
Date:   Fri, 18 Mar 2022 10:16:16 +0800
Message-ID: <20220318021616.2599630-1-liaoyu15@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500003.china.huawei.com (7.185.36.200)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scontrol doesn't get freed when kstrdup returns NULL.
Fix by free iscontrol in that case.

     scontrol = kzalloc(sizeof(*scontrol), GFP_KERNEL);
     if (!scontrol)
         return -ENOMEM;

     scontrol->name = kstrdup(hdr->name, GFP_KERNEL);
     if (!scontrol->name)
         return -ENOMEM;

Signed-off-by: Yu Liao <liaoyu15@huawei.com>
---
 sound/soc/sof/topology.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/topology.c b/sound/soc/sof/topology.c
index 367fbe2d5b31..88f34f43d693 100644
--- a/sound/soc/sof/topology.c
+++ b/sound/soc/sof/topology.c
@@ -905,8 +905,10 @@ static int sof_control_load(struct snd_soc_component *scomp, int index,
 		return -ENOMEM;
 
 	scontrol->name = kstrdup(hdr->name, GFP_KERNEL);
-	if (!scontrol->name)
+	if (!scontrol->name) {
+		kfree(scontrol);
 		return -ENOMEM;
+	}
 
 	scontrol->scomp = scomp;
 	scontrol->access = kc->access;
-- 
2.25.1

