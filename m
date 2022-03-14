Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E162AC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Mar 2022 07:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236769AbiCNHlq (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232409AbiCNHlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 03:41:45 -0400
Received: from ZXSHCAS1.zhaoxin.com (ZXSHCAS1.zhaoxin.com [203.148.12.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF1E40E65;
        Mon, 14 Mar 2022 00:40:35 -0700 (PDT)
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHCAS1.zhaoxin.com
 (10.28.252.161) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 14 Mar
 2022 15:25:27 +0800
Received: from [192.168.43.174] (124.64.16.6) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 14 Mar
 2022 15:25:24 +0800
To:     <mathias.nyman@intel.com>, <gregkh@linuxfoundation.org>,
        <stern@rowland.harvard.edu>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>,
        <tonywwang@zhaoxin.com>, <weitaowang@zhaoxin.com>
From:   "WeitaoWang-oc@zhaoxin.com" <WeitaoWang-oc@zhaoxin.com>
Subject: [PATCH] USB: Fix xhci ERDP update issue
Message-ID: <3c576edf-89c3-ccf3-a43f-4ce2c1ced18d@zhaoxin.com>
Date:   Mon, 14 Mar 2022 15:25:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [124.64.16.6]
X-ClientProxiedBy: ZXSHCAS1.zhaoxin.com (10.28.252.161) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some situations, software handles TRB events slower than adding TRBs,
xhci_irq will not exit until all events are handled. If xhci_irq just
handles 256 TRBs and exit, the temp variable(event_ring_deq) driver 
records in xhci irq is equal to driver current dequeue pointer. It will 
cause driver not update ERDP and software dequeue pointer lost sync with 
ERDP. On the next xhci_irq, the event ring is full but driver will not 
update ERDP as software dequeue pointer is equal to ERDP.

[  536.377115] xhci_hcd 0000:00:12.0: ERROR unknown event type 37
[  566.933173] sd 8:0:0:0: [sdb] tag#27 uas_eh_abort_handler 0 uas-tag 7 
inflight: CMD OUT
[  566.933181] sd 8:0:0:0: [sdb] tag#27 CDB: Write(10) 2a 00 17 71 e6 78 
00 00 08 00
[  572.041186] xhci_hcd On some situataions,the0000:00:12.0: xHCI host 
not responding to stop endpoint command.
[  572.057193] xhci_hcd 0000:00:12.0: Host halt failed, -110
[  572.057196] xhci_hcd 0000:00:12.0: xHCI host controller not 
responding, assume dead
[  572.057236] sd 8:0:0:0: [sdb] tag#26 uas_eh_abort_handler 0 uas-tag 6 
inflight: CMD
[  572.057240] sd 8:0:0:0: [sdb] tag#26 CDB: Write(10) 2a 00 38 eb cc d8 
00 00 08 00
[  572.057244] sd 8:0:0:0: [sdb] tag#25 uas_eh_abort_handler 0 uas-tag 5 
inflight: CMD

Fixed this issue by update software record temp variable when handles 
128 TRB events.

Signed-off-by: Weitao Wang <WeitaoWang-oc@zhaoxin.com>
---
  drivers/usb/host/xhci-ring.c | 1 +
  1 file changed, 1 insertion(+)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index d0b6806..f970799 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -3141,6 +3141,7 @@ irqreturn_t xhci_irq(struct usb_hcd *hcd)
                 if (event_loop++ < TRBS_PER_SEGMENT / 2)
                         continue;
                 xhci_update_erst_dequeue(xhci, event_ring_deq);
+               event_ring_deq = xhci->event_ring->dequeue;

                 /* ring is half-full, force isoc trbs to interrupt more 
often */
                 if (xhci->isoc_bei_interval > AVOID_BEI_INTERVAL_MIN)
-- 
2.7.4
