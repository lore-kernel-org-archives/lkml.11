Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48DCC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jul 2022 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbiGUPHA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jul 2022 11:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiGUPGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:06:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1123A87219
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:06:52 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 9A1B6339DE;
        Thu, 21 Jul 2022 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1658416010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oSBrM4FdSKRCKBsymNl6arKewQhlbJQ1SN7EpKFfZ0w=;
        b=jygmK9DbdsCtPtWwOlIr22Oe1AR8xr1mPnbGxf9zV/2/FwYYhM/FSacjzhuNv6ZGTUnoB2
        v0wFBNuVFa+3gOuJSYAS6O8t7774cpWCRmK4DugQExOihYzFUYZLKeOkUizabzkZUyyvJZ
        yGbohJ3RS/C2LCfTfXPwrqW1QVrjCgg=
Received: from suse.cz (pathway.suse.cz [10.100.12.24])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4C5F72C14B;
        Thu, 21 Jul 2022 15:06:50 +0000 (UTC)
Date:   Thu, 21 Jul 2022 17:06:49 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Kieran Bingham <kbingham@kernel.org>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH v2] scripts/gdb: fix 'lx-dmesg' on 32 bits arch
Message-ID: <20220721150649.GA23294@pathway.suse.cz>
References: <20220719122831.19890-1-pmladek@suse.com>
 <878ropw7h9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878ropw7h9.fsf@jogness.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-07-19 15:41:30, John Ogness wrote:
> On 2022-07-19, Petr Mladek <pmladek@suse.com> wrote:
> > From: Antonio Borneo <antonio.borneo@foss.st.com>
> >
> ...
> >
> > Query the really used atomic_long_t counter type size.
> >
> > Fixes: e60768311af8 ("scripts/gdb: update for lockless printk ringbuffer")
> > Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > [pmladek@suse.com: Query the really used atomic_long_t counter type size]
> > Tested-by: Antonio Borneo <antonio.borneo@foss.st.com>
> > Link: https://lore.kernel.org/r/20220617143758.137307-1-antonio.borneo@foss.st.com
> 
> Reviewed-by: John Ogness <john.ogness@linutronix.de>

The patch has been committed into printk/linux.git, branch for-5.20.

Best Regards,
Petr
