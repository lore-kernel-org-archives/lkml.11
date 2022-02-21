Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30443C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 09:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350817AbiBUJj4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 04:39:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbiBUJcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 04:32:21 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B51F286E8;
        Mon, 21 Feb 2022 01:13:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD32460E9D;
        Mon, 21 Feb 2022 09:13:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2F49C340E9;
        Mon, 21 Feb 2022 09:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1645434823;
        bh=PnNy4pm/URP5p1SyrTpSnRUcVuoyh4EpAMxfQCUSi8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TPdcMkciWarBTX8yChWPwxC2pRp/eQLz8yu+XdNSbwX89TRY2GX7Qyrzk8m78Al/J
         EiqTIolzsvvC1SUoc4Th+qCM56cVDjjpk+zwkzw6wqgyP4g8N2dh8cvmQ2aC9/IYLh
         wg7oPACd5fvS9n/J2TgL8YMZK4uWblN6CBpJYrQk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Miaoqian Lin <linmq006@gmail.com>,
        Juan Vazquez <juvazq@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 143/196] Drivers: hv: vmbus: Fix memory leak in vmbus_add_channel_kobj
Date:   Mon, 21 Feb 2022 09:49:35 +0100
Message-Id: <20220221084935.701874908@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220221084930.872957717@linuxfoundation.org>
References: <20220221084930.872957717@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miaoqian Lin <linmq006@gmail.com>

[ Upstream commit 8bc69f86328e87a0ffa79438430cc82f3aa6a194 ]

kobject_init_and_add() takes reference even when it fails.
According to the doc of kobject_init_and_add()：

   If this function returns an error, kobject_put() must be called to
   properly clean up the memory associated with the object.

Fix memory leak by calling kobject_put().

Fixes: c2e5df616e1a ("vmbus: add per-channel sysfs info")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
Reviewed-by: Juan Vazquez <juvazq@linux.microsoft.com>
Link: https://lore.kernel.org/r/20220203173008.43480-1-linmq006@gmail.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hv/vmbus_drv.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 392c1ac4f8193..44bd0b6ff5059 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2027,8 +2027,10 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 	kobj->kset = dev->channels_kset;
 	ret = kobject_init_and_add(kobj, &vmbus_chan_ktype, NULL,
 				   "%u", relid);
-	if (ret)
+	if (ret) {
+		kobject_put(kobj);
 		return ret;
+	}
 
 	ret = sysfs_create_group(kobj, &vmbus_chan_group);
 
@@ -2037,6 +2039,7 @@ int vmbus_add_channel_kobj(struct hv_device *dev, struct vmbus_channel *channel)
 		 * The calling functions' error handling paths will cleanup the
 		 * empty channel directory.
 		 */
+		kobject_put(kobj);
 		dev_err(device, "Unable to set up channel sysfs files\n");
 		return ret;
 	}
-- 
2.34.1



