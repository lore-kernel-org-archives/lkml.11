Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A593C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 14:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbiGEObu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:31:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiGEObs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:31:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29BE921BD
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 07:31:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA00D619C5
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 14:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB72C341C7;
        Tue,  5 Jul 2022 14:31:45 +0000 (UTC)
Date:   Tue, 5 Jul 2022 10:31:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/fair: fix boolreturn.cocci warning
Message-ID: <20220705103143.1ea1d527@rorschach.local.home>
In-Reply-To: <20220705073822.7276-1-jiapeng.chong@linux.alibaba.com>
References: <20220705073822.7276-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue,  5 Jul 2022 15:38:22 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> This was found by coccicheck:
> 
> ./kernel/sched/fair.c:9988:9-10: WARNING: return of 0/1 in function 'imbalanced_active_balance' with return type bool.
> 
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>

As your subject says "fix boolreturn.cocci warning". Can you please?

That is, this change has been presented 10 times before, and every time
it is nacked or ignored. The true fix is to fix boolreturn.cocci to not
warn about this in existing code.

Just in case it wasn't clear. NACK to this change.

-- Steve
