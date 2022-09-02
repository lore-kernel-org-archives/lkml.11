Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE19BC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 12:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiIBMcT (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 08:32:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236661AbiIBMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 08:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41113E190B;
        Fri,  2 Sep 2022 05:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D3A62109;
        Fri,  2 Sep 2022 12:24:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CC7BC433C1;
        Fri,  2 Sep 2022 12:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662121489;
        bh=48K8ti4/WbEJQ+8DJb0y3V3p3MGlpvPYyectvO5r+L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=afQpzJo2wU24i9wMsaZ7WuRkd1NBidx+WNWRK9Fth6Oycut0/8rhToQjniqYX8Dp+
         BafiK/uL2JrajNYwRdAviUbEtZXFxMy7PfZqfjtKv3TJqc/V1huqnk25bKRGb2l6vt
         +/v5uILpbOru9O2M0sN9EGAScJjn7bFQc7i1eLvY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 24/56] net: Fix a data-race around sysctl_net_busy_read.
Date:   Fri,  2 Sep 2022 14:18:44 +0200
Message-Id: <20220902121401.037492311@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121400.219861128@linuxfoundation.org>
References: <20220902121400.219861128@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit e59ef36f0795696ab229569c153936bfd068d21c ]

While reading sysctl_net_busy_read, it can be changed concurrently.
Thus, we need to add READ_ONCE() to its reader.

Fixes: 2d48d67fa8cd ("net: poll/select low latency socket support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 79f085df52cef..cd23a8e4556ca 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2856,7 +2856,7 @@ void sock_init_data(struct socket *sock, struct sock *sk)
 
 #ifdef CONFIG_NET_RX_BUSY_POLL
 	sk->sk_napi_id		=	0;
-	sk->sk_ll_usec		=	sysctl_net_busy_read;
+	sk->sk_ll_usec		=	READ_ONCE(sysctl_net_busy_read);
 #endif
 
 	sk->sk_max_pacing_rate = ~0U;
-- 
2.35.1



