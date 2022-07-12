Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E44C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jul 2022 01:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiGLBQu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 21:16:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGLBQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 21:16:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56C0133432
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 18:16:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 06745B81628
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:16:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8060AC34115;
        Tue, 12 Jul 2022 01:16:41 +0000 (UTC)
Date:   Mon, 11 Jul 2022 21:16:39 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Schspa Shi <schspa@gmail.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] sched/rt: fix bad task migration for rt tasks
Message-ID: <20220711211639.6c714635@gandalf.local.home>
In-Reply-To: <m2edyrnny9.fsf@gmail.com>
References: <20220708211755.73637-1-schspa@gmail.com>
        <20220708172614.14191089@gandalf.local.home>
        <m2v8s7mg78.fsf@gmail.com>
        <20220711161037.06b8c1ea@gandalf.local.home>
        <m2edyrnny9.fsf@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Jul 2022 08:53:56 +0800
Schspa Shi <schspa@gmail.com> wrote:

> How about to change this to 
> 
> 			/*
> 			 * We had to unlock the run queue. In
> 			 * the mean time, task could have
> 			 * migrated already or had its affinity changed.
> 			 * Also make sure that it wasn't scheduled on its rq.
> 			 * It is possible the task was scheduled, set
>              * "migrate_disabled" and then got preempted, And we
>              * check task migration disable flag here too.
> 			 */

That's better. But of course it needs better formatting ;-)

-- Steve
