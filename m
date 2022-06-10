Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5F4C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jun 2022 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235686AbiFJOTv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jun 2022 10:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbiFJOTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 10:19:50 -0400
Received: from m12-14.163.com (m12-14.163.com [220.181.12.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D2A49F5067;
        Fri, 10 Jun 2022 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=lj55d
        Mjfsh6HcTwUrT+72iAA78NOgDMVv6Okyo6jIVA=; b=MIt39uMx1jdLHZl9mMxHZ
        DCCanyW7C7tmxtF+stfeUF2Zs3V3daUfpsim6kD+2En/5s6MrTPgQmjZX4MM18/m
        gpyDAjfcS6Abe4miWRnIyGOIXm8obnMg+k+nMu4u7ocNDPgN14drrGAoB0YbMxJn
        FOZBwtni5MHwZcJVfMYDtQ=
Received: from carlis-virtual-machine (unknown [218.17.89.92])
        by smtp10 (Coremail) with SMTP id DsCowAAXjx9CT6Ni_SpSHA--.18671S2;
        Fri, 10 Jun 2022 22:03:47 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     gregkh@linuxfoundation.org, zhangxuezhi1@coolpad.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: core: sysfs: convert sysfs snprintf to sysfs_emit
Date:   Fri, 10 Jun 2022 22:03:45 +0800
Message-Id: <20220610140345.102331-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: DsCowAAXjx9CT6Ni_SpSHA--.18671S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWxCrWrWw43JF48XFW8Zwb_yoWkurg_Cr
        W09r17Wr18tF4SyryxA3WavrZYqa12vF10gF4UtrySq3W2gw1xZw17ury8JrWUWF4xZFZr
        Ar1kuryS9F48ujkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnDCztUUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBOQUchV-PN3qyEwAAsZ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/usb/core/sysfs.c:921:8-16:
WARNING: use scnprintf or sprintf
drivers/usb/core/sysfs.c:730:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/usb/core/sysfs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/core/sysfs.c b/drivers/usb/core/sysfs.c
index fa2e49d432ff..6387c0dfe30e 100644
--- a/drivers/usb/core/sysfs.c
+++ b/drivers/usb/core/sysfs.c
@@ -727,7 +727,7 @@ static ssize_t authorized_show(struct device *dev,
 			       struct device_attribute *attr, char *buf)
 {
 	struct usb_device *usb_dev = to_usb_device(dev);
-	return snprintf(buf, PAGE_SIZE, "%u\n", usb_dev->authorized);
+	return sysfs_emit(buf, "%u\n", usb_dev->authorized);
 }
 
 /*
@@ -918,7 +918,7 @@ static ssize_t authorized_default_show(struct device *dev,
 	struct usb_hcd *hcd;
 
 	hcd = bus_to_hcd(usb_bus);
-	return snprintf(buf, PAGE_SIZE, "%u\n", hcd->dev_policy);
+	return sysfs_emit(buf, "%u\n", hcd->dev_policy);
 }
 
 static ssize_t authorized_default_store(struct device *dev,
-- 
2.25.1

