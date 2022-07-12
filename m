Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F16BCC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 13:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233356AbiGLNxb (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jul 2022 09:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiGLNxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:53:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C63B5D2C
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515E161857
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 13:53:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77FDCC3411C;
        Tue, 12 Jul 2022 13:53:27 +0000 (UTC)
Date:   Tue, 12 Jul 2022 09:53:25 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        zhaohui.shi@horizon.ai
Subject: Re: [PATCH v5 1/2] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220712095325.408d1730@gandalf.local.home>
In-Reply-To: <20220712013125.623338-1-schspa@gmail.com>
References: <20220712013125.623338-1-schspa@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 09:31:24 +0800
Schspa Shi <schspa@gmail.com> wrote:

> @@ -1998,11 +1998,15 @@ static struct rq *find_lock_lowest_rq(struct task_struct *task, struct rq *rq)
>  			 * the mean time, task could have
>  			 * migrated already or had its affinity changed.
>  			 * Also make sure that it wasn't scheduled on its rq.
> +			 * It is possible the task was scheduled, set
> +			 * "migrate_disabled" and then got preempted, And we
> +			 * check task migration disable flag here too.

Nit.  "got preempted, so we must check the task migration disable flag here
too".

But other than that.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

>  			 */
