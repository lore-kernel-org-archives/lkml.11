Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 412A6C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 08:17:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242562AbiHWIR4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 04:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242517AbiHWIL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:11:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8086170A;
        Tue, 23 Aug 2022 01:08:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8D06611A8;
        Tue, 23 Aug 2022 08:08:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD78CC433D6;
        Tue, 23 Aug 2022 08:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661242119;
        bh=yXT7p9wh4HXbnK7OLAUNhB3dmPOuBMTo6K5JG9vx2iU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ssVVp2w7rKbcc6Kg38OK/17GwbmAuPpsYnYBKgn9srLdqwGi57jBfai7a3Kl7pkDg
         qVi30VZrE6dIelkopBc6WJfkpOFJka/bsdjX8tYRUZ8NXpIhwXTmcqQj2RGSKAESzJ
         YPgsGtjltEdDiKCycYlvC/EVjrwzzvwl+opiRvMY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Tom Zanussi <zanussi@kernel.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        "Steven Rostedt (Google)" <rostedt@goodmis.org>
Subject: [PATCH 5.19 036/365] tracing: Have filter accept "common_cpu" to be consistent
Date:   Tue, 23 Aug 2022 09:58:57 +0200
Message-Id: <20220823080119.705956620@linuxfoundation.org>
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

From: Steven Rostedt (Google) <rostedt@goodmis.org>

commit b2380577d4fe1c0ef3fa50417f1e441c016e4cbe upstream.

Make filtering consistent with histograms. As "cpu" can be a field of an
event, allow for "common_cpu" to keep it from being confused with the
"cpu" field of the event.

Link: https://lkml.kernel.org/r/20220820134401.513062765@goodmis.org
Link: https://lore.kernel.org/all/20220820220920.e42fa32b70505b1904f0a0ad@kernel.org/

Cc: stable@vger.kernel.org
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Cc: Tom Zanussi <zanussi@kernel.org>
Fixes: 1e3bac71c5053 ("tracing/histogram: Rename "cpu" to "common_cpu"")
Suggested-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 kernel/trace/trace_events.c |    1 +
 1 file changed, 1 insertion(+)

--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -176,6 +176,7 @@ static int trace_define_generic_fields(v
 
 	__generic_field(int, CPU, FILTER_CPU);
 	__generic_field(int, cpu, FILTER_CPU);
+	__generic_field(int, common_cpu, FILTER_CPU);
 	__generic_field(char *, COMM, FILTER_COMM);
 	__generic_field(char *, comm, FILTER_COMM);
 


