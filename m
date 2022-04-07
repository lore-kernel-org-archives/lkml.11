Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E26CC433EF
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Apr 2022 15:13:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344501AbiDGPPY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Apr 2022 11:15:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237149AbiDGPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF570198954;
        Thu,  7 Apr 2022 08:13:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F39B61DFB;
        Thu,  7 Apr 2022 15:13:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEFBEC385A4;
        Thu,  7 Apr 2022 15:13:20 +0000 (UTC)
Date:   Thu, 7 Apr 2022 11:13:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: runtime warning after merge of the cel-fixes tree
Message-ID: <20220407111318.649f908d@gandalf.local.home>
In-Reply-To: <20220407105446.186114c3@gandalf.local.home>
References: <20220407144524.2a592ed6@canb.auug.org.au>
        <F83867B8-2737-4850-83A6-13B95973A0BB@oracle.com>
        <20220407105446.186114c3@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Apr 2022 10:54:46 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, I know we added code to handle "__get_sockaddr()" but I guess this
> should also be fine for "__get_dynamic_array()" as well.

Does the below patch fix it?

(not even compiled tested)

-- Steve

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index e11e167b7809..043b80f3e19a 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -392,8 +392,9 @@ static void test_event_printk(struct trace_event_call *call)
 			if (!(dereference_flags & (1ULL << arg)))
 				goto next_arg;
 
-			/* Check for __get_sockaddr */;
-			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
+			/* Check for __get_sockaddr or __get_dynamic_array */;
+			if (str_has_prefix(fmt + i, "__get_sockaddr(") ||
+			    str_has_prefix(fmt + i, "__get_dynamic_array(")) {
 				dereference_flags &= ~(1ULL << arg);
 				goto next_arg;
 			}
