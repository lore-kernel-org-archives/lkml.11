Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0AAFECAAD5
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 08:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236006AbiIBIye (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 04:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiIBIyb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 04:54:31 -0400
Received: from mail-m973.mail.163.com (mail-m973.mail.163.com [123.126.97.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58DC19410B
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 01:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=pqcpp
        UH4uIpCV/sY/RwJOUDwY1HHs3lcJjMzAP+wqjY=; b=Sb5eGe4yQOzoyFyHtn0ta
        bwvb5vvF9JtxodVZ1pPfF5bGapXqhGzw5RwnpIUbaGHhnKXKaUusQEEg+cSBaD1c
        YyfKjcFhaaV2GlxlhMq9K44hSCYeWyF+hwed6iIKgHMrMJ/JdTSuMMZpD8yvOKGZ
        8S83T1oc5C14hP+deuQPzA=
Received: from localhost.localdomain (unknown [116.128.244.169])
        by smtp3 (Coremail) with SMTP id G9xpCgBXAYOpxBFjm625aA--.7112S2;
        Fri, 02 Sep 2022 16:54:05 +0800 (CST)
From:   Jiangshan Yi <13667453960@163.com>
To:     shaggy@kernel.org
Cc:     viro@zeniv.linux.org.uk, akpm@linux-foundation.org,
        jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiangshan Yi <yijiangshan@kylinos.cn>,
        k2ci <kernel-bot@kylinos.cn>
Subject: [PATCH] fs/jfs/jfs_xattr.h: Fix spelling typo in comment
Date:   Fri,  2 Sep 2022 16:53:38 +0800
Message-Id: <20220902085338.2536017-1-13667453960@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: G9xpCgBXAYOpxBFjm625aA--.7112S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrury7Jr47ZFy5GF17Xw1kXwb_yoW3ArcE9a
        1IvF4v93yUtF4Fvr1UZFZakFyY9r4UKrWDtr4UAFsYyw1Uta9xJa95JrWIkrnxGr4qgFsY
        gwn3Gry3W34qgjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1GNtDUUUUU==
X-Originating-IP: [116.128.244.169]
X-CM-SenderInfo: bprtllyxuvjmiwq6il2tof0z/1tbizRxw+1c7N-N5ygABsA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiangshan Yi <yijiangshan@kylinos.cn>

Fix spelling typo in comment.

Reported-by: k2ci <kernel-bot@kylinos.cn>
Signed-off-by: Jiangshan Yi <yijiangshan@kylinos.cn>
---
 fs/jfs/jfs_xattr.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/jfs/jfs_xattr.h b/fs/jfs/jfs_xattr.h
index c50167a7bc50..0d33816d251d 100644
--- a/fs/jfs/jfs_xattr.h
+++ b/fs/jfs/jfs_xattr.h
@@ -25,7 +25,7 @@ struct jfs_ea_list {
 	struct jfs_ea ea[];	/* Variable length list */
 };
 
-/* Macros for defining maxiumum number of bytes supported for EAs */
+/* Macros for defining maximum number of bytes supported for EAs */
 #define MAXEASIZE	65535
 #define MAXEALISTSIZE	MAXEASIZE
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

