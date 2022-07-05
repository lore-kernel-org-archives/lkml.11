Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADE5CCA47B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Jul 2022 14:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232893AbiGEOKQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Jul 2022 10:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiGEOJp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 10:09:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C26644B;
        Tue,  5 Jul 2022 07:00:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 23F1FB817DF;
        Tue,  5 Jul 2022 14:00:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129E6C341C7;
        Tue,  5 Jul 2022 14:00:42 +0000 (UTC)
Date:   Tue, 5 Jul 2022 10:00:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>
Subject: Re: [PATCH v2] tracing/ipv4/ipv6: Use static array for name field
 in fib*_lookup_table event
Message-ID: <20220705100041.01a8c184@rorschach.local.home>
In-Reply-To: <38135333-b277-1b1b-8346-1da2e1f114a7@gmail.com>
References: <20220704091436.3705edbf@rorschach.local.home>
        <38135333-b277-1b1b-8346-1da2e1f114a7@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Jul 2022 13:09:01 -0600
David Ahern <dsahern@gmail.com> wrote:

> >  include/trace/events/fib.h  | 6 +++---
> >  include/trace/events/fib6.h | 8 ++++----
> >  2 files changed, 7 insertions(+), 7 deletions(-)
> >   
> 
> Reviewed-by: David Ahern <dsahern@kernel.org>
> 

Is everyone OK if I take this through my tree then?

I'm fine if it goes through net-next too.

-- Steve
