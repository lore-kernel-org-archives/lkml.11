Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F5EDC3527C
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 07:29:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355892AbiDLH3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 03:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240912AbiDLHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:12:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6FA128985;
        Mon, 11 Apr 2022 23:50:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8FE39B81B4D;
        Tue, 12 Apr 2022 06:50:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB201C385A6;
        Tue, 12 Apr 2022 06:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649746210;
        bh=oYrzifBdOmeUMo7V+VlgUhjuhY3Vb/678e/gZ/SW9kE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uJ5VU4GFeOIus+j4qDRms+Crqhaw4uTcC51bxrWaRtoEDB9Bd12ZnqPOMVGJQY/BR
         pcdUjwrJTpGqENuhlNgTeSJx636k9nrdyCSkiy6dwn322umwgHsfrP0ANlZuiTmfQA
         FlypXg2NzgPbaBPsE/sdILfE66OeQew5p4z8Ar/o=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 200/277] SUNRPC: Handle low memory situations in call_status()
Date:   Tue, 12 Apr 2022 08:30:03 +0200
Message-Id: <20220412062947.826851212@linuxfoundation.org>
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

From: Trond Myklebust <trond.myklebust@hammerspace.com>

[ Upstream commit 9d82819d5b065348ce623f196bf601028e22ed00 ]

We need to handle ENFILE, ENOBUFS, and ENOMEM, because
xprt_wake_pending_tasks() can be called with any one of these due to
socket creation failures.

Fixes: b61d59fffd3e ("SUNRPC: xs_tcp_connect_worker{4,6}: merge common code")
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/clnt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/sunrpc/clnt.c b/net/sunrpc/clnt.c
index 9a183c254c84..3286add1a958 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2369,6 +2369,11 @@ call_status(struct rpc_task *task)
 	case -EPIPE:
 	case -EAGAIN:
 		break;
+	case -ENFILE:
+	case -ENOBUFS:
+	case -ENOMEM:
+		rpc_delay(task, HZ>>2);
+		break;
 	case -EIO:
 		/* shutdown or soft timeout */
 		goto out_exit;
-- 
2.35.1



