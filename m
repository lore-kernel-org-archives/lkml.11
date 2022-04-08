Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65618C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Apr 2022 21:03:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239619AbiDHVFj (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Apr 2022 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239605AbiDHVFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 17:05:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9866D11C7D7
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 14:03:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2999F61F0D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 21:03:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C3FC385A3;
        Fri,  8 Apr 2022 21:03:30 +0000 (UTC)
Date:   Fri, 8 Apr 2022 17:03:29 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Jeff Xie <xiehuan09@gmail.com>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] tracing: make tp_printk work on syscall tracepoints
Message-ID: <20220408170329.15933f94@gandalf.local.home>
In-Reply-To: <CAEr6+EA-7H4tfpUhZqwLJA=nT+1NgXjwcKYuiqMrrDuC_Bj4hA@mail.gmail.com>
References: <20220329163931.710555-1-xiehuan09@gmail.com>
        <CAEr6+EA-7H4tfpUhZqwLJA=nT+1NgXjwcKYuiqMrrDuC_Bj4hA@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Apr 2022 22:21:18 +0800
Jeff Xie <xiehuan09@gmail.com> wrote:

> Anyone have any suggestions for this patch series? ;-)

Thanks for the reminder. I'll look at them now.

-- Steve
