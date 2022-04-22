Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDADC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Apr 2022 18:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiDVSzP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Apr 2022 14:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiDVSzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 14:55:12 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 994A9202B50
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 11:47:51 -0700 (PDT)
Received: from [2a02:8108:963f:de38:6624:6d8d:f790:d5c]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1nhyGQ-0006dR-Ga; Fri, 22 Apr 2022 20:44:18 +0200
Message-ID: <56ac17fd-5f13-840c-09d8-03363af94520@leemhuis.info>
Date:   Fri, 22 Apr 2022 20:44:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: PANIC: "Oops: 0000 [#1] PREEMPT SMP PTI" starting from 5.17 on
 dual socket Intel Xeon Gold servers
Content-Language: en-US
To:     Minchan Kim <minchan@kernel.org>
Cc:     Jirka Hladky <jhladky@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        regressions@lists.linux.dev,
        Justin Forbes <jforbes@fedoraproject.org>,
        Tejun Heo <tj@kernel.org>
References: <CAE4VaGBZk2NL6Tn2fGxmGMR-n8KFNqgPOktY_sQ1vjViLDNhhg@mail.gmail.com>
 <CAE4VaGB4=aCd8iDb4EduR+-5QTSgVWd5sxrnBA4e3g9dPrnuBg@mail.gmail.com>
 <YkTxox8ZQIDtojfU@google.com>
 <CAFxkdAq6r2WnwML-pPfdZiajaYZCEcUU3GrXW=+wsA7CxGnJdQ@mail.gmail.com>
 <CAE4VaGBchOMWeHQ8GKiGFv_aCaNGLEvSdLWXZTpE+qC=0bgM3A@mail.gmail.com>
 <YkY6W1NS+1RTw0VB@google.com>
 <CAE4VaGDAMZqjwumyvbityzEiK30=5a5vuDMjaS+UHM39R-oPRw@mail.gmail.com>
 <YkstxbC3OfzYnSRw@google.com>
 <CAE4VaGAQZcQzN8D+iwcBnP5vY=Ctmbh+oTikvONHir6JjTgpsw@mail.gmail.com>
 <YmGKrd1BR9HSEy6q@slm.duckdns.org> <YmLznjFdpblHzZiM@google.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <YmLznjFdpblHzZiM@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1650653271;d77986d0;
X-HE-SMSGID: 1nhyGQ-0006dR-Ga
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22.04.22 20:27, Minchan Kim wrote:
> On Thu, Apr 21, 2022 at 06:47:41AM -1000, Tejun Heo wrote:
> [...]

Many thx for looking into this.

> Jirka, Could you test the patch? Once it's confirmed, I need to resend
> it with Ccing stable.

When you do so, could you please include a proper "Link:" tag pointing
to all reports of the regression, as explained in the Linux kernels
documentation (see 'Documentation/process/submitting-patches.rst' and
'Documentation/process/5.Posting.rst'). E.g. in this case:

Link: https://bugzilla.kernel.org/show_bug.cgi?id=215696
Link:
https://lore.kernel.org/lkml/CAE4VaGDZr_4wzRn2___eDYRtmdPaGGJdzu_LCSkJYuY9BEO3cw@mail.gmail.com/

This concept is not new (Linus and quite a few other developers use them
like this for a long time), I just recently improved those documents to
clarify things, as my regression tracking efforts rely on this (and
there might be other people and software out there that does) -- that's
why it's making my work a lot harder if such tags are missing. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

P.S.: As the Linux kernel's regression tracker I'm getting a lot of
reports on my table. I can only look briefly into most of them and lack
knowledge about most of the areas they concern. I thus unfortunately
will sometimes get things wrong or miss something important. I hope
that's not the case here; if you think it is, don't hesitate to tell me
in a public reply, it's in everyone's interest to set the public record
straight.

> [...]
