Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A063C00144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jul 2022 13:58:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbiGZN6Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jul 2022 09:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238863AbiGZN6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 09:58:22 -0400
Received: from out30-43.freemail.mail.aliyun.com (out30-43.freemail.mail.aliyun.com [115.124.30.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD875BF53;
        Tue, 26 Jul 2022 06:58:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=22;SR=0;TI=SMTPD_---0VKVecKN_1658843892;
Received: from 192.168.1.4(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VKVecKN_1658843892)
          by smtp.aliyun-inc.com;
          Tue, 26 Jul 2022 21:58:14 +0800
Subject: Re: [PATCH V4 0/5] RISC-V fixups to work with crash tool
To:     Conor.Dooley@microchip.com, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, anup@brainfault.org,
        heiko@sntech.de, guoren@kernel.org, mick@ics.forth.gr,
        alexandre.ghiti@canonical.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, corbet@lwn.net
Cc:     kexec@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        crash-utility@redhat.com, huanyi.xj@alibaba-inc.com,
        heinrich.schuchardt@canonical.com, k-hagio-ab@nec.com,
        hschauhan@nulltrace.org
References: <20220726093729.1231867-1-xianting.tian@linux.alibaba.com>
 <651b552d-8954-e58c-e994-4a9782f1112a@microchip.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <0f723ce0-48b4-b31d-e590-94b45cef8fa5@linux.alibaba.com>
Date:   Tue, 26 Jul 2022 21:58:12 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <651b552d-8954-e58c-e994-4a9782f1112a@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/7/26 下午5:52, Conor.Dooley@microchip.com 写道:
> On 26/07/2022 10:37, Xianting Tian wrote:
>> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> Ah I see you've already sent a v4.
>
>> Changes v1 -> v2:
>>    1, remove the patch "Add a fast call path of crash_kexec()" from this series
>>    of patches, as it already applied to riscv git.
>>    https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/commit/?h=for-next&id=3f1901110a89b0e2e13adb2ac8d1a7102879ea98
>>    2, add 'Reviewed-by' based on the comments of v1.
>> Changes v2 -> v3:
>>    use "riscv" instead of "riscv64" in patch 5 subject line.
>> Changes v3 -> v4:
>>    use "riscv" instead of "riscv64" in the summary of patch 5 subject line.
> There's no need to respin a series for the sake 3 characters in the cover
> letter (so sorry if you misunderstood me!)...
>
>> Xianting Tian (5):
>>     RISC-V: use __smp_processor_id() instead of smp_processor_id()
>>     RISC-V: Add arch_crash_save_vmcoreinfo support
>>     riscv: Add modules to virtual kernel memory layout dump
>>     RISC-V: Fixup getting correct current pc
>>     riscv: crash_core: Export kernel vm layout, phys_ram_base
> ...but it would've been good to align these to either "riscv:" or
> "RISC-V:" & not mix the two in a series. Don't do this right away,
> it is okay to wait for more significant changes before sending out
> a new version as this sort of thing could easily be changed when
> being applied.
Many thanks, I got it, waiting these patches to be applied:)
>
> Thanks,
> Conor.
>
>
