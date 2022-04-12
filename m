Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F054DC3527E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355692AbiDLH3B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:29:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351773AbiDLHMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831E0BEA;
        Mon, 11 Apr 2022 23:52:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4442AB81B4D;
        Tue, 12 Apr 2022 06:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A891FC385AA;
        Tue, 12 Apr 2022 06:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746345;
        bh=NfeNvJW7Ua+DZevPzPJ9NzsiwccHYeffGmFmilqXX3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u+SUpXzlXeQt4rgjp81NpP9fDrKyGOUkSjV8eaIrezXIWWlI/dnZpEmTkI4MulUg7
         34dtCjHCmmIpZhICjVx/xNqVtFeDVSk6Af5tD6NHCaeCEzu/2tKVndcDpStUkWIcVy
         UY7gqTRs8ptodZvUPQggMDMQIl8/VeD/tgbOlo5c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tony Lu <tonylu@linux.alibaba.com>,
        Dust Li <dust.li@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 249/277] net/smc: send directly on setting TCP_NODELAY
Date:   Tue, 12 Apr 2022 08:30:52 +0200
Message-Id: <20220412062949.248838414@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062942.022903016@linuxfoundation.org>
References: <20220412062942.022903016@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dust Li <dust.li@linux.alibaba.com>

commit b70a5cc045197aad9c159042621baf3c015f6cc7 upstream.

In commit ea785a1a573b("net/smc: Send directly when
TCP_CORK is cleared"), we don't use delayed work
to implement cork.

This patch use the same algorithm, removes the
delayed work when setting TCP_NODELAY and send
directly in setsockopt(). This also makes the
TCP_NODELAY the same as TCP.

Cc: Tony Lu <tonylu@linux.alibaba.com>
Signed-off-by: Dust Li <dust.li@linux.alibaba.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/af_smc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -2419,8 +2419,8 @@ static int smc_setsockopt(struct socket
 		    sk->sk_state != SMC_CLOSED) {
 			if (val) {
 				SMC_STAT_INC(smc, ndly_cnt);
-				mod_delayed_work(smc->conn.lgr->tx_wq,
-						 &smc->conn.tx_work, 0);
+				smc_tx_pending(&smc->conn);
+				cancel_delayed_work(&smc->conn.tx_work);
 			}
 		}
 		break;


