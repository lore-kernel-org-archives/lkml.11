Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34F8C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 12:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240487AbiCGMOy (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:14:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235118AbiCGMOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 07:14:50 -0500
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC7524D9F4
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 04:13:55 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04407;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V6VlUYF_1646655231;
Received: from 30.240.98.128(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0V6VlUYF_1646655231)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 07 Mar 2022 20:13:52 +0800
Message-ID: <a31431bf-24bb-71ac-8f3c-f9ca19f5c4f0@linux.alibaba.com>
Date:   Mon, 7 Mar 2022 20:13:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:98.0)
 Gecko/20100101 Thunderbird/98.0
Subject: Re: [PATCH RFC] arm64: improve display about CPU architecture in
 cpuinfo
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     catalin.marinas@arm.com, will@kernel.org, joey.gouly@arm.com,
        mark.rutland@arm.com, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220307030417.22974-1-rongwei.wang@linux.alibaba.com>
 <87h78a178u.wl-maz@kernel.org>
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
In-Reply-To: <87h78a178u.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/7/22 4:45 PM, Marc Zyngier wrote:
> On Mon, 07 Mar 2022 03:04:17 +0000,
> Rongwei Wang <rongwei.wang@linux.alibaba.com> wrote:
>>
>> Now, it is unsuitable for both ARMv8 and ARMv9 to show a
>> fixed string "CPU architecture: 8" in /proc/cpuinfo.
> 
> Please read the various threads that have been going on over the past
> 10+ years about *why* we don't allow this sort of change (TL;DR: it
> breaks userspace, and we don't do that).
> 
> Also, there is no material difference between v8 and v9 that would be
> observable from userspace outside of the "Features:" line. And if that
> doesn't convince you, just think of '8' as the number of bytes used byI got your point. It seems that we can regard '8' as the number of 
bytes. But what make me do this is that 'CPU architecture: 8' is 
confusing, especially those responsible for testing.
And I believe that most people regard this '8' as ARMv8, maybe not.

In fact, I'm not sure it has potential ABI implications, so seek your 
advice.

Thanks!
> a virtual address. You can't make that a '9'. Yet.
> 
> 	M.
> 
