Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6528BC433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Feb 2022 04:08:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344234AbiBIEIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 23:08:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346430AbiBID2n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 22:28:43 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E5DC061576;
        Tue,  8 Feb 2022 19:28:42 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644377321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=lYo3QBxWEb3sYyyC7Y9NvFdCKKAa/0p/ymIbiLeV3GM=;
        b=CxvWoM55y35IoPBK2TZ3q/r3Fh5yCltzB9yW8/NO19GCZHVFtbTP6g46t3dIO7oV2kBUq1
        P67jRa2ipAgZew930/4C1mU/8IQDpFZeCCFQfzTJh/cKbxz7tEhf4gv6xNo+BArZNpY6zF
        HOaXBlKteMCX9mjeOjce1WYiXSOxB4c=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usbip: vudc: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:28:13 +0800
Message-Id: <20220209032813.38703-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/usb/usbip/vudc_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
index 678faa82598c..d43252b77efd 100644
--- a/drivers/usb/usbip/vudc_main.c
+++ b/drivers/usb/usbip/vudc_main.c
@@ -26,7 +26,7 @@ static struct platform_driver vudc_driver = {
 	},
 };
 
-static struct list_head vudc_devices = LIST_HEAD_INIT(vudc_devices);
+static LIST_HEAD(vudc_devices);
 
 static int __init init(void)
 {
-- 
2.25.1

