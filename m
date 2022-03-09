Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF7AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 16:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbiCIQqs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 11:46:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239006AbiCIQcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:32:03 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91531A7DB9;
        Wed,  9 Mar 2022 08:26:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 471A5B82256;
        Wed,  9 Mar 2022 16:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99638C340F8;
        Wed,  9 Mar 2022 16:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646843166;
        bh=xAX3loMR5mPRaq31kqGAqN9kE+3WU6JXu+F/CbN4ztE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cHezaA7+FaZ9/9/JXE10AaJn5SGnujYa8r0TBiSTSMjpVLd6FgGqj+/+mTdoXKczg
         5qxUi4Y/9WamrgAsIJCxwjn9MbCHjvButGknWXctWuNT3STd69kXjngl+pUnJ3pnMw
         90nvJghycuNHngy0hcUb7gq33WTgL/oFErWwbM8RLaIeZgc4Q3HLtk51TX1Am1BMus
         2uoAGVRtnPhQQQQnTqSAsqOEx8Nrcdl3J2yZc7zNQ4v/rPEfV18j0wT+Vgd25yB2pl
         SALShdJLLG+BW3Izwk7A5dJ2+Xz0vNK0FoABhc4biUkWiNC60E3jU5VygwkoV/fsae
         hojgA+83J9IIQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Sasha Levin <sashal@kernel.org>, davem@davemloft.net,
        yoshfuji@linux-ipv6.org, dsahern@kernel.org, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 11/14] tcp: make tcp_read_sock() more robust
Date:   Wed,  9 Mar 2022 11:25:04 -0500
Message-Id: <20220309162508.137035-11-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220309162508.137035-1-sashal@kernel.org>
References: <20220309162508.137035-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit e3d5ea2c011ecb16fb94c56a659364e6b30fac94 ]

If recv_actor() returns an incorrect value, tcp_read_sock()
might loop forever.

Instead, issue a one time warning and make sure to make progress.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Jakub Sitnicki <jakub@cloudflare.com>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/r/20220302161723.3910001-2-eric.dumazet@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/tcp.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 4dce1b418acc..f7795488b0ad 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1669,11 +1669,13 @@ int tcp_read_sock(struct sock *sk, read_descriptor_t *desc,
 				if (!copied)
 					copied = used;
 				break;
-			} else if (used <= len) {
-				seq += used;
-				copied += used;
-				offset += used;
 			}
+			if (WARN_ON_ONCE(used > len))
+				used = len;
+			seq += used;
+			copied += used;
+			offset += used;
+
 			/* If recv_actor drops the lock (e.g. TCP splice
 			 * receive) the skb pointer might be invalid when
 			 * getting here: tcp_collapse might have deleted it
-- 
2.34.1

