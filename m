Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4A3C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 16 May 2022 19:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345274AbiEPTHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 May 2022 15:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241889AbiEPTG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 15:06:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D489248E6;
        Mon, 16 May 2022 12:06:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2935F614C5;
        Mon, 16 May 2022 19:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E247C385AA;
        Mon, 16 May 2022 19:06:53 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Will Deacon <will@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     Chen Zhou <dingguo.cz@antgroup.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        John Donnelly <John.p.donnelly@oracle.com>,
        Dave Kleikamp <dave.kleikamp@oracle.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Feng Zhou <zhoufeng.zf@bytedance.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] arm64: kdump: Do not allocate crash low memory if not needed
Date:   Mon, 16 May 2022 20:06:51 +0100
Message-Id: <165272800400.3869992.18113408678309495430.b4-ty@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511032033.426-1-thunder.leizhen@huawei.com>
References: <20220511032033.426-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 May 2022 11:20:32 +0800, Zhen Lei wrote:
> When "crashkernel=X,high" is specified, the specified "crashkernel=Y,low"
> memory is not required in the following corner cases:
> 1. If both CONFIG_ZONE_DMA and CONFIG_ZONE_DMA32 are disabled, it means
>    that the devices can access any memory.
> 2. If the system memory is small, the crash high memory may be allocated
>    from the DMA zones. If that happens, there's no need to allocate
>    another crash low memory because there's already one.
> 
> [...]

Applied to arm64 (for-next/crashkernel), thanks!

[1/1] arm64: kdump: Do not allocate crash low memory if not needed
      https://git.kernel.org/arm64/c/8f0f104e2ab6

-- 
Catalin

