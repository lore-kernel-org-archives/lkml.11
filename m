Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89085C47081
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 10:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353495AbiDEKH6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 06:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240988AbiDEIcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:32:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46DA27E1;
        Tue,  5 Apr 2022 01:25:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BB60060FF5;
        Tue,  5 Apr 2022 08:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2B7C385A2;
        Tue,  5 Apr 2022 08:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649147141;
        bh=5zlb1hptJ2v/BAudDlnKXkagzh8LBcBz6czfaqR09DE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VQulTGc140I3uQ7TOA+UU19vLg8DQ6qCaC6nKuO0ISgdi4eMNxhCHEumqNTeeiJsY
         AOOovy7D4VaaiYWPCYJBRj4MAh8qB3ywsdW3aniH0T7uNa8xWe3bggqGFx8VRldzqU
         uZsZH/QQNGJPWURhVYa3iM/sU324HuoqyrqWlwz4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Wang Hai <wanghai38@huawei.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.17 1017/1126] wireguard: socket: free skb in send6 when ipv6 is disabled
Date:   Tue,  5 Apr 2022 09:29:24 +0200
Message-Id: <20220405070437.337693548@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Hai <wanghai38@huawei.com>

commit bbbf962d9460194993ee1943a793a0a0af4a7fbf upstream.

I got a memory leak report:

unreferenced object 0xffff8881191fc040 (size 232):
  comm "kworker/u17:0", pid 23193, jiffies 4295238848 (age 3464.870s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff814c3ef4>] slab_post_alloc_hook+0x84/0x3b0
    [<ffffffff814c8977>] kmem_cache_alloc_node+0x167/0x340
    [<ffffffff832974fb>] __alloc_skb+0x1db/0x200
    [<ffffffff82612b5d>] wg_socket_send_buffer_to_peer+0x3d/0xc0
    [<ffffffff8260e94a>] wg_packet_send_handshake_initiation+0xfa/0x110
    [<ffffffff8260ec81>] wg_packet_handshake_send_worker+0x21/0x30
    [<ffffffff8119c558>] process_one_work+0x2e8/0x770
    [<ffffffff8119ca2a>] worker_thread+0x4a/0x4b0
    [<ffffffff811a88e0>] kthread+0x120/0x160
    [<ffffffff8100242f>] ret_from_fork+0x1f/0x30

In function wg_socket_send_buffer_as_reply_to_skb() or wg_socket_send_
buffer_to_peer(), the semantics of send6() is required to free skb. But
when CONFIG_IPV6 is disable, kfree_skb() is missing. This patch adds it
to fix this bug.

Signed-off-by: Wang Hai <wanghai38@huawei.com>
Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireguard/socket.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/wireguard/socket.c
+++ b/drivers/net/wireguard/socket.c
@@ -160,6 +160,7 @@ out:
 	rcu_read_unlock_bh();
 	return ret;
 #else
+	kfree_skb(skb);
 	return -EAFNOSUPPORT;
 #endif
 }


