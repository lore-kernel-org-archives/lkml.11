Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F84C35280
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 14:08:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344198AbiDROJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 10:09:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343742AbiDRNyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:54:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2283A13D5C;
        Mon, 18 Apr 2022 06:03:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E29660B3C;
        Mon, 18 Apr 2022 13:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DBDAC385A1;
        Mon, 18 Apr 2022 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650287009;
        bh=v86yU2KzhbAfi1tTJiLt7A+HXLuAH1F0afqfBB61swM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xHoRy5xcJ5MNUYDOh6Vww/OOAnInqpOt2wY9jTzMJ9VNtgc/9BBXNJ5Fznsz1Kvic
         5BxH9RlXC+II0usVtFtZQqDwKyuu5alDhltQtc+/6vMhgAddwTp6zBxvPVZVMYrHvb
         IJqj9SDLdSsGVXMTWyGClEVOSjpS8TIpSdALXwZY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Yajun Deng <yajun.deng@linux.dev>,
        "David S. Miller" <davem@davemloft.net>,
        Pavel Machek <pavel@denx.de>
Subject: [PATCH 4.9 003/218] netdevice: add the case if dev is NULL
Date:   Mon, 18 Apr 2022 14:11:09 +0200
Message-Id: <20220418121158.826759816@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121158.636999985@linuxfoundation.org>
References: <20220418121158.636999985@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yajun Deng <yajun.deng@linux.dev>

commit b37a466837393af72fe8bcb8f1436410f3f173f3 upstream.

Add the case if dev is NULL in dev_{put, hold}, so the caller doesn't
need to care whether dev is NULL or not.

Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
Signed-off-by: David S. Miller <davem@davemloft.net>
Cc: Pavel Machek <pavel@denx.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/netdevice.h |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/include/linux/netdevice.h
+++ b/include/linux/netdevice.h
@@ -3410,7 +3410,8 @@ void netdev_run_todo(void);
  */
 static inline void dev_put(struct net_device *dev)
 {
-	this_cpu_dec(*dev->pcpu_refcnt);
+	if (dev)
+		this_cpu_dec(*dev->pcpu_refcnt);
 }
 
 /**
@@ -3421,7 +3422,8 @@ static inline void dev_put(struct net_de
  */
 static inline void dev_hold(struct net_device *dev)
 {
-	this_cpu_inc(*dev->pcpu_refcnt);
+	if (dev)
+		this_cpu_inc(*dev->pcpu_refcnt);
 }
 
 /* Carrier loss detection, dial on demand. The functions netif_carrier_on


