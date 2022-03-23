Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CDDCC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 19:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344290AbiCWTei (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 15:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344277AbiCWTef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 15:34:35 -0400
Received: from gateway33.websitewelcome.com (gateway33.websitewelcome.com [192.185.146.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8644738BF
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 12:33:05 -0700 (PDT)
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway33.websitewelcome.com (Postfix) with ESMTP id C0AE39F073
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:33:04 -0500 (CDT)
Received: from gator4132.hostgator.com ([192.185.4.144])
        by cmsmtp with SMTP
        id X6jAnKsa6b6UBX6jAnYsvC; Wed, 23 Mar 2022 14:33:04 -0500
X-Authority-Reason: nr=8
Received: from host-79-43-204-123.retail.telecomitalia.it ([79.43.204.123]:49850 helo=[10.0.0.45])
        by gator4132.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bristot@kernel.org>)
        id 1nX6j9-002X2T-Ui; Wed, 23 Mar 2022 14:33:04 -0500
Message-ID: <21ebdc8c-ddf8-cd0a-b93c-5d5dd74a9a84@kernel.org>
Date:   Wed, 23 Mar 2022 20:32:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [GIT PULL] tracing/rtla: Updates to the RTLA tool
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220321103035.564a1df5@gandalf.local.home>
 <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <CAHk-=whxmA86E=csNv76DuxX_wYsg8mW15oUs3XTabu2Yc80yw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4132.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kernel.org
X-BWhitelist: no
X-Source-IP: 79.43.204.123
X-Source-L: No
X-Exim-ID: 1nX6j9-002X2T-Ui
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: host-79-43-204-123.retail.telecomitalia.it ([10.0.0.45]) [79.43.204.123]:49850
X-Source-Auth: kernel@bristot.me
X-Email-Count: 3
X-Source-Cap: YnJpc3RvdG1lO2JyaXN0b3RtZTtnYXRvcjQxMzIuaG9zdGdhdG9yLmNvbQ==
X-Local-Domain: no
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/22 19:15, Linus Torvalds wrote:
> On Mon, Mar 21, 2022 at 7:30 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>>
>> I'm sending this as a separate pull request from my normal tracing tree, as
>> it had dependencies to commits in your tree but not in my development
>> branch. As it only affects the tools/ directory, I kept it separate as it
>> has no changes to the kernel itself.
> 
> Yes, please keep the tooling updates separate from the kernel ones,
> the way we now for some time have for the perf tooling too.
> 
> That said, mentioning the perf tools, I wish the tracing tools would
> do a bit more package checking and helpful error messages too, rather
> than just fail with
> 
>     fatal error: tracefs.h: No such file or directory
> 
> when (presumably) libtracefs and friends are needed.
> 
> Hmm?

Yes, we need to improve the Makefile.

It depends on procps-ng-devel and python3-docutils packages and the latest
libtracefs (1.3) and libtraceevent (1.5). There is info about it in the README,
but we definitely need to improve the Makefile... I will prioritize that.

-- Daniel
>               Linus

