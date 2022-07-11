Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D8E8C43334
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Jul 2022 08:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230345AbiGKIf4 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Jul 2022 04:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiGKIfU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:35:20 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58F4E2FC
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:34:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 61485176B;
        Mon, 11 Jul 2022 01:34:47 -0700 (PDT)
Received: from [10.57.86.128] (unknown [10.57.86.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E70ED3F70D;
        Mon, 11 Jul 2022 01:34:44 -0700 (PDT)
Message-ID: <80b0362d-6ece-1da1-18c0-c1030fe4a303@arm.com>
Date:   Mon, 11 Jul 2022 09:34:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v6] coresight: etm4x: avoid build failure with unrolled
 loops
To:     Arnd Bergmann <arnd@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        David Laight <David.Laight@aculab.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Tom Rix <trix@redhat.com>, coresight@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <llvm@lists.linux.dev>
References: <20220708231520.3958391-1-ndesaulniers@google.com>
 <CAK8P3a0x2KJuCjupKuj6XAYUAeF47ZV4bWuEGUQFOcOK_Do2jA@mail.gmail.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <CAK8P3a0x2KJuCjupKuj6XAYUAeF47ZV4bWuEGUQFOcOK_Do2jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2022 20:13, Arnd Bergmann wrote:
> On Sat, Jul 9, 2022 at 1:15 AM Nick Desaulniers <ndesaulniers@google.com> wrote:
> 
>>          ({                                                                      \
>>                  u64 __val;                                                      \
>>                                                                                  \
>> -               if (__builtin_constant_p((offset)))                             \
>> +               if (__is_constexpr((offset)))                                   \
>>                          __val = read_etm4x_sysreg_const_offset((offset));       \
>>                  else                                                            \
>>                          __val = etm4x_sysreg_read((offset), true, (_64bit));    \
>>
> 
> This is clearly better than the current version using
> __builtin_constant_p(), but
> I don't think it's safe in all cases, since there are expressions that
> are constant
> expressions to the compiler but are not valid input to the assembler.
> 
> I would prefer to see this fixed differently, but doing this one first is also
> fine with me:
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
>          Arnd


Thanks, I have queued this.

Suzuki
