Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B603C43217
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Apr 2022 09:36:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353942AbiDLJeZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Apr 2022 05:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380244AbiDLJVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:21:09 -0400
X-Greylist: delayed 431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 12 Apr 2022 01:26:32 PDT
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8F338BD9;
        Tue, 12 Apr 2022 01:26:32 -0700 (PDT)
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
        by mail-out.m-online.net (Postfix) with ESMTP id 4KczCJ4Nnwz1r4JD;
        Tue, 12 Apr 2022 10:19:08 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.70])
        by mail.m-online.net (Postfix) with ESMTP id 4KczCJ2GNVz1qty4;
        Tue, 12 Apr 2022 10:19:08 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
        by localhost (dynscan1.mail.m-online.net [192.168.6.70]) (amavisd-new, port 10024)
        with ESMTP id rXjb5LFYsQQh; Tue, 12 Apr 2022 10:19:07 +0200 (CEST)
X-Auth-Info: /mg83ax7YgZuCI0/7BlnjE0KpBKb9OSSgf4yqYyYL/rip/QnkSIDtPEXLMW/Bvw9
Received: from igel.home (ppp-46-244-183-143.dynamic.mnet-online.de [46.244.183.143])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.mnet-online.de (Postfix) with ESMTPSA;
        Tue, 12 Apr 2022 10:19:07 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
        id 2092F2C3625; Tue, 12 Apr 2022 10:19:07 +0200 (CEST)
From:   Andreas Schwab <schwab@linux-m68k.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mikulas Patocka <mpatocka@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] stat: don't fail if the major number is >= 256
References: <alpine.LRH.2.02.2204111023230.6206@file01.intranet.prod.int.rdu2.redhat.com>
        <CAHk-=wijDnLH2K3Rh2JJo-SmWL_ntgzQCDxPeXbJ9A-vTF3ZvA@mail.gmail.com>
        <alpine.LRH.2.02.2204111236390.31647@file01.intranet.prod.int.rdu2.redhat.com>
        <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
X-Yow:  Yow!  Now we can become alcoholics!
Date:   Tue, 12 Apr 2022 10:19:07 +0200
In-Reply-To: <CAHk-=wgsHK4pDDoEgCyKgGyo-AMGpy1jg2QbstaCR0G-v568yg@mail.gmail.com>
        (Linus Torvalds's message of "Mon, 11 Apr 2022 19:37:44 -1000")
Message-ID: <87tuayn284.fsf@igel.home>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 11 2022, Linus Torvalds wrote:

>> For me, the failure happens in cp_compat_stat (I have a 64-bit kernel). In
>> struct compat_stat in arch/x86/include/asm/compat.h, st_dev and st_rdev
>> are compat_dev_t which is 16-bit. But they are followed by 16-bit
>> paddings, so they could be extended.
>
> Ok, that actually looks like a bug.
>
> The compat structure should match the native structure.  Those "u16
> __padX" fields seem to be just a symptom of the bug.

Looks like the move to 32-bit st_[r]dev was never applied to struct
compat_stat, see commit e95b206567 ("[PATCH] struct stat - support
larger dev_t") from tglx/history.git.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
