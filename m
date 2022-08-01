Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FBFC19F29
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 12:18:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiHAMSQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 08:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234266AbiHAMRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:17:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A432491CA;
        Mon,  1 Aug 2022 04:59:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FEDB81163;
        Mon,  1 Aug 2022 11:59:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26D2DC433C1;
        Mon,  1 Aug 2022 11:59:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659355143;
        bh=qfBSJkoLITgNp5hMOPkftoMMMYczmKycikn8cT0fsnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HQ8N1T2jZZBboCFgucn2wQsUbrXvx4R2uJhhmU2NaurydFmJumJzcE9CzTr/lzFr7
         EOXF/V5yaN6VGRm9RY8jAZJT/aZulu4Zv2cyjWVuipSWOc4CAE1csxy7z9pH8b3fUB
         +VOtDOHkxJiayEIvZoBf3NIgzeGo0hRmJ6cD0frc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 61/88] tcp: Fix a data-race around sysctl_tcp_comp_sack_slack_ns.
Date:   Mon,  1 Aug 2022 13:47:15 +0200
Message-Id: <20220801114140.851159905@linuxfoundation.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220801114138.041018499@linuxfoundation.org>
References: <20220801114138.041018499@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 22396941a7f343d704738360f9ef0e6576489d43 ]

While reading sysctl_tcp_comp_sack_slack_ns, it can be changed
concurrently.  Thus, we need to add READ_ONCE() to its reader.

Fixes: a70437cc09a1 ("tcp: add hrtimer slack to sack compression")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 3591a25a8631..5de396075a27 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -5551,7 +5551,7 @@ static void __tcp_ack_snd_check(struct sock *sk, int ofo_possible)
 		      rtt * (NSEC_PER_USEC >> 3)/20);
 	sock_hold(sk);
 	hrtimer_start_range_ns(&tp->compressed_ack_timer, ns_to_ktime(delay),
-			       sock_net(sk)->ipv4.sysctl_tcp_comp_sack_slack_ns,
+			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_comp_sack_slack_ns),
 			       HRTIMER_MODE_REL_PINNED_SOFT);
 }
 
-- 
2.35.1



