Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A46EC433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Feb 2022 20:25:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237681AbiBDUZc (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Feb 2022 15:25:32 -0500
Received: from mxout01.lancloud.ru ([45.84.86.81]:59662 "EHLO
        mxout01.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbiBDUZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 15:25:27 -0500
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout01.lancloud.ru E2E8D2076EA7
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
From:   Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH] platform: use dev_err_probe() in platform_get_irq_byname()
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-kernel@vger.kernel.org>
Organization: Open Mobile Platform
Message-ID: <11a4aeb2-721c-56a9-919b-f356a30720e0@omp.ru>
Date:   Fri, 4 Feb 2022 23:25:23 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1907.lancloud.ru (fd00:f066::207)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 2043727c2882 ("driver core: platform: Make use of the helper
function dev_err_probe()") missed to also convert platform_get_irq_byname()
for some strange reason -- do that now.

Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>

---
 drivers/base/platform.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: driver-core/drivers/base/platform.c
===================================================================
--- driver-core.orig/drivers/base/platform.c
+++ driver-core/drivers/base/platform.c
@@ -469,9 +469,9 @@ int platform_get_irq_byname(struct platf
 	int ret;
 
 	ret = __platform_get_irq_byname(dev, name);
-	if (ret < 0 && ret != -EPROBE_DEFER)
-		dev_err(&dev->dev, "IRQ %s not found\n", name);
-
+	if (ret < 0)
+		return dev_err_probe(&dev->dev, ret, "IRQ %s not found\n",
+				     name);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(platform_get_irq_byname);
