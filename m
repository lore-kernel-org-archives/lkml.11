Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D91DC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 May 2022 07:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244505AbiEaH3D (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 May 2022 03:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242971AbiEaH3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:29:01 -0400
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 415EE793A9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 00:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=NGUDH
        gG8iVG5OQXyT3DJVTMbEFQi7F2v0GBzMtCTvKE=; b=J3Mp6mC4DOU8h8S0Dqecp
        xeVldRi7P9WRfVXGRsZOZxwHLtfjN8gByg/SeujOzFfOS+TK6luQoSJT2/ZlRGHg
        zzsKXB2PSgWtbCvzNy1iRyX62sjOW6R/KZCSJ2faYF/rgDLjCrJUJJRATELIdo0A
        VR85OAoN+Z5mDIuDQS0pis=
Received: from carlis (unknown [218.17.89.92])
        by smtp7 (Coremail) with SMTP id C8CowACXyaCQw5Vi53O0FQ--.54171S2;
        Tue, 31 May 2022 15:28:16 +0800 (CST)
From:   Xuezhi Zhang <zhangxuezhi1@coolpad.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        dankamongmen@gmail.com, jcmvbkbc@gmail.com, siglesias@igalia.com,
        zhangxuezhi1@coolpad.com, igormtorrente@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] tty: vt: convert sysfs snprintf to sysfs_emit
Date:   Tue, 31 May 2022 07:28:14 +0000
Message-Id: <20220531072814.34999-1-zhangxuezhi1@coolpad.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: C8CowACXyaCQw5Vi53O0FQ--.54171S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrZrWxKw1DKryUWFy5Xw13Jwb_yoWkCrc_C3
        WxZrWfKF48ta1UA3ZrAr4avr9avF4vvF1UXw4qq3yfJrWq93Z7Zr9F9r9xtry5W3ykJFyU
        Cws7ZFyfursrWjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUnPku7UUUUU==
X-Originating-IP: [218.17.89.92]
Sender: llyz108@163.com
X-CM-SenderInfo: xoo16iiqy6il2tof0z/xtbBORAShV-PNp6tOwAAsQ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following coccicheck warnings:
drivers/tty/vt/vt.c:3942:8-16:
WARNING: use scnprintf or sprintf
drivers/tty/vt/vt.c:3950:8-16:
WARNING: use scnprintf or sprintf

Signed-off-by: Xuezhi Zhang <zhangxuezhi1@coolpad.com>
---
 drivers/tty/vt/vt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..7ea7d14e9271 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -3939,7 +3939,7 @@ static ssize_t show_bind(struct device *dev, struct device_attribute *attr,
 	bind = con_is_bound(con->con);
 	console_unlock();
 
-	return snprintf(buf, PAGE_SIZE, "%i\n", bind);
+	return sysfs_emit(buf, "%i\n", bind);
 }
 
 static ssize_t show_name(struct device *dev, struct device_attribute *attr,
@@ -3947,7 +3947,7 @@ static ssize_t show_name(struct device *dev, struct device_attribute *attr,
 {
 	struct con_driver *con = dev_get_drvdata(dev);
 
-	return snprintf(buf, PAGE_SIZE, "%s %s\n",
+	return sysfs_emit(buf, "%s %s\n",
 			(con->flag & CON_DRIVER_FLAG_MODULE) ? "(M)" : "(S)",
 			 con->desc);
 
-- 
2.25.1

