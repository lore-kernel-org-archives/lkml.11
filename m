Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0786EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jun 2022 15:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377973AbiFPPeI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 11:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236304AbiFPPeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:34:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54E7D2DAA3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:34:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 040AFB8247C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 15:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 470C7C34114;
        Thu, 16 Jun 2022 15:34:02 +0000 (UTC)
Date:   Thu, 16 Jun 2022 11:34:00 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: possible trace_printk() bug in v5.19-rc1
Message-ID: <20220616113400.15335d91@gandalf.local.home>
In-Reply-To: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
References: <F6C267B0-83EA-4151-A4EC-44482AC52C59@oracle.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jun 2022 15:22:26 +0000
Chuck Lever III <chuck.lever@oracle.com> wrote:

> Hi Steve-
> 
> Since v5.19-rc1, trace_printk() no longer displays a function
> name, but rather a kernel address. I don't have time at the
> moment to track this down to a specific commit, just parking
> it here in case someone can get to it sooner than me.
> 
>           <idle>-0     [003]   269.397568: bprint:               0xffffffffc0cccab7: nf=0xffff888172dbfba0 still on the LRU or a dispose list
>           <idle>-0     [003]   269.397576: bprint:               0xffffffffc0cccafa: nf=0xffff888172dbfba0
>           <idle>-0     [003]   269.397583: bprint:               0xffffffffc0cccab7: nf=0xffff8881726cd4d8 still on the LRU or a dispose list
>           <idle>-0     [003]   269.397584: bprint:               0xffffffffc0cccafa: nf=0xffff8881726cd4d8
> 

It uses the normal vsprintf() in the kernel (that is, it prints the
function address just like printk() does with %pS). So if trace_printk() is
broken, then so is printk().

But one reason for this is if you have a trace_printk() in a module, do the
record, and then remove the module. The function name will also be removed
from kallsyms, leaving you with only the function address.

Did you remove any modules before displaying the trace?

-- Steve
