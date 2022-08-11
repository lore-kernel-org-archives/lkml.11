Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A1C25B06
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Aug 2022 23:12:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236629AbiHKXMr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Aug 2022 19:12:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236642AbiHKXMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 19:12:42 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 Aug 2022 16:12:41 PDT
Received: from esa4.mentor.iphmx.com (esa4.mentor.iphmx.com [68.232.137.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A459CA0623
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 16:12:41 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.93,231,1654588800"; 
   d="scan'208";a="81178192"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa4.mentor.iphmx.com with ESMTP; 11 Aug 2022 15:11:38 -0800
IronPort-SDR: 7i3JnU3CFV+Cpa2RDTuGc2tZu7ccsc3TNEiAoCS0WsI5jMLB81nTe547JTmqUh3nT/zsr6yKNZ
 y7zbnG0a8h3c1J5LcDc2U3qh+BJIzs3IWjkmMH8qTsLffH+mUlQMBSl6N1rNHnweV13Jo7i4kb
 MAcZrS/FwBwn5WzV8D7frL4BNGYzxoYs/4wOO7+IB1zYihJxbeEI7scAWO6/aJqqgpqAK+JVLH
 MKRs52lz422wtfLtSi2NUNwgzqrGHjEr9QP6J+yyusCaNnkAKoV7byQ3sT2vVQnZhmgTY+RE7s
 iZ4=
From:   "George G. Davis" <george_davis@mentor.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "moderated list:ARM64 PORT (AARCH64 ARCHITECTURE)" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
CC:     <george_davis@mentor.com>,
        "George G. Davis" <davis.george@siemens.com>
Subject: [PATCH] arm64: enable kernel command line concatenation
Date:   Thu, 11 Aug 2022 19:11:27 -0400
Message-ID: <20220811231127.787178-1-george_davis@mentor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210) To
 svr-orw-mbx-10.mgc.mentorg.com (147.34.90.210)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "George G. Davis" <davis.george@siemens.com>

Enable CONFIG_CMDLINE to extend the boot loader supplied cmdline. This
can then be used in config fragments to set command line arguments
specific to testing of different kernel config options.

Signed-off-by: George G. Davis <davis.george@siemens.com>
---
 arch/arm64/Kconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 571cc234d0b3..cf4a44cde21b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2140,6 +2140,12 @@ config CMDLINE_FROM_BOOTLOADER
 	  the boot loader doesn't provide any, the default kernel command
 	  string provided in CMDLINE will be used.
 
+config CMDLINE_EXTEND
+	bool "Extend bootloader kernel arguments"
+	help
+	  The command-line arguments provided by the boot loader will be
+	  appended to the default kernel command string.
+
 config CMDLINE_FORCE
 	bool "Always use the default kernel command string"
 	help
-- 
2.25.1

