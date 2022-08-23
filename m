Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9702EC32772
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 09:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347334AbiHWJCR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 05:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240444AbiHWJBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 05:01:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA8D383054;
        Tue, 23 Aug 2022 01:28:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C2F361494;
        Tue, 23 Aug 2022 08:27:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6D1C433C1;
        Tue, 23 Aug 2022 08:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661243233;
        bh=PTSYZ9FApOOBJKtWbi9ijKt7DTtB+H8+ux8d997unJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LMVgb3pmmyU449SVqw4vMLqnBwy4N8fzyfacpxoJPVkPKUpcnT9Cyu2m14SIDFWz4
         m5l99GuDD9guNRVUDXaY8wIJaDQgDUBPF5HmELwyHfW8LxPmzvV9bqGjNGhdPtmMaM
         KWEqewzTNkVClF4vAywVomBdDS2fAf8n84F7JfpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Zhengchao Shao <shaozhengchao@huawei.com>,
        Nikolay Aleksandrov <razor@blackwall.org>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.19 212/365] net: rtnetlink: fix module reference count leak issue in rtnetlink_rcv_msg
Date:   Tue, 23 Aug 2022 10:01:53 +0200
Message-Id: <20220823080127.075499596@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080118.128342613@linuxfoundation.org>
References: <20220823080118.128342613@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhengchao Shao <shaozhengchao@huawei.com>

commit 5b22f62724a0a09e00d301abf5b57b0c12be8a16 upstream.

When bulk delete command is received in the rtnetlink_rcv_msg function,
if bulk delete is not supported, module_put is not called to release
the reference counting. As a result, module reference count is leaked.

Fixes: a6cec0bcd342 ("net: rtnetlink: add bulk delete support flag")
Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>
Link: https://lore.kernel.org/r/20220815024629.240367-1-shaozhengchao@huawei.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/rtnetlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index ac45328607f7..4b5b15c684ed 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -6070,6 +6070,7 @@ static int rtnetlink_rcv_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (kind == RTNL_KIND_DEL && (nlh->nlmsg_flags & NLM_F_BULK) &&
 	    !(flags & RTNL_FLAG_BULK_DEL_SUPPORTED)) {
 		NL_SET_ERR_MSG(extack, "Bulk delete is not supported");
+		module_put(owner);
 		goto err_unlock;
 	}
 
-- 
2.37.2



