Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F59C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Apr 2022 02:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348671AbiDOCdI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 22:33:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233911AbiDOCdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 22:33:02 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C24140CD;
        Thu, 14 Apr 2022 19:30:35 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0VA5GlK6_1649989831;
Received: from 30.240.101.97(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0VA5GlK6_1649989831)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 15 Apr 2022 10:30:32 +0800
Message-ID: <3c242430-9f6c-0e04-91fc-10132e88df99@linux.alibaba.com>
Date:   Fri, 15 Apr 2022 10:30:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH] arm64/sme: Add hwcap for Scalable Matrix Extension
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>
Cc:     Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Joey Gouly <joey.gouly@arm.com>,
        Vincenzo Frascino <Vincenzo.Frascino@arm.com>,
        Mark Brown <broonie@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Fuad Tabba <tabba@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220414115544.36204-1-tianjia.zhang@linux.alibaba.com>
 <875ynbc1je.wl-maz@kernel.org>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
In-Reply-To: <875ynbc1je.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 4/14/22 8:06 PM, Marc Zyngier wrote:
> On Thu, 14 Apr 2022 12:55:44 +0100,
> Tianjia Zhang <tianjia.zhang@linux.alibaba.com> wrote:
>>
>> Allow userspace to detect support for SME (Scalable Matrix Extension)
>> by providing a hwcap for it, using the official feature name FEAT_SME,
>> declared in ARM DDI 0487H.a specification.
> 
> Err, not just that, for sure. What does this patch buys you on its
> own, given that the kernel doesn't implement anything yet and that all
> the SME instructions will UNDEF?
> 
> [1] is the real deal.
> 
> Thanks,
> 
> 	M.
> 
> [1] https://lore.kernel.org/r/20220408114328.1401034-1-broonie@kernel.org
> 

Thanks for your suggestion, I have a very simple scenario, I can see
whether the SME feature is supported in cpuinfo, it seems impractical at
the moment.

Kind regards,
Tianjia
