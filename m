Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A9BC43334
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jun 2022 03:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231210AbiF2D3U (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 23:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229694AbiF2D3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 23:29:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 872921A050
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 20:29:16 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXn414SRXz9svM;
        Wed, 29 Jun 2022 11:28:33 +0800 (CST)
Received: from dggpemm500016.china.huawei.com (7.185.36.25) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 11:29:04 +0800
Received: from huawei.com (10.67.174.33) by dggpemm500016.china.huawei.com
 (7.185.36.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 11:29:04 +0800
From:   "GONG, Ruiqi" <gongruiqi1@huawei.com>
To:     Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>
CC:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        <kernel-hardening@lists.openwall.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        Gong Ruiqi <gongruiqi1@huawei.com>
Subject: [PATCH] stack: Declare {randomize_,}kstack_offset to fix Sparse warnings
Date:   Wed, 29 Jun 2022 11:29:39 +0800
Message-ID: <20220629032939.2506773-1-gongruiqi1@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.174.33]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500016.china.huawei.com (7.185.36.25)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following Sparse warnings that got noticed when the PPC-dev
patchwork was checking another patch (see the link below):

init/main.c:862:1: warning: symbol 'randomize_kstack_offset' was not declared. Should it be static?
init/main.c:864:1: warning: symbol 'kstack_offset' was not declared. Should it be static?

Which in fact are triggered on all architectures that have
HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET support (for instances x86, arm64
etc).

Link: https://lore.kernel.org/lkml/e7b0d68b-914d-7283-827c-101988923929@huawei.com/T/#m49b2d4490121445ce4bf7653500aba59eefcb67f
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Xiu Jianfeng <xiujianfeng@huawei.com>
Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
---
 init/main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/init/main.c b/init/main.c
index e2490387db2b..6aa0fb2340cc 100644
--- a/init/main.c
+++ b/init/main.c
@@ -101,6 +101,10 @@
 #include <linux/stackdepot.h>
 #include <net/net_namespace.h>
 
+#ifdef CONFIG_RANDOMIZE_KSTACK_OFFSET
+#include <linux/randomize_kstack.h>
+#endif
+
 #include <asm/io.h>
 #include <asm/bugs.h>
 #include <asm/setup.h>
-- 
2.25.1

