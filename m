Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDF92C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 15:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359742AbiBDPco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 10:32:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:23256 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1359729AbiBDPco (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 10:32:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643988764; x=1675524764;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y90kpLLV55S7E+WAS5zMpsCx27LldDzWId8+y8ndgYs=;
  b=gz0xkTTt9mrDrweqMtn3sAYrgOwxF+5M+q51x79ztl4uf5DOcdj4fK6r
   lOYxli7gHfV3WclimXHXCQi3GMK0c9UtsoVrV3U8EM03oRUfEvArIuFlq
   R9AO8JhoesvK2Gm7RWoH9vWZchZ4Z3jSKGQdh3jNeW711Bg/LMs8Nped6
   sSzfBD6zgMFoUAo1LukLcuJL/hkIXod9GrqQ0+nFInso1zw2Bb2qX4lfg
   xEEbbyWBKOg4pYyPQwx54QkMrRwz0gdBvg8vOnaAijkik7rOxn4hBvg30
   CiKL9JYifLRkgg8ahCMYKdkJNuCEQq3YVdMX/oXKj5G263g4FpgXuhFKV
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="309130252"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="309130252"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 07:32:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="566767476"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 04 Feb 2022 07:32:42 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 0A71E204; Fri,  4 Feb 2022 17:32:56 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] tty: Drop duplicate NULL check in TTY port functions
Date:   Fri,  4 Feb 2022 17:32:53 +0200
Message-Id: <20220204153253.11006-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The free_page(addr), which becomes free_pages(addr, 0) checks addr against 0.
No need to repeat this check in the callers, i.e.  tty_port_free_xmit_buf()
and tty_port_destructor().

Note, INIT_KFIFO() is safe without that check, because it operates on
a separate member and doesn't rely on the FIFO itself to be allocated.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Jiri Slaby <jirislaby@kernel.org>
---
v2: updated note in commit message (Greg), added tag (Jiri)
 drivers/tty/tty_port.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 4282895ede9e..880608a65773 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -240,11 +240,9 @@ EXPORT_SYMBOL(tty_port_alloc_xmit_buf);
 void tty_port_free_xmit_buf(struct tty_port *port)
 {
 	mutex_lock(&port->buf_mutex);
-	if (port->xmit_buf != NULL) {
-		free_page((unsigned long)port->xmit_buf);
-		port->xmit_buf = NULL;
-		INIT_KFIFO(port->xmit_fifo);
-	}
+	free_page((unsigned long)port->xmit_buf);
+	port->xmit_buf = NULL;
+	INIT_KFIFO(port->xmit_fifo);
 	mutex_unlock(&port->buf_mutex);
 }
 EXPORT_SYMBOL(tty_port_free_xmit_buf);
@@ -271,8 +269,7 @@ static void tty_port_destructor(struct kref *kref)
 	/* check if last port ref was dropped before tty release */
 	if (WARN_ON(port->itty))
 		return;
-	if (port->xmit_buf)
-		free_page((unsigned long)port->xmit_buf);
+	free_page((unsigned long)port->xmit_buf);
 	tty_port_destroy(port);
 	if (port->ops && port->ops->destruct)
 		port->ops->destruct(port);
-- 
2.34.1

