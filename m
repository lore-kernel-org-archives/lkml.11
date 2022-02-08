Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F32C433EF
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Feb 2022 15:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381886AbiBHPsL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Feb 2022 10:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381833AbiBHPsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 10:48:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFD4C061576
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 07:48:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3CE186164A
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 15:48:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00DDCC004E1;
        Tue,  8 Feb 2022 15:48:07 +0000 (UTC)
Date:   Tue, 8 Feb 2022 10:48:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Jeff Xie <xiehuan09@gmail.com>, mingo@redhat.com,
        zanussi@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 0/4] trace: Introduce objtrace trigger to trace the
 kernel object
Message-ID: <20220208104806.5272f2ea@gandalf.local.home>
In-Reply-To: <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
References: <20220204035644.734878-1-xiehuan09@gmail.com>
        <20220208230830.6b8c03c0f4f11c1ed18da236@kernel.org>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Feb 2022 23:08:30 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> Thanks for updating the series. I've tested the patches and confirmed
> the objtrace is working :)
> 
> Tested-by: Masami Hiramatsu <mhiramat@kernel.org>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> 
> for the series.

Thanks. Just to give you an update on my own workload.

I'm finishing my last week of on-boarding, and hopefully, I'll have more
time next week to look at more things upstream. And hopefully, I'll be able
to get to looking at this series then.

Cheers,

-- Steve
