Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7735C00140
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Aug 2022 21:15:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239081AbiHOVPU (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Aug 2022 17:15:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347982AbiHOVHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 17:07:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D642E686;
        Mon, 15 Aug 2022 12:17:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1B3A2B8107A;
        Mon, 15 Aug 2022 19:17:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6608DC433C1;
        Mon, 15 Aug 2022 19:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660591036;
        bh=9gl4kRdQ+WLKKQ5khPH9o29OL7Te4TCVWT384FGVGKk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CN/XWQ+SZwtm8+YvOY3yGycumBkpfQgANOH7UjMW5YtEyNtXclLbQbbyjWARF6nUn
         FwUAghLPcdw4ZZiam37Ze/K1zIu4EedGi3PPZuABP1z/gzNSq2asZdxeg5QK2kF0ZL
         Rc1qND5OwxVhNpqUzl+oac/bObRwh9rBlLo59KqM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Jian <liujian56@huawei.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 0451/1095] skmsg: Fix invalid last sg check in sk_msg_recvmsg()
Date:   Mon, 15 Aug 2022 19:57:30 +0200
Message-Id: <20220815180448.289597023@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180429.240518113@linuxfoundation.org>
References: <20220815180429.240518113@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Jian <liujian56@huawei.com>

[ Upstream commit 9974d37ea75f01b47d16072b5dad305bd8d23fcc ]

In sk_psock_skb_ingress_enqueue function, if the linear area + nr_frags +
frag_list of the SKB has NR_MSG_FRAG_IDS blocks in total, skb_to_sgvec
will return NR_MSG_FRAG_IDS, then msg->sg.end will be set to
NR_MSG_FRAG_IDS, and in addition, (NR_MSG_FRAG_IDS - 1) is set to the last
SG of msg. Recv the msg in sk_msg_recvmsg, when i is (NR_MSG_FRAG_IDS - 1),
the sk_msg_iter_var_next(i) will change i to 0 (not NR_MSG_FRAG_IDS), the
judgment condition "msg_rx->sg.start==msg_rx->sg.end" and
"i != msg_rx->sg.end" can not work.

As a result, the processed msg cannot be deleted from ingress_msg list.
But the length of all the sge of the msg has changed to 0. Then the next
recvmsg syscall will process the msg repeatedly, because the length of sge
is 0, the -EFAULT error is always returned.

Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
Signed-off-by: Liu Jian <liujian56@huawei.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: John Fastabend <john.fastabend@gmail.com>
Link: https://lore.kernel.org/bpf/20220628123616.186950-1-liujian56@huawei.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/skmsg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index ede0af308f40..f50f8d95b628 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -462,7 +462,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 
 			if (copied == len)
 				break;
-		} while (i != msg_rx->sg.end);
+		} while (!sg_is_last(sge));
 
 		if (unlikely(peek)) {
 			msg_rx = sk_psock_next_msg(psock, msg_rx);
@@ -472,7 +472,7 @@ int sk_msg_recvmsg(struct sock *sk, struct sk_psock *psock, struct msghdr *msg,
 		}
 
 		msg_rx->sg.start = i;
-		if (!sge->length && msg_rx->sg.start == msg_rx->sg.end) {
+		if (!sge->length && sg_is_last(sge)) {
 			msg_rx = sk_psock_dequeue_msg(psock);
 			kfree_sk_msg(msg_rx);
 		}
-- 
2.35.1



