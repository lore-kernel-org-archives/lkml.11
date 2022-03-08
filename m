Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BE86C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Mar 2022 12:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346796AbiCHM2V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Mar 2022 07:28:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346865AbiCHM2O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:28:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DC4546657
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:27:18 -0800 (PST)
Date:   Tue, 8 Mar 2022 13:27:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646742436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5TO2CaVQGT8QTsFFV2q3urdSORX8irKbNETQMa4ApM4=;
        b=W9NYfZPo/AKNx9d5YW8LJjaBFWne1CviMOrreSGaq15aaMxbh2yz1n0aBHP8soujJrLYKZ
        B4HrHuGW8flA3UuoDKdg11IZz7vI1k+JQAVPe7ahfCA21hZIOyJl9Vfu9PPgZf2EV52m/3
        mBxHmO0cfXLlKh+9jdQVTH2o/yV4QaiJ/+rnaNwyg3bSdwa41EamOgnHc1NcBFYiggcvBD
        ZuirLy4Pt+DiA72nq/uD0lLf0469LONd33iZTagDAPpC95cADUahjORiss7DU4lZNRFrvH
        2eE5gtgwEKxiXsA4U8bIKR+OZt950YHmvMVOYs9MJKIMzG0piXk0NYu50d/x/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646742436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=5TO2CaVQGT8QTsFFV2q3urdSORX8irKbNETQMa4ApM4=;
        b=VyN3+ivAhMg3O6A9WsBi0SQxvFXA5qsBMlLvLnFIMtzJOByw3MaFSWbLFTPsnJ0Oub0U/L
        m1/KjtLE+qhMdUBA==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Fei Li <fei1.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH REPOST] virt: acrn: Remove unsued acrn_irqfds_mutex.
Message-ID: <YidLo57Kw/u/cpA5@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

acrn_irqfds_mutex is not used, never was.

Remove acrn_irqfds_mutex.

Fixes: aa3b483ff1d71 ("virt: acrn: Introduce irqfd")
Cc: Fei Li <fei1.li@intel.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---

Repost of
   https://lore.kernel.org/all/20210910094708.3430340-1-bigeasy@linutronix.de/

please apply, it is trivial.

 drivers/virt/acrn/irqfd.c |    1 -
 1 file changed, 1 deletion(-)

--- a/drivers/virt/acrn/irqfd.c
+++ b/drivers/virt/acrn/irqfd.c
@@ -17,7 +17,6 @@
 #include "acrn_drv.h"
 
 static LIST_HEAD(acrn_irqfd_clients);
-static DEFINE_MUTEX(acrn_irqfds_mutex);
 
 /**
  * struct hsm_irqfd - Properties of HSM irqfd
