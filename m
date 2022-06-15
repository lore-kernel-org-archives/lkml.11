Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2E42C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 09:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348076AbiFOJbN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 05:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347361AbiFOJbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 05:31:12 -0400
Received: from mail-m964.mail.126.com (mail-m964.mail.126.com [123.126.96.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D13D533367
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 02:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=wSyOh
        7TGpKD2kl3xp22qwOR325N+9r8RRXVPnSEe8+M=; b=Z5ci7uin7PadAKgs23lml
        1voAIHwgT9P2Fi9mkZ1hf6fPzWn/s8lGLuuc6NLXrU/ry2iluDwlsqmCLWcmRI1h
        BAQcLdZskVIUcmTsoOMTn1uSvfafvoTxO15U4QZjMWDdaYDlZ0NlxxaFixjmRoDW
        X1lpCF3JEnBxwv0+C8mTWM=
Received: from localhost.localdomain (unknown [124.16.139.61])
        by smtp9 (Coremail) with SMTP id NeRpCgAH+p6gpqlimnAfEw--.6836S2;
        Wed, 15 Jun 2022 17:30:08 +0800 (CST)
From:   heliang <windhl@126.com>
To:     linus.walleij@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        windhl@126.com
Subject: [PATCH] arch: arm: mach-versatile: Add missing of_node_put()
Date:   Wed, 15 Jun 2022 17:29:58 +0800
Message-Id: <20220615092958.3962271-1-windhl@126.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: NeRpCgAH+p6gpqlimnAfEw--.6836S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF13Ar13GFy3Xr1DCF4UArb_yoW3uFb_tF
        1ftaykGw4rJFyIgrykCF1fGrZrZ340gr1kJryIyr98Ary3ArnrArZ7t3s2gw4rWFW2kr43
        Wrs7CrWF9ay29jkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_7Ks3UUUUU==
X-Originating-IP: [124.16.139.61]
X-CM-SenderInfo: hzlqvxbo6rjloofrz/xtbBGgghF1-HZTWGvAABsX
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vexpress_smp_dt_prepare_cpus(), of_find_matching_node() will
return a node pointer with refcount incremented. We should use
of_node_put() when it is not used anymore.

Signed-off-by: heliang <windhl@126.com>
---
 arch/arm/mach-versatile/platsmp-vexpress.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-versatile/platsmp-vexpress.c b/arch/arm/mach-versatile/platsmp-vexpress.c
index 1ee3c45e71c9..459b5870de59 100644
--- a/arch/arm/mach-versatile/platsmp-vexpress.c
+++ b/arch/arm/mach-versatile/platsmp-vexpress.c
@@ -66,6 +66,8 @@ static void __init vexpress_smp_dt_prepare_cpus(unsigned int max_cpus)
 
 	if (scu)
 		scu_enable(of_iomap(scu, 0));
+	
+	of_node_put(scu);
 
 	/*
 	 * Write the address of secondary startup into the
-- 
2.25.1

