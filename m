Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B74C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 10:38:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242250AbiHOKix (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 06:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbiHOKiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:38:51 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB7B13D64
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:38:49 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id 7men2800a4C55Sk01men5m; Mon, 15 Aug 2022 12:38:47 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXUd-0019cC-Ch; Mon, 15 Aug 2022 12:38:47 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXUc-00C0SR-PO; Mon, 15 Aug 2022 12:38:46 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to y
Date:   Mon, 15 Aug 2022 12:38:45 +0200
Message-Id: <1498887cf43bf7ab7c47e2a397e67bff55524f92.1660559553.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NF_CONNTRACK_PROCFS was marked obsolete in commit 54b07dca68557b09
("netfilter: provide config option to disable ancient procfs parts") in
v3.3.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 net/netfilter/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/netfilter/Kconfig b/net/netfilter/Kconfig
index 22f15ebf6045b3a9..4b8d04640ff32274 100644
--- a/net/netfilter/Kconfig
+++ b/net/netfilter/Kconfig
@@ -144,7 +144,6 @@ config NF_CONNTRACK_ZONES
 
 config NF_CONNTRACK_PROCFS
 	bool "Supply CT list in procfs (OBSOLETE)"
-	default y
 	depends on PROC_FS
 	help
 	This option enables for the list of known conntrack entries
-- 
2.25.1

