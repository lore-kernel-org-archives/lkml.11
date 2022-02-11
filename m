Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B677C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 23:42:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354279AbiBKXms (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Feb 2022 18:42:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbiBKXmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 18:42:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 845BDA5;
        Fri, 11 Feb 2022 15:42:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1FA65618C1;
        Fri, 11 Feb 2022 23:42:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AFD2C340EB;
        Fri, 11 Feb 2022 23:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644622960;
        bh=dotqGisqT6xom3+yh8EyRGKAr3ZPuPfXjlwiUjg95Ts=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L3v8QvPp3JMZbdQ4ppy6JgyNZgaXGe5VSW78Ipfb6YsDzpX80460JbXGPlSBe+LC2
         tZS1QlBPidxrH2gIImwt01t0tG99p/OMtHvgVqoSkvz6unRe8BJDa28tdqex3ga01+
         iAHlNczc8ZWEzbMRP86WaIU06zb5xRberL88oV5WerAA2K8ZUaCcfYa4q80OJmDSl0
         2LyhZ+C6ZpdiTjrm+LihYt6VVoHf257j1rWUsdGXn147bmqcNEFeCeO9Syz+ekHVLU
         rvn3qb0Nxaa8TPc4pB61rrECoXKaAjL1Qfd5SLFPKZ/fcc1EE4lu10NmnFGv4NJXfd
         vphpBbr28/uMQ==
Message-ID: <8340d413-4951-5e62-ef5f-f396523edac7@kernel.org>
Date:   Fri, 11 Feb 2022 15:42:38 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 2/8] kernel/fork: Duplicate task_struct before stack
 allocation.
Content-Language: en-US
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <20220125152652.1963111-1-bigeasy@linutronix.de>
 <20220125152652.1963111-3-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220125152652.1963111-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/25/22 07:26, Sebastian Andrzej Siewior wrote:
> alloc_thread_stack_node() already populates the task_struct::stack
> member except on IA64. The stack pointer is saved and populated again
> because IA64 needs it and arch_dup_task_struct() overwrites it.

I understand the problem, I think.

> 
> Allocate thread's stack after task_struct has been duplicated as a
> preparation.
> 

But I don't understand this.  How does this patch relate to the problem?

Also, you appear to be missing a change to the free_stack and free_tsk 
code at the end of dup_task_struct().
