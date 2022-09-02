Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECACC38145
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Sep 2022 13:40:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236927AbiIBNkY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Sep 2022 09:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236846AbiIBNjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 09:39:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40324F8FE7;
        Fri,  2 Sep 2022 06:17:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 512616220E;
        Fri,  2 Sep 2022 12:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F54C433C1;
        Fri,  2 Sep 2022 12:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1662122407;
        bh=l55iIEOTa99MJyVj0bZkhMqp2quVOE9KQuUvpsRy65E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1Q925U9h01tRQO8xaxutTCu9bHx00BIk/aU7j9IXuEdHwtu5hmQTZ/oKq4Uzdenx
         AwOp7HtpOVzTgzfNIRY/CpR051ZWZ/ekoqnQQxs95TECkffacvCfEQ02j4A1yUJmd5
         UPo9gAVG8wchLX622nor8kts5qSqxMKae5cpIXGM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.10 36/37] net/af_packet: check len when min_header_len equals to 0
Date:   Fri,  2 Sep 2022 14:19:58 +0200
Message-Id: <20220902121400.298585305@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220902121359.177846782@linuxfoundation.org>
References: <20220902121359.177846782@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

commit dc633700f00f726e027846a318c5ffeb8deaaeda upstream.

User can use AF_PACKET socket to send packets with the length of 0.
When min_header_len equals to 0, packet_snd will call __dev_queue_xmit
to send packets, and sock->type can be any type.

Reported-by: syzbot+5ea725c25d06fb9114c4@syzkaller.appspotmail.com
Fixes: fd1894224407 ("bpf: Don't redirect packets with invalid pkt_len")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/packet/af_packet.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2986,8 +2986,8 @@ static int packet_snd(struct socket *soc
 	if (err)
 		goto out_free;
 
-	if (sock->type == SOCK_RAW &&
-	    !dev_validate_header(dev, skb->data, len)) {
+	if ((sock->type == SOCK_RAW &&
+	     !dev_validate_header(dev, skb->data, len)) || !skb->len) {
 		err = -EINVAL;
 		goto out_free;
 	}


