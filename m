Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929F8C25B0E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 10:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242316AbiHOKje (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 06:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231272AbiHOKj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 06:39:29 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C152C12ADA
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 03:39:28 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id 7mfP2800V4C55Sk01mfPEY; Mon, 15 Aug 2022 12:39:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXVC-0019do-PB; Mon, 15 Aug 2022 12:39:22 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1oNXVB-00C0TX-VM; Mon, 15 Aug 2022 12:39:21 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Pablo Neira Ayuso <pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        Florian Westphal <fw@strlen.de>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jan Engelhardt <jengelh@medozas.de>
Cc:     netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] netfilter: conntrack: NF_CONNTRACK_PROCFS should no longer default to y
Date:   Mon, 15 Aug 2022 12:39:20 +0200
Message-ID: <1498887cf43bf7ab7c47e2a397e67bff55524f92.1660559553.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20220815103920.xxgHq9tY_6mlFaZMhMgvLokv43fgEdptdGCPIIZixyg@z>

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

