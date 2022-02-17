Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4ED2C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Feb 2022 10:50:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239349AbiBQKvD (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Feb 2022 05:51:03 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237741AbiBQKu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:50:58 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 346081ED1E7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:50:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F36F0D6E;
        Thu, 17 Feb 2022 02:50:43 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AF8093F66F;
        Thu, 17 Feb 2022 02:50:42 -0800 (PST)
Subject: Re: [PATCH] sched: Fix yet more sched_fork() races
To:     Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Borislav Petkov <bp@suse.de>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        zhangqiao22@huawei.com, tj@kernel.org
References: <Ygj7feK+vdtPw6zj@zn.tnic>
 <CAHk-=wiHUWHHcPLCvyXQKf2wbL3L1SOQSGVuCdf-py6QZGnuqQ@mail.gmail.com>
 <YgoWoh6pIzlsQx6d@hirez.programming.kicks-ass.net>
 <YgoeCbwj5mbCR0qA@hirez.programming.kicks-ass.net>
 <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <e6f7de1e-330e-5b2a-f937-d8e9f9a32316@arm.com>
Date:   Thu, 17 Feb 2022 11:50:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Yg4MdYLBqiw8zFaF@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/02/2022 09:51, Peter Zijlstra wrote:
> On Mon, Feb 14, 2022 at 10:16:57AM +0100, Peter Zijlstra wrote:
>> Zhang, Tadeusz, TJ, how does this look?
> 
> *sigh* I was hoping for some Tested-by, since I've no idea how to
> operate this cgroup stuff properly.

At least the reproducer from
https://syzkaller.appspot.com/bug?id=9d9c27adc674e3a7932b22b61c79a02da82cbdc1
doesn't barf with this patch but it does on 5.17-rc2 on Arm64 Juno-r0.

sched: Fix yet more sched_fork() races (2022-02-17 Peter Zijlstra)
13765de8148f - sched/fair: Fix fault in reweight_entity (2022-02-06
Tadeusz Struk)
26291c54e111 - Linux 5.17-rc2 (2022-01-30 Linus Torvalds)

Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>

[...]
