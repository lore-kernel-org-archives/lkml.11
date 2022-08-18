Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 241B5C00140
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Aug 2022 23:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244251AbiHRX2q (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Aug 2022 19:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbiHRX2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 19:28:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE87BC13E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 16:28:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C50D261753
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:28:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A21B9C433D6;
        Thu, 18 Aug 2022 23:28:41 +0000 (UTC)
Date:   Thu, 18 Aug 2022 19:28:52 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Abhishek Shah <abhishek.shah@columbia.edu>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        Gabriel Ryan <gabe@cs.columbia.edu>
Subject: Re: data-race in pcpu_alloc / pcpu_nr_pages
Message-ID: <20220818192852.0934313f@gandalf.local.home>
In-Reply-To: <CAEHB248ZfrhSr3V3Ag59fCPoBmm+O==mFrgq7xQipoSgew_Row@mail.gmail.com>
References: <CAEHB248ZfrhSr3V3Ag59fCPoBmm+O==mFrgq7xQipoSgew_Row@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Aug 2022 18:29:00 -0400
Abhishek Shah <abhishek.shah@columbia.edu> wrote:

> Hi all,
> 
> We found a race involving the *pcpu_nr_populated *variable. We discovered
> that the racing variable is used in meminfo_proc_show
> <https://elixir.bootlin.com/linux/v5.18-rc5/source/fs/proc/meminfo.c#L123>,
> but we were not sure if there were other security-relevant implications of
> this race. Please let us know what you think.

So you see that the number displayed in meminfo can be written to while
it's being read?  As it's a long value, it is likely to be accurate (the
value before or after the update). pcpu_nr_pages() is only used to display
the number of pages in meminfo.

I don't see any problem here.

-- Steve
