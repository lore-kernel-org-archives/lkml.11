Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1776C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 10:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352908AbiCYK7R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 06:59:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244096AbiCYK7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 06:59:15 -0400
Received: from out203-205-221-164.mail.qq.com (out203-205-221-164.mail.qq.com [203.205.221.164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B81EBD8AF
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 03:57:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648205855;
        bh=6OcTYymcpn1ETfdJpMGEKngpR17gFGKQz5gHn9I1PVs=;
        h=From:To:Cc:Subject:Date;
        b=OGFF21uWtclTkkMcGS/fvDp5C3/8pZcA3SGyjozfh+OiaeK/UK6uOf06GRSxK6j3S
         vVCAV/GwAY1p2m3QmYcvsBVUYfjgHdZJYwVZWe9x5enVFLEaNUF/M81k1N3ca0BaHT
         OXJIqgV0dNL7Fuo2syJwETlZuaVixfyUHedrbxMY=
Received: from localhost.localdomain ([43.227.136.188])
        by newxmesmtplogicsvrsza8.qq.com (NewEsmtp) with SMTP
        id E602687E; Fri, 25 Mar 2022 18:57:32 +0800
X-QQ-mid: xmsmtpt1648205852tconbqa3l
Message-ID: <tencent_33384AA3FF65207ECC63B9531C1F1417E108@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeieFm7kI9XblVO1Ypif6OeHBEb2nEHDiQJ3sU6oQQmw5b1GkMOP7O
         Mnb1pv9Urdl+jVwu9BK08Pcl/Qfm274NkG8mQOHFlLL4wJCK/8PRt/Y8ZyqPNW1cPnYLQ5dUVMYI
         LJNrNT/ETTzZ55PY+baBFGSygMRKPmeqMqwchlkvBsHcOgPvP9aEFB87yzq+hbZGYW7OiwaLibPh
         rlkxwETKD+Cs8/BdqeGLNzdqNUX4I7lTnqY2dbv129sC8bLaLOFCpsllcBzO4XimrAVS2MWGMPK+
         K/aU6U3HErZv+mDnucPhxcus6DecqSMaKZSSGvwfFeZ2OYNiWt/ZD45UiyQHS7SqjuyuJiDzsXuo
         7hrtX5IvVcT4wtZgFdB7Hvsl8Fqlgi+jbxQUiItzOMY+tYaeLtVB4IfNUfbdeInrsywTnpN9/Xlu
         c5hCYDFF2IQNpoHMgq6dhS8n+3tRU33rSIxuEUdTWWOw9C4UBVaBmWkn2MVrehPp6071QN1DpPvW
         OMXZJCscAPzIl5fUZIuBy/RcMxb63Qn7BSf1OvPI7VkFp4VJGX9GabBMQLkHRBcBbCFrP8tywaay
         3qV5yZmg2+sTxXdhJUVGpkrs9CB5UG3gW35WHT3+EmQsuJWhXVO+NbhWXCHvVVnKr5mDZZVqYreH
         9qIGtwKjlUThCBHmtMKDTJTab+JY0y1JZOVAsT5oYG1MLedLLdIfQneIHMVFfMyu5UjDwX4Mt/TN
         c9XjlGHy2eZrJ/jR6rfOs6VaO5M8DFgggsXA7cTVZh5oRwxsvhzP9vWKIr69qMhZ5anmHozWty+3
         LJek2SVyH8XvZq1r9MV8aVvIH9o/G7c9DkWJgwTN2A65l/2dsDmPGUtgFJ60MYKGeS37NNuqawyc
         H3nzDBDKkp346Tvyk4DfVC5erHHN6UDN3jYyNTLGr6w53DHzAd3LDG7If4qbNF9NSzLuahzFjFcB
         b1rvKqIcE=
From:   xkernel.wang@foxmail.com
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] mips: sgi-ip22: add a check for the return of kzalloc()
Date:   Fri, 25 Mar 2022 18:57:18 +0800
X-OQ-MSGID: <20220325105719.4348-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

kzalloc() is a memory allocation function which can return NULL when
some internal memory errors happen. So it is better to check it to
prevent potential wrong memory access.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 arch/mips/sgi-ip22/ip22-gio.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/sgi-ip22/ip22-gio.c b/arch/mips/sgi-ip22/ip22-gio.c
index dfc52f6..38d12f4 100644
--- a/arch/mips/sgi-ip22/ip22-gio.c
+++ b/arch/mips/sgi-ip22/ip22-gio.c
@@ -363,6 +363,8 @@ static void ip22_check_gio(int slotno, unsigned long addr, int irq)
 		printk(KERN_INFO "GIO: slot %d : %s (id %x)\n",
 		       slotno, name, id);
 		gio_dev = kzalloc(sizeof *gio_dev, GFP_KERNEL);
+		if (!gio_dev)
+			return;
 		gio_dev->name = name;
 		gio_dev->slotno = slotno;
 		gio_dev->id.id = id;
-- 
