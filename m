Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EFE6C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 11:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238609AbiF0Lvs (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 07:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238315AbiF0LsQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 07:48:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878C5BE27;
        Mon, 27 Jun 2022 04:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 46545B81135;
        Mon, 27 Jun 2022 11:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC00DC3411D;
        Mon, 27 Jun 2022 11:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1656330031;
        bh=UXg+caDZViLDCGGqSC1Tlk6iVf12vqfpXnYzX9ccsA4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PV+GrP+gPHl+MWNlXrjZgy0hAUtQXVefLNZIMc51YCV8WkzqRKe0EMW/EKzotDNt8
         XsmLMjkhBxhtYEouAmyB0+vlhmA4YNiqVbaBvK9cpJhA2cGYjFmkIv8oZhH5/NAPY9
         L8mIJq1ZxApl2iyftHf4GlWv89UuuMFf2/5JWbAU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>,
        Jiri Olsa <jolsa@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.18 061/181] rethook: Reject getting a rethook if RCU is not watching
Date:   Mon, 27 Jun 2022 13:20:34 +0200
Message-Id: <20220627111946.335180096@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220627111944.553492442@linuxfoundation.org>
References: <20220627111944.553492442@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[ Upstream commit c0f3bb4054ef036e5f67e27f2e3cad9e6512cf00 ]

Since the rethook_recycle() will involve the call_rcu() for reclaiming
the rethook_instance, the rethook must be set up at the RCU available
context (non idle). This rethook_recycle() in the rethook trampoline
handler is inevitable, thus the RCU available check must be done before
setting the rethook trampoline.

This adds a rcu_is_watching() check in the rethook_try_get() so that
it will return NULL if it is called when !rcu_is_watching().

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/165461827269.280167.7379263615545598958.stgit@devnote2
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/trace/rethook.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index b56833700d23..c69d82273ce7 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -154,6 +154,15 @@ struct rethook_node *rethook_try_get(struct rethook *rh)
 	if (unlikely(!handler))
 		return NULL;
 
+	/*
+	 * This expects the caller will set up a rethook on a function entry.
+	 * When the function returns, the rethook will eventually be reclaimed
+	 * or released in the rethook_recycle() with call_rcu().
+	 * This means the caller must be run in the RCU-availabe context.
+	 */
+	if (unlikely(!rcu_is_watching()))
+		return NULL;
+
 	fn = freelist_try_get(&rh->pool);
 	if (!fn)
 		return NULL;
-- 
2.35.1



