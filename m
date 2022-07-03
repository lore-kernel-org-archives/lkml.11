Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871CEC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Jul 2022 23:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232305AbiGCXRB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Jul 2022 19:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiGCXRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:17:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD06B5FE3;
        Sun,  3 Jul 2022 16:16:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F97DB80CE5;
        Sun,  3 Jul 2022 23:16:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B5EC341C6;
        Sun,  3 Jul 2022 23:16:56 +0000 (UTC)
Date:   Sun, 3 Jul 2022 19:16:54 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     David Ahern <dsahern@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Subject: Re: [PATCH] tracing/ipv4/ipv6: Give size to name field in
 fib*_lookup_table event
Message-ID: <20220703191654.082db731@gandalf.local.home>
In-Reply-To: <5f25dd4a-7394-cf97-4fc8-c43f0c449fc7@gmail.com>
References: <20220703102359.30f12e39@rorschach.local.home>
        <5f25dd4a-7394-cf97-4fc8-c43f0c449fc7@gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Jul 2022 13:03:20 -0600
David Ahern <dsahern@gmail.com> wrote:


> > Alternatively, if the intent was to use a fixed size, then it should be
> > converted into __array() of type char, which will remove the meta data in
> > the event that stores the size.  
> 
> I would prefer this option over duplicating the all of the checks to
> save 14B.

That's why I mentioned the alternative. To give you that option.

I'll send a v2 later that uses the static array.

-- Steve

