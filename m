Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1FACCA495
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 02:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343751AbiF1Cdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 22:33:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244855AbiF1C2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 22:28:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCDD252A1;
        Mon, 27 Jun 2022 19:26:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78582B81C0A;
        Tue, 28 Jun 2022 02:26:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70BB8C36AE3;
        Tue, 28 Jun 2022 02:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656383214;
        bh=FLIlumWy9MvT64Z6j0K6B/r+aHemoWqFt8wxgtZA+4E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K877l3QN8bRWrzSgpgaLluZmuEnuS/HaN8PIYiKnSv0nePKVOojIoI+ia8RcD1Rsh
         phRGzHFSgVyrPBuLLfFBK3MsEHc3myItQpe68DhCBWDi7Ry9CwTYKrrP1ir2igPhRO
         MQ7Cj4gEEqZM7j2KkUE72qMKO3BdNc5YM+r2QndanRA0Fxrpkf5qNl31WURbPzreyY
         sKlEcq1rpkuT6mtlsi/sS3p5/yqBAQ7aZbkEc8/471YEDJIZ81k9dsABuhrfeRZjrF
         uhh3IhB8EHGAlg+M7/yXcC0HfQYJBMQvaRJMIeXY2qKN5KxBLQUuATdDna/4Bo6Xb8
         fl/dxoCtm4esg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Liang He <windhl@126.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Sasha Levin <sashal@kernel.org>, yangtiezhu@loongson.cn,
        linux-mips@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 15/17] mips/pic32/pic32mzda: Fix refcount leak bugs
Date:   Mon, 27 Jun 2022 22:26:13 -0400
Message-Id: <20220628022615.596977-15-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628022615.596977-1-sashal@kernel.org>
References: <20220628022615.596977-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liang He <windhl@126.com>

[ Upstream commit eb9e9bc4fa5fb489c92ec588b3fb35f042ba6d86 ]

of_find_matching_node(), of_find_compatible_node() and
of_find_node_by_path() will return node pointers with refcout
incremented. We should call of_node_put() when they are not
used anymore.

Signed-off-by: Liang He <windhl@126.com>
Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/mips/pic32/pic32mzda/init.c | 7 ++++++-
 arch/mips/pic32/pic32mzda/time.c | 3 +++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/mips/pic32/pic32mzda/init.c b/arch/mips/pic32/pic32mzda/init.c
index 406c6c5cec29..f8985d4573e6 100644
--- a/arch/mips/pic32/pic32mzda/init.c
+++ b/arch/mips/pic32/pic32mzda/init.c
@@ -131,13 +131,18 @@ static int __init pic32_of_prepare_platform_data(struct of_dev_auxdata *lookup)
 		np = of_find_compatible_node(NULL, NULL, lookup->compatible);
 		if (np) {
 			lookup->name = (char *)np->name;
-			if (lookup->phys_addr)
+			if (lookup->phys_addr) {
+				of_node_put(np);
 				continue;
+			}
 			if (!of_address_to_resource(np, 0, &res))
 				lookup->phys_addr = res.start;
+			of_node_put(np);
 		}
 	}
 
+	of_node_put(root);
+
 	return 0;
 }
 
diff --git a/arch/mips/pic32/pic32mzda/time.c b/arch/mips/pic32/pic32mzda/time.c
index 1894e50939b5..04879b85aac9 100644
--- a/arch/mips/pic32/pic32mzda/time.c
+++ b/arch/mips/pic32/pic32mzda/time.c
@@ -40,6 +40,9 @@ static unsigned int pic32_xlate_core_timer_irq(void)
 		goto default_map;
 
 	irq = irq_of_parse_and_map(node, 0);
+
+	of_node_put(node);
+
 	if (!irq)
 		goto default_map;
 
-- 
2.35.1

