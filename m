Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E733C3527B
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387884AbiDLJM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358685AbiDLHmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 03:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9C53A78;
        Tue, 12 Apr 2022 00:18:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D16A6177A;
        Tue, 12 Apr 2022 07:18:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87581C385AB;
        Tue, 12 Apr 2022 07:18:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649747926;
        bh=5JSIA/Lvh8ph+aTBot7Q4dH+1Hwb/0nwpJ+yIcQqTJQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XVxztg9UYQwNbyKZQcjFaGR+g73vGdwAGHcJC5JsPFTpREMVgczm9D/uRttYKjka5
         f/BDD/VJagAxlj9d3ldjEeOOXS+OvGFR1R1J225rU+ydkW82TkTBQqvS5lxGvscXbs
         nJA30ue/+NH/codpbk2can6FiNfTjlJdG9HMsmxs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.17 256/343] SUNRPC: Handle low memory situations in call_status()
Date:   Tue, 12 Apr 2022 08:31:14 +0200
Message-Id: <20220412062958.716975511@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220412062951.095765152@linuxfoundation.org>
References: <20220412062951.095765152@linuxfoundation.org>
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
index bf1fd6caaf92..0222ad4523a9 100644
--- a/net/sunrpc/clnt.c
+++ b/net/sunrpc/clnt.c
@@ -2364,6 +2364,11 @@ call_status(struct rpc_task *task)
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



