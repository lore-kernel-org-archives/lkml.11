Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C73ACCA47C
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jun 2022 14:08:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbiFWOIK (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jun 2022 10:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231454AbiFWOII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 10:08:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF63EB8F;
        Thu, 23 Jun 2022 07:08:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2E28B823D8;
        Thu, 23 Jun 2022 14:08:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C72C1C3411B;
        Thu, 23 Jun 2022 14:07:59 +0000 (UTC)
Date:   Thu, 23 Jun 2022 15:07:56 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H . Peter Anvin" <hpa@zytor.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        Chen Zhou <dingguo.cz@antgroup.com>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        liushixin <liushixin2@huawei.com>
Subject: Re: [PATCH 5/5] arm64: kdump: Don't defer the reservation of crash
 high memory
Message-ID: <YrRzvO5F0dumsbAU@arm.com>
References: <20220613080932.663-1-thunder.leizhen@huawei.com>
 <20220613080932.663-6-thunder.leizhen@huawei.com>
 <YrFYHYgX3mC//t2l@MiWiFi-R3L-srv>
 <3f66323d-f371-b931-65fb-edfae0f01c88@huawei.com>
 <YrIIJkhKWSuAqkCx@arm.com>
 <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrLUREAoBMSZo7RR@MiWiFi-R3L-srv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 22, 2022 at 04:35:16PM +0800, Baoquan He wrote:
> On 06/21/22 at 07:04pm, Catalin Marinas wrote:
> > The problem with splitting is that you can end up with two entries in
> > the TLB for the same VA->PA mapping (e.g. one for a 4KB page and another
> > for a 2MB block). In the lucky case, the CPU will trigger a TLB conflict
> > abort (but can be worse like loss of coherency).
> 
> Thanks for this explanation. Is this a drawback of arm64 design? X86
> code do the same thing w/o issue, is there way to overcome this on
> arm64 from hardware or software side?

It is a drawback of the arm64 implementations. Having multiple TLB
entries for the same VA would need additional logic in hardware to
detect, so the microarchitects have pushed back. In ARMv8.4, some
balanced was reached with FEAT_BBM so that the only visible side-effect
is a potential TLB conflict abort that could be resolved by software.

> I ever got a arm64 server with huge memory, w or w/o crashkernel setting 
> have different bootup time. And the more often TLB miss and flush will
> cause performance cost. It is really a pity if we have very powerful
> arm64 cpu and system capacity, but bottlenecked by this drawback.

Is it only the boot time affected or the runtime performance as well?

-- 
Catalin
