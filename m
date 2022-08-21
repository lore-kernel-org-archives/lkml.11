Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26DF1C3F6B0
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Aug 2022 15:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiHUPgn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Aug 2022 11:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiHUPgm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 11:36:42 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E2AD1ADA2;
        Sun, 21 Aug 2022 08:36:41 -0700 (PDT)
X-QQ-mid: bizesmtp90t1661096165t374baa6
Received: from localhost.localdomain ( [182.148.14.124])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 21 Aug 2022 23:36:03 +0800 (CST)
X-QQ-SSF: 0100000000200020B000B00A0000000
X-QQ-FEAT: DCPPvtqe8IzjFnN8vSMSGBUwANjnMiqsqhv9KSe9/xAj/mxepGoZuYvIWSMWS
        4d1ypT1J91f6T7xsvIZpMyzvsz8jQ7HD9XhhtJKw8qtJ1qmZm9P/mMQ2bM5RTszDD0vBfSR
        AaRrVkFzh/NWpLFn5rymWFvEcnfEq3XcdqwAnZ2BijNGUHiEHAodluCXCwdSj2k+WWj2VTA
        mquAI/IiaeoweCAk4DRLFzIzfJBt8ZmZSzFDkfLMBdnPnixSzRq3foExNseKy/pNKVVReOr
        iMr5EtKv9etj/PlXyWwNuu1Te4nFZ+pEoy8rNFVRRO2HdRmXav7og6yAksY8hPc6Gu7ZMms
        19s5WGRwU78EUujABoNp34yPtxHAyr+JcaYxKGRmtXcL0XmP1FA4zX+MB6ZZA==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, narmstrong@baylibre.com,
        jbrunet@baylibre.com, mturquette@baylibre.com, sboyd@kernel.org,
        khilman@baylibre.com
Cc:     linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] clk/meson: fix repeated words in comments
Date:   Sun, 21 Aug 2022 23:35:46 +0800
Message-Id: <20220821153546.7358-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 Delete the redundant word 'by'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/x86/tools/relocs.c        | 2 +-
 drivers/clk/meson/clk-regmap.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index e2c5b296120d..3f8ab8efb674 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -764,7 +764,7 @@ static void walk_relocs(int (*process)(struct section *sec, Elf_Rel *rel,
  *	to the start of the per_cpu area that does not change).
  *
  *	Relocations that apply to the per_cpu area need to have their
- *	offset adjusted by by the value of __per_cpu_load to make them
+ *	offset adjusted by the value of __per_cpu_load to make them
  *	point to the correct place in the loaded image (because the
  *	virtual address of .data..percpu is 0).
  *
diff --git a/drivers/clk/meson/clk-regmap.h b/drivers/clk/meson/clk-regmap.h
index e365312da54e..e08a9fa0cc36 100644
--- a/drivers/clk/meson/clk-regmap.h
+++ b/drivers/clk/meson/clk-regmap.h
@@ -18,7 +18,7 @@
  * @data:	data specific to the clock type
  *
  * Clock which is controlled by regmap backed registers. The actual type of
- * of the clock is controlled by the clock_ops and data.
+ * the clock is controlled by the clock_ops and data.
  */
 struct clk_regmap {
 	struct clk_hw	hw;
-- 
2.36.1

