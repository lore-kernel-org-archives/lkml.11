Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EEEC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Feb 2022 18:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232012AbiBUSpS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Feb 2022 13:45:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbiBUSod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 13:44:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18105D83;
        Mon, 21 Feb 2022 10:44:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC54C61500;
        Mon, 21 Feb 2022 18:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 790CFC340E9;
        Mon, 21 Feb 2022 18:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645469048;
        bh=N8byXcetwAxj2jN//6lTgsMjjsQ2MQ95vI/QBrqz184=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ctXUb7UMGVcyM9oo9+y6ws2gR30oQG6qUv10GaXvjtSSsCXCn6OWQU7E1EPTaaR23
         vOGzjWYnnAtb7kEs7EtR3oIlS9YWjzSfZN2aIqC06likivvMFrDS1nWR/2eW5VfQdf
         nYalfO1Pyzj+ZeZUgbynSncub4khwTBcf+lgFY43V6deCUHV2KlsrKR4GZxqDyD2oh
         bZbGYxiyCu+Y//1R5xsrkP5AMnUUT3zTD4W8Vvg4Z3LNv3nZY5LxBq1UbByYJ60UTW
         AkdpSXt6fkBLwW2EAkVKTjeOp0biGNZLb38dSsFFHxhMpriqabKGOB1pvzQqxH4eso
         CzcaOT9alyRlQ==
Message-ID: <6ac2e2c8-798a-2b52-43f4-a4d940b39e2d@kernel.org>
Date:   Mon, 21 Feb 2022 10:44:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 0/8] kernel/fork: Move thread stack free otu of the
 scheduler path.
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
References: <20220217102406.3697941-1-bigeasy@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
In-Reply-To: <20220217102406.3697941-1-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/17/22 02:23, Sebastian Andrzej Siewior wrote:
> This is a follup-up on the patch
>      sched: Delay task stack freeing on RT
>      https://lkml.kernel.org/r/20210928122411.593486363@linutronix.de
> 
> It addresses the review feedback:
> - Decouple stack accounting from its free invocation. The accounting
>    happens in do_exit(), the final free call happens later.
> 
> - Add put_task_stack_sched() to finish_task_switch(). Here the VMAP
>    stack is cached only. If it fails, or in the !VMAP case then the final
>    free happens in delayed_put_task_struct(). This is also an oportunity
>    to cache the stack.
> 
> Changes since v1:
>    - Drop the bit marked und use addtional RCU head to free the stack in
>    case that it can't be cached. Suggested by Andy Lutomirski.

Acked-by: Andy Lutomirski <luto@kernel.org>

This version is much nicer.  Thanks!

--Andy
