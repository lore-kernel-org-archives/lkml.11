Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E040C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jul 2022 15:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241283AbiGTPkZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jul 2022 11:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240941AbiGTPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:40:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FD9E0C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:40:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2D99A61CD9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 15:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243FFC3411E;
        Wed, 20 Jul 2022 15:40:12 +0000 (UTC)
Date:   Wed, 20 Jul 2022 11:40:10 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: ftrace_kill() leads to kmalloc-512 UAF
Message-ID: <20220720114010.20d3e0dd@gandalf.local.home>
In-Reply-To: <YtgdsW8UBSwCKtQW@localhost.localdomain>
References: <YtgdsW8UBSwCKtQW@localhost.localdomain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022 18:22:25 +0300
Alexey Dobriyan <adobriyan@gmail.com> wrote:

> Basically, if ftrace_kill() is ever called ever there is a ticking UAFbomb.

That's because ftrace_kill() means something horribly went wrong, and
because ftrace modifies the kernel text, it shuts everything down and this
needs to be fixed.

The fix is not to have something handle ftrace_kill(), it's to fix the
situation so that ftrace_kill() is not called.

Hmm, perhaps we should add an option to make ftrace_kill() call BUG().

I'll go back and take a look at your analysis.

Thanks,

-- Steve
