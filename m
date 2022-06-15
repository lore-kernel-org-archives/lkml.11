Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60E09C43334
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jun 2022 13:54:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348941AbiFONyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jun 2022 09:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347675AbiFONyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 09:54:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0D71213D63
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 06:54:43 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E29CE153B;
        Wed, 15 Jun 2022 06:54:42 -0700 (PDT)
Received: from wubuntu (FVFF764EQ05P.cambridge.arm.com [10.1.32.43])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B6433F73B;
        Wed, 15 Jun 2022 06:54:41 -0700 (PDT)
Date:   Wed, 15 Jun 2022 14:54:39 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Lukasz Luba <lukasz.luba@arm.com>,
        Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com,
        =?utf-8?B?546L56eRIChLZSBXYW5nKQ==?= <Ke.Wang@unisoc.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220615135439.cmdc5kw5dihonphy@wubuntu>
References: <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
 <CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com>
 <20220510145625.t5py7atlhgojsfyf@wubuntu>
 <37357c86-bab7-d0c7-88d0-ace63ccdb6c8@arm.com>
 <20220510184436.fdgzzcfqqevinx5p@wubuntu>
 <0505936e-3746-4623-a967-103a0158bfbd@arm.com>
 <CAB8ipk8RUsxYs6JdeMeUPADQRNqT=Jqz15ecwbzbf0RHUDqOXg@mail.gmail.com>
 <20220514235513.jm7ul2y6uddj6eh2@airbuntu>
 <20220615101316.tzexnp3dl2cqfbrj@wubuntu>
 <CAB8ipk8tgKDeESzKGjts=8MVvb=bWr6WYN6xetczRRYp4sYWSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk8tgKDeESzKGjts=8MVvb=bWr6WYN6xetczRRYp4sYWSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/15/22 19:17, Xuewen Yan wrote:
> Hi Qais
> 
> Sorry for the late action.
> I've had higher priority work lately and haven't had more energy to
> work on the patch for a while.

No problem.

> Could you test the patch? I will also work on this patch asap.

I did run some tests on the patch. I wanted a confirmation it fixes your
problem though before taking this any further.


Thanks

--
Qais Yousef
