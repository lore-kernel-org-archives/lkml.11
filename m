Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F15D6C433F5
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Mar 2022 02:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231657AbiCCCHw (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbiCCCHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 21:07:51 -0500
Received: from mail-m971.mail.163.com (mail-m971.mail.163.com [123.126.97.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01CFC13F93
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 18:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=/B/qV
        PJ6uIJdog1etJxUaLhtEcABY8fXow+nh3nMsu4=; b=AR4voaIU6Jr9DrUCUxjne
        zB2AXhxyRbrtSZ+irluIF5Pk6FYJ4+nPBopVKvuo7WVF/UnaFcEq+no52ybi1Pa7
        c15nr5dBb7TDLLbRxCFbnb79Mcxfcy8EqQYizy9QIzuqMekKItDimFsN7Pt+Tl/l
        KCgrvkd20F5LGa7EKWEfh8=
Received: from localhost.localdomain (unknown [218.106.182.227])
        by smtp1 (Coremail) with SMTP id GdxpCgB3T4qnIiBi91UABw--.7592S4;
        Thu, 03 Mar 2022 10:06:54 +0800 (CST)
From:   Jianglei Nie <niejianglei2021@163.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Jianglei Nie <niejianglei2021@163.com>
Subject: [PATCH] tty: vt: consolemap: Add missing kfree() in con_do_clear_unimap()
Date:   Thu,  3 Mar 2022 10:06:30 +0800
Message-Id: <20220303020630.460257-1-niejianglei2021@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GdxpCgB3T4qnIiBi91UABw--.7592S4
X-Coremail-Antispam: 1Uf129KBjvdXoW7GF4fWw47GFyUuryxCr1kGrg_yoWxZrX_Ga
        y8Cayfur4j939Yya13Cr15urWfZFZ5ZF1kWFnFqF9xt34DZw4xJ3y2vr9xWryUW3yrAFnx
        JFWvvr18Cr98WjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRJCzAJUUUUU==
X-Originating-IP: [218.106.182.227]
X-CM-SenderInfo: xqlhyxxdqjzvrlsqjii6rwjhhfrp/1tbiPgK4jFxBqajsmQACsj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We should free p after con_release_unimap(p) like the call points of
con_release_unimap() do in the same file.

This patch adds the missing kfree() after con_release_unimap(p).

Signed-off-by: Jianglei Nie <niejianglei2021@163.com>
---
 drivers/tty/vt/consolemap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/vt/consolemap.c b/drivers/tty/vt/consolemap.c
index d815ac98b39e..5279c3d27720 100644
--- a/drivers/tty/vt/consolemap.c
+++ b/drivers/tty/vt/consolemap.c
@@ -520,6 +520,7 @@ static int con_do_clear_unimap(struct vc_data *vc)
 		p->refcount++;
 		p->sum = 0;
 		con_release_unimap(p);
+		kfree(p);
 	}
 	return 0;
 }
-- 
2.25.1

