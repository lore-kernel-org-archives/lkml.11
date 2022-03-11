Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF313C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 19:35:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351141AbiCKTgm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:36:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234259AbiCKTgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:36:41 -0500
Received: from mxout01.lancloud.ru (mxout01.lancloud.ru [45.84.86.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68E21F68C0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 11:35:33 -0800 (PST)
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru 2A131206FFD9
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v2] platform: finally disallow IRQ0 in platform_get_irq() and
 its ilk
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>
Organization: Open Mobile Platform
Message-ID: <025679e1-1f0a-ae4b-4369-01164f691511@omp.ru>
Date:   Fri, 11 Mar 2022 22:35:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT01.lancloud.ru (fd00:f066::141) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is
invalid") only calls WARN() when IRQ0 is about to be returned, however
using IRQ0 is considered invalid (according to Linus) outside the arch/
code where it's used by the i8253 drivers. Many driver subsystems treat
0 specially (e.g. as an indication of the polling mode by libata), so
the users of platform_get_irq[_byname]() in them would have to filter
out IRQ0 explicitly and this (quite obviously) doesn't scale...
Let's finally get this straight and return -EINVAL instead of IRQ0!

Fixes: a85a6c86c25b ("driver core: platform: Clarify that IRQ 0 is invalid")
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Acked-by: Marc Zyngier <maz@kernel.org>

---
The patch is against the 'driver-core-next' branch of Greg Kroah-Hartman's
'driver-core.git' repo.

Changes in version 2:
- added Marc's ACK.

 drivers/base/platform.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

Index: driver-core/drivers/base/platform.c
===================================================================
--- driver-core.orig/drivers/base/platform.c
+++ driver-core/drivers/base/platform.c
@@ -231,7 +231,8 @@ int platform_get_irq_optional(struct pla
 out_not_found:
 	ret = -ENXIO;
 out:
-	WARN(ret == 0, "0 is an invalid IRQ number\n");
+	if (WARN(!ret, "0 is an invalid IRQ number\n"))
+		return -EINVAL;
 	return ret;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_optional);
@@ -446,7 +447,8 @@ static int __platform_get_irq_byname(str
 
 	r = platform_get_resource_byname(dev, IORESOURCE_IRQ, name);
 	if (r) {
-		WARN(r->start == 0, "0 is an invalid IRQ number\n");
+		if (WARN(!r->start, "0 is an invalid IRQ number\n"))
+			return -EINVAL;
 		return r->start;
 	}
 
