Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89CEC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 19 May 2022 03:08:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233068AbiESDI5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 May 2022 23:08:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233028AbiESDIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:08:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B76AD9E86
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 20:08:49 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACE9023A;
        Wed, 18 May 2022 20:08:48 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 347F83F73D;
        Wed, 18 May 2022 20:08:45 -0700 (PDT)
Message-ID: <f8b83f8e-eb99-16e4-4e9a-dca58971b437@arm.com>
Date:   Thu, 19 May 2022 08:38:43 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] amba: Drop builtin_amba_driver()
Content-Language: en-US
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Wang Kefeng <wangkefeng.wang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220517062929.3109873-1-anshuman.khandual@arm.com>
 <CAK8P3a3eR-eiY4Y8TNbyQNZiFXoEA8rk5EObZXg-D=JmxjnGCA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAK8P3a3eR-eiY4Y8TNbyQNZiFXoEA8rk5EObZXg-D=JmxjnGCA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/18/22 17:50, Arnd Bergmann wrote:
> On Tue, May 17, 2022 at 7:29 AM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>> Drop builtin_amba_driver() which is not used anymore.
> 
> The patch looks correct, but I don't see the purpose. Are you trying
> to discourage
> having amba drivers as built-in? Otherwise the next time we get an amba
> driver that cannot be a loadable module, someone might want to add back the
> same macro.

Right, then it should be added back. But for now this is just dead code
and not being used, hence why keep it ?
